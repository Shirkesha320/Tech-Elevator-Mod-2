-- Write queries to return the following:
-- The following queries utilize the "world" database.

-- 1. The city name, country name, and city population of all cities in Europe with population greater than 1 million
-- (36 rows)

SELECT city.name, country.name, city.population
FROM city 
JOIN country  ON country.code = city.countrycode
WHERE country.continent = 'Europe' AND city.population > 1000000;
-- 2. The city name, country name, and city population of all cities in countries where French is an official language and the city population is greater than 1 million
-- (2 rows)

SELECT city.name, country.name , city.population
FROM city 
JOIN country ON country.code = city.countrycode
JOIN countrylanguage ON countrylanguage = country.code
WHERE countrylanguage = 'French' and countrylanguage.isofficial = TRUE AND city.population > 1000000;

-- 3. The name of the countries and continents where the language Javanese is spoken
-- (1 row)

SELECT co.name, co.continent
FROM country co
JOIN countrylanguage cl ON cl.countrycode = co.code
WHERE cl.language = 'Javanese';

-- 4. The names of all of the countries in Africa that speak French as an official language
-- (5 row)

SELECT co.name
FROM country co
JOIN countrylanguage cl ON cl.countrycode = co.code
WHERE co.continent = 'Africa' AND cl.language = 'French' AND cl.isofficial = TRUE;

-- 5. The average city population of cities in Europe
-- (average city population in Europe: 287,684)

SELECT AVG(city.population)
FROM city
JOIN country ON country.code = city.countrycode
WHERE country.continent = 'Europe'


-- 6. The average city population of cities in Asia
-- (average city population in Asia: 395,019)

SELECT AVG(city.population)
FROM city
JOIN country ON country.code = city.countrycode
WHERE country.continent = 'Asia'


-- 7. The number of cities in countries where English is an official language
-- (number of cities where English is official language: 523)

SELECT COUNT(*)
FROM city
JOIN country ON country.code = city.countrycode
JOIN countrylanguage  ON countrylanguage.countrycode = country.code
WHERE countrylanguage.language = 'English' AND countrylanguage.isofficial = TRUE;

-- 8. The average population of cities in countries where the official language is English
-- (average population of cities where English is official language: 285,809)

SELECT AVG(city.population)
FROM city
JOIN country ON country.code = city.countrycode
JOIN countrylanguage  ON countrylanguage.countrycode = country.code
WHERE countrylanguage.language = 'English' AND countrylanguage.isofficial = TRUE;


-- 9. The names of all of the continents and the population of the continent’s largest city
-- (6 rows, largest population for North America: 8,591,309)

SELECT continent, MAX(city.population)
FROM country
JOIN city ON city.countrycode = country.code
GROUP BY country.continent


-- 10. The names of all of the cities in South America that have a population of more than 1 million people and the official language of each city’s country
-- (29 rows)

SELECT city.name
FROM city
JOIN country ON country.code = city.countrycode
JOIN countrylanguage ON countrylanguage.countrycode = country.code
WHERE country.continent = 'South America' and city.population > 1000000 and countrylanguage.isofficial = 'English';

