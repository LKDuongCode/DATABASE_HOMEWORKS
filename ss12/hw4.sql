use s12;

#2
create table order_warnings (
	warning_id int primary key auto_increment,
    order_id int not null,
    warning_message varchar(255) not null
);

#3
delimiter //
create trigger trig_after_delete_orders 
after insert on orders for each row
begin
	if (new.price * new.quantity) > 5000 then
		insert into order_warnings (order_id,warning_message) values
		(new.order_id, 'Total value exceeds limit');
    end if;

end
// delimiter ;

#4
insert into orders (customer_name, product, quantity, price, order_date) values
('Mark', 'Monitor', 2, 3000.00, '2023-08-01'),
('Paul', 'Mouse', 1, 50.00, '2023-08-02');

