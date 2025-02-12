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

#5
select p.productLine,p.textDescription,v.total_sales,v.total_quantity from view_total_sales as v
join productlines p on v.productLine = p.productLine
where v.total_sales > 2000000
order by v.total_sales desc;