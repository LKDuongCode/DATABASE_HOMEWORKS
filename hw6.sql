use world;

#2
delimiter //
create procedure GetCountriesWithLargeCities ()
begin
	select name, Population from country
    where Population > 10000000 and Continent = 'Asia'
    order by Population desc;
end;
// delimiter ;

#3
call GetCountriesWithLargeCities();

#4
drop procedure if exists GetCountriesWithLargeCities;