-- Active: 1653565335388@@127.0.0.1@3306@sakila
/*
1.Get the amount of cities per country in the database. Sort them by country, country_id.

2.Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest

3.Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.
Show the ones who spent more money first .

4.Which film categories have the larger film duration (comparing average)?
Order by average in descending order

5.Show sales per film rating
*/

--1
select co.country, co.country_id, count(ci.city_id) from country co
inner join city ci using(country_id)
group by co.country, co.country_id
order by co.country, co.country_id;

--2
select co.country, co.country_id, count(ci.city_id) from country co
inner join city ci using(country_id)
group by co.country, co.country_id
having count(ci.city_id) > 10
order by count(ci.city) DESC;

--3
select concat(c.first_name, ", ",c.last_name) as `name`, 
(SELECT a.address FROM address a WHERE a.address_id = c.address_id) as address,
(select count(r.rental_id) from rental r where r.customer_id=c.customer_id) as total_rentadas,
(select sum(p.amount) from payment p where p.customer_id=c.customer_id) as dinero_en_rentas
from customer c
order by dinero_en_rentas asc;

--4
select c.name, avg(f.length) as duracion_promedio from category c
inner join film_category fc using(category_id)
inner join film f using(film_id)
group by c.name
order by duracion_promedio;

--5
select f.rating, count(r.rental_id) from film f 
inner join inventory i using(film_id)
inner join rental r using(inventory_id)
group by f.rating; 

--pasando a la siguiente guia 

/*
1.Find all the film titles that are not in the inventory.

2.Find all the films that are in the inventory but were never rented.
Show title and inventory_id.
This exercise is complicated.
hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null

3.Generate a report with:
customer (first, last) name, store id, film title,
when the film was rented and returned for each of these customers
order by store_id, customer last_name

4.Show sales per store (money of rented films)
show store's city, country, manager info and total sales (money)
(optional) Use concat to show city and country and manager first and last name

5.Which actor has appeared in the most films?
*/

--1
select f.title from film f
left join inventory i on f.film_id=i.film_id
where isnull(i.film_id) = TRUE;

--2
select i.inventory_id from inventory i
