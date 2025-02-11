create database ss07;
use ss07;

#1
create table categories (
	category_id int primary key auto_increment,
    category_name varchar(255)
);

create table books (
	book_id int primary key auto_increment,
    title varchar(255),
    author varchar(255),
    pub_year int,
    available_quantity int,
    category_id int,
    constraint fk_category foreign key (category_id) references categories(category_id) 
);

create table readers (
	reader_id int primary key auto_increment,
    r_name varchar(255),
    phone_number varchar(15),
    email varchar(255)
);

create table borrowing (
	borrow_id int primary key auto_increment,
    reader_id int,
    book_id int,
    borrow_date date,
    due_date date,
    constraint fk_reader foreign key (reader_id) references readers(reader_id), 
    constraint fk_book foreign key (book_id) references books(book_id) 
);


create table returning (
	return_id int primary key auto_increment,
    borrow_id int,
    return_date date,
    constraint fk_borrow foreign key (borrow_id) references borrowing(borrow_id) 
);

create table fines (
	fine_id int primary key auto_increment,
    return_id int,
    fine_amount decimal(10,2),
    constraint fk_returning foreign key (return_id) references returning(return_id) 
);

#2 trong ảnh gửi kèm
#3 
insert into categories (category_name) values 
('Fiction'), 
('Non-Fiction');

insert into books (title, author, pub_year, available_quantity, category_id) values 
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 10, 1), 
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 2011, 5, 2);

insert into readers (r_name, phone_number, email) values 
('Nguyen Van A', '0123456789', 'nguyenvana@example.com'), 
('Tran Thi B', '0987654321', 'tranb@example.com');

insert into borrowing (reader_id, book_id, borrow_date, due_date) values 
(1, 1, '2023-10-01', '2023-10-15'), 
(2, 2, '2023-10-05', '2023-10-20');

insert into returning (borrow_id, return_date) values 
(1, '2023-10-10'), 
(2, '2023-10-18');

insert into fines (return_id, fine_amount) values 
(1, 0.00), 
(2, 5.00);

#4
select * from readers;
update readers
set r_name = 'Nguyen Van AA'
where reader_id = 1;

#5
select * from books;
delete from books
where book_id = 1;

