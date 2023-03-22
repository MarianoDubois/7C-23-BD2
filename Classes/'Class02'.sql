-- Active: 1679485957399@@127.0.0.1@3306@class02
create table film(
    film_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(40),
    descripcion VARCHAR(120),
    release_year DATE
);
create table actor(
    actor_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40)
);
create table film_actor(
    film_actor_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    actor_id BIGINT,
    film_id BIGINT
);
alter TABLE film ADD last_update DATE;
alter TABLE actor ADD last_update DATE;
ALTER Table film_actor
ADD CONSTRAINT fk_actor 
FOREIGN KEY (actor_id)
REFERENCES actor (actor_id);
ALTER Table film_actor
ADD CONSTRAINT fk_film
FOREIGN KEY (film_id)
REFERENCES film (film_id);
insert into film(title,descripcion,release_year,last_update) values
("avengers","la primera pelicula de la saga avengers",20120426,curdate()),
("rapidos y furiosos: 5in control","la quinta pelicula de la saga de rapidos y furiosos",20110429,curdate()),
("Harry Potter y la piedra filosofal","la primera pelicula de la saga harry potter",20011116,curdate());
insert into actor(first_name,last_name,last_update) values
("Robert","Downey",curdate()),
("Vin","Diesel",curdate()),
("Daniel","Radcliffe",curdate());
insert into film_actor(actor_id,film_id) values
(1,1),
(2,2),
(3,3);

