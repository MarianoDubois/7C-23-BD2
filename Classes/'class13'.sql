-- Active: 1682515061137@@127.0.0.1@3306@sakila
use sakila;

#1
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date,last_update)
SELECT 
    1,'Pepe','Perez','pepeperez@gmail.com', MAX(address_id),1,NOW(),NOW() 
FROM address
WHERE city_id IN (SELECT city_id FROM city WHERE country_id IN (SELECT country_id FROM country WHERE country = 'United States'));

select * from customer;

#2
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT
    NOW(),i.inventory_id,c.customer_id, NULL,s.staff_id 
FROM inventory AS i
INNER JOIN film AS f USING (film_id)
INNER JOIN customer AS c ON c.customer_id=1
INNER JOIN staff AS s ON s.store_id = 2  
WHERE f.title = 'ACE GOLDFINGER';      

select * from rental;

#3
UPDATE film
SET release_year = 
    CASE rating
        WHEN 'G' THEN '2001'
        WHEN 'PG' THEN '2002'
        WHEN 'PG-13' THEN '2003'
        WHEN 'R' THEN '2004'
        WHEN 'NC-17' THEN '2005'
        ELSE '2000' 
END;

select DISTINCT release_year from film;
SELECT * from film;

#4
 -- Paso 1 = 16052,11
SELECT rental_id, inventory_id
FROM rental
WHERE return_date IS NULL
ORDER BY rental_date DESC
LIMIT 1;


-- Paso 2
UPDATE rental
SET return_date = NOW()
WHERE rental_id = 16052;

UPDATE inventory
SET last_update = NOW()
WHERE inventory_id = 11; 

#5
DELETE FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1);

DELETE FROM payment
WHERE rental_id IN (SELECT rental_id FROM rental WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1));

DELETE FROM film_actor
WHERE film_id = 1;

DELETE FROM film_category
WHERE film_id = 1;

DELETE FROM inventory
WHERE film_id = 1;

DELETE FROM film
WHERE film_id = 1;

select * from film;

#6
#11
SELECT inventory_id
FROM inventory
WHERE film_id IS NOT NULL
AND inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL)
LIMIT 1;

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (NOW(), 11, 2, NULL, 2);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (2, 2, LAST_INSERT_ID(), 23, NOW());

select * from rental;