-- Active: 1679485957399@@127.0.0.1@3306@sakila
/*
1 Show title and special_features of films that are PG-13
2 Get a list of all the different films duration.
3 Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
4 Show title, category and rating of films that have 'Behind the Scenes' as special_features
5 Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
6 Show the address, city and country of the store with id 1
7 Show pair of film titles and rating of films that have the same rating.
8 Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
*/
select title, special_features
from film
where rating = "PG-13";
select title, length
from film;
select title, rental_rate, replacement_cost
from film
where replacement_cost BETWEEN 20 and 24;
select f.title, c.name, f.rating
from film f 
inner join film_category fc on fc.film_id=f.film_id 
inner join category c on fc.category_id=c.category_id  
where f.special_features="Behind the Scenes";
select a.first_name, a.last_name
from actor a
inner join film_actor fa on fa.actor_id=a.actor_id
inner join film f on f.film_id=fa.film_id
where f.title="ZOOLANDER FICTION";
select s.store_id, a.address, ci.city, co.country
from store s
inner join address a on a.address_id=s.address_id
inner join city ci on ci.city_id=a.city_id
inner join country co on co.country_id=ci.country_id
where s.store_id=1;
select f1.title, f2.title, f1.rating, f2.rating
from film f1, film f2
where f1.film_id<>f2.film_id && f1.rating=f2.rating;
select f.title, sto.store_id, sta.first_name, sta.last_name
from film f
inner join inventory i on i.film_id=f.film_id
inner join store sto on sto.store_id=i.store_id
inner join staff sta on sta.staff_id=sto.manager_staff_id
where sto.store_id=2;
/*
--------------------------------------------------------------------------
*/
/*
1 List all the actors that share the last name. Show them in order
2 Find actors that don't work in any film
3 Find customers that rented only one film
4 Find customers that rented more than one film
5 List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
6 List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
7 List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
8 List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
*/
--1
select a1.actor_id, a1.first_name, a1.last_name, 
a2.actor_id, a2.first_name, a2.last_name
from actor a1, actor a2
where a1.actor_id<>a2.actor_id && a1.last_name=a2.last_name
order by last_name;
--1
select a1.first_name, a1.last_name, a1.actor_id
from actor a1
where exists(select a2.last_name, a2.actor_id
            from actor a2
            where a1.actor_id<>a2.actor_id && a1.last_name=a2.last_name)
order by last_name;
--2
select a.first_name, a.actor_id
from actor a
where not exists(select *
                from film_actor fa
                where a.actor_id=fa.actor_id);
--3
select c.first_name, c.last_name
from customer c
where exists(
    select customer_id
    from rental r
    where r.customer_id=c.customer_id having count(*) = 1);
--4
select c.first_name
from customer c
where exists(
    select r.customer_id
    from rental r
    where r.customer_id=c.customer_id having count(*) > 1);
--5
select a.first_name
from actor a
where exists(
    select f.title
    from film f inner join film_actor fa on fa.film_id=f.film_id
    where f.film_id=fa.film_id && a.actor_id=fa.actor_id && (f.title="BETRAYED REAR" or f.title="CATCH AMISTAD"));
--6
SELECT a1.last_name 
FROM actor a1
where exists (SELECT * 
        FROM film f
        join film_actor fa on f.film_id = fa.film_id
        where a1.actor_id = fa.actor_id and fa.film_id = f.film_id 
        and f.title = "BETRAYED REAR")
and not EXISTS (SELECT * 
        FROM film f
        join film_actor fa on f.film_id = fa.film_id
        where a1.actor_id = fa.actor_id and fa.film_id = f.film_id 
        and f.title = "CATCH AMISTAD");
--7
select a.first_name
from actor a
where exists(
    select f.title
    from film f inner join film_actor fa on fa.film_id=f.film_id
    where f.film_id=fa.film_id && a.actor_id=fa.actor_id && f.title="BETRAYED REAR" && f.title="CATCH AMISTAD");
--8
select a.first_name
from actor a
where not exists(
    select f.title
    from film f inner join film_actor fa on fa.film_id=f.film_id
    where f.film_id=fa.film_id && a.actor_id=fa.actor_id && (f.title="BETRAYED REAR" or f.title="CATCH AMISTAD"));
/*
--------------------------------------------------------------------------
*/
/*
1 Find the films with less duration, show the title and rating.
2 Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty resultset.
3 Generate a report with list of customers showing the lowest payments done by each of them. Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.
4 Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.
*/
--1
select title, rating, length
from film 
where length = (select min(length) from film);
--2
select f1.title, f1.length
from film f1
where f1.length = (select min(length) from film)
and not exists(select * from film f2 where f1.film_id<>f2.film_id
and f1.length >= f2.length);
--3
select cu.first_name, cu.last_name, a.address, min(p.amount)
from customer cu
inner join payment p on p.customer_id=cu.customer_id
inner join address a on a.address_id=cu.address_id
group by cu.first_name,cu.last_name,a.address;
--4
select cu.first_name, cu.last_name, a.address, min(p.amount), max(p.amount)
from customer cu
inner join payment p on p.customer_id=cu.customer_id
inner join address a on a.address_id=cu.address_id
group by cu.first_name,cu.last_name,a.address; 
/*
--------------------------------------------------------------------------
*/
/*
1 Get the amount of cities per country in the database. Sort them by country, country_id.
2 Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest
3 Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.
Show the ones who spent more money first .
4 Which film categories have the larger film duration (comparing average)?
Order by average in descending order
5 Show sales per film rating
*/
--1
select co.country, COUNT(ci.city)
from country co
inner join city ci on co.country_id=ci.country_id
group by co.country, co.country_id
order by co.country, co.country_id;
--2
select co.country, COUNT(ci.city) 
from country co
inner join city ci on co.country_id=ci.country_id
group by co.country
having count(ci.city) >= 10
order by count(ci.city) desc;
--3
select cu.first_name, cu.last_name, a.address,
(select count(*) from rental r where cu.customer_id=r.customer_id),
(select sum(p.amount) from payment p where p.customer_id=cu.customer_id) as dinero_gastado
from customer cu
inner join address a on a.address_id=cu.address_id
order by dinero_gastado desc;
--4
select c.name,
(select avg(f.length)
from film f 
inner join film_category fc on f.film_id=fc.film_id
where c.category_id=fc.category_id) as average
from category c
order by average desc;
--5
SELECT c.name, AVG(f.length) AS PROMEDIO_DURACION
FROM film f
         INNER JOIN film_category fc ON fc.film_id = f.film_id
         INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY PROMEDIO_DURACION DESC;
