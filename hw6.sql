use classicmodels;

#2
create view view_orders_summary as
select c.customerNumber ,c.customerName ,count(o.customerNumber) as total_orders from customers as c
join orders as  o on c.customerNumber = o.customerNumber
group by o.customerNumber;

#3
select * from view_orders_summary
where total_orders > 3;