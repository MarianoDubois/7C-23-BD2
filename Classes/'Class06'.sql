-- Active: 1679485957399@@127.0.0.1@3306@sakila
#Query 1 List all the actors that share the last name. Show them in order
select first_name, last_name
from actor as ac1
where exists(select last_name 
            from actor as ac2
            where ac1.last_name = ac2.last_name
            and ac1.actor_id <> ac2.actor_id)
order by last_name;
#Query 2 Find actors that don't work in any film

select first_name
from actor as ac
where not exists(select actor_id from film_actor as fa where fa.actor_id = ac.actor_id);
#Query 3 Find customers that rented only one film
select first_name
from customer as cu
where exists(select customer_id
            from rental as r
            where cu.customer_id = r.customer_id having count(*) = 1);
#Query 4 Find customers that rented more than one film
select first_name
from customer as cu
where exists(select customer_id
            from rental as r
            where cu.customer_id = r.customer_id having count(*) > 1);
#Query 5 List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
select first_name, last_name
from actor as ac
where exists(select title
            from film as f
            inner join film_actor fa on f.film_id = fa.film_id
            where f.film_id = fa.film_id
            and ac.actor_id = fa.actor_id
            and (f.title = "BETRAYED REAR"
            or f.title = "CATCH AMISTAD"));
#Query 6 List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
select first_name, last_name
from actor as ac
where exists(select title
            from film as f
            inner join film_actor fa on f.film_id = fa.film_id
            where f.film_id = fa.film_id
            and ac.actor_id = fa.actor_id
            and (f.title = "BETRAYED REAR"
            and f.title <> "CATCH AMISTAD"));
#Query 7 List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
select first_name, last_name
from actor as ac
where exists(select title
            from film as f
            inner join film_actor fa on f.film_id = fa.film_id
            where f.film_id = fa.film_id
            and ac.actor_id = fa.actor_id
            and f.title = "BETRAYED REAR"
            and f.title = "CATCH AMISTAD");
#Query 8 List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
select first_name, last_name
from actor as ac
where not exists(select title
            from film as f
            inner join film_actor fa on f.film_id = fa.film_id
            where f.film_id = fa.film_id
            and ac.actor_id = fa.actor_id
            and (f.title = "BETRAYED REAR"
            or f.title = "CATCH AMISTAD"))
order by first_name, last_name;