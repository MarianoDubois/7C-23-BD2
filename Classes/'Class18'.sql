-- Active: 1682515061137@@127.0.0.1@3306@sakila
#Write a function that returns the amount of copies of a film in a store in sakila-db. 
#Pass either the film id or the film name and the store id.
SELECT f.title
FROM inventory inv
INNER JOIN film f ON inv.film_id = f.film_id
INNER JOIN store s ON inv.store_id = s.store_id
WHERE s.store_id = 1

SELECT COUNT(*) AS cantidad_copias
FROM inventory inv
INNER JOIN film f ON inv.film_id = f.film_id
INNER JOIN store s ON inv.store_id = s.store_id
WHERE (f.film_id = 1 OR f.title = 'AGENT TRUMAN')
  AND s.store_id = 1;


#Write a stored procedure with an output parameter that contains a list of customer first and last names separated by ";", 
#that live in a certain country. You pass the country it gives you the list of people living there. 
#USE A CURSOR, do not use any aggregation function (ike CONTCAT_WS.
select * from country;

DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerClientesEnPais;
CREATE PROCEDURE ObtenerClientesEnPais(IN p_pais VARCHAR(50), OUT p_lista_clientes VARCHAR(1000))
BEGIN
    DECLARE hecho INT DEFAULT 0;
    DECLARE nombre VARCHAR(255);
    DECLARE clientes_pais CURSOR FOR
        SELECT CONCAT(c.first_name, ' ', c.last_name)
        FROM customer c
        INNER JOIN address a ON c.address_id = a.address_id
        INNER JOIN city ci ON a.city_id = ci.city_id
        INNER JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = p_pais;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET hecho = 1;
    
    SET p_lista_clientes = '';

    OPEN clientes_pais;
    
    FETCH clientes_pais INTO nombre;
    
    WHILE NOT hecho DO
        IF p_lista_clientes = '' THEN
            SET p_lista_clientes = nombre;
        ELSE
            SET p_lista_clientes = CONCAT(p_lista_clientes, ';', nombre);
        END IF;
        
        FETCH clientes_pais INTO nombre;
    END WHILE;
    
    CLOSE clientes_pais;
END //
DELIMITER ;

CALL ObtenerClientesEnPais('Argentina', @lista_clientes);
SELECT @lista_clientes;


#Review the function inventory_in_stock and the procedure film_in_stock explain the code, write usage examples.

-- Función inventory_in_stock
-- Esta es una función SQL que toma dos parámetros, p_film_id (el ID de la película) y p_store_id (el ID de la tienda), 
-- y devuelve un valor booleano que indica si una película está en stock en una tienda específica.
-- Ejemplo de Uso:
SELECT inventory_in_stock(1, 1); -- Verifica si la película con ID 1 está en stock en la tienda con ID 1

-- Esta consulta devolverá TRUE si la película está en stock y FALSE si no lo está.


-- Procedimiento film_in_stock:
-- Este procedimiento se utiliza para verificar si una película específica está en stock en una tienda específica y, 
-- si es así, muestra la información de la película y del inventario.
-- Ejemplo de Uso:
CALL film_in_stock(1, 1); -- Verifica y muestra información sobre la película con ID 1 en la tienda con ID 1

-- Este llamado al procedimiento mostrará la información de la película y del inventario si está disponible, 
-- o mostrará un mensaje indicando que la película no está disponible en esa tienda si no está en stock.