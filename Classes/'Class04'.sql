-- Active: 1679485957399@@127.0.0.1@3306@sakila
#query 1 Show title and special_features of films that are PG-13
SELECT title, special_features FROM film WHERE rating = 'PG-13' ORDER BY title;
#query 2 Get a list of all the different films duration.
SELECT title, length FROM film;
#query 3 Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
SELECT title, rental_rate, replacement_cost 
FROM film
WHERE replacement_cost BETWEEN 20.00 and 24.00;
#query 4 Show title, category and rating of films that have 'Behind the Scenes' as special_features
SELECT f.title, f.rating, c.name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE special_features = 'Behind the Scenes';
#quey 5 Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'ZOOLANDER FICTION';
#query 6 Show the address, city and country of the store with id 1
SELECT a.address, c.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE s.store_id = '1';
#query 7 Show pair of film titles and rating of films that have the same rating.
select f1.title, f1.rating, f2.title, f2.rating from film f1, film f2 where f1.film_id <> f2.film_id and f1.rating = f2.rating;
#query 8 Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
select staff.first_name, staff.last_name, film.title
from staff join store on staff.store_id = store.store_id 
join inventory on store.store_id = inventory.store_id 
join film on inventory.film_id = film.film_id 
where store.store_id = 2;