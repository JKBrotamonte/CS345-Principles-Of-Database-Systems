--
-- Extra-credit: SQL-DDL/DML
-- @author: Jared Brotamonte, 6072572
-- NAU, CS 345, Fall 2023
--

--
-- Output 1: start fresh
-- ---------------------
-- 

DROP DATABASE IF EXISTS movie_db;
SHOW DATABASES;

--
-- Output 2: initialization
-- ------------------------
-- 

CREATE DATABASE IF NOT EXISTS movie_db;
SHOW DATABASES;

--
-- Output 3: inspect the database
-- ------------------------------
-- 

USE movie_db;
SHOW TABLES;

--
-- Output 4: the Movie table
-- -------------------------
-- 

CREATE TABLE movie(
movie_id INT PRIMARY KEY NOT NULL,
title VARCHAR(255) NOT NULL,
genre VARCHAR(50),
release_date DATE,
duration INT,
director VARCHAR(100)
);
DESC movie;

--
-- Output 5: the Room table
-- ------------------------
-- 

CREATE TABLE room(
room_id INT PRIMARY KEY NOT NULL,
theater_name VARCHAR(100) NOT NULL,
seating_capacity INT
);
DESC ROOM;

--
-- Output 6: the Showtime table
-- ----------------------------
-- 

CREATE TABLE showtime(
showtime_id INT PRIMARY KEY NOT NULL,
movie_id INT,
room_id INT,
start_time TIME,
end_time TIME,
show_date DATE,
FOREIGN KEY (movie_id) REFERENCES
movie(movie_id) ON DELETE CASCADE,
FOREIGN KEY (room_id) REFERENCES
room(room_id) ON DELETE CASCADE
);
DESC showtime;

--
-- Output 7: the Customer table
-- ----------------------------
-- 

CREATE TABLE customer(
customer_id INT PRIMARY KEY NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100),
address VARCHAR(255),
membership_status ENUM("Gold","Silver","Bronze")
);
DESC customer;

--
-- Output 8: the Ticket table
-- --------------------------
-- 

CREATE TABLE ticket(
ticket_id INT PRIMARY KEY NOT NULL,
showtime_id INT,
customer_id INT,
room_id INT,
ticket_type ENUM("Standard","VIP"),
purchase_date DATE,
seat_number INT,
purchase_price DECIMAL(10,2),
FOREIGN KEY (showtime_id) REFERENCES
showtime(showtime_id) ON DELETE CASCADE,
FOREIGN KEY (customer_id) REFERENCES
customer(customer_id) ON DELETE CASCADE
);
DESC ticket;

--
-- Output 9: check the work so far
-- -------------------------------
-- 

SHOW TABLES;

--
-- Output 10: change Room
-- ----------------------
-- 

ALTER TABLE room CHANGE theater_name room_name VARCHAR(100);
DESC room;

-- 
-- Output 11: change Ticket
-- ------------------------
-- 

ALTER TABLE ticket ADD CONSTRAINT fk_room_id FOREIGN KEY (room_id) REFERENCES room(room_id);
DESC ticket;

--
-- Output 12: change Ticket
-- ------------------------
-- 

ALTER TABLE ticket DROP seat_number;
DESC ticket;

--
-- Output 13: Movie is populated with data
-- ---------------------------------------
-- 

INSERT INTO movie(movie_id, title, genre, release_date, duration, director) 
	VALUES (1, "The Shawshank Redemption", "Drama", "1994-09-23", 142, "Frank Darabont"),
		   (2, "the Godfather", "Crime", "1972-03-24", 175, "Francis Ford Coppola"),
           (3, "Pulp Fiction", "Crime", "1994-10-14", 154, "Quentin Taratino"),
           (4, "The Dark Knight", "Action", "2008-07-18", 152, "Christopher Nolan");
SELECT * FROM movie;

--
-- Output 14: Customer is populated with data
-- ------------------------------------------
-- 

INSERT INTO customer(customer_id, first_name, last_name, email, address, membership_status)
	VALUES (1, "Natasha", "Romanoff", "natasha@email.com", "123 Main St", "Gold"),
		   (2, "Diana", "Prince", "diana@email.com", "456 Elm St", "Silver"),
           (3, "Peter", "Parker", "peter@email.com", "42 Web St", "Silver"),
           (4, "Clark", "Kent", "clark@email.com", "1 Superman Way", "Gold"),
           (5, "Jean", "Grey", "jean@email.com", "789 Oak St", "Bronze"),
           (6, "Bruce", "Wayne", "bruce@email.com", "33 Batcave Rd", "Bronze");
SELECT * FROM customer;

--
-- Output 15: Room is populated with data
-- --------------------------------------
-- 

INSERT INTO room(room_id, room_name, seating_capacity)
	VALUES (1, "Main Theater", 150),
		   (2, "3D Theater", 60),
           (3, "Comfort Theater", 70);
SELECT * FROM room;

--
-- Output 16: Showtime is populated with data
-- ------------------------------------------
-- 

INSERT INTO showtime(showtime_id, movie_id, room_id, start_time, end_time, show_date)
	VALUES (1, 1, 1, "15:00:00", "17:00:00", "2023-11-01"),
		   (2, 2, 2, "18:30:00", "20:30:00", "2023-11-01"),
           (3, 3, 3, "14:15:00", "16:15:00", "2023-11-02"),
           (4, 4, 3, "19:00:00", "21:00:00", "2023-11-02"),
           (5, 1, 2, "16:30:00", "18:30:00", "2023-11-03"),
           (6, 2, 1, "20:00:00", "22:00:00", "2023-11-03");
SELECT * FROM showtime;

--
-- Output 17: Ticket is populated with data
-- ----------------------------------------
-- 

INSERT INTO ticket(ticket_id, showtime_id, customer_id, room_id, ticket_type, purchase_date, purchase_price)
	VALUES (1, 1, 2, 1, "Standard", "2023-11-01", 12.99),
		   (2, 1, 6, 2, "VIP", "2023-11-01", 25.99),
           (3, 3, 3, 3, "Standard", "2023-11-02", 11.99),
           (4, 2, 1, 2, "VIP", "2023-11-02", 24.99),
           (5, 3, 2, 3, "Standard", "2023-11-03", 13.99);
SELECT * FROM ticket;

--
-- Output 18: VIP tickets have changed
-- -----------------------------------
-- 

UPDATE ticket SET purchase_price = 26.99 WHERE ticket_type = "VIP";
SELECT * FROM ticket;

--
-- Output 19: clean up
-- -------------------
-- 

DROP TABLE ticket;
DROP TABLE customer;
DROP TABLE showtime;
DROP TABLE movie;
DROP TABLE room;
SHOW TABLES;

--
-- Output 20: clean up
-- -------------------
-- 

DROP DATABASE IF EXISTS movie_db;
SHOW DATABASES;

--
-- end script
-- 