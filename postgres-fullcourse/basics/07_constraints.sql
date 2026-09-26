-- NOT NULL, UNIQUE, DEFAULT, CHECK -> constraints we can use on DB

DROP TABLE IF EXISTS basic_schema.accounts_table;

CREATE TABLE basic_schema.accounts_table(
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT TRUE,
    age INTEGER CHECK (age > 18),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- SOME INSERTION OF RECORDS
--- Happy path
INSERT INTO basic_schema.accounts_table (full_name, email, age) VALUES
('Jeldi Kamal Kumar', 'jeldi.kamal2011@gmail.com', 30),
('', '', 34);

--- Error Path -- not providing NOT NULL constrained columns -- WILL FAIL
INSERT INTO basic_schema.accounts_table (full_name, email, age) VALUES
(NULL, 'jeldi@mail.com', 40);

--- Error Path -- providing same value for email with UNIQUE constraint -- WILL FAIL
INSERT INTO basic_schema.accounts_table (full_name, email, age) VALUES
('full_name_1', 'jeldi@mail.com', 23),
('full_name_2', 'jeldi@mail.com', 24);


-- Error Path -- providing value for age that violates CHECK constraint -- WILL FAIL
INSERT INTO basic_schema.accounts_table (full_name, email, age) VALUES
('full_name_3', 'unique_email@mail.com', 17);

