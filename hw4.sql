#2
select product_name ,category, price ,stock_quantity from products 
order by price desc;

#3
select product_name, category, price, stock_quantity from products limit 2 offset 2;

#4
select product_name, category, price, stock_quantity from products
where category = 'Electronics' order by price desc;

#5
select product_name, category, price, stock_quantity from products
where category = 'Clothing' order by price asc limit 1;