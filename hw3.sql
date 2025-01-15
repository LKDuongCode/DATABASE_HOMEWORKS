# tạo db
CREATE DATABASE ss02;
USE ss02;

# tạo table
CREATE TABLE product (
	id INT PRIMARY KEY AUTO_INCREMENT ,
    product_name VARCHAR(250) NOT NULL,
    price DECIMAL(10,0) NOT NULL,
    quantity INT
);


 