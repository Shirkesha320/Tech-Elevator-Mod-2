-- INSERT
SELECT * FROM countrylanguage WHERE language = 'Klingon';
\

-- 1. Add Klingon as a spoken language in the USA
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage) VALUES ('USA', 'Klingon', false, .05);
-- 2. Add Klingon as a spoken language in Great Britain (GBR)
INSERT INTO countrylanguage VALUES ('GBR', 'Klingon', false, .05);


-- UPDATE
SELECT capital FROM country WHERE code='USA';
--3813
SELECT * FROM city WHERE id=3813;
--Washington
SELECT * FROM city WHERE name='Houston' AND countrycode='USA';
--3796


-- 1. Update the capital of the USA to Houston
UPDATE country SET capital = 3796  WHERE
code='USA';

-- 2. Update the capital of the USA to Washington DC 
UPDATE country SET capital = (SELECT id FROM city WHERE name='Washington' AND countrycode='USA')  WHERE
code='USA';

UPDATE country SET capital = (SELECT id FROM city WHERE name='Washington' AND countrycode='USA')  WHERE
code=(SELECT code FROM country WHERE name ='United States');


-- DELETE

-- 1. Delete English as a spoken language in the USA
DELETE FROM countrylanguage WHERE language='English' AND countrycode='USA';
SELECT * FROM countrylanguage WHERE countrycode='USA';

-- 2. Delete all occurrences of the Klingon language 
--see what's there
SELECT * FROM countrylanguage WHERE language='Klingon';

--DELETE
DELETE FROM countrylanguage WHERE language='Klingon';

SELECT * FROM country WHERE code='USA';

-- REFERENTIAL INTEGRITY

-- 1. Try just adding Elvish to the country language table.

INSERT INTO countrylanguage VALUES ('USA', 'Elvish', false, .03);

-- 2. Try inserting English as a spoken language in the country ZZZ. What happens?
INSERT INTO countrylanguage VALUES ('ZZZ', 'English', false, .03);


-- 3. Try deleting the country USA. What happens?
DELETE FROM country WHERE code='USA';


-- CONSTRAINTS

-- 1. Try inserting English as a spoken language in the USA
INSERT INTO countrylanguage (language, countrycode, isofficial, percentage) VALUES ('English', 'USA', true, .70);

-- 2. Try again. What happens?

-- 3. Let's relocate the USA to the continent - 'Outer Space'
UPDATE country SET continent = 'Outer Space' WHERE code='USA';


-- How to view all of the constraints

SELECT pg_constraint.*
FROM pg_catalog.pg_constraint
INNER JOIN pg_catalog.pg_class ON pg_class.oid = pg_constraint.conrelid
INNER JOIN pg_catalog.pg_namespace ON pg_namespace.oid = connamespace;


-- MORE READABLE FORMS...
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE;
SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS


-- TRANSACTIONS

-- 1. Try deleting all of the rows from the country language table and roll it back.
START TRANSACTION;
DELETE FROM countrylanguage;
SELECT * FROM countrylanguage;
ROLLBACK;
SELECT * FROM countrylanguage;

-- 2. Try updating all of the cities to be in the USA and roll it back
START TRANSACTION;
UPDATE city SET countrycode='USA';
SELECT * FROM city;
ROLLBACK;


-- 3. Demonstrate INSERT USING SELECT then roll it back


--INSERT INTO countrylanguage (countrycode, language, isofficial, percentage) with a SELECT statement that returns
-- multiple rows with matching data type/count for INSERT. Will insert one new record for each of the
-- records returned by the SELECT.
--
-- this example will insert Klingon into countrylanguage for every country that currently
-- has English as a language. (English will still be there because this an INSERT not an UPDATE, so we are
-- just adding Klingon)
--
START TRANSACTION;
INSERT INTO countrylanguage (countrycode, language, isofficial, percentage)
SELECT countrycode, 'Klingon',  false, .1 FROM countrylanguage WHERE language='English';
ROLLBACK;

-- should return 60 records until ROLLBACK, then be reset to 0 when 
-- INSERT above is rolled back
SELECT * FROM countrylanguage WHERE language='Klingon';

SELECT countrycode, language FROM countrylanguage WHERE countrycode IN 
(SELECT countrycode FROM countrylanguage WHERE language='English') ORDER BY countrycode, language;

-- 4. Demonstrate two different SQL connections trying to access the same table where one happens to be inside of a transaction but hasn't committed yet.



-- IF WE START A TRANSACTION AND UPDATE A VALUE:

-- 1) THAT VALUE WILL BE UPDATED FOR OUR SESSION BUT ***NOT*** ANY OTHER SESSIONS TRYING TO LOOK AT THE DATA
-- 2) IF ANOTHER SESSION IS TRYING TO MODIFY THE SAME DATA, IT WILL HANG UNTIL OUR TRANSACTION COMPLETES 
--    (IS EITHER ROLLED BACK OR COMMITTED). THIS IS KNOW AS WAITING ON A TABLE LOCK
-- 3) IF WE ROLLBACK THE TRANSACTION, OUR CHANGE WILL BE REVERTED AND WON"T BE VISIBLE TO OUR SEESION
--    OUR ANYONE ELSE'S
-- 4) IF WE COMMIT OUR TRANSACTION RATHER THAN ROLLING IT BACK, THE DATA WILL NOW BE PERMANENT
--    FOR ALL SESSIONS
-- 5) WHEN RUNNING IN DBVIS, IF YOUR START A TRANSACTION AND DO SOMETHING THAT CAUSES AN ERROR,
--    YOU WILL NEED TO MANUALLY CALL ROLLBACK (OR COMMIT BUT DOESN'T MAKE SENSE SINCE THERE
---   WAS AN ERROR) IN ORDER TO FINISH THE TRANSACTION. IF YOU DON'T DBVIS WILL PROBABLY COMPLAIN
---   AND AT THAT POINT YOU CAN MAUALLY ROLLBACK THE TRANSACTION IN ORDER TO BE ABLE TO 
--    MODIFY DATA AGAIN.
START TRANSACTION;
SELECT * FROM city WHERE name='Amsterdam';
UPDATE city SET countrycode = 'USA' WHERE name='Amsterdam';     
ROLLBACK; --COMMTI IF YOU WANR TO SAVE

SELECT * FROM city WHERE name='Amsterdam';

SELECT country FROM country;
