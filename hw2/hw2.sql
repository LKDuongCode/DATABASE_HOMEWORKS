use ss07;

#1
create table departments (
    department_id int primary key,
    department_name varchar(255),
    location varchar(255)
);

create table employees (
    employee_id int primary key,
    name varchar(255),
    dob date,
    department_id int,
    salary decimal(10, 2),
    foreign key (department_id) references departments(department_id)
);

create table projects (
    project_id int primary key,
    project_name varchar(255),
    start_date date,
    end_date date
);

create table workReports (
    report_id int primary key,
    employee_id int,
    report_date date,
    report_content text,
    foreign key (employee_id) references employees(employee_id)
);

create table timeSheets (
    timesheet_id int primary key,
    employee_id int,
    project_id int,
    work_date date,
    hours_worked decimal(5, 2),
    foreign key (employee_id) references employees(employee_id),
    foreign key (project_id) references projects(project_id)
);
#2 trong ảnh kèm

#3
insert into departments (department_id, department_name, location) values
(1, 'Sales', 'New York'),
(2, 'Engineering', 'San Francisco'),
(3, 'Human Resources', 'Chicago'),
(4, 'Marketing', 'Los Angeles'),
(5, 'Finance', 'Boston');

insert into employees (employee_id, name, dob, department_id, salary) values
(1, 'John Doe', '1985-05-15', 1, 50000.00),
(2, 'Jane Smith', '1990-08-25', 2, 60000.00),
(3, 'Alice Johnson', '1988-03-30', 3, 55000.00),
(4, 'Bob Brown', '1992-11-12', 4, 52000.00),
(5, 'Charlie Davis', '1987-07-20', 5, 58000.00);

insert into projects (project_id, project_name, start_date, end_date) values
(1, 'Project Alpha', '2023-01-01', '2023-06-30'),
(2, 'Project Beta', '2023-02-15', '2023-08-15'),
(3, 'Project Gamma', '2023-03-01', '2023-09-30'),
(4, 'Project Delta', '2023-04-10', '2023-10-10'),
(5, 'Project Epsilon', '2023-05-20', '2023-11-20');

insert into workReports (report_id, employee_id, report_date, report_content) values
(1, 1, '2023-01-10', 'Completed initial sales analysis.'),
(2, 2, '2023-02-20', 'Developed new feature for the app.'),
(3, 3, '2023-03-15', 'Conducted employee satisfaction survey.'),
(4, 4, '2023-04-25', 'Launched new marketing campaign.'),
(5, 5, '2023-05-30', 'Prepared quarterly financial report.');

insert into timeSheets (timesheet_id, employee_id, project_id, work_date, hours_worked) values
(1, 1, 1, '2023-01-05', 8.00),
(2, 2, 2, '2023-02-10', 7.50),
(3, 3, 3, '2023-03-12', 6.00),
(4, 4, 4, '2023-04-18', 8.50),
(5, 5, 5, '2023-05-22', 7.00);

#4
update projects
set project_name = 'project qt'
where project_id = 1;

#5
delete t
from timesheets t
join employees e on t.employee_id = e.employee_id
where e.employee_id = 1;

delete w
from workreports w
join employees e on w.employee_id = e.employee_id
where e.employee_id = 1;

delete from employees
where employee_id = 1;