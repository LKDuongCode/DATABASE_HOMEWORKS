USE ss14_second;

#2
delimiter //
create procedure IncreaseSalary(in emp_id int,in new_salary decimal(10,2),in reason text)
begin
    declare old_salary decimal(10,2);
    declare emp_exists int default 0;
	select exists(select 1 from salaries where employee_id = emp_id) into emp_exists;
    
    if emp_exists = 0 then
        signal sqlstate '45000' set message_text = 'nhân viên không tồn tại!';
    end if;
    
	select base_salary into old_salary from salaries where employee_id = emp_id;
   start transaction;
    insert into salary_history (employee_id, old_salary, new_salary, reason)
    values (emp_id, old_salary, new_salary, reason);
    update salaries set base_salary = new_salary where employee_id = emp_id;
    commit;
end //
delimiter ;


#3
call IncreaseSalary(1, 5000.00, 'tăng lương định kỳ');

#4
delimiter //
create procedure DeleteEmployee(in emp_id int)
begin
    declare emp_exists int default 0;
    declare old_salary decimal(10,2);
    select exists (select 1 from employees where employee_id = emp_id) into emp_exists;

    if emp_exists = 0 then
        signal sqlstate '45000' set message_text = 'nhân viên không tồn tại!';
    end if;
    
    select base_salary into old_salary from salaries where employee_id = emp_id;
    
   start transaction;
    insert into salary_history (employee_id, old_salary, new_salary, reason)
    values (emp_id, old_salary, null, 'nhân viên đã bị xóa');
    delete from salaries where employee_id = emp_id;
    delete from employees where employee_id = emp_id;
    commit;
end //
delimiter ;
#5
call DeleteEmployee(2);