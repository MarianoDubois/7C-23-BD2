-- Active: 1682515061137@@127.0.0.1@3306@sakila
#1- Insert a new employee to , but with an null email. Explain what happens.
CREATE TABLE
    `employees` (
        `employeeNumber` int(11) NOT NULL,
        `lastName` varchar(50) NOT NULL,
        `firstName` varchar(50) NOT NULL,
        `extension` varchar(10) NOT NULL,
        `email` varchar(100) NOT NULL,
        `officeCode` varchar(10) NOT NULL,
        `reportsTo` int(11) DEFAULT NULL,
        `jobTitle` varchar(50) NOT NULL,
        PRIMARY KEY (`employeeNumber`)
    );

INSERT INTO
    employees (
        employeeNumber,
        lastName,
        firstName,
        extension,
        email,
        officeCode,
        reportsTo,
        jobTitle
    )
VALUES (
        100,
        'Francisco',
        'Giayetto',
        'x123',
        NULL,
        '----',
        NULL,
        'ADMIN'
    );
# Error ya que la columna email no puede ser NULL


#2
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES (100, 'Smith', 'sr', 'x321', 'srsmith@mail.com', '---', 11, 'ADMIN');
UPDATE employees SET employeeNumber = employeeNumber - 20;
#Cambia el numero de employeeNumber por el valor anterior menos 20
select * from employees;
UPDATE employees SET employeeNumber = employeeNumber + 20;
#Cambia el numero de employeeNumber por el valor anterior mas 20

#3- Add a age column to the table employee where and it can only accept values from 16 up to 70 years old.
ALTER TABLE employees
ADD COLUMN age INT CHECK (age >= 16 AND age <= 70);


#4- Describe the referential integrity between tables film, actor and film_actor in sakila db.
-- Tabla "film" (película):
--     La tabla "film" contiene información sobre películas(titulo,etc).
-- Tabla "actor":
--     La tabla "actor" contiene información sobre actores(nombre,apellido,etc).
-- Tabla "film_actor":
--         Actúa como una tabla de enlace o tabla de relación.
--         Contiene dos columnas: "film_id" (identificador de película) y "actor_id" (identificador de actor).
--         Estas columnas se utilizan para establecer una relación de muchos a muchos entre películas y actores.
--         La columna "film_id" en "film_actor" hace referencia a la columna "film_id" en la tabla "film", creando una relación de clave externa.
--         La columna "actor_id" en "film_actor" hace referencia a la columna "actor_id" en la tabla "actor", también creando una relación de clave externa.

-- La integridad referencial en este contexto asegura lo siguiente:
--     Las películas listadas en la tabla "film_actor" (a través de la columna "film_id") deben corresponder a registros de películas existentes en la tabla "film".
--     Los actores listados en la tabla "film_actor" (a través de la columna "actor_id") deben corresponder a registros de actores existentes en la tabla "actor".

-- Esta integridad ayuda a mantener la consistencia en la base de datos y asegura que solo se puedan establecer relaciones válidas entre películas y actores. Evita la creación de registros huérfanos o relaciones que apunten a registros que no existen, lo que contribuye a mantener la precisión y coherencia de los datos.


#5- Create a new column called lastUpdate to table employee and use trigger(s) to keep the date-time updated on inserts and updates operations. Bonus: add a column lastUpdateUser and the respective trigger(s) to specify who was the last MySQL user that changed the row (assume multiple users, other than root, can connect to MySQL and change this table).
ALTER TABLE employees
ADD COLUMN lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE employees
ADD COLUMN lastUpdateUser VARCHAR(50);

DELIMITER //
CREATE TRIGGER update_lastUpdate
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_lastUpdateUser
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

show TRIGGERS;


#6- Find all the triggers in sakila db related to loading film_text table. What do they do? Explain each of them using its source code for the explanation.
SHOW TRIGGERS LIKE 'film_text';
# Este codigo muestra los TRIGGERS en una tabla especifica
# Este fue el resultado: Empty set (0,01 sec)
