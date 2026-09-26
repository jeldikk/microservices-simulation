DROP TABLE IF EXISTS basic_schema.students;

CREATE TABLE basic_schema.students(
    student_id SERIAL PRIMARY KEY, -- primary key mean this column uniquely identifes the row
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE, -- no two records have same email value
    age INTEGER CHECK (age >= 18), -- age must be at least 18
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP-- record creation timestamp, DEFAULT mean it takes by default the current timestamp when a new row is inserted
);

INSERT INTO basic_schema.students (name, email, age) VALUES
('John Doe', 'john.doe@example.com', 20),
('Jane Smith', 'jane.smith@example.com', 22),
('Alice Johnson', 'alice.johnson@example.com', 19),
('Jeldi Kamal Kumar', 'jeldi.kamal.kumar@example.com', 21);

INSERT INTO basic_schema.students (name, email, age) VALUES
('Bob Brown', 'bob.brown@example.com', 23),
('Charlie Davis', 'charlie.davis@example.com', 24);

INSERT INTO basic_schema.students (name, email, age) VALUES
('David Evans', 'david.evans@example.com', 10);