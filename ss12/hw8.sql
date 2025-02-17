use ss12;

#2
create table salary_history (
    history_id int auto_increment primary key,
    emp_id int not null,
    old_salary decimal(10, 2) not null,
    new_salary decimal(10, 2) not null,
    change_date datetime not null,
    foreign key (emp_id) references employees(emp_id)
);

#3
create table salary_warnings (
    warning_id int auto_increment primary key,
    emp_id int not null,
    warning_message varchar(255) not null,
    warning_date datetime not null,
    foreign key (emp_id) references employees(emp_id)
);

#4
delimiter //
create trigger after_salary_update
after update on employees for each row
begin
    insert into salary_history (emp_id, old_salary, new_salary, change_date)
    values (old.emp_id, old.salary, new.salary, now());
    if new.salary < old.salary * 0.7 then
        insert into salary_warnings (emp_id, warning_message, warning_date)
        values (new.emp_id, 'Salary decreased by more than 30%', now());
    end if;
    if new.salary > old.salary * 1.5 then
        set new.salary = old.salary * 1.5;
        insert into salary_warnings (emp_id, warning_message, warning_date)
        values (new.emp_id, 'Salary increased above allowed threshold (adjusted to 150% of previous salary)', now());
    end if;
end
// delimiter ;

#5
delimiter //
create trigger after_project_insert after insert on projects for each row
begin
    declare active_pj int;
    select count(*) into active_pj from projects
    where emp_id = new.emp_id and status = 'in progress';
    if active_pj > 3 then
        signal sqlstate '45000' set message_text = 'more than 3 project';
    end if;
    if new.status = 'in progress' and new.start_date > now() then
        signal sqlstate '45000' set message_text = 'wrong status"';
    end if;
end
// delimiter ;

#6
create view PerformanceOverview as
select p.project_id, p.name as project_name, count(e.emp_id) as employee_count, datediff(p.end_date, p.start_date) as total_days, p.status from projects p
left join employees e on p.emp_id = e.emp_id
group by p.project_id, p.name, p.end_date, p.start_date, p.status;

#7
update employees 
set salary = salary * 0.5 
where emp_id = 1; 

update employees
set salary = salary * 2
where emp_id = 2; 

#8
insert into projects (name, emp_id, start_date, status) 
values ('new 1', 1, curdate(), 'in progress');
insert into projects (name, emp_id, start_date, status) 
values ('new 2', 1, curdate(), 'in progress');
insert into projects (name, emp_id, start_date, status) 
values ('new 3', 1, curdate(), 'in progress');
insert into projects (name, emp_id, start_date, status) 
values ('new 4', 1, curdate(), 'in progress'); 

insert into projects (name, emp_id, start_date, status) 
values ('future project', 2, date_add(curdate(), interval 5 day), 'in progress');

#9
select * from PerformanceOverview;