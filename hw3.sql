use classicmodels;

#2
explain analyze select * from customers where country = 'country';

#3
create index idx_country on customers(country);

#4
explain analyze select * from customers where country = 'country';
/*
-Trước:
cost:12.9
time: 0.06 
-Sau:
cost:0.35
time: 0.0356
==> sau khi đánh index nhanh hơn 
*/

#6 đề thiếu phần 5
drop index idx_country on customers;