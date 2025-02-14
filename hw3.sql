use ss11;
#2
delimiter //
create procedure GetCustomerByPhone (in phone varchar(15))
begin
	select customerid, fullname, dateofbirth, address, email from customers where PhoneNumber = phone;
end
// delimiter ;

#3
delimiter //
create procedure GetTotalBalance (in in_customerid int, out total_balance decimal(15,2))
begin
	set total_balance = (select sum(balance) as total_balance from accounts a
    where CustomerID = in_customerid
    group by CustomerID);
end
// delimiter ;


#4
delimiter //
create procedure IncreaseEmployeeSalary (in employee_id int ,out new_salary decimal(10,2))
begin
	set new_salary = (select (salary * 1.1) from employees where employeeid = employee_id);
end
// delimiter ;


#5
call GetCustomerByPhone('0901234567');

set @total_balance = 0;
call GetTotalBalance (1,@total_balance);
select @total_balance as total;

set @new_salary = 0;
call IncreaseEmployeeSalary(4, @new_salary);
select @new_salary as new_salary;

#6
drop procedure if exists IncreaseEmployeeSalary;
drop procedure if exists GetTotalBalance;
drop procedure if exists GetCustomerByPhone;

