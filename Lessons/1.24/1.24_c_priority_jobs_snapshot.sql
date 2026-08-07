-- Create TEMP Table
CREATE OR REPLACE TEMP TABLE src_priority_jobs AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.name AS company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    r.priority_lvl,
    CURRENT_TIMESTAMP AS updated_at
FROM
    data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd 
    ON jpf.company_id = cd.company_id 
INNER JOIN staging.priority_roles AS r 
    ON jpf.job_title_short = r.role_name;

-- -- UPDATE Statement
-- UPDATE main.priority_jobs_snapshot AS tgt
-- SET
--     priority_lvl = src.priority_lvl,
--     updated_at = src.updated_at
-- FROM src_priority_jobs AS src
-- WHERE tgt.job_id = src.job_id
--     AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl; -- ojo, if we use <>, it will not update NULL values when they change to a non-NULL value, or vice versa. IS DISTINCT FROM will handle NULLs correctly.

-- -- INSERT Statement
-- INSERT INTO main.priority_jobs_snapshot (
--     job_id,
--     job_title_short,
--     company_name,
--     job_posted_date,
--     salary_year_avg,
--     priority_lvl,
--     updated_at
-- )
-- SELECT
--     src.job_id,
--     src.job_title_short,
--     src.company_name,
--     src.job_posted_date,
--     src.salary_year_avg,
--     src.priority_lvl,
--     src.updated_at
-- FROM src_priority_jobs AS src
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM main.priority_jobs_snapshot AS tgt
--     WHERE tgt.job_id = src.job_id
-- );

-- -- DELETE Statement
-- DELETE FROM main.priority_jobs_snapshot AS tgt
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM src_priority_jobs AS src
--     WHERE src.job_id = tgt.job_id
-- );

-- MERGE INTO it performs update, insert, and delete operations in a single statement, making it more efficient and easier to maintain than separate statements. It also ensures that the operations are atomic, meaning that either all of them succeed or none of them do, which helps maintain data integrity.
MERGE INTO main.priority_jobs_snapshot AS tgt
USING src_priority_jobs AS src
ON tgt.job_id = src.job_id

WHEN MATCHED AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl THEN
    UPDATE SET
        priority_lvl = src.priority_lvl,
        updated_at = src.updated_at

WHEN NOT MATCHED THEN
INSERT (
        job_id,
        job_title_short,
        company_name,
        job_posted_date,
        salary_year_avg,
        priority_lvl,
        updated_at
    )
    VALUES (
        src.job_id,
        src.job_title_short,
        src.company_name,
        src.job_posted_date,
        src.salary_year_avg,
        src.priority_lvl,
        src.updated_at
    )

WHEN NOT MATCHED BY SOURCE THEN DELETE;

-- Final Check Query
SELECT
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_lvl) AS priority_lvl,
    MIN(updated_at) AS updated_at
FROM priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count DESC;

-- -- CTAS for Creating Table is used instead of the MERGE with smaller datasets.
-- CREATE OR REPLACE TABLE priority_jobs_snapshot AS
-- SELECT
--     jpf.job_id,
--     jpf.job_title_short,
--     cd.name AS company_name,
--     jpf.job_posted_date,
--     jpf.salary_year_avg,
--     r.priority_lvl,
--     CURRENT_TIMESTAMP AS updated_at
-- FROM
--     data_jobs.job_postings_fact AS jpf
-- LEFT JOIN data_jobs.company_dim AS cd 
--     ON jpf.company_id = cd.company_id
-- INNER JOIN staging.priority_roles AS r
--     ON jpf.job_title_short = r.role_name;

-- .read Lessons/1.24/1.24_c_priority_jobs_snapshot.sql