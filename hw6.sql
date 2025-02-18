use ss13;

#2
create table enrollments_history (
	history_id int primary key auto_increment,
    student_id int,
    foreign key (student_id) references students(student_id),
    course_id int,
    foreign key (course_id) references students(course_id),
    enroll_action varchar(50),
    created_at timestamp default current_timestamp
);

#3
delimiter //
create procedure sp_enroll_course2 (in in_student_name varchar(50), in in_course_name varchar(50))
begin
	start transaction;
    -- check enroll
    if exists (select 1 from enrollments where student_id = (select student_id from students where student_name = in_student_name) and course_id = (select course_id from courses where course_name = in_course_name)) then
		rollback;
        signal sqlstate '45000' set message_text = 'already enrolled!';
	end if;
    
    -- check slot
    if (select coalesce(available_seats, 0) from courses where course_name = in_course_name) <= 0 then
		insert into enrollment_history (student_id, course_id, status, enroll_date)
		values ((select student_id from students where student_name = in_student_name),(select course_id from courses where course_name = in_course_name),'not enough slot',now());
		rollback;
		signal sqlstate '45000' set message_text = 'not enough slot';
    end if;
    
    -- add 
    insert into enrollments (student_id, course_id) values
    ((select coalesce(student_id,0) from students where student_name = in_student_name), (select coalesce(course_id,0) from courses  where course_name = in_course_name));
    
    update courses set available_seats = available_seats - 1  where course_name = in_course_name ;
	insert into enrollment_history (student_id, course_id, status, enroll_date)
	values ((select student_id from students where student_name = in_student_name),(select course_id from courses where course_name = in_course_name), 'success', now());
     commit;
end
// delimiter ;

#3
set sql_safe_updates = 0;
call sp_enroll_course2 ('Nguyễn Văn An','Lập trình C');
