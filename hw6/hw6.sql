#2
select e.name, d.department_name
from employees as e
join departments as d on e.department_id = d.department_id
order by e.name;

select name, salary
from employees
where salary > 5000
order by salary desc;

select e.name, coalesce(sum(t.hours_worked), 0) as total_hours
from employees as e
left join timeSheets as t on e.employee_id = t.employee_id
group by e.employee_id, e.name;

select d.department_name, avg(e.salary) as avg_salary
from employees as e
join departments as d on e.department_id = d.department_id
group by d.department_id, d.department_name;

select p.project_name, coalesce(sum(t.hours_worked), 0) as total_hours
from projects as p
join timeSheets as t on p.project_id = t.project_id
where year(t.work_date) = 2025 and month(t.work_date) = 2
group by p.project_id, p.project_name;

select e.name , p.project_name, coalesce(sum(t.hours_worked), 0) as total_hours
from employees as e
join timeSheets as t on e.employee_id = t.employee_id
join projects as p on t.project_id = p.project_id
group by e.employee_id, e.name, p.project_id, p.project_name;


select d.department_name, count(e.employee_id) as employee_count
from departments as d
join employees as e on d.department_id = e.department_id
group by d.department_id, d.department_name
having count(e.employee_id) > 1;

select w.report_date, e.name, w.report_content
from workReports as w
join employees as e on w.employee_id = e.employee_id
order by w.report_date desc
limit 2 offset 1;

select w.report_date, e.name as employee_name, count(w.report_id) as report_count
from workReports as w
join employees as e on w.employee_id = e.employee_id
where w.report_content is not null
and w.report_date between '2025-01-01' and '2025-02-01'
group by w.report_date, e.name;



