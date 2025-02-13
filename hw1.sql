use world;

#2
delimiter //
create procedure get_info_byId (in country_code char(3))
begin 
	select ct.id, ct.Name, ct.Population from country c
	join city ct on c.code = ct.CountryCode
	where ct.CountryCode = country_code;
end;
// delimiter 


#3
call get_info_byId('VNM');

#4
drop procedure if exists get_info_byId;




