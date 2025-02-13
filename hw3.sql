use world;

#2
delimiter //
create procedure get_country_by_language (in language char(30))
begin
	select cl.CountryCode, cl.Language, cl.Percentage from countrylanguage cl
    join country c on c.code = cl.CountryCode
    where cl.Language = language and cl.Percentage > (50);
end;
// delimiter ;

#3
call get_country_by_language('Vietnamese');

#4
drop procedure if exists get_country_by_language;