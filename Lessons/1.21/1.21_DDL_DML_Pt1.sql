-- .read Lessons/1.21/1.21_DDL_DML_Pt1.sql this command can be pasted into the terminal to run this full script. remeber to use forward slashes

USE data_jobs; -- We can't drop jobs-mart because we are using, so we need to switch to data_jobs for instance

DROP DATABASE IF EXISTS jobs_mart;

CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

SELECT *
FROM information_schema.schemata;

USE jobs_mart; -- Switch to the database we want to work on

CREATE SCHEMA IF NOT EXISTS staging; -- If we are not in the right database CREATE SCHEMA jobs_mart.stagin

-- DROP SCHEMA IF EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.preferred_roles ( --staging. is added to list the schema where we want to create the table
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'Software Engineer');

SELECT *
FROM staging.preferred_roles;

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN; -- DROP COLUMN preferred_role; if we need to delete the column instead

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id = 2; -- WHERE role_id IN (1, 2); This is used istead of multiple ORs

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER; --BOOLEAN can convert to INTEGER, but VARCHAR can't, for instance ALTER COLUMN role_name TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT *
FROM staging.priority_roles;