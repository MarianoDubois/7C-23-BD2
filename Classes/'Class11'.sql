-- Active: 1679485957399@@127.0.0.1@3306@sakila
SELECT c.country , count(ct.city) as City_cant FROM country c join city ct on c.country_id = ct.country_id GROUP BY c.country HAVING City_cant > 10 ORDER BY City_cant desc;

SELECT  c.first_name, 
        c.last_name,
        (SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id) AS 'Cant_pelis_que_alquilo',
        (SELECT GROUP_CONCAT(DISTINCT title ORDER BY title SEPARATOR ', ')
            FROM film
            WHERE film_id IN(SELECT film_id
                                FROM inventory
                                WHERE store_id IN(SELECT store_id
                                                    FROM store
                                                    WHERE store_id IN(SELECT store_id
                                                                        FROM customer 
                                                                        WHERE customer_id IN(SELECT customer_id
                                                                                                FROM rental r
                                                                                                WHERE c.customer_id = r.customer_id))))) AS 'Pelis_que_alguna_vez_alquilo'
                                                                                                from customer c;
--def bad
select c.first_name 
from customer c inner join rental r on c.customer_id = r.customer_id 
where c.customer_id = r.customer_id and return_date <= CURDATE();

--maybe good?
SELECT c.last_name
from customer c inner join rental r on c.customer_id = r.customer_id
where r.return_date = null;

--gudge
select *
from rental r inner join payment p on p.rental_id = r.rental_id 
where p.amount BETWEEN 2 and 7;

SELECT c.last_name,
(SELECT MAX(p.amount) from payment p where c.customer_id = p.customer_id),
(SELECT MIN(p.amount) from payment p where c.customer_id = p.customer_id),
(SELECT GROUP_CONCAT(p.amount SEPARATOR ', ') FROM payment p WHERE c.customer_id = p.customer_id) from customer c;

SELECT title, max(replacement_cost), min(replacement_cost) from film group by title;

SELECT c.first_name,c.last_name 
from customer c 
where exists (SELECT c2.first_name from customer c2 where c.first_name = c2.first_name and c.customer_id != c2.customer_id) 
order by c.first_name;

SELECT a.last_name
from actor a 
where exists (SELECT * from film f join film_actor fa on f.film_id = fa.film_id where a.actor_id = fa.actor_id and fa.film_id = f.film_id and (f.title = 'BETRAYED REAR' and 'CATCH AMISTAD'))
and not exists (SELECT * from film f join film_actor fa on f.film_id = fa.film_id where a.actor_id = fa.actor_id and fa.film_id = f.film_id and f.title = 'ACE GOLDFINGER') ;

select f.title, COUNT(fa.actor_id)
from film f inner join film_actor fa on f.film_id=fa.film_id
GROUP BY f.title
having COUNT(fa.actor_id) > 4;

SELECT (SELECT first_name
        FROM actor a2
        WHERE a1.first_name LIKE 'A%' 
        AND first_name = ANY(SELECT first_name
                    FROM actor a2
                    WHERE a1.first_name = a2.first_name
                        AND a1.actor_id <> a2.actor_id)), last_name
    FROM actor a1
    ORDER BY a1.first_name;