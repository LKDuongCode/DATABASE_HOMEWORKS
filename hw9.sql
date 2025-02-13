use world;

#2
create view vw_CountryLanguage as
select c.code, c.name, cl.Language, cl.IsOfficial from country c
join countrylanguage cl on c.code = cl.CountryCode
where cl.IsOfficial = 'T';

#3
select * from vw_CountryLanguage;

#4
create view vw_country_eng as
select  c.name as c_name , ct.Population, ct.name as city_name from country c
join countrylanguage cl on c.code = cl.CountryCode
join city ct on c.code = ct.CountryCode
where cl.language = 'English' and cl.IsOfficial = 'T' and ct.Population > 1000000;


delimiter //
create procedure GetLargeCitiesWithEnglish ()
begin
	select * from vw_country_eng
    order by population desc limit 20;
end
// delimiter ;

#5
call GetLargeCitiesWithEnglish ();

#6
drop view if exists vw_country_eng;
drop procedure if exists GetLargeCitiesWithEnglish;