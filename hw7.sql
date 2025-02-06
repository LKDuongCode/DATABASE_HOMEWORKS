#2
select s.name, s.email, c.course_name, e.enrollment_date from enrollments as e
left join students as s on s.student_id = e.student_id
left join courses as c on c.course_id = e.course_id
where s.email is null or e.enrollment_date between '2025-01-12'and '2025-01-18'
order by s.name asc;

#3
select c.course_name, c.fee, s.name, e.enrollment_date 
from courses as c
left join enrollments as e on c.course_id = e.course_id
left join students as s on s.student_id = e.student_id
where c.fee > 1000000 or e.student_id is null
order by c.fee asc, c.course_name desc;

#4
select s.name, s.email, c.course_name, e.enrollment_date from enrollments as e
left join students as s on s.student_id = e.student_id
left join courses as c on c.course_id = e.course_id
where s.email is null or c.fee > 1000000
order by s.name asc, c.course_name asc;




