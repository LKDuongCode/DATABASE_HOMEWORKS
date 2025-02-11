use session07;

create database Test2;
use Test2;

create table students (
    studentId int primary key,
    studentName varchar(50),
    age int,
    email varchar(100)
);

create table class (
    classId int primary key,
    className varchar(50)
);

create table classStudent (
    studentId int,
    classId int,
    primary key (studentId, classId),
    foreign key (studentId) references students(studentId),
    foreign key (classId) references class(classId)
);

create table subjects (
    subjectId int primary key,
    subjectName varchar(50)
);

create table mark (
    mark int,
    subjectId int,
    studentId int,
    primary key (subjectId, studentId),
    foreign key (subjectId) references subjects(subjectId),
    foreign key (studentId) references students(studentId)
);

insert into students (studentId, studentName, age, email) values
(1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
(2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
(3, 'Nguyen Van Quyen', 19, 'quyen'),
(4, 'Pham Thanh Binh', 25, 'binh@com'),
(5, 'Nguyen Van Tai Em', 30, 'taiem@sport.vn');

insert into class (classId, className) values
(1, 'C0706L'),
(2, 'C0708G');

insert into classStudent (studentId, classId) values
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 2),
(5, 1);

insert into subjects (subjectId, subjectName) values
(1, 'SQL'),
(2, 'Java'),
(3, 'C'),
(4, 'Visual Basic');

insert into mark (mark, subjectId, studentId) values
(8, 1, 1),
(4, 2, 1),
(9, 1, 1),
(7, 1, 3),
(3, 1, 4),
(5, 2, 5),
(8, 3, 3),
(1, 3, 5),
(3, 2, 4);

select * from students;

select * from subjects;

select studentId, avg(mark) as averageMark
from mark
group by studentId;

select distinct s.subjectName
from subjects s
join mark m on s.subjectId = m.subjectId
where m.mark > 9;

select studentId, avg(mark) as averageMark
from mark
group by studentId
order by averageMark desc;

update subjects
set subjectName = concat('Day la mon hoc ', subjectName);

alter table classStudent drop foreign key classStudent_ibfk_1;
alter table classStudent drop foreign key classStudent_ibfk_2;
alter table mark drop foreign key mark_ibfk_1;
alter table mark drop foreign key mark_ibfk_2;

delete from students where studentId = 1;

alter table students add column status bit default 1;

update students set status = 0;