#1 VẼ ERD (ẢNH ĐÍNH KÈM)

#2 THIẾT KẾ DATABASE --------------------------------------------------------------------
-- tạo database 
create database flight_ticket_management;
use flight_ticket_management;

-- tạo table 
create table flight (
	flight_id char(10) primary key, -- 
    airline_name varchar(100),
    departure_airport varchar(100),
    arrival_airport varchar(100),
    departure_time datetime,
    arrival_time datetime,
    ticket_price decimal(10,2)
);

create table passenger (
    passenger_id char(10) primary key,
    passenger_full_name varchar(150) not null,
    passenger_email varchar(255) not null unique,
    passenger_phone char(15) not null unique,
    passenger_bod date not null
);

create table booking (
    booking_id int primary key auto_increment,
    passenger_id char(10) not null,
    foreign key (passenger_id) references passenger(passenger_id),
    flight_id char(10) not null,
    foreign key (flight_id) references flight(flight_id),
    booking_date date not null,
    booking_status enum('Confirmed','Cancelled','Pending') not null
);

create table payment (
    payment_id int primary key auto_increment,
    booking_id int not null unique,
    foreign key (booking_id) references booking(booking_id),
    payment_method enum('credit card','bank transfer','cash') not null,
    payment_amount decimal(10,2) not null check(payment_amount > 0),
    payment_date date not null,
    payment_status enum('success','failed','pending') not null
);


-- Thêm cột passenger_gender có kiểu dữ liệu là enum với các giá trị 'Nam', 'Nữ', 'Khác' trong bảng Passenger.
alter table passenger
add column passenger_gender enum('Nam','Nữ','Khác');

/*
Thêm cột ticket_quantity trong bảng Booking có kiểu dữ liệu là integer, có rằng buộc NOT NULL và giá trị mặc định là 1. 
Cột này thể hiện số lượng vé mà hành khách đã đặt
*/
alter table booking 
add column ticket_quantity int not null default 1;

-- Thêm rằng buộc cho cột payment_amount trong bảng Payment phải có giá trị lớn hơn 0 và có kiểu dữ liệu là DECIMAL(10, 2).
alter table payment modify payment_amount decimal(10,2);
alter table payment add constraint payment_amount check(payment_amount > 0);

#3 THAO TÁC DỮ LIỆU ------------------------------------------------------------------------------------
-- thêm dữ liệu
insert into passenger values 
('P0001', 'Nguyen Anh Tuan','tuan.nguyen@example.com','0901234567','1995-05-15','Nam'),
('P0002', 'Tran Thi Mai','mai.tran@example.com','0912345678','1996-06-16','Nữ'),
('P0003', 'Le Minh Tuan','tuan.le@example.com','0923456789','1997-07-17','Nam'),
('P0004', 'Pham Hong Son','son.pham@example.com','0934567890','1998-08-18','Nam'),
('P0005', 'Nguyen Thi Lan','lan.nguyen@example.com','0945678901','1999-09-19','Nữ'),
('P0006', 'Vu Thi Bao','bao.vu@example.com','0956789012','2000-10-20','Nữ'),
('P0007', 'Doan Minh Hoang','hoang.doan@example.com','0967890123','2001-11-21','Nam'),
('P0008', 'Nguyen Thi Thanh','thanh.nguyen@example.com','0978901234','2002-12-22','Nữ'),
('P0009', 'Trinh Bao Vy','vy.trinh@example.com','0989012345','2003-01-23','Nữ'),
('P0010', 'Bui Hoang Nam','nam.bui@example.com','0990123456','2004-02-24','Nam');

insert into flight values
('F001','VietJet Air','Tan Son Nhat','Nha Trang','2025-03-01 08:00:00','2025-03-01 10:00:00',150.5),
('F002','Vietnam Airlines','Noi Bai','Hanoi','2025-03-01 09:00:00','2025-03-01 11:30:00',200.0),
('F003','Bamboo Airways','Da Nang','Phu Quoc','2025-03-01 10:00:00','2025-03-01 12:00:00',120.8),
('F004','Vietravel Airlines','Can Tho','Ho Chi Minh','2025-03-01 11:00:00','2025-03-01 12:30:00',180.0);

insert into booking (passenger_id,flight_id,booking_date,booking_status,ticket_quantity) values 
('P0001','F001','2025-02-20','Confirmed',1),
('P0002','F002','2025-02-21','Cancelled',2),
('P0003','F003','2025-02-22','Pending',1),
('P0004','F004','2025-02-23','Confirmed',3),
('P0005','F001','2025-02-24','Pending',1),
('P0006','F002','2025-02-25','Confirmed',2),
('P0007','F003','2025-02-26','Cancelled',1),
('P0008','F004','2025-02-27','Pending',4),
('P0009','F001','2025-02-28','Confirmed',1),
('P0010','F002','2025-02-28','Pending',1),

('P0001','F003','2025-03-01','Confirmed',3),
('P0002','F004','2025-03-02','Cancelled',1),
('P0003','F001','2025-03-03','Pending',2),
('P0004','F002','2025-03-04','Confirmed',1),
('P0005','F003','2025-03-05','Cancelled',2),
('P0006','F004','2025-03-06','Pending',1),
('P0007','F001','2025-03-07','Confirmed',3),
('P0008','F002','2025-03-08','Cancelled',2),
('P0009','F003','2025-03-09','Pending',1),
('P0010','F004','2025-03-10','Confirmed',1);


insert into payment (booking_id,payment_method,payment_amount,payment_date,payment_status) values
(1,'Credit Card','150.5','2025-02-20','Success'),
(2,'Bank Transfer','200.0','2025-02-21','Failed'),
(3,'Cash','120.8','2025-02-22','Pending'),
(4,'Credit Card','180.0','2025-02-23','Success'),
(5,'Bank Transfer','150.5','2025-02-24','Pending'),
(6,'Cash','200.0','2025-02-25','Success'),
(7,'Credit Card','120.8','2025-02-26','Failed'),
(8,'Bank Transfer','180.0','2025-02-27','Pending'),
(9,'Cash','150.5','2025-02-28','Success'),
(10,'Credit Card','200.0','2025-03-01','Pending');

/* 
Viết câu UPDATE cho phép cập nhật trạng thái thanh toán trong bảng Payment:
Cập nhật trạng thái thanh toán thành "Success" nếu số tiền thanh toán (payment_amount) > 0 và phương thức thanh toán là "Credit Card".
Cập nhật trạng thái thanh toán thành "Pending" nếu phương thức thanh toán là "Bank Transfer" và số tiền thanh toán nhỏ hơn 100.
Chỉ cập nhật trạng thái thanh toán cho những giao dịch có ngày thanh toán (payment_date) là trước ngày hiện tại(CURRENT_DATE)
*/
set sql_safe_updates = 0;

update payment 
set payment_status = 'success'
where payment_amount > 0 
and payment_method = 'credit card' and payment_date < current_date;

update payment 
set payment_status = 'pending'
where payment_method = 'bank transfer' 
and payment_amount < 100 and payment_date < current_date;

-- Xóa các bản ghi trong bảng Payment nếu trạng thái thanh toán là "Pending" và phương thức thanh toán là "Cash".
delete from payment 
where payment_status = 'Pending' and  payment_method = 'Cash';


#4  TRUY VẤN DỮ LIỆU ------------------------------------------------------------------
-- 1. Lấy thông tin 5 hành khách gồm mã, tên, email, ngày sinh, và giới tính, sắp xếp theo tên hành khách tăng dần
select passenger_id, passenger_full_name, passenger_email, passenger_bod, passenger_gender from passenger
order by passenger_full_name asc
limit 5;

-- 2. Lấy thông tin các chuyến bay gồm mã, tên hãng hàng không, sân bay khởi hành và sân bay đến, sắp xếp theo giá vé giảm dần
select flight_id, airline_name, departure_airport, arrival_airport from flight
order by ticket_price desc;

-- 3. Lấy thông tin các hành khách gồm mã hành khách, tên hành khách, chuyến bay đã đặt và trạng thái vé là "Cancelled"
select p.passenger_id, p.passenger_full_name,
concat(airline_name,' - ','Bay từ ',departure_airport,' đến ',arrival_airport) as booked_flight, b.booking_status from booking b
join passenger p on p.passenger_id = b.passenger_id
join flight f on f.flight_id = b.flight_id
where b.booking_status = 'Cancelled';

/*4. Lấy danh sách các chuyến bay gồm mã vé, mã hành khách,
 chuyến bay đã đặt, và số lượng vé cho chuyến bay có trạng thái "Confirmed", sắp xếp theo số lượng vé giảm dần*/
select b.booking_id, p.passenger_id, concat(airline_name,' - ','Bay từ ',departure_airport,' đến ',arrival_airport) as booked_flight, b.ticket_quantity  from booking b
join passenger p on p.passenger_id = b.passenger_id
join flight f on f.flight_id = b.flight_id
where b.booking_status = 'Confirmed'
order by b.ticket_quantity desc;

/*
5. Lấy danh sách các hành khách gồm mã vé, tên hành khách, chuyến bay đã đặt, 
và số lượng vé cho các hành khách có số lượng vé đặt trong khoảng từ 2 đến 3, sắp xếp theo tên hành khách
*/
select b.booking_id, p.passenger_full_name,
concat(airline_name,' - ','Bay từ ',departure_airport,' đến ',arrival_airport) as booked_flight, b.ticket_quantity from booking b
join passenger p on p.passenger_id = b.passenger_id
join flight f on f.flight_id = b.flight_id
where b.ticket_quantity between 2 and 3
order by p.passenger_full_name;


/*
6. Lấy danh sách các hành khách đã đặt ít nhất 2 vé và có trạng thái thanh toán là "Pending", gồm mã hành khách, tên hành khách và số lượng vé đã đặt
*/
select p.passenger_id, p.passenger_full_name, b.ticket_quantity from booking b
join passenger p on p.passenger_id = b.passenger_id
join payment pay on pay.booking_id = b.booking_id 
where b.ticket_quantity >= 2 and pay.payment_status = 'pending';


/*
7. Lấy danh sách các hành khách gồm mã hành khách, tên hành khách và số tiền thanh toán cho các giao dịch có trạng thái thanh toán "Success"
*/
select p.passenger_id, p.passenger_full_name, pa.payment_amount from booking b
join passenger p on p.passenger_id = b.passenger_id
join payment pa on pa.booking_id = b.booking_id
where pa.payment_status = 'Success';


/*
8. Lấy danh sách 5 hành khách đầu tiên có số lượng vé đặt (ticket_quantity) lớn hơn 1,
 sắp xếp theo số lượng vé giảm dần, gồm mã hành khách, tên hành khách, số lượng vé và trạng thái vé
*/
select p.passenger_id, p.passenger_full_name, b.ticket_quantity, b.booking_status from booking b
join passenger p on p.passenger_id = b.passenger_id
where b.ticket_quantity > 1 
order by ticket_quantity desc
limit 5;

/*
9. Lấy danh sách các chuyến bay có số lượng vé đặt nhiều nhất, gồm mã chuyến bay, tên hãng hàng không, và số lượng vé đặt
*/
select f.flight_id, f.airline_name, sum(b.ticket_quantity) from booking b
join flight f on f.flight_id = b.flight_id
group by  f.flight_id, f.airline_name
-- so sánh để lọc ra danh sách chuyến bay được đặt vé nhiều dựa trên chuyến bay được đặt vé nhiều nhất.
having sum(b.ticket_quantity) = (
	select sum(b.ticket_quantity) from booking b
	join flight f on f.flight_id = b.flight_id
	group by  f.flight_id
	order by  sum(b.ticket_quantity) desc limit 1
)
order by  sum(b.ticket_quantity);


/*
10. Lấy danh sách các hành khách gồm tên hành khách, số tiền thanh toán,
trạng thái thanh toán cho những hành khách có ngày sinh trước năm 2000, sắp xếp theo tên hành khách
*/
select p.passenger_full_name, pa.payment_amount, pa.payment_status  from booking b
join passenger p on p.passenger_id = b.passenger_id
join payment pa on pa.booking_id = b.booking_id
where year(p.passenger_bod) < 2000
order by p.passenger_full_name;

#5 TẠO VIEW --------------------------------------------------------------------------------------------------
/*
1. Tạo view view_all_passenger_booking để lấy danh sách tất cả các hành khách và vé họ đã đặt,
 gồm mã hành khách, tên hành khách, mã vé, mã chuyến bay và số lượng vé đã đặt
*/
create view view_all_passenger_booking as
select p.passenger_id, p.passenger_full_name, b.booking_id, f.flight_id, 
b.ticket_quantity as total_booked_ticket from booking b
join passenger p on p.passenger_id = b.passenger_id
join flight f on f.flight_id = b.flight_id;

select passenger_id, passenger_full_name, booking_id, flight_id, total_booked_ticket from view_all_passenger_booking;

/*
2. Tạo view view_successful_payment để lấy danh sách các hành khách đã thanh toán thành công, 
gồm mã hành khách, tên hành khách và số tiền thanh toán, chỉ lấy các giao dịch có trạng thái thanh toán "Success"
*/
create view view_successful_payment as 
select p.passenger_id, p.passenger_full_name, sum(pa.payment_amount) as total_payment from booking b
join passenger p on p.passenger_id = b.passenger_id
join payment pa on pa.booking_id = b.booking_id
where pa.payment_status = 'success'
group by p.passenger_id, p.passenger_full_name;

select  passenger_id, passenger_full_name, payment_amount from view_successful_payment;

#6 TẠO TRIGGER -----------------------------------------------------------------------------------------------------
/*
1. Tạo một trigger để kiểm tra và đảm bảo rằng số lượng vé (ticket_quantity) trong bảng Booking không bị giảm xuống dưới 1 khi có sự thay đổi.
 Nếu số lượng vé nhỏ hơn 1, trigger sẽ thông báo lỗi SIGNAL SQLSTATE và không cho phép cập nhật.
*/
delimiter //
create trigger trg_bf_update_booking 
before update on booking for each row
begin
	if(new.ticket_quantity < 1) then
		signal sqlstate '45000' set message_text = 'ticket_quantity không được nhỏ hơn 1';
    end if;
end
// delimiter ;

-- kiểm tra
update booking
set ticket_quantity = 0
where booking_id = 1; -- báo lỗi 

/*
2. Tạo một trigger để khi thực hiện chèn dữ liệu vào bảng Payment, sẽ tự động kiểm tra trạng thái thanh toán,
nếu như trạng thái thanh toán là “Success” thì tiến hành cập nhật trạng thái booking_status của ở bảng Booking tương ứng với hóa đơn đó thành “Confirmed”
*/
delimiter //
create trigger trg_af_insert_payment
after insert on payment 
for each row
begin
    -- kiểm tra nếu trạng thái thanh toán là 'success'
    if new.payment_status = 'success' then
        -- cập nhật trạng thái của booking tương ứng thành 'confirmed'
        update booking
        set booking_status = 'confirmed'
        where booking_id = new.booking_id;
    end if;
end; 
// delimiter ;

-- kiểm tra
insert into payment (booking_id,payment_method,payment_amount,payment_date,payment_status) values
(3,'Credit Card','150.5','2025-02-20','Success');

select b.booking_id, pa.payment_id, b.passenger_id, b.flight_id, b.ticket_quantity, pa.payment_method, pa.payment_amount, pa.payment_status, b.booking_status from booking b
left join payment pa on pa.booking_id = b.booking_id;


#7 TẠO PROCEDURE ------------------------------------------------------------------------------------------------
/*
1. Tạo một stored procedure có tên GetAllPassengerBookings để lấy thông tin tất cả các hành khách và vé họ đã đặt,
bao gồm mã hành khách, tên hành khách, mã vé, mã chuyến bay và số lượng vé
*/
delimiter //
create procedure GetAllPassengerBookings ()
begin
	select p.passenger_id, p.passenger_full_name, b.booking_id, f.flight_id, b.ticket_quantity from booking b
    join passenger p on p.passenger_id = b.passenger_id
    join flight f on f.flight_id = b.flight_id;
end
// delimiter ;

call GetAllPassengerBookings();

/*
2. Tạo một stored procedure có tên AddBooking để thực hiện thao tác cập nhật một bản ghi trong vào bảng Booking dựa theo khóa chính.
Các tham số đầu vào:
p_booking_id: Mã vé.
p_passenger_id: Mã hành khách.
p_flight_id: Mã chuyến bay.
p_ticket_quantity: Số lượng vé.

==> thầy Quang yêu cầu bỏ hai input này:
p_payment_method: Phương thức thanh toán.
p_payment_amount: Số tiền thanh toán.
*/
set autocommit = 0;
delimiter //
create procedure addbooking (
    in p_booking_id int,
    in p_passenger_id char(10),
    in p_flight_id char(10),
    in p_ticket_quantity int
)
begin
    start transaction;
    -- kiểm tra các khóa truyền vào có tồn tại không (liên kết với bảng booking)
    if not exists (
        select 1 from booking b
        join passenger p on p.passenger_id = b.passenger_id
        join flight f on f.flight_id = b.flight_id
        where b.passenger_id = p_passenger_id 
        and b.booking_id = p_booking_id 
        and b.flight_id = p_flight_id
    ) then
        rollback;
        signal sqlstate '45000' set message_text = 'booking not exists';
    else 
        -- nếu tồn tại, cập nhật số lượng vé 
        update booking 
        set ticket_quantity = p_ticket_quantity
        where booking_id = p_booking_id;
        
        -- cập nhật tổng tiền thanh toán nếu đã có bản ghi trong payment
        update payment
        set payment_amount = p_ticket_quantity * (select ticket_price from flight where flight_id = p_flight_id)
        where booking_id = p_booking_id;

        -- nếu không có bản ghi trong payment, chèn mới
        insert into payment (booking_id, payment_method, payment_amount, payment_date, payment_status)
        select p_booking_id, 'credit card', (p_ticket_quantity * f.ticket_price), curdate(), 'pending' from flight f
        where f.flight_id = p_flight_id and not exists (select 1 from payment where booking_id = p_booking_id);
    end if;
    commit;
end;
// delimiter ;

-- kiểm tra
call addbooking (1, 'p0003', 'f001', 3); -- ok
call addbooking (999, 'p9999', 'f999', 2); -- lỗi 

select b.booking_id, b.passenger_id, b.flight_id, f.ticket_price, b.ticket_quantity, pa.payment_method, pa.payment_amount, pa.payment_status, b.booking_status from booking b
join passenger p on p.passenger_id = b.passenger_id
join flight f on f.flight_id = b.flight_id
join payment pa on pa.booking_id = b.booking_id;

