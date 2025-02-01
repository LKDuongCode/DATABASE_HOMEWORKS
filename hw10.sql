create table student10 (
	student_id int primary key auto_increment,
    std_name varchar(255) not null,
    email varchar(255) not null,
    dob date not null
);

create table enrollments (
	enrollment_id int primary key auto_increment,
    student_id int, foreign key (student_id) references student10(student_id),
    course_name varchar(255) not null,
    erollment_date date not null
);

INSERT INTO student10 (std_name, email, dob)
VALUES
('Nguyen Van A', 'nguyenvana@example.com', '2000-05-15'),
('Tran Thi B', 'tranthib@example.com', '1999-08-22'),
('Le Van C', 'levanc@example.com', '2001-01-10'),
('Pham Thi D', 'phamthid@example.com', '1998-12-05'),
('Hoang Van E', 'hoangvane@example.com', '2002-03-18');

INSERT INTO enrollments (student_id, course_name, enrollment_date)
VALUES
(1, 'Math 101', '2025-01-10'),
(1, 'Physics 101', '2025-01-15'),
(2, 'Chemistry 101', '2025-01-12'),
(2, 'Biology 101', '2025-01-20'),
(3, 'History 101', '2025-02-01'),
(3, 'Geography 101', '2025-02-05'),
(4, 'Computer Science 101', '2025-03-01'),
(4, 'Programming Basics', '2025-03-10'),
(5, 'English Literature', '2025-04-01'),
(5, 'Creative Writing', '2025-04-05');


SELECT * FROM student10 WHERE std_name LIKE 'Nguyen%' AND YEAR(dob) >= 2000;

set sql_safe_updates = 0;
update student10
set email = 'updated_email@example.com'
where std_name = 'Nguyen Van A';

select * from enrollments where course_name like '%101%';

delete from enrollments where enrollment_date < '2025-02-01';