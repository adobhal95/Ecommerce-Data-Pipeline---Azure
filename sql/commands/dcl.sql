/*
* create a dedicated ADF user with least-privilege access for Azure Data Factory connections
*/

-- Create a Dedicated User (Login Role)
CREATE ROLE adf_user
WITH
    LOGIN
    PASSWORD 'password123';

-- Grant Database Connection Access
GRANT CONNECT ON DATABASE your_database_name TO adf_user;

-- Allow Schema Usage (Required for accessing objects within the schema)
GRANT USAGE ON SCHEMA public TO adf_user;

-- Grant Read-Only Access to Existing Tables (Recommended)
GRANT SELECT ON ALL TABLES IN SCHEMA public TO adf_user;

-- Grant SELECT privileges on future tables in the public schema
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO adf_user;
