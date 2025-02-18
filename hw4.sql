use ss13;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    available_seats INT NOT NULL
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
INSERT INTO students (student_name) VALUES ('Nguyễn Văn An'), ('Trần Thị Ba');

INSERT INTO courses (course_name, available_seats) VALUES 
('Lập trình C', 25), 
('Cơ sở dữ liệu', 22);


#2 -- sử dụng tên nhưng đề không có unique, lỡ sinh viên trùng tên nhau thì sao 
delimiter //
create procedure sp_enroll_course (in in_student_name varchar(50), in in_course_name varchar(50))
begin
	start transaction;
    -- check slot
    if (select coalesce(available_seats, 0) from courses where course_name = in_course_name) <= 0 then
		rollback;
		signal sqlstate '45000' set message_text = 'not enough slot';
    end if;
    
    -- add 
    insert into enrollments (student_id, course_id) values
    ((select coalesce(student_id,0) from students where student_name = in_student_name), (select coalesce(course_id,0) from courses  where course_name = in_course_name));
    
    update courses set available_seats = available_seats - 1  where course_name = in_course_name ;
     commit;
end
// delimiter ;

drop procedure sp_enroll_course;

#3
set sql_safe_updates = 0;
call sp_enroll_course ('Nguyễn Văn An','Lập trình C');