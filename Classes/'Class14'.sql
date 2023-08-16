-- Active: 1682515061137@@127.0.0.1@3306
#Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the city.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS NombreCompleto, a.address, ci.city
FROM customer c
INNER JOIN address a USING (address_id)
INNER JOIN city ci USING (city_id)
INNER JOIN country co USING (country_id)
WHERE co.country = 'Argentina';

#Write a query that shows the film title, language and rating. Rating shall be shown as the full text described here: https://en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States. Hint: use case.
SELECT f.title, l.name AS lenguaje,
       CASE f.rating
           WHEN 'G' THEN 'General Audiences'
           WHEN 'PG' THEN 'Parental Guidance Suggested'
           WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN 'R' THEN 'Restricted'
           WHEN 'NC-17' THEN 'Adults Only'
           ELSE 'Not Rated'
       END rating
FROM film f
INNER JOIN language l USING (language_id);

#Write a search query that shows all the films (title and release year) an actor was part of. Assume the actor comes from a text box introduced by hand from a web page. Make sure to "adjust" the input text to try to find the films as effectively as you think is possible.
SELECT CONCAT(ac.first_name,' ',ac.last_name)as Nombre, f.title, f.release_year
FROM film f
    INNER JOIN film_actor USING(film_id)
    INNER JOIN actor ac USING(actor_id)
WHERE
    CONCAT(first_name, ' ', last_name) LIKE TRIM(UPPER('ED CHASE'));

select * from actor;

#Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not. There should be returned column with two possible values 'Yes' and 'No'.
SELECT f.title, CONCAT(c.first_name, ' ', c.last_name) AS Nombre,
       CASE
           WHEN r.return_date IS NULL THEN 'No'
           ELSE 'Sí'
       END Devuelto
FROM rental r
INNER JOIN inventory i USING (inventory_id)
INNER JOIN film f USING (film_id)
INNER JOIN customer c USING (customer_id)
WHERE MONTH(r.rental_date) IN (5, 6);

select MONTH(rental_date) from rental;


#Investigate CAST and CONVERT functions. Explain the differences if any, write examples based on sakila DB.
-- Función CAST:

-- La función CAST se utiliza para convertir un valor de un tipo de datos a otro tipo de datos. 
-- Es útil cuando necesitas cambiar el tipo de datos de una columna o expresión en una consulta. 
-- Sin embargo, debe haber una conversión válida entre los tipos de datos para que CAST funcione correctamente.
-- Ejemplo: SELECT title, CAST(length AS FLOAT) AS length_in_float FROM film;

-- Función CONVERT:

-- La función CONVERT también se utiliza para cambiar el tipo de datos de una columna o expresión en una consulta. 
-- La principal diferencia entre CONVERT y CAST es que CONVERT proporciona más flexibilidad al permitirte especificar 
-- el formato de salida para ciertos tipos de datos, como fechas y horas.
-- Ejemplo: SELECT title, CONVERT(last_update, DATE) AS formatted_last_update FROM film;

-- Diferencias:
--     Sintaxis: La sintaxis básica de CAST es CAST(expresión AS tipo_de_dato), mientras que la sintaxis de CONVERT es CONVERT(expresión, tipo_de_dato).
--     Flexibilidad: CONVERT proporciona más flexibilidad al permitirte especificar formatos de salida para tipos de datos como fechas y horas.



#Investigate NVL, ISNULL, IFNULL, COALESCE, etc type of function. Explain what they do. Which ones are not in MySql and write usage examples.
-- NVL: Reemplaza un valor nulo con un valor predeterminado especificado.
-- Ejemplo:  SELECT NVL(nombre, 'Desconocido') FROM empleados;

-- ISNULL: Devuelve un valor especificado si la expresión es nula; de lo contrario, devuelve la expresión.
-- Ejemplo:  SELECT ISNULL(nombre, 'Desconocido') FROM empleados;

-- IFNULL:  Devuelve un valor especificado si la expresión es nula; de lo contrario, devuelve la expresión.
-- Ejemplo: SELECT IFNULL(nombre, 'Desconocido') FROM empleados;

-- COALESCE: Devuelve el primer valor no nulo en una lista de expresiones.
-- Ejemplo:SELECT COALESCE(nombre, apellido, 'Desconocido') FROM empleados;

-- MySQL no admite NVL o ISNULL, pero tiene su propia función IFNULL. Para lograr funcionalidad similar en diferentes 
-- sistemas de bases de datos, puedes utilizar COALESCE, que es más ampliamente compatible y portátil.