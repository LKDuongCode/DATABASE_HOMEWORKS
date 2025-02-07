#2
select CustomerName, ProductName, sum(Quantity) as TotalQuantity from orders
group by CustomerName, ProductName
having sum(Quantity) > 1;

#3
select CustomerName, OrderDate, Quantity from orders
where Quantity > 2;

#4
select CustomerName, OrderDate, sum(Quantity*Price) as TotalSpent from orders
group by CustomerName, OrderDate
having sum(Quantity*Price) > 20000000;

#5
