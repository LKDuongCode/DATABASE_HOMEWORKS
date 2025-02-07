#2
select min(Price) as min, max(Price) as max from orders;

#3
select CustomerName, count(OrderID) as orderCount from orders
group by CustomerName;

#4
select min(OrderDate) as EarliesDate , max(OrderDate) as LatesDate from orders;


