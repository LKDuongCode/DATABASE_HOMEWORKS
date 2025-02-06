create database ss05;
use ss05;

create table customers (
	customer_id int primary key auto_increment,
    c_name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(15),
    address varchar(255)
);

create table orders (
	order_id int primary key auto_increment,
    order_date date not null,
    total_amount decimal(10,2) not null,
    order_status varchar(50),
    customer_id int,
    constraint fk_customerID foreign key (customer_id) references customers(customer_id)
);


INSERT INTO customers (c_name, email, phone, address)
VALUES
('Nguyen Van An', 'nguyenvanan@example.com', '0901234567', '123 Le Loi, TP.HCM'),
('Tran Thi Bich', 'tranthibich@example.com', '0912345678', '456 Nguyen Hue, TP.HCM'),
('Le Van Cuong', 'levancuong@example.com', '0923456789', '789 Dien Bien Phu, Ha Noi');

INSERT INTO orders (customer_id, order_date, total_amount, order_status)
VALUES
(1, '2025-01-10', 500000, 'Pending'),
(1, '2025-01-12', 325000, 'Completed'),
(NULL, '2025-01-13', 450000, 'Cancelled'),
(3, '2025-01-14', 270000, 'Pending'),
(2, '2025-01-16', 850000, NULL);

#2 
select o.order_id, o.order_date, o.total_amount, c.c_name, c.email from orders as o
left join customers as c on c.customer_id = o.customer_id;

#3
select c.customer_id, c.c_name, c.phone, o.order_id, o.order_status from customers as c
left join orders as o on  c.customer_id = o.customer_id;

#4
select c.customer_id, c.c_name, c.phone, o.order_id, o.total_amount, o.order_date from customers as c
 join orders as o on  c.customer_id = o.customer_id;
 
 
