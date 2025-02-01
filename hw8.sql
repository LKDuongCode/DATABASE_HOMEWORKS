USE ss03;

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK(price > 0),
    stock INT NOT NULL CHECK(stock >= 0),
    category VARCHAR(100)
);

INSERT INTO product (product_name, price, stock, category) VALUES
('iPhone 14', 999.99, 20, 'Electronics'),
('Samsung Galaxy S23', 849.99, 15, 'Electronics'),
('Sony Headphones', 199.99, 30, 'Electronics'),
('Wooden Table', 120.50, 10, 'Furniture'),
('Office Chair', 89.99, 25, 'Furniture'),
('Running Shoes', 49.99, 50, 'Sports'),
('Basketball', 29.99, 100, 'Sports'),
('T-Shirt', 19.99, 200, 'Clothing'),
('Laptop Bag', 39.99, 40, 'Accessories'),
('Desk Lamp', 25.00, 35, 'Electronics');

SELECT * FROM product 
WHERE category = 'Electronics' AND price > 200;

SELECT * FROM product WHERE stock < 20;

SELECT product_name, price FROM product WHERE category = 'Sports' OR category = 'Accessories';

SET SQL_SAFE_UPDATES = 0;
UPDATE product SET stock = 100
WHERE product_name LIKE 'S%';

UPDATE product SET category = 'Premium Electronics'
WHERE price > 500;

DELETE FROM product WHERE stock = 0;

DELETE FROM product WHERE category = 'Clothing' AND price < 30;