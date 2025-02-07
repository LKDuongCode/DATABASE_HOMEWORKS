#2
select s.student_id, s.name as student_name, s.email, c.course_name, e.enrollment_date from students as s 
join enrollments as e on s.student_id = e.student_id 
join courses as c on e.course_id = c.course_id 
where s.student_id in (select student_id 
from enrollments 
group by student_id 
having count(course_id) > 1) 
order by s.student_id, e.enrollment_date;

#3
select s2.name as student_name, s2.email, e.enrollment_date, c.course_name, c.fee from students as s1 
join enrollments as e on s1.student_id = e.student_id 
join courses as c on e.course_id = c.course_id 
join enrollments as e2 on c.course_id = e2.course_id 
join students as s2 on e2.student_id = s2.student_id 
where s1.name = 'Nguyen Van An' and s2.student_id != s1.student_id;
    
#4
select c.course_name, c.duration, c.fee, count(e.student_id) as total_students from courses as c 
join enrollments as e on c.course_id = e.course_id 
group by c.course_name, c.duration, c.fee 
having total_students > 2;
    
#5
select s.name as student_name, s.email, sum(c.fee) as total_fee_paid, count(e.course_id) as courses_count from students s 
join enrollments as e on s.student_id = e.student_id 
join courses as c on e.course_id = c.course_id 
where c.duration > 30 
group by s.student_id, s.name, s.email 
having count(e.course_id) >= 2;