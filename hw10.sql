use world;

#2
create view OfficialLanguageView  as
select c.code, c.name, cl.Language from country c
join countrylanguage cl on c.code = cl.CountryCode
where cl.IsOfficial = 'T';

#3
select * from OfficialLanguageView;
#4
create index idx_name on city(name);

#5
delimiter //
create procedure GetSpecialCountriesAndCities (in lang char(30))
begin
	select c.name, ct.name as city_name, ct.population as city_pop, c.population as total_pop from country c
    join city ct on ct.CountryCode = c.code
    join countrylanguage cl on cl.CountryCode = c.code
    where cl.Language = lang and c.Population > 5000000 and ct.name like 'New%'
    order by c.Population desc limit 10;
end
// delimiter ;

#6
call GetSpecialCountriesAndCities ('English');