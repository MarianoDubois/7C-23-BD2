-- Active: 1682515061137@@127.0.0.1@3306@sakila
#Find all the film titles that are not in the inventory.
SELECT title FROM film
WHERE film_id NOT IN (SELECT DISTINCT inventory.film_id FROM inventory);

#Find all the films that are in the inventory but were never rented.
SELECT f.title, i.inventory_id FROM film f
JOIN inventory i using(film_id)
LEFT JOIN rental r using(inventory_id)
WHERE r.rental_id IS NULL;

#Generate a report 
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    r.store_id,
    f.title ,
    r.rental_date,
    r.return_date
FROM customer AS c
JOIN rental AS r USING (customer_id)
JOIN inventory AS i USING (inventory_id)
JOIN film AS f USING (film_id)
ORDER BY r.store_id, c.last_name;

#Show sales per store (money of rented films)
SELECT s.store_id, SUM(p.amount) AS `Ventas totales`
FROM store AS s
INNER JOIN inventory AS i USING (store_id)
INNER JOIN rental AS r USING (inventory_id)
INNER JOIN payment AS p USING (rental_id)
GROUP BY s.store_id;

#Which actor has appeared in the most films?
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS nombre, COUNT(fa.film_id) AS cantidad
FROM actor a
JOIN film_actor fa using(actor_id)
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY cantidad DESC
LIMIT 1;
