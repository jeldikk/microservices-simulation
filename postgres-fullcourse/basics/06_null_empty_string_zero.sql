
-- null means unknown/missing value
-- empty string means a known value that is string with no characters
-- zero mean actual numeric value of 0

DROP TABLE IF EXISTS basic_schema.empty_values_example;

CREATE TABLE basic_schema.empty_values_example (
    id SERIAL PRIMARY KEY,
    nickname TEXT,
    bio TEXT,
    score INTEGER
);

-- add some items
INSERT INTO basic_schema.empty_values_example (nickname, bio, score) VALUES
(null, 'Learning Postgres SQL', 10),
('non null text', null, 0),
('', 'non empty nickname', 20),
('jeldikk', '', 0);