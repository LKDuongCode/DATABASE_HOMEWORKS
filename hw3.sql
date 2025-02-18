use ss13;

CREATE TABLE company_funds (
    fund_id INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(15,2) NOT NULL -- Số dư quỹ công ty
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,   -- Tên nhân viên
    salary DECIMAL(10,2) NOT NULL    -- Lương nhân viên
);

CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,                      -- ID nhân viên (FK)
    salary DECIMAL(10,2) NOT NULL,   -- Lương được nhận
    pay_date DATE NOT NULL,          -- Ngày nhận lương
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


INSERT INTO company_funds (balance) VALUES (50000.00);

INSERT INTO employees (emp_name, salary) VALUES
('Nguyễn Văn An', 5000.00),
('Trần Thị Bốn', 4000.00),
('Lê Văn Cường', 3500.00),
('Hoàng Thị Dung', 4500.00),
('Phạm Văn Em', 3800.00);


#2
delimiter //
create procedure sp_trans_salary (in in_empid int, in in_fundid int) -- thêm id của funds vì nó không có liên kết gì với bảng employee
begin
    declare bank_status bit default 1;
    set autocommit = 0;
	start transaction;
    -- check balance
    if (select coalesce(balance,0) from company_funds where fund_id = in_fundid) < (select coalesce(salary,0) from employees where emp_id = in_empid) then
		rollback;
        signal sqlstate '45000' set message_text = 'not enough fund';
    end if;
    
    -- trans
    update company_funds set balance = balance - (select coalesce(salary,0) from employees where emp_id = in_empid)
    where fund_id = in_fundid;
    
    insert into payroll (emp_id, salary, pay_date)
    values (in_empid, (select coalesce(salary,0) from employees where emp_id = in_empid), curdate());
    
    -- check status and commit 
    if (bank_status = 0) then
		rollback;
        signal sqlstate '45000' set message_text = 'do not transfer salary';
    end if;
    commit;
end
// delimiter ;
drop procedure if exists sp_trans_salary;

#3
call sp_trans_salary (5,1);
