create database hackathon;
use hackathon;

# câu 2 ----------------------------------------------------------
create table tbl_customers (
    customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    phone varchar(20) not null unique,
    email varchar(100) not null unique,
    address varchar(255)
);

create table tbl_customers_info (
    customer_id int primary key,
    membership_level enum('standard', 'vip', 'vvip'),
    registration_date date,
    total_spent decimal(10,2),
    foreign key (customer_id) references tbl_customers(customer_id) 
);

create table tbl_rooms (
    room_id int primary key auto_increment,
    room_number varchar(10) not null unique,
    room_type enum('single', 'double', 'suite'),
    price_per_night decimal(10,2),
    status enum('available', 'booked', 'maintenance')
);

create table tbl_bookings (
    booking_id int primary key auto_increment,
    customer_id int,
    room_id int,
    check_in_date datetime,
    check_out_date datetime,
    status enum('confirmed', 'checked-in', 'checked-out', 'cancelled'),
    foreign key (customer_id) references tbl_customers(customer_id) ,
    foreign key (room_id) references tbl_rooms(room_id)
);

create table tbl_services (
    service_id int primary key auto_increment,
    service_name varchar(100) not null,
    price decimal(10,2)
);

create table tbl_booking_services (
    booking_service_id int primary key auto_increment,
    booking_id int,
    service_id int,
    quantity int,
    foreign key (booking_id) references tbl_bookings(booking_id) ,
    foreign key (service_id) references tbl_services(service_id) 
);

alter table tbl_customers_info add column loyalty_points int;
alter table tbl_customers modify phone varchar(15);
alter table tbl_customers_info drop column total_spent;


#Câu 3------------------------------------
insert into tbl_customers (customer_name, phone, email, address)
values 
('Nguyễn Văn A','0932767326','anv@gmail.com','Hà Nội'),
('Trần Thị B','0992378636','btt@gmail.com','Hồ Chí Minh'), 
('Lê Văn C','0932767365','clv@gmail.com','Đà Nẵng'),
('Phạm Thị D','0973265632','dpdpt@gmail.com','Hà Nội'),
('Nguyễn Thị E','0923865633','ent@gmail.com','Hồ Chí Minh');


-- dữ liệu được cho trong phần này là dữ liệu của total_spent , không phải của loyalty_points
alter table tbl_customers_info add column total_spent decimal(10,2);
alter table tbl_customers_info drop column loyalty_points;
insert into tbl_customers_info 
values
(1,'vip','2023-01-01','1500.00'),
(2,'standard','2023-02-15','800.00'),
(3,'vvip','2023-03-10','2000.00'),
(4,'standard','2023-04-05','500.00'),
(5,'vip','2023-05-20','1500.00');

insert into tbl_rooms 
values
(101,'A101','single','500.00','available'),
(102,'B202','double','700.00','maintenance'),
(103,'C301','suite','1200.00','available'),
(104,'D402','double','500.00','booked'),
(105,'E501','single','800.00','available');


insert into tbl_bookings (booking_id, customer_id, room_id, check_in_date, check_out_date, status) 
values
(1001, 1, 101, '2023-06-01', '2023-07-05', 'confirmed'),
(1002, 2, 102, '2023-06-10', NULL, 'checked-in'),
(1003, 3, 103, '2023-06-20', '2023-06-25', 'cancelled'),
(1004, 4, 104,NULL, '2023-06-15', 'cancelled'),
(1005, 5, 105, '2023-06-01', '2023-07-05', 'confirmed');

insert into tbl_services
values
(1,'Ăn sáng',100.00),
(2,'Giặt ủi',30.00),
(3,'Dịch vụ phòng',20.00),
(4,'Thuê xe đạp ạp',30.00),
(5,'Massage',100.00);

insert into tbl_booking_services
values
(1,1001,1,2),
(2,1002,2,2),
(3,1003,3,1),
(4,1004,2,1),
(5,1005,1,2);

#4
select room_id, room_number, room_type, price_per_night, status from tbl_rooms;

select distinct c.customer_id, c.customer_name, c.phone, c.email, c.address from tbl_customers as c
join tbl_bookings as b on c.customer_id = b.customer_id;

#5
select room_type, count(*) as empty_count from tbl_rooms
where status = 'available'
group by room_type;

select s.service_name, sum(bs.quantity) as total from tbl_services as s
join tbl_booking_services as bs on s.service_id = bs.service_id
group by s.service_id, s.service_name
having sum(bs.quantity) > 0;

#6
select c.customer_name , count(b.booking_id) as booking_count from tbl_customers as c
left join tbl_bookings as b on c.customer_id = b.customer_id
group by c.customer_id, c.customer_name;


select c.customer_name, count(b.booking_id) as booking_count from tbl_customers as c
join tbl_bookings as b on c.customer_id = b.customer_id
group by c.customer_id, c.customer_name
having count(b.booking_id) >= 2;


#7
select c.customer_name, sum(r.price_per_night * (b.check_out_date - b.check_in_date)) as total_spent
from tbl_customers c
join tbl_bookings b on c.customer_id = b.customer_id
join tbl_rooms r on b.room_id = r.room_id
where b.check_in_date is not null and b.check_out_date is not null
group by c.customer_id, c.customer_name
order by sum(r.price_per_night * (b.check_out_date - b.check_in_date)) desc
limit 5;


#8
select c.customer_name, count(b.booking_id) as total_booked_room from tbl_customers as c
left join tbl_bookings as b on c.customer_id = b.customer_id
group by c.customer_id, c.customer_name
order by total_booked_room desc;



#9
select * from tbl_rooms where room_id not in (select distinct room_id from tbl_bookings);



