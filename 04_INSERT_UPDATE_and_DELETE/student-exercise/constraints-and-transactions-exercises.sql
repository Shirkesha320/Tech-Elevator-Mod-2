-- Write queries to return the following:
-- The following changes are applied to the "dvdstore" database.**

-- 1. Add actors, Hampton Avenue, and Lisa Byway to the actor table.

SELECT *
FROM actor 

INSERT INTO actor(first_name, last_name)
VALUES ('HAMPTON', 'AVENUE'), ('LISA', 'BYWAY')

-- 2. Add "Euclidean PI", "The epic story of Euclid as a pizza delivery boy in
-- ancient Greece", to the film table. The movie was released in 2008 in English.
-- Since its an epic, the run length is 3hrs and 18mins. There are no special
-- features, the film speaks for itself, and doesn't need any gimmicks.

SELECT * 
FROM film 
ORDER BY film_id DESC
INSERT INTO film(title, description, release_year, language_id, length)
VALUES ('EUCLIDEAN PI', 'The epic story of Euclid as a pizza delivery boy in ancient Greece', 2008, 1, 198)

--DELETE 
--FROM film WHERE
--film_id = 1002 or film_id = 1003

-- 3. Hampton Avenue plays Euclid, while Lisa Byway plays his slightly
-- overprotective mother, in the film, "Euclidean PI". Add them to the film.

SELECT *
FROM film_actor
ORDER BY film_id DESC

INSERT INTO film_actor(actor_id, film_id)
VALUES ((SELECT actor_id FROM actor WHERE first_name = 'LISA' AND last_name = 'BYWAY'),
       (SELECT film_id FROM film WHERE title = 'EUCLIDEAN PI'));
       
INSERT INTO film_actor(actor_id, film_id)
VALUES ((SELECT actor_id FROM actor WHERE first_name = 'HAMPTON' AND last_name = 'AVENUE'),
       (SELECT film_id FROM film WHERE title = 'EUCLIDEAN PI'));
  

-- 4. Add Mathmagical to the category table.

SELECT *
FROM category

INSERT INTO category(name) 
VALUES ('Mathmagical')


-- 5. Assign the Mathmagical category to the following films, "Euclidean PI",
-- "EGG IGBY", "KARATE MOON", "RANDOM GO", and "YOUNG LANGUAGE"

SELECT *
FROM film_category
ORDER BY film_id DESC;
SELECT category_id From category WHERE name = 'Mathmagical';



--INSERT INTO film_category(film_id, category_id)
--
--INSERT INTO film_category(film_id, category_id)
--VALUES ((SELECT film_id FROM  film WHERE title = 'EUCLIDEAN PI'), (SELECT category_id FROM category WHERE name = 'Mathmagical'));
--1001
--VALUES((SELECT film_id FROM  film WHERE title = 'EGG IGBY'), (SELECT category_id FROM category WHERE name = 'Mathmagical'));
--274
--INSERT INTO  film_category(film_id, category_id)
--VALUES ((SELECT film_id FROM  film WHERE title = 'KARATE MOON'), (SELECT category_id FROM category WHERE name = 'Mathmagical'));
--494
--VALUES ((SELECT film_id FROM  film WHERE title = 'RANDOM GO'SELECT category_id FROM category WHERE name = 'Mathmagical'));
--714
--INSERT INTO  film_category(film_id, category_id)
--VALUES ((SELECT film_id FROM  film WHERE title = 'YOUNG LANGUAGE'), (SELECT category_id FROM category WHERE name = 'Mathmagical'));
--996

--DELETE FROM film_category WHERE category_id =
--(SELECT category_id From category WHERE name = 'Mathmagical');



--DELETE FROM film_category WHERE film_id = '996' AND category_id != 17;
--DELETE FROM film_category WHERE film_id = '714' AND category_id != 17;
--DELETE FROM film_category WHERE film_id = '274' AND category_id != 17;
--DELETE FROM film_category WHERE film_id = '494' AND category_id != 17;




-- 6. Mathmagical films always have a "G" rating, adjust all Mathmagical films
-- accordingly.
-- (5 rows affected)

UPDATE film
SET rating = 'G'
WHERE film_id
IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name ='Mathmagical'))

SELECT title, rating 
FROM film
WHERE film_id
IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name ='Mathmagical'))

-- 7. Add a copy of "Euclidean PI" to all the stores.

SELECT * 
FROM inventory
ORDER BY film_id DESC;

INSERT INTO inventory(film_id, store_id)
VALUES ((SELECT film_id FROM film WHERE title = 'EUCLIDEAN PI'), 1);

INSERT INTO inventory(film_id, store_id)
VALUES ((SELECT film_id FROM film WHERE title = 'EUCLIDEAN PI'), 2);

-- 8. The Feds have stepped in and have impounded all copies of the pirated film,
-- "Euclidean PI". The film has been seized from all stores, and needs to be
-- deleted from the film table. Delete "Euclidean PI" from the film table.
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>


DELETE FROM film WHERE
title = 'EUCLIDEAN PI';
 --didn't delete because of foregin key constraint is linked to another table
 
-- 9. Delete Mathmagical from the category table.
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>

DELETE FROM film WHERE
title = 'Mathmagical';
--didn't delete because of foregin key constraint is linked to another table

-- 10. Delete all links to Mathmagical in the film_category table
-- (Did it succeed? Why?)
-- <YOUR ANSWER HERE>

SELECT *
FROM film_category
ORDER BY category_id DESC;

DELETE FROM film_category WHERE 
category_id = 17
--yes because not linked to another table

-- 11. Retry deleting Mathmagical from the category table, followed by retrying
-- to delete "Euclidean PI".
-- (Did either deletes succeed? Why?)
-- <YOUR ANSWER HERE>

START TRANSACTION;

DELETE FROM category WHERE
NAME = 'Mathmagical';

DELETE FROM category WHERE
NAME = 'EUCLIDEAN PI';

COMMIT;

-- FIRST ONE WORKS SECOND ONE DOESNOT ITS STILL BEING USED

-- 12. Check database metadata to determine all constraints of the film id, and
-- describe any remaining adjustments needed before the film "Euclidean PI" can
-- be removed from the film table.

---Did this one in class its because the foriegn key is being used on a different table. Intergrety

