create database review;
use review;

#1 vẽ erd trong ảnh

#2 tạo bảng 
create table customers (	
	customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    phone varchar(20) not null,
    address varchar(255)
);

create table products (
	product_id int primary key auto_increment,
    product_name varchar(100) not null unique,
    price decimal(10,2) not null,
    quantity int not null check(quantity >= 0),
    category varchar(50) not null
);

create table employees (
	employee_id int primary key auto_increment,
    employee_name varchar(100) not null,
    birthday date,
    position varchar(50) not null,
    salary decimal(10,2) not null,
    revenue decimal (10,2) default 0
);

create table orders (
	order_id int primary key auto_increment,
    customer_id int,
    foreign key (customer_id) references customers(customer_id),
	employee_id int,
    foreign key (employee_id) references employees(employee_id),
	order_date datetime default current_timestamp,
    total_amount decimal(10,2) default 0
);

create table order_details (
	order_details_id int primary key auto_increment,
    order_id int,
    foreign key (order_id) references orders(order_id),
	product_id int,
    foreign key (product_id) references products(product_id),
	quantity int not null check(quantity > 0),
    unit_price decimal(10,2) not null
);

#3 sửa cấu trúc bảng
-- 3.1 
alter table customers add column email varchar(100) not null unique;
-- 3.2 
alter table employees drop column birthday;

#4 chèn dữ liệu 
INSERT INTO customers (customer_name, phone, address,email) VALUES
('Nguyễn Văn A', '0987654321', '123 Đường ABC, Hà Nội','gg@gmail.com'),
('Trần Thị B', '0912345678', '456 Đường XYZ, TP. HCM','aa@gmail.com'),
('Lê Văn C', '0909090909', '789 Đường QWE, Đà Nẵng','bb@gmail.com'),
('Phạm Thị D', '0988111222', '321 Đường RTY, Hải Phòng','cc@gmail.com'),
('Hoàng Văn E', '0977555444', '654 Đường UIO, Cần Thơ','ee@gmail.com');

INSERT INTO products (product_name, price, quantity, category) VALUES
('Điện thoại Samsung', 15000000, 10, 'Điện tử'),
('Laptop Dell', 22000000, 5, 'Máy tính'),
('Bàn phím cơ', 1200000, 15, 'Phụ kiện'),
('Chuột gaming', 800000, 20, 'Phụ kiện'),
('Màn hình LG', 5000000, 8, 'Màn hình');

INSERT INTO employees (employee_name, birthday, position, salary, revenue) VALUES
('Nguyễn Văn X', '1990-05-20', 'Nhân viên bán hàng', 12000000, 5000000),
('Trần Thị Y', '1995-08-15', 'Nhân viên kỹ thuật', 14000000, 7000000),
('Lê Văn Z', '1988-03-10', 'Quản lý', 20000000, 15000000),
('Phạm Minh T', '1992-11-25', 'Nhân viên kho', 10000000, 3000000),
('Hoàng Hải M', '1997-07-30', 'Nhân viên bán hàng', 13000000, 6000000);

INSERT INTO orders (customer_id, employee_id, order_date, total_amount) VALUES
(1, 1, '2024-02-01 10:30:00', 32000000),
(2, 2, '2024-02-02 11:15:00', 5000000),
(3, 3, '2024-02-03 14:45:00', 15000000),
(4, 4, '2024-02-04 16:20:00', 22000000),
(5, 5, '2024-02-05 18:00:00', 800000);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 200, 15000000),
(1, 3, 100, 1200000),
(2, 5, 10, 5000000),
(3, 2, 10, 22000000),
(4, 4, 20, 800000);

#5 truy vấn cơ bản 
-- 5.1
select customer_id, customer_name, phone, address, email from customers;
-- 5.2
update products
set product_name = 'Laptop Dell XPS2', price = 99.99
where product_id = 1;
-- 5.3
select o.order_id, c.customer_name, e.employee_name, o.total_amount, o.order_date from orders o
join customers c on c.customer_id = o.customer_id
join employees e on e.employee_id = o.employee_id;


#6 truy vấn đầy đủ 
-- 6.1
select  c.customer_id ,c.customer_name, count(o.order_id) as total_orders from orders o
join customers c on c.customer_id = o.customer_id
group by c.customer_id ,c.customer_name;

-- 6.2 
select e.employee_id, e.employee_name, sum(o.total_amount) as cur_revenue, year(o.order_date) as cur_year from employees e 
join orders o on o.employee_id = e.employee_id
where year(o.order_date) = year(curdate())
group by e.employee_id, year(o.order_date);

-- 6.3
select p.product_id, p.product_name, od.quantity from order_details od
join orders o on o.order_id = od.order_id
join products p on p.product_id = od.product_id
where od.quantity > 100 and month(o.order_date) = month(curdate())
order by od.quantity desc;

#7 truy vấn nâng cao
-- 7.1
INSERT INTO customers (customer_name, phone, address,email) VALUES
('Nguyễn chưa đặt hàng', '0987654389', '123 Đường ABC, Hà Nội','qqq@gmail.com');

select c.customer_id, c.customer_name, o.order_id from customers c
left join orders o on o.customer_id = c.customer_id
where order_id is null;

-- 7.2
select product_name, price from products
where price > (select avg(price) from products);

-- 7.3
INSERT INTO customers (customer_name, phone, address,email) VALUES
('Nguyễn Văn A2', '0987654320', '123 Đường ABC, Hà Nội','aa2@gmail.com');
INSERT INTO orders (customer_id, employee_id, order_date, total_amount) VALUES
(7, 1, '2024-02-01 10:30:00', 32000000);

select c.customer_id, c.customer_name, max(o.total_amount) as total_spent from customers c
join orders o on o.customer_id = c.customer_id
group by c.customer_id, customer_name
having max(o.total_amount) = (select max(total_amount) from orders);

#8 tạo view 
-- 8.1
create view view_order_list as
select o.order_id, c.customer_name, e.employee_name, o.total_amount , o.order_date from orders o
join customers c on c.customer_id = o.customer_id
join employees e on e.employee_id = o.employee_id;

-- 8.2
create view view_order_detail_product as
select od.order_details_id, p.product_name, od.quantity, od.unit_price from order_details od
join products p on p.product_id = od.product_id
order by od.quantity desc;

#9 tạo thủ tục lưu trữ
-- 9.1
delimiter //
create procedure proc_insert_employee (in in_name varchar(100), in in_birthday date, in in_pos varchar(50), in in_salary decimal(10,2), out out_empID int)
begin
	insert into employees (employee_name, birthday, position, salary) values
    (in_name,in_birthday,in_pos,in_salary);
    
    set out_empID = last_insert_id();
end
// delimiter ;

call proc_insert_employee ('new e1','2025-01-01','quản lí','20000000.00', @new_emp_id);
select @new_emp_id;

-- 9.2
delimiter //
create procedure proc_get_orderdetails (in in_orderID int)
begin
	select * from order_details where order_id = in_orderID;
end
// delimiter ;

call proc_get_orderdetails (1);

-- 9.3
delimiter //
create procedure proc_cal_total_amount_by_order (in in_orderID int, out in_quantity int)
begin
	select count(distinct product_id) into in_quantity from order_details
    where order_id = in_orderID;
end
// delimiter ;

call proc_cal_total_amount_by_order (1, @quantity);
select @quantity;


#10 trigger
delimiter //
create trigger trigger_after_insert_order_details
before insert on order_details for each row
begin
    declare current_stock int;
    
    -- lấy số lượng sản phẩm hiện có 
    select quantity into current_stock from products where product_id = new.product_id;

    -- kiểm tra nếu số lượng 
    if current_stock < new.quantity then
        signal sqlstate '45000'
        set message_text = 'số lượng sản phẩm trong kho không đủ';
    end if;

    -- nếu đủ 
    update products 
    set quantity = quantity - new.quantity
    where product_id = new.product_id;
end //
delimiter ;

insert into order_details (order_id, product_id, quantity, unit_price)
values (1, 1, 5, 15000000);

#11 transaction 
delimiter //
create procedure proc_insert_order_details(
    in in_orderID int,
    in in_productID int,
    in in_quantity int,
    in in_unit_price decimal(10,2)
)
begin
    declare total_amount decimal(10,2);

    start transaction;
    -- kiểm tra xem đơn hàng có tồn tại không
    if not exists (select 1 from orders where order_id = in_orderID) then
	rollback;
        signal sqlstate '45000'
        set message_text = 'không tồn tại mã hóa đơn';
    end if;

    -- chèn dữ liệu
    insert into order_details (order_id, product_id, quantity, unit_price)
    values (in_orderID, in_productID, in_quantity, in_unit_price);
    
    -- cập nhật tổng tiền 
    select sum(quantity * unit_price) into total_amount from order_details where order_id = in_orderID;
    update orders set total_amount = total_amount where order_id = in_orderID;

    commit;
end //
delimiter ;

call proc_insert_order_details(1, 2, 3, 500000);

