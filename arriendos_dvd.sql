--Construye las siguientes consultas:
--Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor. 

        --Customer
SELECT * FROM customer

--INSERTAR
INSERT INTO customer
(store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active)
VALUES
('1', 'Ruben', 'Araneda', 'ruben.araneda@example.com', '605', 'true', '2024-11-04', 
'2024-11-04 20:50:00', '1');

--Modifcar
UPDATE customer
SET email = 'austin.cintron@example.com'
WHERE customer_id = 599;

--Eliminar
-- Eliminar la restricción existente en Rental
ALTER TABLE Rental
DROP CONSTRAINT rental_customer_id_fkey;

-- Crear una nueva restricción con ON DELETE CASCADE
ALTER TABLE Rental
ADD CONSTRAINT rental_customer_id_fkey
FOREIGN KEY (customer_id)
REFERENCES Customer(customer_id)
ON DELETE CASCADE;

-- Eliminar la restricción existente en Payment
ALTER TABLE Payment
DROP CONSTRAINT payment_customer_id_fkey;

ALTER TABLE Payment
ADD CONSTRAINT payment_customer_id_fkey
FOREIGN KEY (customer_id)
REFERENCES Customer(customer_id)
ON DELETE CASCADE;

-- Eliminar registros relacionados en Rental
DELETE FROM Rental
WHERE customer_id = 598;

-- Eliminar registros relacionados en Payment
DELETE FROM Payment
WHERE customer_id = 598;

-- Ahora eliminar al cliente
DELETE FROM Customer
WHERE customer_id = 598;



        --STAFF
SELECT * FROM staff

--Insertar
INSERT INTO staff
(staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update, picture)
VALUES
('3', 'Chris', 'Drew', '5', 'chris.drew@example.com', '3', 'true', 'chris', '456123', '2024-11-19 16:10:06', 'null');

--Modificar
UPDATE staff
SET email = 'mike.hola@example.com'
WHERE staff_id = 1;

--Eliminar
DELETE FROM staff
WHERE staff_id = 3;


        --ACTOR
SELECT * FROM actor;

--Insertar
INSERT INTO actor
(actor_id, first_name, last_name, last_update)
VALUES
('201', 'Pedro', 'Pascal', '2024-11-27 23:04:08');

--Modificar
UPDATE actor
SET last_name = 'Balmaceda'
WHERE actor_id = 201;

--Eliminar
ALTER TABLE film_actor
DROP CONSTRAINT film_actor_actor_id_fkey;

ALTER TABLE film_actor
ADD CONSTRAINT film_actor_actor_id_fkey
FOREIGN KEY (actor_id) REFERENCES actor (actor_id)
ON DELETE CASCADE;

DELETE FROM actor 
WHERE actor_id = 143;



--Listar todas las “rental” con los datos del “customer” dado un año y mes.
SELECT 
    rental_id,
    rental_date,
    inventory_id,
    customer.customer_id,
    return_date,
    staff_id,
    rental.last_update
FROM 
    rental
JOIN 
    customer ON rental.customer_id = customer.customer_id
WHERE 
    EXTRACT(YEAR FROM rental_date) = 2005 
    AND EXTRACT(MONTH FROM rental_date) = 5
ORDER BY 
    rental_id ASC;



--Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
SELECT 
    payment_id AS "Número",
    payment_date AS "Fecha",
    amount AS "Monto"
FROM 
    payment
ORDER BY 
    payment_id ASC;



--Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
SELECT
    film_id,
    title,
    release_year,
    rental_rate
FROM
    film
WHERE
    release_year = 2006
    AND rental_rate > 4.0
ORDER BY
    rental_rate ASC;



--Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si éstas pueden ser nulas, 
--y su tipo de dato correspondiente.
SELECT
    table_name AS "Tabla",
    column_name AS "Columna",
    data_type AS "Tipo de dato",
    CASE
        WHEN is_nullable = 'YES' THEN 'Si'
        ELSE 'No'
    END AS "Permite NULL"
FROM
    information_schema.columns
WHERE
    table_schema = 'public'
    AND table_name IN ('category', 'inventory', 'customer', 'film_category', 'rental', 
						'film', 'payment', 'adress', 'languaje', 'staff', 'city', 
						'country', 'film_actor', 'actor', 'store');