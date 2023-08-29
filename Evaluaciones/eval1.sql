-- Active: 1653565335388@@127.0.0.1@3306@sakila
--Mostraron aquellas películas cuya cantidad de actores sea menor al promedio de actores por películas. Además mostrar su cantidad de actores y una lista de los nombres de esos actores.
select f.title, COUNT(fa.actor_id) as 'cant_actores'
from film f inner join film_actor fa on f.film_id=fa.film_id
GROUP BY f.title
having COUNT(fa.actor_id) < avg(cant_actores);
--Obtener los pares de pagos realizados por el mismo cliente, considerar los clientes cuyo nombre comienza con alguna vocal. Mostrar el nombre del cliente y los 2 montos.
select c.first_name
from customer c
where EXISTS(select p.amount from payment p inner join customer c2 on c2.customer_id = p.customer_id where p.customer_id = c2.customer_id);
--Listar todas las películas cuya duración no sea la máxima ni la mínima, y además no deben tener a los actores cuyas id's son las siguientes(11,56,45,34,89) y el replacement cost no sea el máximo.
SELECT f.title from film f where f.length < max(f.length) and f.length > min(f.length) group by f.title;

--1

--2

--3