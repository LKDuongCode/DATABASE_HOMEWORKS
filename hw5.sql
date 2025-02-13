use world;

#2
delimiter //
create procedure GetLargeCitiesByCountry (in country_code char(3))
begin
	select ct.id, ct.name, ct.Population from country c
    join city ct on c.code = ct.CountryCode
    where c.code = country_code and ct.population > 1000000
    order by ct.Population desc;
end;
// delimiter ;

#3
call GetLargeCitiesByCountry('VNM');

#4
drop procedure if exists GetLargeCitiesByCountry ;