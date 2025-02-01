use ss04;
create table customer (
	customer_id int primary key auto_increment,
    customer_name varchar(255) not null,
    birthday date not null,
    sex bit not null,
    job varchar(50),
    phone_number char(11) not null unique,
    email varchar(100) not null unique,
    address varchar(255) not null
);

insert into customer (customer_name, birthday, sex, job, phone_number, email, address) values
('Nguyễn Văn A', '1990-01-15', 1, 'Kỹ sư', '01234567890', 'nguyenvana@example.com', 'Hà Nội, Việt Nam'),
('Trần Thị B', '1985-03-22', 0, 'Giáo viên', '01234567891', 'tranthib@example.com', 'Đà Nẵng, Việt Nam'),
('Lê Văn C', '1992-06-10', 1, 'Nhân viên văn phòng', '01234567892', 'levanc@example.com', 'Hồ Chí Minh, Việt Nam'),
('Phạm Thị D', '1988-09-30', 0, 'Chủ doanh nghiệp', '01234567893', 'phamthid@example.com', 'Nha Trang, Việt Nam'),
('Nguyễn Văn E', '1995-08-05', 1, 'Sinh viên', '01234567894', 'nguyenvane@example.com', 'Hải Phòng, Việt Nam'),
('Trần Văn F', '1991-12-12', 1, 'Y tá', '01234567895', 'tranvanf@example.com', 'Cần Thơ, Việt Nam'),
('Lê Thị G', '1993-04-25', 0, 'Kế toán', '01234567896', 'lethig@example.com', 'Hà Giang, Việt Nam'),
('Nguyễn Văn H', '1986-07-19', 1, 'Nhà báo', '01234567897', 'nguyenvanh@example.com', 'Huế, Việt Nam'),
('Phạm Văn I', '1994-02-14', 1, 'Thiết kế đồ họa', '01234567898', 'phamvani@example.com', 'Đồng Nai, Việt Nam'),
('Nguyễn Thị J', '1993-11-11', 0, 'Nhân viên bán hàng', '01234567899', 'nguyenthij@example.com', 'Long An, Việt Nam');

update customer set
customer_name = 'Nguyễn Quang Nhật',
birthday = '2004-01-11'
where customer_id = 1;

delete from customer where month(birthday) = '8';

select customer_id, customer_name, birthday, sex, phone_number from customer 
where birthday < '2004-01-11';

select * from customer where job is null;
