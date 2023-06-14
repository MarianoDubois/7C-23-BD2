
select title, length
from film
where length = (select min(length) from film);

select title, length
from film as f1
where length <= (select min(length) from film)
  and not EXISTS(select * from film AS f2 where f2.film_id <> f1.film_id and f2.length <= f1.length);

select c.first_name as nombre,c.last_name as apellido, a.address as direccion,
	(select min(amount) from payment p where c.customer_id = p.customer_id ) as min
from customer c
JOIN address a on c.address_id = a.address_id
order by c.first_name;

select c.first_name as nombre,c.last_name as apellido, a.address as direccion,
	(select MIN(amount) from payment p where c.customer_id = p.customer_id ) as min, 
    (select MAX(amount) from payment p where c.customer_id = p.customer_id ) AS max
from customer c
JOIN address a on c.address_id = a.address_id
order by c.first_name;

SELECT c.last_name, (SELECT MIN(p.amount) from payment p WHERE p.customer_id = c.customer_id), a.address
FROM customer c
join address a on c.address_id = a.address_id
order by c.last_name asc
;

SELECT c.last_name, p.amount, a.address
FROM customer c
join payment p on c.customer_id = p.customer_id
join address a on c.address_id = a.address_id
WHERE p.amount <= ALL (SELECT p.amount from payment p WHERE p.customer_id = c.customer_id) order by c.last_name asc
;