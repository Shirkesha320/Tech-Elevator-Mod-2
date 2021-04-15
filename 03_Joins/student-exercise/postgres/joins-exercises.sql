-- The following queries utilize the "dvdstore" database.

-- 1. All of the films that Nick Stallone has appeared in
-- (30 rows)

SELECT title 
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE actor.first_name = 'NICK' AND actor.last_name = 'STALLONE';

-- 2. All of the films that Rita Reynolds has appeared in
-- (20 rows)
SELECT title 
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE actor.first_name = 'RITA' AND actor.last_name = 'REYNOLDS';


-- 3. All of the films that Judy Dean or River Dean have appeared in
-- (46 rows)

SELECT title 
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE (actor.first_name = 'Judy' AND actor.last_name = 'Dean')
 OR(actor.first_name = 'River' AND actor.last_name = 'Dean');


-- 4. All of the the 'Documentary' films
-- (68 rows)

SELECT title 
FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category on category.category_id = film_category.category_id
WHERE category.name = 'Documentary';


-- 5. All of the 'Comedy' films
-- (58 rows)

SELECT title 
FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category on category.category_id = film_category.category_id
WHERE category.name = 'Comedy';

-- 6. All of the 'Children' films that are rated 'G'
-- (10 rows)

SELECT title 
FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category on category.category_id = film_category.category_id
WHERE category.name = 'Children' and rating = 'G';


-- 7. All of the 'Family' films that are rated 'G' and are less than 2 hours in length
-- (3 rows)

SELECT title 
FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category on category.category_id = film_category.category_id
WHERE category.name = 'Family' and rating = 'G' and length < 120;



-- 8. All of the films featuring actor Matthew Leigh that are rated 'G'
-- (9 rows)

SELECT title 
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE actor.first_name = 'MATTHEW' AND actor.last_name = 'LEIGH' AND rating = 'G';

-- 9. All of the 'Sci-Fi' films released in 2006
-- (61 rows)

SELECT title 
FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category on category.category_id = film_category.category_id
WHERE category.name = 'Sci-Fi' AND release_year = 2006;


-- 10. All of the 'Action' films starring Nick Stallone
-- (2 rows)

SELECT title 
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
JOIN film_category ON film_category.film_id = film.film_id
Join category On category.category_id = film_category.category_id
WHERE actor.first_name = 'NICK' AND actor.last_name = 'STALLONE' AND category.name = 'Action';


-- 11. The address of all stores, including street address, city, district, and country
-- (2 rows)CITY 

SELECT address, address2,city, district, country
FROM store
JOIN address on address.address_id =store.address_id
JOIN city on city.city_id = address.city_id
JOIN country On country.country_id = city.country_id;

-- 12. A list of all stores by ID, the storeâ€™s street address, and the name of the storeâ€™s manager
-- (2 rows)

SELECT store.store_id, address, staff.last_name, staff.first_name
FROM store
JOIN address ON address.address_id = store.address_id
JOIN staff ON staff.staff_id = store.manager_staff_id;


-- 13. The first and last name of the top ten customers ranked by number of rentals
-- (#1 should be â€œELEANOR HUNTâ€? with 46 rentals, #10 should have 39 rentals)

SELECT customer.first_name, customer.last_name, COUNT(*) AS Total_rentals
FROM customer
JOIN rental ON rental.customer_id = customer.customer_id
GROUP By customer.first_name, customer.last_name
ORDER BY Total_Rentals DESC
LIMIT 10;

-- 14. The first and last name of the top ten customers ranked by dollars spent
-- (#1 should be â€œKARL SEALâ€? with 221.55 spent, #10 should be â€œANA BRADLEYâ€? with 174.66 spent)

SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS totalpayment
FROM customer
JOIN payment ON payment.customer_id = customer.customer_id
GROUP BY customer.first_name,customer.last_name
ORDER BY totalpayment DESC LIMIT 10;



-- 15. The store ID, street address, total number of rentals, total amount of sales (i.e. payments), and average sale of each store.
-- (NOTE: Keep in mind that while a customer has only one primary store, they may rent from either store.)
-- (Store 1 has 7928 total rentals and Store 2 has 8121 total rentals)

SELECT store.store_id, address.address, COUNT(payment.amount), SUM(payment.amount), AVG(payment.amount) 
FROM store
JOIN address ON address.address_id = store.address_id
JOIN city ON city.city_id = address.city_id
JOIN inventory ON inventory.store_id = store.store_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY store.store_id, address.address;



-- 16. The top ten film titles by number of rentals
-- (#1 should be â€œBUCKET BROTHERHOODâ€? with 34 rentals and #10 should have 31 rentals)

SELECT film.title, COUNT(rental. *) AS bucket
FROM film
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY film.title
ORDER BY bucket DESC LIMIT 10;

-- 17. The top five film categories by number of rentals
-- (#1 should be â€œSportsâ€? with 1179 rentals and #5 should be â€œFamilyâ€? with 1096 rentals)

SELECT category.name, COUNT(rental.rental_id) AS totalrentals
FROM film
JOIN inventory ON film.film_id = inventory.film_id 
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN film_category ON film.film_id = film_category.category_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY totalrentals DESC LIMIT 5;

-- 18. The top five Action film titles by number of rentals
-- (#1 should have 30 rentals and #5 should have 28 rentals)

SELECT COUNT (rental.rental_id) AS totalrentals
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Action'
GROUP BY film.title
ORDER BY totalrentals DESC
LIMIT 5;



-- 19. The top 10 actors ranked by number of rentals of films starring that actor
-- (#1 should be â€œGINA DEGENERESâ€? with 753 rentals and #10 should be â€œSEAN GUINESSâ€? with 599 rentals)

SELECT actor.first_name, actor.last_name, COUNT(rental.rental_id) AS totalrentals
FROM rental
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film ON film.film_id = inventory.film_id
JOIN film_actor ON film_actor.film_id = film.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY totalrentals DESC
LIMIT 10;

-- 20. The top 5 â€œComedyâ€? actors ranked by number of rentals of films in the â€œComedyâ€? category starring that actor
-- (#1 should have 87 rentals and #5 should have 72 rentals)
        
SELECT actor.first_name, actor.last_name AS topactors, COUNT(rental.rental_id) AS totalrentals
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id

JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy'
GROUP BY actor.actor_id, topactors
ORDER BY totalrentals DESC
LIMIT 5;






