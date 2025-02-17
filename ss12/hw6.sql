use ss12;

#2
create table budget_warnings (
	warning_id int primary key auto_increment,
    project_id int not null,
    warning_mes varchar(255) not null
);

#3
delimiter //
create trigger trg_after_update_projects 
after update on  projects for each row
begin
	if(new.total_salary > new.budget) then
		if (select count(project_id) from budget_warnings where project_id = new.project_id ) = 0 then
            insert into budget_warnings (project_id, warning_mes) 
            values (new.project_id, 'Budget exceeded due to high salary');
		else select 'is exists';
        end if;
    end if;
end;
// delimiter ;

#4
create view ProjectOverview as
select p.project_id, p.project_name, p.total_salary, w.warning_mes from warning_mes w
join projects p on p.project_id = w.project_id;

#5
INSERT INTO workers (name, project_id, salary) VALUES ('Michael', 1, 6000.00);
INSERT INTO workers (name, project_id, salary) VALUES ('Sarah', 2, 10000.00);
INSERT INTO workers (name, project_id, salary) VALUES ('David', 3, 1000.00);

#6
select * from budget_warnings;
select * from ProjectOverview;