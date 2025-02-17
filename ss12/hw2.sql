#2
create table price_changes (
	change_id int primary key auto_increment,
    product varchar(100) not null,
    old_price decimal(10,2) not null,
    new_price decimal(10,2) not null
);

#3
delimiter //
create trigger trg_after_update_orders
after update on orders for each row
begin
	insert into price_changes (product, old_price, new_price) values
	(old.product, old.price, new.price);
end
// delimiter ;


#4
set sql_safe_updates = 0;
update orders
set price = 2000.00
where product = 'Laptop';

update orders
set price = 800.00
where product = 'Smartphone';

#5
select * from price_changes;