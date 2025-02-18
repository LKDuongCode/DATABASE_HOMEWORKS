create database ss13;
use ss13;

#1
create table accounts (
	acc_id int primary key auto_increment,
    acc_name varchar(50),
    balance decimal(10,2)
) engine = InnoDB;

#2
INSERT INTO accounts (acc_name, balance) VALUES 
('Nguyễn Văn An', 1000.00),
('Trần Thị Bảy', 500.00);

#3
delimiter //
create procedure sp_transfer_money (in in_from_acc int, in in_to_acc int, in in_amount decimal (10,2))
begin
	set autocommit = 0;
	start transaction;
    -- kiểm tra tồn tại 
    if not exists (select 1 from accounts where acc_id = in_from_acc) or not exists (select 1 from accounts where acc_id = in_to_acc) then
		rollback; -- có thể không cần rollback vì trước đó chưa thay đổi dữ liệu. nếu gặp lỗi, sp sẽ dừng lại luôn 
        signal sqlstate '45000' set message_text =  'acc not exists';
    end if;

    -- kiểm tra số dư gửi
    if (select balance from accounts where acc_id = in_from_acc) < in_amount then
		rollback;
		signal sqlstate '45000' set message_text =  'not enough money';
    end if;

    -- trừ tiền 
    update accounts
    set balance = balance - in_amount 
    where acc_id = in_from_acc;

    -- công tiền
	update accounts
    set balance = balance + in_amount 
    where acc_id = in_to_acc;

	commit;
	select 'successfull!' as status;
end; 
// delimiter ;

#4
call sp_transfer_money (1,2,200);	