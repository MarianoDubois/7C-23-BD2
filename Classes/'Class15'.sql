-- Active: 1682515061137@@127.0.0.1@3306@sakila

use sakila;

CREATE OR REPLACE VIEW LIST_OF_CUSTOMERS AS 
	select
	    c.customer_id,
	    concat(c.first_name, ' ', c.last_name),
	    a.address,
	    a.postal_code,
	    a.phone,
	    ci.city,
	    ct.country,
	    CASE
	        WHEN c.active = 1 THEN 'active'
	        ELSE 'inactive'
	    END AS status,
	    c.store_id
	from customer c
	    inner join address a USING(address_id)
	    inner join city ci USING (city_id)
	    inner join country ct USING (country_id);
; 

select * from list_of_customers;

CREATE or REPLACE VIEW FILM_DETAILS AS 
	SELECT
	    f.film_id,
	    f.title,
	    f.description,
	    c.name AS Categoria,
	    f.rental_rate AS Precio,
	    f.length AS Duracion,
	    f.rating,
	    GROUP_CONCAT(a.first_name, ' ', a.last_name) AS Actores
	FROM film f
	    INNER JOIN film_category fc using (film_id)
	    INNER JOIN category c USING (category_id)
	    INNER JOIN film_actor fa USING(film_id)
	    INNER JOIN actor a USING(actor_id)
	GROUP BY  f.film_id, f.title, f.description, c.name, f.rental_rate, f.length, f.rating;

SELECT * from `FILM_DETAILS`;

CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT
    c.name AS category,
    SUM(f.rental_rate) AS total
FROM film f
    JOIN film_category USING (film_id)
    JOIN category c USING (category_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
GROUP BY c.name;

SELECT * from sales_by_film_category;

CREATE OR REPLACE VIEW actor_information AS
SELECT
    a.actor_id AS actor_id,
    a.first_name AS first_name,
    a.last_name AS last_name,
    COUNT(fa.film_id) AS "Peliculas actuadas"
FROM actor a
    INNER JOIN film_actor fa USING(actor_id)
GROUP BY
    a.actor_id, a.first_name, a.last_name;

select * from actor_information;

#Actor_info
CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `sakila`.`actor_info` AS
select
    `a`.`actor_id` AS `actor_id`,
    `a`.`first_name` AS `first_name`,
    `a`.`last_name` AS `last_name`,
    group_concat(distinct concat(
        `c`.`name`, ': ',(
            select group_concat(`f`.`title` order by `f`.`title` ASC separator ', ') 
            from ((`sakila`.`film` `f` 
                join `sakila`.`film_category` `fc` on((`f`.`film_id` = `fc`.`film_id`))) 
                join `sakila`.`film_actor` `fa` on((`f`.`film_id` = `fa`.`film_id`))) 
            where ((`fc`.`category_id` = `c`.`category_id`) and (`fa`.`actor_id` = `a`.`actor_id`)))) 
            order by `c`.`name` ASC separator '; ') AS `film_info`

#selecciona el id del actor, primer nombre y apellido. 
# Ademas genera una cadena que muestra el nombre de cada categoría, seguido de una lista de los títulos de las películas relacionados con el actor. 
# Cada categoría está separada por un ";", y las películas en cada categoría están separados ",". Ordenado por categoria
from
    (((`sakila`.`actor` `a`
left join `sakila`.`film_actor` `fa` on
    ((`a`.`actor_id` = `fa`.`actor_id`)))
left join `sakila`.`film_category` `fc` on
    ((`fa`.`film_id` = `fc`.`film_id`)))
left join `sakila`.`category` `c` on
    ((`fc`.`category_id` = `c`.`category_id`)))
#Las relaciones necesarias con las tablas
group by
    `a`.`actor_id`,
    `a`.`first_name`,
    `a`.`last_name`;
#Agrupa por actores
