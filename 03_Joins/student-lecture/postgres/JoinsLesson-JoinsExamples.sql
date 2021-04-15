--Table_One LEFT / Table_Two RIGHT


-- INNER JOIN is default
-- PART THAT'S LIKE (INNER) ONLY
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM one
JOIN two ON one.number = two.number;

-- THIS IS THE SAME: INNER IS DEFAULT
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM one
INNER JOIN two ON one.number = two.number;


--LEFT JOIN (Left outer join) 
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM one
LEFT JOIN two ON one.number = two.number;

--RIGHT JOIN (right outer join) 
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM one
RIGHT JOIN two ON one.number = two.number;




--FULL OUTER JOIN 
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM one
FULL OUTER JOIN two ON one.number = two.number;

-- Useful variations
-- can filter in left/right join to leverage data 

--only entries in left table (i.e. - which students don't have classes) 
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM one
LEFT JOIN two ON one.number = two.number
WHERE two.number IS NULL;

--only entries in right table
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM one
RIGHT JOIN two ON one.number = two.number
WHERE one.number IS NULL;

-- could do this by swaping one for two above
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM two
LEFT JOIN one  ON one.number = two.number
WHERE one.number IS NULL;

--ALL DATA NOT LIKE (LEFT or RIGHT but NOT BOTH)
SELECT one.number AS one_number, one.description AS one_description, two.number AS two_number, two.description AS two_description
FROM one
FULL OUTER JOIN two ON one.number = two.number
WHERE one.number IS NULL OR two.number IS NULl;




