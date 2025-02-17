use ss12;

#1
create table projects (
    project_id int auto_increment primary key,
    name varchar(100) not null,
    budget decimal(15,2) not null,
    total_salary decimal(15,2) default 0
);

create table workers (
    worker_id int auto_increment primary key,
    name varchar(100) not null,
    project_id int,
    salary decimal(10,2) not null,
    foreign key (project_id) references projects(project_id)
);

#2
INSERT INTO projects (name, budget) VALUES
('Bridge Construction', 10000.00),
('Road Expansion', 15000.00),
('Office Renovation', 8000.00);

#3
delimiter //
create trigger trg_after_insert_worker
after insert on workers for each row
begin
	update projects 
    set total_salary = total_salary + new.salary
    where worker_id = new.worker_id;
end;

create trigger trg_after_delete_worker
after delete on workers for each row 
begin
	update projects 
    set total_salary = total_salary - old.salary
    where worker_id = old.worker_id;
end
// delimiter ;

#4
INSERT INTO workers (name, project_id, salary) VALUES
('John', 1, 2500.00),
('Alice', 1, 3000.00),
('Bob', 2, 2000.00),
('Eve', 2, 3500.00),
('Charlie', 3, 1500.00);

#5
delete from workers where worker_id = 1;
select * from project;

