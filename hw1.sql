CREATE DATABASE ss14_first;
USE ss14_first;
	-- 1. Bảng customers (Khách hàng)
	CREATE TABLE customers (
		customer_id INT PRIMARY KEY AUTO_INCREMENT,
		name VARCHAR(255) NOT NULL,
		email VARCHAR(255) UNIQUE NOT NULL,
		phone VARCHAR(20),
		address TEXT,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);

	-- 2. Bảng orders (Đơn hàng)
	CREATE TABLE orders (
		order_id INT PRIMARY KEY AUTO_INCREMENT,
		customer_id INT NOT NULL,
		order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		total_amount DECIMAL(10,2) DEFAULT 0,
		status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
		FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
	);

	-- 3. Bảng products (Sản phẩm)
	CREATE TABLE products (
		product_id INT PRIMARY KEY AUTO_INCREMENT,
		name VARCHAR(255) NOT NULL,
		price DECIMAL(10,2) NOT NULL,
		description TEXT,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);

	-- 4. Bảng order_items (Chi tiết đơn hàng)
	CREATE TABLE order_items (
		order_item_id INT PRIMARY KEY AUTO_INCREMENT,
		order_id INT NOT NULL,
		product_id INT NOT NULL,
		quantity INT NOT NULL CHECK (quantity > 0),
		price DECIMAL(10,2) NOT NULL,
		FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
		FOREIGN KEY (product_id) REFERENCES products(product_id)
	);

	-- 5. Bảng inventory (Kho hàng)
	CREATE TABLE inventory (
		product_id INT PRIMARY KEY,
		stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
		last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
	);

	-- 6. Bảng payments (Thanh toán)
	CREATE TABLE payments (
		payment_id INT PRIMARY KEY AUTO_INCREMENT,
		order_id INT NOT NULL,
		payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		amount DECIMAL(10,2) NOT NULL,
		payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
		status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
		FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
	);

-- Thêm dữ liệu cho bảng customers
INSERT INTO customers (name, email, phone, address) VALUES
('Nguyễn Văn A', 'nguyenvana@example.com', '0987654321', 'Hà Nội, Việt Nam'),
('Trần Thị B', 'tranthib@example.com', '0971234567', 'Hồ Chí Minh, Việt Nam'),
('Lê Hoàng C', 'lehoangc@example.com', '0969876543', 'Đà Nẵng, Việt Nam'),
('Phạm Minh D', 'phamminhd@example.com', '0912345678', 'Cần Thơ, Việt Nam'),
('Hoàng Thanh E', 'hoangthanhe@example.com', '0908765432', 'Hải Phòng, Việt Nam');

-- Thêm dữ liệu cho bảng products
INSERT INTO products (name, price, description) VALUES
('Laptop Dell XPS 13', 25000000, 'Laptop cao cấp của Dell'),
('iPhone 14 Pro', 32000000, 'Điện thoại iPhone mới nhất'),
('Samsung Galaxy S22', 28000000, 'Smartphone Android mạnh mẽ'),
('Tai nghe AirPods Pro', 5500000, 'Tai nghe không dây cao cấp'),
('Bàn phím cơ Keychron K8', 2500000, 'Bàn phím cơ không dây chất lượng');

-- Thêm dữ liệu cho bảng orders
INSERT INTO orders (customer_id, total_amount, status) VALUES
(1, 57000000, 'Pending'),
(2, 32000000, 'Completed'),
(3, 2500000, 'Pending'),
(4, 28000000, 'Cancelled'),
(5, 25000000, 'Completed');

-- Thêm dữ liệu cho bảng order_items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 25000000),
(1, 2, 1, 32000000),
(2, 2, 1, 32000000),
(3, 5, 1, 2500000),
(4, 3, 1, 28000000),
(5, 1, 1, 25000000);

-- Thêm dữ liệu cho bảng inventory
INSERT INTO inventory (product_id, stock_quantity) VALUES
(1, 10),
(2, 5),
(3, 8),
(4, 15),
(5, 20);

-- Thêm dữ liệu cho bảng payments
INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(1, 57000000, 'Credit Card', 'Pending'),
(2, 32000000, 'PayPal', 'Completed'),
(3, 2500000, 'Cash', 'Pending'),
(4, 28000000, 'Bank Transfer', 'Failed'),
(5, 25000000, 'Credit Card', 'Completed');



delimiter //
#2
create trigger trg_bf_insert_order_items
before insert on order_items for each row
begin
	if (select i.stock_quantity from inventory i join products p on p.product_id = i.product_id where p.product_id = new.product_id) 
    < new.quantity then
		signal sqlstate '45000' set message_text = 'Không đủ hàng trong kho!';
    end if;
end;
// delimiter ;

delimiter //
#3
create trigger trg_af_insert_orders
after insert on orders for each row
begin
	update orders set total_amount = (select price * quantity from order_items where order_id = new.order_id) where order_id = new.order_id;
end;
// delimiter ;

delimiter //
#4
create trigger trg_bf_update_products
before update on order_items for each row
begin
	if new.quantity > (select * from inventory where product_id = new.product_id) then
		signal sqlstate '45000' set message_text = 'Không đủ hàng trong kho để cập nhật số lượng!';
    end if;
end;
// delimiter ;

delimiter //
#5
create trigger trg_af_update_order_items
after update on order_items
for each row
begin
    update orders
    set total_amount = total_amount - (old.price * old.quantity) + (new.price * new.quantity)
    where order_id = new.order_id;
end 
// delimiter ;

delimiter //
#6
create trigger trg_bf_delete_orders
before delete on orders
for each row
begin
    if old.status = 'Completed' then
        signal sqlstate '45000'
        set message_text = 'Không thể xóa đơn hàng đã thanh toán!';
    end if;
end 
// delimiter ;

#7
delimiter //
create trigger trg_af_delete_order_items
after delete on order_items
for each row
begin
    update inventory
    set stock_quantity = stock_quantity + old.quantity
    where product_id = old.product_id;
end 
// delimiter ;


#8
drop trigger if exists trg_bf_insert_order_items;
drop trigger if exists trg_af_insert_orders;
drop trigger if exists trg_bf_update_products;
drop trigger if exists trg_af_update_order_items;
drop trigger if exists trg_bf_delete_orders;
drop trigger if exists trg_af_delete_order_items;

