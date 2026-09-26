DROP TABLE IF EXISTS basic_schema.products_basic;

CREATE TABLE basic_schema.products_basic(
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL, -- string with maximum length of 100 characters
    description TEXT, -- string with no specific maximum length
    stock INTEGER DEFAULT 0 CHECK (stock >= 0), -- default stock is 0
    price NUMERIC(10, 2) CHECK (price >= 0), -- price with up to 10 digits, 2 of which are after the decimal point, must be non-negative
    total_views BIGINT DEFAULT 0, -- default total views is 0, BIGINT is larger than INTEGER
    is_active BOOLEAN DEFAULT TRUE, -- indicates if the product is active, default is TRUE
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- record creation timestamp, DEFAULT mean it takes by default the current timestamp when a new row is inserted
);

-- queries to insert data into products_basic
INSERT INTO basic_schema.products_basic (name, description, stock, price, total_views, is_active) VALUES
('Product 1', 'Description for product 1', 10, 19.99, 100, TRUE),
('Product 2', 'Description for product 2', 5, 29.99, 50, TRUE),
('Product 3', 'Description for product 3', 0, 9.99, 200, FALSE),
('Product 4', 'Description for product 4', 15, 49.99, 300, TRUE),
('Product 5', 'Description for product 5', 16, 23.44, 200, FALSE);


-- query all products
SELECT * FROM basic_schema.products_basic;

-- query product