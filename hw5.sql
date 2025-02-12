use classicmodels;
#2
create index idx_creaditLimit on customers(creditLimit);

#3
create view top_customers as
select c.customerNumber, c.customerName, c.city, c.creditLimit
from customers as c
left join offices as o on c.salesRepEmployeeNumber = o.officeCode
where c.creditLimit between 50000 and 100000
order by c.creditLimit desc
limit 5;

select * from top_customers;

#4 
explain analyze select * from top_customers;