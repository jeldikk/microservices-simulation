

-- IF NOT EXISTS ensure that the schema gets created only when it is not created
CREATE SCHEMA IF NOT EXISTS basic_schema;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- query
SELECT schema_name, schema_owner
FROM information_schema.schemata
ORDER BY schema_name;