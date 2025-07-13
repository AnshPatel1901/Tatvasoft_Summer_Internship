CREATE TABLE customer (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) UNIQUE
);

SELECT * FROM customer;

ALTER TABLE customer ADD created_date TIMESTAMPTZ;
ALTER TABLE customer ADD updated_date TIMESTAMPTZ;

ALTER TABLE customer ADD active BOOLEAN;
ALTER TABLE customer DROP active;

ALTER TABLE customer RENAME last_name TO surname;
ALTER TABLE customer RENAME surname TO last_name;


CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL REFERENCES customer(customer_id),
	order_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	order_number VARCHAR(50) NOT NULL,
	order_amount DECIMAL(10,2) NOT NULL
);

SELECT * FROM orders;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL DEFAULT 1,
    item_total DECIMAL(10,2) GENERATED ALWAYS AS (quantity * (SELECT price FROM products WHERE products.product_id = order_items.product_id)) STORED
);

INSERT INTO products (product_name, price, stock) VALUES
('Laptop', 800.00, 10),
('Mouse', 20.00, 100),
('Keyboard', 35.00, 50),
('Monitor', 150.00, 30);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), 
(1, 2, 2), 
(2, 3, 1), 
(3, 4, 2); 

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255)
);

ALTER TABLE products ADD COLUMN category_id INT REFERENCES categories(category_id);
ALTER TABLE products ADD COLUMN supplier_id INT REFERENCES suppliers(supplier_id);

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Accessories'),
('Office Equipment');

INSERT INTO suppliers (supplier_name, contact_email) VALUES
('Tech Distributors', 'contact@techdist.com'),
('Office Supplies Inc.', 'sales@officesupplies.com');

UPDATE products SET category_id = 1, supplier_id = 1 WHERE product_name = 'Laptop';
UPDATE products SET category_id = 2, supplier_id = 1 WHERE product_name = 'Mouse';
UPDATE products SET category_id = 2, supplier_id = 1 WHERE product_name = 'Keyboard';
UPDATE products SET category_id = 1, supplier_id = 2 WHERE product_name = 'Monitor';


DELETE FROM suppliers WHERE supplier_name = 'Office Supplies Inc.';

SELECT p.product_name, c.category_name, s.supplier_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id
LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id;

SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;


INSERT INTO customer(customer_id, first_name, last_name, email, created_date, updated_date)
VALUES(1, 'Ansh', 'Patel', 'abc@google.com', NOW(), NULL);


INSERT INTO customer(customer_id, first_name, last_name, email, created_date, updated_date)
VALUES  (2, 'John', 'Doe', 'johndoe@example.com', NOW(), NULL),
  (3, 'Alice', 'Smith', 'alicesmith@example.com', NOW(), NULL),
  (4, 'Bob', 'Johnson', 'bjohnson@example.com', NOW(), NULL),
  (5, 'Emma', 'Brown', 'emmabrown@example.com', NOW(), NULL),
  (6, 'Michael', 'Lee', 'michaellee@example.com', NOW(), NULL),
  (7, 'Sarah', 'Wilson', 'sarahwilson@example.com', NOW(), NULL),
  (8, 'David', 'Clark', 'davidclark@example.com', NOW(), NULL),
  (9, 'Olivia', 'Martinez', 'oliviamartinez@example.com', NOW(), NULL),
  (10, 'James', 'Garcia', 'jamesgarcia@example.com', NOW(), NULL),
  (11, 'Sophia', 'Lopez', 'sophialopez@example.com', NOW(), NULL),
  (12, 'Jennifer', 'Davis', 'jennifer.davis@example.com', NOW(), NULL),
  (13, 'Jennie', 'Terry', 'jennie.terry@example.com', NOW(), NULL),
  (14, 'JENNY', 'SMITH', 'jenny.smith@example.com', NOW(), NULL),
  (15, 'Hiren', 'Patel', 'hirenpatel@example.com', NOW(), NULL);


INSERT INTO orders (customer_id, order_number, order_amount)
VALUES(1, 'ORD001', 50.00),
  (2, 'ORD002', 35.75),
  (3, 'ORD003', 100.00),
  (4, 'ORD004', 30.25),
  (5, 'ORD005', 90.75),
  (6, 'ORD006', 25.50),
  (7, 'ORD007', 60.00),
  (8, 'ORD008', 42.00),
  (9, 'ORD009', 120.25),
  (10, 'ORD010', 85.00),
  (1, 'ORD011', 55.00),
  (1, 'ORD012', 80.25),
  (2, 'ORD013', 70.00),
  (3, 'ORD014', 45.00),
  (1, 'ORD015', 95.50),
  (2, 'ORD016', 27.50),
  (2, 'ORD017', 65.75),
  (2, 'ORD018', 75.50);

SELECT first_name FROM customer;
SELECT first_name, last_name, email FROM customer;

SELECT * FROM customer;

SELECT first_name, last_name FROM customer ORDER BY first_name ASC;
SELECT first_name, last_name FROM customer ORDER BY last_name DESC;

SELECT last_name, first_name FROM customer WHERE first_name = 'Hiren';
SELECT customer_id, first_name, last_name FROM customer WHERE first_name = 'Hiren' AND last_name = 'Bumrah';

SELECT customer_id, first_name, last_name FROM customer WHERE first_name IN ('John', 'David', 'James');

SELECT first_name, last_name FROM customer WHERE first_name LIKE '%EN%';

SELECT first_name, last_name FROM customer WHERE first_name ILIKE '%EN%'; 

SELECT * FROM orders AS o INNER JOIN customer AS c ON o.customer_id = c.customer_id;
SELECT * FROM customer AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.first_name, c.last_name, c.email,
       COUNT(o.order_id) AS NoOrders,
       SUM(o.order_amount) AS Total
FROM customer AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;  

SELECT c.customer_id, c.first_name, c.last_name, c.email,
       COUNT(o.order_id) AS No_Orders,
       SUM(o.order_amount) AS Total
FROM customer AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 1;

SELECT customer_id, first_name, last_name, email
FROM customer
WHERE EXISTS (
  SELECT 1 FROM orders WHERE orders.customer_id = customer.customer_id
);


UPDATE customer
SET first_name = 'Hello', last_name = 'World', email = 'HelloWorld123@gmail.com'
WHERE customer_id = 1;


SELECT * FROM customer;

DELETE FROM customer WHERE customer_id = 11;
