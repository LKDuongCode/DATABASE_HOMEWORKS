use ss11;

#2
delimiter //
create procedure UpdateSalaryByID (in in_empid int, out new_salary decimal(10,2))
begin
    set new_salary = (select salary from employees where employeeid = in_empid);
    
    if new_salary < 20000000 then
        set new_salary = new_salary * 1.1;
    else
        set new_salary = new_salary * 1.05;
    end if;
end 
// delimiter ;



#3
delimiter //
create procedure GetLoanAmountByCustomerID (in in_customerid int, out out_total_loans decimal(15,2))
begin
	select sum(loanamount) into out_total_loans from loans  where CustomerID = in_customerid group by CustomerID;
    if out_total_loans is null then
		set out_total_loans = 0;
    end if;
end
// delimiter ;
drop procedure if exists GetLoanAmountByCustomerID;

#4
delimiter //
create procedure DeleteAccountIfLowBalance(in in_accID int)
begin
	declare acc_balance decimal(15,2) default 0;
    set acc_balance = (select balance from accounts where accountid = in_accid);
	if acc_balance < 1000000 then
		select 'Tài khoản có số dư dưới 1 triệu - xóa thành công!' as mes;
	else select 'Không thể xóa! ' as mes;
    end if;
end
 // delimiter ;

#5
delimiter //
create procedure transferMoney(in from_account int, in to_account int, in amount decimal(15,2))
begin
	-- kiểm tra tk tồn tại
    declare is_exist bit default 0;
    declare is_enough bit default 0;
    if (select count(accountid) from accounts where accountid = from_account) > 0 and (select count(accountid) from accounts where accountid = to_account) > 0 then
		set is_exist = 1;
	else select 'tai khoan khong ton tai' as mes;
    end if;
    
    -- kiểm tra số dư
    if is_exist = 1 and (select balance from accounts where  accountid = from_account ) > amount then 
		set is_enough = 1;
	else select 'tai khoan khong du tien' as mes;
	end if;
    
    -- chuyen tien
	if is_enough = 1 then
		update accounts set balance = balance - amount where accountid = from_account;
		update accounts set balance = balance + amount where accountid = to_account;
        select 'chuyen tien thanh cong', amount as mes;
    end if;
end
// delimiter ;
drop procedure if exists transferMoney;

#6
set @new_salary = 0;
call UpdateSalaryByID(4,@new_salary);

update employees 
set salary = @new_salary
where employeeid = 4;
select salary from employees where employeeid = 4;

--
set @total_loans = 0;
call GetLoanAmountByCustomerID (1, @total_loans);
select @total_loans;
--
call DeleteAccountIfLowBalance(8);

--
call transferMoney(1,3,2000000);



