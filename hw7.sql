use chinook;

#2
create view View_Track_Details  as
select t.trackid, t.name as trackname, al.title, art.name as artist_name, t.unitprice from artist art
join album al on al.artistid = art.artistid
join track t on t.albumid = al.albumid 
where t.unitprice > 0.99;

select * from View_Track_Details;
#3
create view View_Customer_Invoice as
select c.customerid, sum(i.total) as total  from customer c
join invoice i on i.customerid = c.customerid
join employee e on e.ReportsTo = c.SupportRepId
group by c.customerid
having sum(i.total) > 50;

select * from View_Customer_Invoice;

#4
create view View_Top_Selling_Tracks as
select t.trackid, t.name , sum(il.quantity) as total from invoiceline il
join invoice i on i.invoiceid = il.invoiceid
join track t on t.trackid = il.trackid
group by t.trackid, t.name
having sum(il.quantity) > 10;

#5
create index idx_Track_Name on Track(Name);
explain select * from Track where Name like '%Love%';

#6
create index idx_Invoice_Total on Invoice(Total);
explain select * from Invoice where Total between 20 and 100;

#7
delimiter //
create procedure GetCustomerSpending (in CustomerId int)
begin
    declare total_spending decimal(10, 2);
    select ifnull(sum(InvoiceAmount), 0) into total_spending from View_Customer_Invoice
    where CustomerID = CustomerId;
    select total_spending as TotalSpent;
end //
delimiter ;
call GetCustomerSpending(1);

#8
delimiter //
create procedure SearchTrackByKeyword (in p_Keyword varchar(255))
begin
    select * from Track
    where Name like concat('%', p_Keyword, '%')
    order by Name; 
end //
delimiter ;

call SearchTrackByKeyword('lo');

#9
delimiter //
create procedure GetTopSellingTracks (in p_MinSales int, in p_MaxSales int)
begin
    select * from View_Top_Selling_Tracks
    where TotalSales between p_MinSales and p_MaxSales
    order by TotalSales desc;
end //
delimiter ;

call GetTopSellingTracks(1, 50);

#10
drop index  idx_track_name on track;
drop index idx_invoice_total on invoice;
drop view if exists View_Track_Details;
drop view if exists View_Customer_Invoice;
drop view if exists View_Top_Selling_Tracks;
drop procedure if exists GetCustomerSpending;
drop procedure if exists SearchTrackByKeyword;
drop procedure if exists GetTopSellingTracks;
