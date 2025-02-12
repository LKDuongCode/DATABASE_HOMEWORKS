use classicmodels;

#2
create index idx_pro_line on products(productLine);

#3
create view view_total_sales as 
select p.productLine,sum(o.quantityOrdered * o.priceEach) as total_sales ,sum(o.quantityOrdered) as total_quantity from products as p
join orderdetails as o on p.productCode = o.productCode
group by p.productLine;

#4
select * from view_total_sales;

