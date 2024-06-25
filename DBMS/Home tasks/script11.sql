-- Create the customer table
CREATE TABLE customer (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert sample data into the customer table
INSERT INTO customer (id, name) VALUES
(1, 'Nimit'),
(2, 'Rehansh'),
(3, 'Priya'),
(4, 'Naman');

-- Create the orders table
CREATE TABLE orders (
    id INT PRIMARY KEY,
    c_id INT,
    FOREIGN KEY (c_id) REFERENCES customer(id)
);

-- Insert sample data into the orders table
INSERT INTO orders (id, c_id) VALUES
(1, 3),
(2, 1);

-- Query to find customers who have never placed any orders
use db1
SELECT c.name AS NEVERORDERED
FROM customer c
LEFT JOIN orders o ON c.id = o.c_id
WHERE o.id IS NULL;


SELECT name AS NEVERORDERED
FROM customer
WHERE id NOT IN (
    SELECT c_id
    FROM orders
);

