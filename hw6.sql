use ss14_second;

#2
delimiter //
create trigger before_update_phone
before update on employees
for each row
begin
    if length(new.phone) != 10 then
        signal sqlstate '45000' set message_text = 'số điện thoại phải có đúng 10 chữ số!';
    end if;
end //
delimiter ;

#3
CREATE TABLE notifications (

    notification_id INT PRIMARY KEY AUTO_INCREMENT,

    employee_id INT NOT NULL,

    message TEXT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

 FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE

);

#4
delimiter //
create trigger trg_after_insert_employee
after insert on employees
for each row
begin
    insert into notifications (employee_id, message)
    values (new.employee_id, 'chào mừng');
end //
delimiter ;

insert into departments (department_id, department_name) values (1, 'hr');
insert into employees values (1,'gg','gg','1234567890','2025-02-19',1);

#5
delimiter //
create procedure AddNewEmployeeWithPhone(
    in emp_name varchar(255),
    in emp_email varchar(255),
    in emp_phone varchar(20),
    in emp_hire_date date,
    in emp_department_id int
)
begin
    declare emp_id int;
    declare emp_exists int default 0;
    if length(emp_phone) != 10 then
        signal sqlstate '45000' set message_text = 'số điện thoại phải có đúng 10 chữ số!';
    end if;
    
   select exists (select 1 from employees where employee_id = emp_id) into emp_exists;
    if emp_exists > 0 then
        signal sqlstate '45000' set message_text = 'email đã tồn tại, không thể thêm nhân viên mới!';
    end if;
    
	start transaction;
    insert into employees (name, email, phone, hire_date, department_id)
    values (emp_name, emp_email, emp_phone, emp_hire_date, emp_department_id);
    set emp_id = last_insert_id();
    commit;
end //
delimiter ;


call AddNewEmployeeWithPhone ('Trần Thị B234 ', 'tranthib234@company.com', '0912345678', '2024-02-17', 1);

#6
drop trigger before_insert_check_payment;
drop trigger after_update_order_status;
drop procedure sp_update_order_status_with_payment;


