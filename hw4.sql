use world;

#2
delimiter //
create procedure UpdateCityPopulation (in city_id int, in new_population int)
begin
	select id, name, Population from city;
    
    update city 
    set Population = new_population
    where id = city_id;
    
    select id, name, Population from city;
end;
// delimiter ;

#3
call UpdateCityPopulation(1,1000);

#4
drop procedure if exists UpdateCityPopulation;