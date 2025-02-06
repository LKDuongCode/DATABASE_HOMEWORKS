#2
select c_name, phone, order_id, total_amount from customers as c
join orders as o on c.customer_id = o.customer_id
where o.order_status = 'Pending' and o.total_amount > 300000;

#3
select c_name, email, order_id from customers as c
join orders as o on c.customer_id = o.customer_id
where o.order_status = 'Completed' or o.order_status is null;

#4
select c_name, address, order_id, order_status from customers as c
join orders as o on c.customer_id = o.customer_id
where o.order_status in ('Pending','Cancelled');

#5
select c_name, phone, order_id, total_amount from customers as c
join orders as o on c.customer_id = o.customer_id
where total_amount between 300000 and 600000;
