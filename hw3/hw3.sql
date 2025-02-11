#1
-- Inserting categories of books into the Categories table
INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Science'),
(2, 'Literature'),
(3, 'History'),
(4, 'Technology'),
(5, 'Psychology');

-- Inserting books into the Books table with details such as title, author, and category
INSERT INTO Books (book_id, title, author, pub_year, available_quantity, category_id) VALUES
(1, 'The History of Vietnam', 'John Smith', 2001, 10, 1),
(2, 'Python Programming', 'Jane Doe', 2020, 5, 4),
(3, 'Famous Writers', 'Emily Johnson', 2018, 7, 2),
(4, 'Machine Learning Basics', 'Michael Brown', 2022, 3, 4),
(5, 'Psychology and Behavior', 'Sarah Davis', 2019, 6, 5);

-- Inserting library users (readers) into the Readers table
INSERT INTO Readers (reader_id, r_name, phone_number, email) VALUES
(1, 'Alice Williams', '123-456-7890', 'alice.williams@email.com'),
(2, 'Bob Johnson', '987-654-3210', 'bob.johnson@email.com'),
(3, 'Charlie Brown', '555-123-4567', 'charlie.brown@email.com');

-- Inserting borrowing records for books
INSERT INTO Borrowing (borrow_id, reader_id, book_id, borrow_date, due_date) VALUES
(1, 1, 1, '2025-02-19', '2025-02-15'),
(2, 2, 2, '2025-02-03', '2025-02-17'),
(3, 3, 3, '2025-02-02', '2025-02-16'),
(4, 1, 2, '2025-03-10', '2025-02-24'),
(5, 2, 3, '2025-05-11', '2025-02-25'),
(6, 2, 3, '2025-02-11', '2025-02-25');


-- Inserting book return records into the Returning table
INSERT INTO Returning (return_id, borrow_id, return_date) VALUES
(1, 1, '2025-03-14'),
(2, 2, '2025-02-28'),
(3, 3, '2025-02-15'),
(4, 4, '2025-02-20'),  
(5, 4, '2025-02-20');

-- Inserting penalty records into the Fines table for late returns
INSERT INTO Fines (fine_id, return_id, fine_amount) VALUES
(1, 1, 5.00),
(2, 2, 0.00),
(3, 3, 2.00);


#2
SELECT * FROM books;
SELECT * FROM readers;

select r.r_name , b.title, br.borrow_date
from borrowing as br
join readers as r on br.reader_id = r.reader_id
join books as b on br.book_id = b.book_id;


select b.title , b.author, c.category_name from books as b
join categories as c on b.category_id = c.category_id;


select r.r_name , f.fine_amount , ret.return_date
from fines as f
join returning as ret on f.return_id = ret.return_id
join borrowing as b on ret.borrow_id = b.borrow_id
join readers as r on b.reader_id = r.reader_id;

#2
update books
set available_quantity = 15
where book_id = 1;

set sql_safe_updates = 0;
delete from fines where return_id in (select return_id from returning where borrow_id in (select borrow_id from borrowing where reader_id = 2));
delete from returning where borrow_id in (select borrow_id from borrowing where reader_id = 2);
delete br from borrowing as br
join readers as r on r.reader_id = br.reader_id  
where br.reader_id =2;
delete from readers where reader_id = 2;

insert into readers (reader_id, r_name, phone_number, email) 
values (2, 'Bob Johnson', '987-654-3210', 'bob.johnson@email.com');