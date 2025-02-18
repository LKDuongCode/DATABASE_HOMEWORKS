use ss13;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, price, stock) VALUES
('Laptop Dell', 1500.00, 10),
('iPhone 13', 1200.00, 8),
('Samsung TV', 800.00, 5),
('AirPods Pro', 250.00, 20),
('MacBook Air', 1300.00, 7);

#2
delimiter //
create procedure sp_process_order (in in_productid int, in in_quantity int )
begin
	set autocommit = 0;
	start transaction;
    -- check stock
    if (select coalesce(stock,0) from products where product_id = in_productid) < in_quantity then
		rollback;
		signal sqlstate '45000' set message_text = 'not enough stock';
    end if;
    
    -- tạo đơn 
    insert into orders (product_id, quantity, total_price) values
    (in_productid, in_quantity, in_quantity * (select price from products where product_id = in_productid));
    
    -- giảm stock 
    update products set stock = stock - in_quantity where product_id = in_productid and stock >= in_quantity;
    
    select 'success' as status;
    commit;
end
// delimiter ;


call sp_process_order (1,2);
select * from orders;


