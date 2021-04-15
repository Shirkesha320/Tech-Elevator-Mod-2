-- SELECT ... FROM
-- Selecting the names for all countries
SELECT name FROM country;


-- Selecting the name and population of all countries
SELECT name, population FROM country;


-- Selecting all columns from the city table
SELECT * FROM country;


-- SELECT ... FROM ... WHERE
-- Selecting the cities in Ohio
SELECT * FROM city WHERE district='Ohio';
SELECT * FROM city WHERE name='Philadelphia';

--Using IN comparison
SELECT * FROM city WHERE district IN ('Ohio', 'Pennsylvania', 'Maryland');

-- NOT IN
SELECT * FROM city WHERE district NOT IN ('Ohio', 'Pennsylvania', 'Maryland');

--Using BETWEEN
SELECT name, population FROM country WHERE  population BETWEEN 100000 AND 500000;

-- NOT  BETWEEN
SELECT name, population FROM country WHERE  population NOT BETWEEN 100000 AND 500000;


-- Selecting countries that gained independence in the year 1776
SELECT * FROM country WHERE indepyear = 1776;

-- Selecting countries not in Asia
SELECT * FROM country WHERE continent != 'Asia';

-- Selecting countries that do not have an independence year
SELECT * FROM country WHERE indepyear IS NULL;

-- Selecting countries that do have an independence year
SELECT * FROM country WHERE indepyear IS NOT NULL;

-- use LIKE comparison
SELECT * FROM city WHERE name LIKE '%p%a';

-- Selecting countries that have a population greater than 5 million
SELECT * FROM country WHERE population > 5000000;



-- SELECT ... FROM ... WHERE ... AND/OR
-- Selecting cities in Ohio and Population greater than 400,000

SELECT * FROM city WHERE  district='Ohio' AND population > 400000;

-- Selecting country names on the continent North America or South America
SELECT name FROM country WHERE continent = 'North America' OR continent = 'SOUTH AMERICA';

-- include continent
SELECT name, continent FROM country WHERE continent = 'North America' OR continent = 'South America';

--DISTINCT
SELECT DISTINCT  district FROM city WHERE district = 'Pennsylvania';



-- SELECTING DATA w/arithmetic
-- Selecting the population, life expectancy, and population per area
--	note the use of the 'as' keyword
SELECT population, lifeexpectancy, (population / surfacearea) AS pop_per_area FROM country;

SELECT population, lifeexpectancy, (population / surfacearea) AS pop_per_area FROM country WHERE lifeexpectancy > 60;

-- CAN use AS to alias column name that exists too
SELECT name AS city_name FROM city;

SELECT name  FROM country WHERE lifeexpectancy > 60;
