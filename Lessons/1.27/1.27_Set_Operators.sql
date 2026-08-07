SELECT UNNEST([1, 1, 1, 2])
EXCEPT ALL
SELECT UNNEST([1, 1, 3]);

CREATE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE (job_id, job_posted_date) -- EXCLUDE is not suppported by all databases.
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * FROM jobs_2023;

CREATE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE (job_id, job_posted_date) -- EXCLUDE is not suppported by all databases.
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

SELECT * FROM jobs_2024;

-- WHICH UNIQUE JOB POSTINGS APPEARED IN EITHER 2023 OR 2024?

SELECT
    'jobs_2023' AS table_name,
    COUNT(*) AS record_count
FROM jobs_2023
UNION 
SELECT
    'jobs_2024' AS table_name,
    COUNT(*)
FROM jobs_2024;

SELECT * FROM jobs_2023
UNION -- UNION returns unique records from both tables.
SELECT * FROM jobs_2024;

-- Which job postings appeared across both years, counting duplicates?

SELECT * FROM jobs_2023
UNION ALL -- UNION ALL returns all records from both tables, including duplicates.
SELECT * FROM jobs_2024;

-- Which job postings appeared in 2023 but not in 2024?

SELECT * FROM jobs_2023
EXCEPT -- EXCEPT returns records from the first table that are not in the second table.
SELECT * FROM jobs_2024;

-- Which job postings from 2023 remain after subtracting matching 2024 postings, one-for-one?

SELECT * FROM jobs_2023
EXCEPT ALL -- EXCEPT ALL returns records from the first table that are not in the second table, counting duplicates.
SELECT * FROM jobs_2024;

-- Which job postings appeared in both 2023 and 2024?

SELECT * FROM jobs_2023
INTERSECT -- INTERSECT returns records that are in both tables.
SELECT * FROM jobs_2024;

-- Which job postings appeared in both years, preserving duplicate counts?

SELECT * FROM jobs_2023
INTERSECT ALL -- INTERSECT ALL returns records that are in both tables, counting duplicates.
SELECT * FROM jobs_2024;