#2
create view view_manager_summary as
select manager_id, count(manager_id) as total_employees  from employees
where manager_id is not null
group by manager_id;

#3
select * from view_manager_summary;

#4
select e.name, v.total_employees from view_manager_summary as v
join employees as e on v.manager_id = e.employee_id;