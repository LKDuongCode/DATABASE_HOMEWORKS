use world;

#2
delimiter //
create procedure GetEnglishSpeakingCountriesWithCities  (in lang char(30))
begin
	select name, Population from country c
    join countrylanguage cl on c.code = cl.CountryCode
    where cl.IsOfficial = 'T' and c.Population > 5000000 and cl.language = lang
    order by c.population desc;
end
// delimiter ;

#3
call GetEnglishSpeakingCountriesWithCities('Vietnamese');

#4
drop procedure if exists GetEnglishSpeakingCountriesWithCities;
