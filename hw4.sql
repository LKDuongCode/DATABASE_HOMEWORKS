#1
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,  -- Khóa chính tự động tăng
    ProductName VARCHAR(100) NOT NULL,         -- Tên sản phẩm
    Category VARCHAR(50) NOT NULL,             -- Loại sản phẩm
    Price DECIMAL(10, 2) NOT NULL,             -- Giá sản phẩm
    Stock INT NOT NULL                         -- Số lượng tồn kho
);
-- Thêm dữ liệu vào bảng Products
INSERT INTO Products (ProductName, Category, Price, Stock)
VALUES
    ('iPhone 14', 'Electronics', 1000.00, 50),
    ('MacBook Air', 'Electronics', 1200.00, 30),
    ('T-Shirt', 'Fashion', 20.00, 200),
    ('Sneakers', 'Fashion', 100.00, 100),
    ('Refrigerator', 'Appliances', 800.00, 10),
    ('Air Conditioner', 'Appliances', 600.00, 15),
    ('Laptop', 'Electronics', 1500.00, 25),
    ('Headphones', 'Electronics', 200.00, 75),
    ('Jacket', 'Fashion', 150.00, 50),
    ('Washing Machine', 'Appliances', 700.00, 8);


#2
-- tim gia san pham MacBook Air
-- so sanh voi ket qua
select ProductName, Category, Price from products
where Price > (select Price from products where ProductName = 'MacBook Air');

#3
-- tim gai laptop
-- so sanh voi ket qua tim thay
select ProductName, Category, Price from products 
where Category = 'Electronics' and Price < (select Price from products where ProductName = 'Laptop');

#4
-- tim so ton kho cua t-shirt
-- so sanh ket qua
select ProductName, Price, Stock from products
where Stock < (select Stock from products where ProductName = 'T-Shirt');


