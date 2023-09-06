#Create a user data_analyst
CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'pepe1234';
#Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

#Login with this user and try to create a table. Show the result of that operation.
mysql -u data_analyst -ppepe1234

CREATE TABLE tabla (
  id INT PRIMARY KEY,
  nombre VARCHAR(1)
);
-- No te permite ya que no le diste el permiso de CREATE

#Try to update a title of a film. Write the update script.
UPDATE sakila.film
SET title = 'Matrix'
WHERE film_id = 1;

#With root or any admin user revoke the UPDATE permission. Write the command
REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';

#Login again with data_analyst and try again the update done in step 4. Show the result.
mysql -u data_analyst -ppepe1234

UPDATE sakila.film
SET title = 'Matrix'
WHERE film_id = 1;

ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'

