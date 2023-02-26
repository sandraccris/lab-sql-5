USE sakila;


-- 1. Drop column picture from staff.

ALTER TABLE staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

select *
from customer
WHERE first_name = "TAMMY";

select *
FROM staff;

INSERT INTO staff VALUES (75, "Tammy", "Sanders", 79, "Tammy.Sanders@sakilacustomer.org", 2, 1, "Tammy", "password123", "2006-02-15");


-- 3 Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:


SELECT customer_id 
FROM customer
WHERE first_name = 'CHARLOTTE' and last_name = 'HUNTER';  -- customer ID is 130


SELECT *
FROM film
WHERE title = "Academy Dinosaur"; -- film_id = 1

SELECT *
FROM inventory
WHERE film_id = 1; -- In store 1 exists 4 copies of movie "Academy Dinosaur, SO i will pick any copy(from 1-4) to insert into "inventory_id" column.

SELECT *
FROM rental
ORDER BY rental_id DESC; -- checking last ID number to not add a duplicate rental_id

select *
from staff
WHERE store_id = 1; -- To check staff id number from employer in store 1

-- rental_id(16050), rental_date(2023-02-25), inventory_id(1), customer_id(130), return_date(ANY??), staff_id(1), last_update(ANY??)
INSERT INTO rental VALUES("16050", "2023-02-25", 1, 130, "2023-02-25", 1, "2023-02-25");

SELECT *
FROM rental
WHERE rental_id = 16050;


-- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

-- 4.1 Check if there are any non-active users

SELECT *
FROM CUSTOMER
WHERE active=0;   -- 15 non-active users


-- 4.2 Create a table "backup table" as suggested

CREATE TABLE backup_table(
customer_id int(11) NOT NULL,    
email text,
date datetime
);

-- 4.3 Insert the non active users in the table backup table

INSERT INTO backup_table values ('16', 'SANDRA.MARTIN@sakilacustomer.org', NOW()),
('64', 'JUDITH.COX@sakilacustomer.org', NOW()),
('124', 'SHEILA.WELLS@sakilacustomer.org', NOW()),
('169', 'ERICA.MATTHEWS@sakilacustomer.org', NOW()),
('241', 'HEIDI.LARSON@sakilacustomer.org', NOW()),
('271', 'PENNY.NEAL@sakilacustomer.org', NOW()),
('315', 'KENNETH.GOODEN@sakilacustomer.org', NOW()),
('368', 'HARRY.ARCE@sakilacustomer.org', NOW()),
('406', 'NATHAN.RUNYON@sakilacustomer.org', NOW()),
('446', 'THEODORE.CULP@sakilacustomer.org', NOW()),
('482', 'MAURICE.CRAWLEY@sakilacustomer.org', NOW()),
('510', 'BEN.EASTER@sakilacustomer.org', NOW()),
('534', 'CHRISTIAN.JUNG@sakilacustomer.org', NOW()),
('558', 'JIMMIE.EGGLESTON@sakilacustomer.org', NOW()),
('592', 'TERRANCE.ROUSH@sakilacustomer.org', NOW());


-- 4.4 Delete the non active users from the table customer

DELETE FROM customer WHERE active = 0;

-- An error comes up. Can not delete non active users from customer table because customer_id is primary key in different tables(ex: Table "rental" and "payment") to ensure data consistency. 