-- PRIMARY KEY helps in identifying the row uniquely in the table

DROP TABLE IF EXISTS basic_schema.sales_table;

CREATE TABLE basic_schema.sales_table (
    id SERIAL PRIMARY KEY,

    title TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO basic_schema.sales_table (title, price) VALUES
('Sale 1', 200),
('Sale 2', 300);

SELECT * FROM basic_schema.sales_table;

-- We can identify the row item by id
SELECT * FROM basic_schema.sales_table WHERE id = 2;

-- failing condition
INSERT INTO basic_schema.sales_table (id, title, price) VALUES
(10, 'duplicate sale', 400);


