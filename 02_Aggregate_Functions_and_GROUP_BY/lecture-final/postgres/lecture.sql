-- ORDERING RESULTS

SELECT population FROM country ORDER BY population;

SELECT name, continent, population FROM country ORDER BY continent, population;

-- Populations of all countries in descending order

SELECT population FROM country ORDER BY population DESC;

SELECT name, continent, population FROM country ORDER BY continent DESC, population 

SELECT name, continent, population FROM country ORDER BY population DESC LIMIT 10;

--Names of countries and continents in ascending order
SELECT name, continent FROM country ORDER BY continent, name;

-- LIMITING RESULTS
-- The name and average life expectancy of the countries with the 10 highest life expectancies.
SELECT name, lifeexpectancy FROM country ORDER BY lifeexpectancy DESC LIMIT 10; -- add null check to fix

SELECT name, lifeexpectancy FROM country 
WHERE lifeexpectancy IS NOT NULL 
ORDER BY lifeexpectancy DESC 
LIMIT 10; 

-- CONCATENATING OUTPUTS

-- The name & state of all cities in California, Oregon, or Washington.
-- "city, state", sorted by state then city
SELECT name || ', ' || district AS city_state FROM city 
WHERE district IN ('California', 'Oregon', 'Washington')
ORDER BY name, district


-- AGGREGATE FUNCTIONS
-- Average Life Expectancy in the World
SELECT AVG(lifeexpectancy) FROM country;

-- Total population in Ohio

SELECT SUM(population) FROM city WHERE district='Ohio';

-- The surface area of the smallest country in the world
SELECT MIN(surfacearea) FROM country;

-- The 10 largest countries in the world
SELECT name FROM country ORDER BY surfacearea DESC LIMIT 10;

SELECT name, surfacearea, governmentform FROM country ORDER BY surfacearea DESC LIMIT 10;

SELECT MAX(surfacearea) FROM country;

select max

-- The number of countries who declared independence in 1991

SELECT count(*) FROM country WHERE indepyear = 1991;

SELECT indepyear FROM country;

-- this returns count of countries without null in indepyear (192)
SELECT count(indepyear) FROM country;

-- this returns count of countries regasrdless of whether the row has null in indepyear (239)
SELECT count(*) FROM country;

-- GROUP BY
SELECT continent FROM country ;

SELECT continent, SUM(population) FROM country GROUP BY continent;

SELECT continent, name, SUM(population) FROM country GROUP BY continent, name ORDER BY continent;



-- Count the number of countries where each language is spoken, ordered from most countries to least
SELECT language, COUNT(language) FROM countrylanguage GROUP BY language;

SELECT language, COUNT(language) FROM countrylanguage GROUP BY language ORDER BY count(language) DESC;

SELECT language, COUNT(language) AS country_count FROM countrylanguage GROUP BY language ORDER BY country_count DESC;

-- bonus using HAVING
SELECT language, COUNT(language) AS country_count FROM countrylanguage GROUP BY language HAVING COUNT(language) > 1 ORDER BY country_count DESC;

-- Average life expectancy of each continent ordered from highest to lowest
SELECT continent, AVG(lifeexpectancy) FROM country GROUP BY continent ORDER BY AVG(lifeexpectancy) DESC;

-- Exclude Antarctica from consideration for average life expectancy
SELECT continent, AVG(lifeexpectancy) FROM country WHERE lifeexpectancy IS NOT NULL GROUP BY continent ORDER BY AVG(lifeexpectancy) DESC; 

SELECT continent, AVG(lifeexpectancy) FROM country WHERE continent != 'Antarctica' GROUP BY continent ORDER BY AVG(lifeexpectancy) DESC;

-- Sum of the population of cities in each state in the USA ordered by state name
SELECT district, SUM(population) FROM city WHERE countrycode='USA' GROUP BY district ;

--using subquery
SELECT district, SUM(population) FROM city WHERE countrycode = (SELECT code FROM country  WHERE name='United States') GROUP BY district ;

SELECT district, SUM(population) FROM city WHERE countrycode IN (SELECT  code FROM country  WHERE continent='Europe') GROUP BY district ;

-- The average population of cities in each state in the USA ordered by state name

SELECT district, AVG(population) FROM city WHERE countrycode='USA' GROUP BY district ORDER BY district;

-- SUBQUERIES
-- Find the names of cities under a given government leader
SELECT * FROM country;
--Elisabeth II

SELECT name FROM city WHERE countrycode IN (SELECT code FROM country WHERE headofstate ='Elisabeth II');

-- Find the names of cities whose country they belong to has not declared independence yet
SELECT name FROM city WHERE countrycode IN (SELECT code FROM country WHERE indepyear IS NULL);

-- Additional samples
-- You may alias column and table names to be more descriptive

-- Alias can also be used to create shorthand references for tables, such as "c" for city and "co" for country.
SELECT name FROM city AS c WHERE c.countrycode IN (SELECT code FROM country AS co WHERE co.indepyear IS NULL);

-- Ordering allows columns to be displayed in ascending order, or descending order (Look at Arlington)

-- Limiting results allows rows to be returned in 'limited' clusters,where LIMIT says how many, and OFFSET (optional) specifies the number of rows to skip

-- Most database platforms provide string functions that can be useful for working with string data. In addition to string functions, string concatenation is also usually supported, which allows us to build complete sentences if necessary.

-- Aggregate functions provide the ability to COUNT, SUM, and AVG, as well as determine MIN and MAX. Only returns a single row of value(s) unless used with GROUP BY.

-- Counts the number of rows in the city table

-- Also counts the number of rows in the city table

-- Gets the SUM of the population field in the city table, as well as
-- the AVG population, and a COUNT of the total number of rows.

SELECT SUM(population) AS total_population, AVG(population)AS AVG_POPULATION, count(*) AS row_count FROM city;

SELECT UPPER(name) FROM city;

-- Gets the MIN population and the MAX population from the city table.
SELECT MIN(population), MAX(population) FROM city;

-- Using a GROUP BY with aggregate functions allows us to summarize information for a specific column. For instance, we are able to determine the MIN and MAX population for each countrycode in the city table.
SELECT countrycode, MIN(population), MAX(population) FROM city GROUP BY countrycode ORDER BY countrycode DESC;
