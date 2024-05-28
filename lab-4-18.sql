Select * from world.farrej88db;

Select CountryCode, count(Language) from world_farrej88db.countrylanguage
group by CountryCode
order by count(Language) desc

select countryCode,count(Language) as "official language", langiage
from world_farrej88db.countrylanguage