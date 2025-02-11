create table Customer (
    cID int primary key,
    Name varchar(25),
    cAge int
);

create table Orders (
    oID int primary key,
    cID int,
    oDate datetime,
    oTotalPrice int,
    foreign key (cID) references Customer(cID) on delete cascade
);

create table Products (
    pID int primary key,
    pName varchar(25),
    pPrice double
);

create table Order_Detail (
    oID int,
    pID int,
    odQTY int,
    primary key (oID, pID),
    foreign key (oID) references Orders(oID),
    foreign key (pID) references Products(pID)
);


insert into Customer (cID, Name, cAge) values
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

insert into Orders (oID, cID, oDate, oTotalPrice) values
(1, 1, '2006-03-21', null),
(2, 2, '2006-03-23', null),
(3, 1, '2006-03-16', null);

insert into Products (pID, pName, pPrice) values
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

insert into Order_Detail (oID, pID, odQTY) values
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

select o.oID, c.cID, o.oDate, o.oTotalPrice
from Customer c
join Orders o on o.cID = c.cID
order by o.oDate desc;  

select p.pName, p.pPrice as max_price
from Products p
where p.pPrice = (select max(pPrice) from Products);

select c.Name, p.pName
from products p
join order_detail od on od.pID = p.pID
join orders o on o.oID = od.oID
join customer c on c.cID = o.cID;

select c.Name from customer c 
left join orders o on o.cID = c.cID
where o.cID is null;

select o.oID, o.oDate, od.odQTY, p.pName, p.pPrice
from products p
join order_detail od on od.pID = p.pID
join orders o on o.oID = od.oID;

select o.oID, o.oDate, sum(od.odQTY * p.pPrice) as total_price
from orders o
join order_detail od on od.oID = o.oID
join products p on p.pID = od.pID
group by o.oID, o.oDate;