use ss13;

#2
create table transaction_log (
	log_id int primary key auto_increment,
    log_mes text not null,
    log_time timestamp default current_timestamp
);

#3
alter table transaction_log add column last_pay_date date ;
alter table employees add column last_pay_date date ;
#4
delimiter //
create procedure sp_trans_money_to_emp(in in_emp_id int, in in_fund_id int)
begin
    declare balance_fund decimal(15,2);
	declare employee_salary decimal(10,2);
	
	select balance into balance_fund from company_funds where fund_id = in_fund_id;
	select salary into employee_salary from employees where emp_id = in_emp_id;

	start transaction;
	-- kiểm tra nhân viên tồn tại
    if not exists (select 1 from employees where emp_id =  in_emp_id) then
		insert into transaction_log (log_mes,last_pay_date) values
        ('not exists', curdate());
        rollback;
        signal sqlstate '45000' set message_text = 'not exists';
    end if;
    
	-- kiểm tra số dư 
    if balance_fund < employee_salary then
		insert into transaction_log (log_mes,last_pay_date) values
        ('not enough fund', curdate());
        rollback;
        signal sqlstate '45000' set message_text = 'not enough fund';
    end if;

    
    -- chuyển tiền 
	update company_funds set balance = balance - employee_salary where fund_id = in_fund_id;
    insert into payroll (emp_id, salary, pay_date) values
    (in_emp_id, employee_salary, curdate());
    
    update employees set last_pay_date = curdate() where emp_id = in_emp_id;
    
	insert into transaction_log (log_mes,last_pay_date) values
	('success', curdate());
    
    commit;
    
end
// delimiter ;

call sp_trans_money_to_emp (1,1);
