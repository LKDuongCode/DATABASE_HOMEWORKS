#2
use world;
delimiter //
create procedure sum_population (in p_countryCode char(3), out total_population int) 
begin
	set total_population = (select Population from country 
    where code = p_countryCode);
end
// delimiter ;

#3
set @result = 0;
call sum_population('VNM',@result);
select @result as total_population;

#4
drop procedure if exists sum_population;