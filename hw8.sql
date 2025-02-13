use wolrd;

#2
delimiter //
create procedure GetCountriesByCityNames ()
begin
	select c.name, cl.Language, c.Population from country c
    join countrylanguage cl on cl.CountryCode = c.Code
    where c.Name like 'A%' and cl.IsOfficial = 'T' and c.Population > 2000000
    order by c.name asc;
end
 // delimiter ;
 
 #3
 call GetCountriesByCityNames ();
 
 #4
 drop procedure if exists GetCountriesByCityNames ;