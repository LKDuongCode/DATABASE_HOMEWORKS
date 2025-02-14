#2 vẽ sơ đồ
#3
use chinook;
create view View_Album_Artist as
select al.AlbumId, al.title, ar.name from album al
join artist ar on al.artistid  = ar.artistid;

#4
create view View_Customer_Spending as
select concat(c.firstname,lastname) as fullname, sum(i.total) as total from customer c
join invoice i on i.customerid = c.customerid group by c.customerid, c.firstname, c.lastname;

#5
create index idx_Employee_LastName on employee(lastname);
explain analyze select * from employee where lastname = 'King'; -- 0.03 giảm 1/2 

#6
delimiter //
create procedure GetTracksByGenre (in in_genreid int)
begin
	select t.trackid, t.name, a.title, art.name, art.artistid  from genre g
    join track t on t.genreid = g.genreid
    join album a on a.albumid = t.albumid
    join artist art on art.artistid = a.artistid
    where t.genreid = in_genreid;
end
// delimiter ;
call GetTracksByGenre (1);

#7
delimiter //
create procedure GetTrackCountByAlbum (in in_albumid int)
begin
	select count(t.trackid) as total_track from track t
    join album a on a.albumid = t.albumid
    where t.albumid = in_albumid;
end
// delimiter ;
call GetTrackCountByAlbum (1);

#8
drop view if exists View_Album_Artist;
drop view if exists View_Customer_Spending;

drop procedure if exists GetTracksByGenre;
drop procedure if exists GetTrackCountByAlbum;

