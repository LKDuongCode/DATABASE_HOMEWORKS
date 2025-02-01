CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    ctm_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(15)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    order_status VARCHAR(50),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (ctm_name, email, phone)
VALUES
('Nguyen Van A', 'nguyenvana@example.com', '1234567890'),
('Tran Thi B', 'tranthib@example.com', '0987654321'),
('Le Van C', 'levanc@example.com', '0912345678'),
('Pham Thi D', 'phamthid@example.com', '0898765432'),
('Hoang Van E', 'hoangvane@example.com', '0812345678'); 

INSERT INTO orders (order_date, total_amount, order_status, customer_id)
VALUES
('2025-01-01', 200.00, 'Pending', 1),
('2025-01-02', 150.50, 'Shipped', 1),
('2025-01-03', 300.75, 'Completed', 2),
('2025-01-04', 450.00, 'Pending', 3),
('2025-01-05', 120.00, 'Cancelled', 2),
('2025-01-06', 99.99, 'Pending', 4),
('2025-01-07', 75.50, 'Shipped', 4),
('2025-01-08', 500.00, 'Completed', 3),
('2025-01-09', 60.00, 'Pending', 1),
('2025-01-10', 250.00, 'Completed', 3);

UPDATE customers SET phone = '0000000000' WHERE ctm_name LIKE "Nguyen%";

SELECT * FROM customers;
SELECT * FROM orders;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM customers
WHERE customer_id IN (
    SELECT c.customer_id
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
    HAVING SUM(o.total_amount) < 100 OR SUM(o.total_amount) IS NULL
);

UPDATE orders 
SET order_status = 'Cancelled'
WHERE order_status = 'Pending'
AND total_amount < 50;