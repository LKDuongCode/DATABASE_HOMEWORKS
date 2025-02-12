use classicmodels;
#2
create  index idx_productLine on products(productLine);

#3
create view view_highest_priced_products as
select p.productLine, p.productName, p.MSRP from products as p
where p.MSRP = (select max(pro.MSRP) from products as pro where pro.productLine = pro.productLine);

#4
select * from view_highest_priced_products;

#5
select v.productLine, v.productName, v.MSRP, p.textDescription from view_highest_priced_products as v
join productlines as p on v.productLine = p.productLine
order by v.MSRP desc
limit 10;