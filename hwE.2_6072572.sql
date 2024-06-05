--
-- Extra-credit: SQL-DQL
-- @author: Jared Brotamonte, 6072572
-- NAU, CS 345, Fall 2023
--

--
-- DDL Statements
-- ------------------

-- drop the database
DROP DATABASE IF EXISTS movie_db;
-- create the database
CREATE DATABASE IF NOT EXISTS movie_db;
-- select airline_db as the context
USE movie_db;
-- create the Movie table
CREATE TABLE IF NOT EXISTS Movie (
movie_id INT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
genre VARCHAR(50),
release_date DATE,
duration INT,
director VARCHAR(100)
);
-- create the Room table
CREATE TABLE IF NOT EXISTS Room (
room_id INT PRIMARY KEY,
room_name VARCHAR(100) NOT NULL,
seating_capacity INT
);
-- create the Showtime table
CREATE TABLE IF NOT EXISTS Showtime (
showtime_id INT PRIMARY KEY,
movie_id INT,
room_id INT,
start_time TIME,
end_time TIME,
show_date DATE,
FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
FOREIGN KEY (room_id) REFERENCES Room(room_id)
);
-- create the Customer table
CREATE TABLE IF NOT EXISTS Customer (
customer_id INT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100),
address VARCHAR(255),
membership_status ENUM('Gold', 'Silver', 'Bronze')
);
-- create the Ticket table
CREATE TABLE IF NOT EXISTS Ticket (
ticket_id INT PRIMARY KEY,
showtime_id INT,
customer_id INT,
room_id INT,
ticket_type ENUM('Standard', 'VIP'),
purchase_date DATE,
purchase_price DECIMAL(10, 2),
FOREIGN KEY (showtime_id) REFERENCES Showtime(showtime_id),
FOREIGN KEY (room_id) REFERENCES Room(room_id),
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

--
-- DML Statements
-- --------------

-- insert data into Movie
INSERT INTO Movie VALUES
(1, 'The Shawshank Redemption', 'Drama', '1994-09-23', 142, 'Frank Darabont'),
(2, 'The Godfather', 'Crime', '1972-03-24', 175, 'Francis Ford Coppola'),
(3, 'Pulp Fiction', 'Crime', '1994-10-14', 154, 'Quentin Tarantino'),
(4, 'The Dark Knight', 'Action', '2008-07-18', 152, 'Christopher Nolan'),
(5, 'Schindler''s List', NULL, '1993-12-15', 195, 'Steven Spielberg'),
(6, 'The Lord of the Rings: The Return of the King', 'Adventure', '2003-12-17',
201, 'Peter Jackson'),
(7, 'Inception', 'Sci-Fi', '2010-07-16', 148, 'Christopher Nolan'),
(8, 'Forrest Gump', 'Drama', '1994-07-06', 142, NULL),
(9, 'The Matrix', 'Sci-Fi', '1999-03-31', 136, 'Lana Wachowski'),
(10, 'Avatar', NULL, '2009-12-18', 162, 'James Cameron'),
(11, 'Casablanca', 'Romance', '1942-11-26', 102, 'Michael Curtiz'),
(12, "Five Nights of Freddie's", 'Thriller', NULL, 110, NULL),
(13, 'The Shining', NULL, '1980-01-01', 146, NULL);
-- insert data into Customer
INSERT INTO Customer VALUES
(1, 'Natasha', 'Romanoff', 'natasha@email.com', '123 Main St', 'Gold'),
(2, 'Diana', 'Prince', 'diana@email.com', '456 Elm St', 'Silver'),
(3, 'Peter', 'Parker', 'peter@email.com', '42 Web St', 'Silver'),
(4, 'Clark', 'Kent', 'clark@email.com', '1 Superman Way', 'Gold'),
(5, 'Jean', 'Grey', 'jean@email.com', '789 Oak St', 'Bronze'),
(6, 'Bruce', 'Wayne', 'bruce@email.com', '33 Batcave Rd', 'Bronze'),
(7, 'Steve', 'Rogers', 'steve@email.com', '123 Shield Ave', 'Gold'),
(8, 'Selina', 'Kyle', 'selina@email.com', '456 Cat St', 'Silver'),
(9, 'Anthony', 'Stark', 'tony@email.com', '42 Stark Tower', 'Silver'),
(10, 'Bruce', 'Banner', 'bruce@email.com', '1 Hulk Lane', 'Gold'),
(11, 'Wanda', 'Maximoff', 'wanda@email.com', '789 Hex St', 'Bronze'),
(12, 'Hal', 'Jordan', 'hal@email.com', '33 Lantern Rd', 'Bronze'),
(13, 'Barbara', 'Gordon', 'barbara@email.com', '123 Batgirl Ave', 'Gold'),
(14, 'Ororo', 'Munroe', 'ororo@email.com', '456 Weather St', 'Silver'),
(15, 'Arthur', 'Curry', 'arthur@email.com', '42 Atlantis Way', 'Silver'),
(16, 'Matt', 'Murdock', 'matt@email.com', '1 Daredevil Lane', 'Gold');
-- insert data into Room
INSERT INTO Room VALUES
(1, 'Main Theater', 150),
(2, '3D Theater', 60),
(3, 'Comfort Theater', 70),
(4, 'Vintage Theater', 50);
-- insert data into Showtime
INSERT INTO Showtime VALUES
(1, 1, 1, '15:00:00', '17:00:00', '2023-11-01'),
(2, 2, 2, '18:30:00', '20:30:00', '2023-11-01'),
(3, 3, 3, '14:15:00', '16:15:00', '2023-11-02'),
(4, 4, 3, '19:00:00', '21:00:00', '2023-11-02'),
(5, 1, 2, '16:30:00', '18:30:00', '2023-11-03'),
(6, 2, 1, '20:00:00', '22:00:00', '2023-11-03'),
(7, 5, 1, '17:00:00', '19:00:00', '2023-11-04'),
(8, 6, 1, '14:30:00', '16:30:00', '2023-11-04'),
(9, 1, 3, '19:30:00', '21:30:00', '2023-11-05'),
(10, 2, 2, '16:45:00', '18:45:00', '2023-11-05'),
(11, 3, 1, '14:00:00', '16:00:00', '2023-11-06'),
(12, 4, 2, '20:15:00', '22:15:00', '2023-11-06'),
(13, 1, 2, '15:30:00', '17:30:00', '2023-11-07'),
(14, 2, 3, '21:00:00', '23:00:00', '2023-11-07'),
(15, 5, 2, '17:45:00', '19:45:00', '2023-11-08'),
(16, 6, 1, '13:30:00', '15:30:00', '2023-11-08');
-- insert data into Ticket
INSERT INTO Ticket VALUES
(1, 1, 2, 1, 'Standard', '2023-11-01', 12.99),
(2, 1, 6, 2, 'VIP', '2023-11-01', 25.99),
(3, 3, 3, 3, 'Standard', '2023-11-02', 11.99),
(4, 2, 1, 2, 'VIP', '2023-11-02', 24.99),
(5, 3, 2, 3, 'Standard', '2023-11-03', 13.99),
(6, 4, 9, 3, 'VIP', '2023-11-03', 26.99),
(7, 2, 10, 1, 'Standard', '2023-11-04', 12.99),
(8, 4, 3, 2, 'VIP', '2023-11-04', 25.99),
(9, 5, 2, 2, 'Standard', '2023-11-05', 13.99),
(10, 6, 4, 1, 'VIP', '2023-11-05', 24.99),
(11, 1, 12, 3, 'Standard', '2023-11-06', 12.99),
(12, 4, 6, 1, 'VIP', '2023-11-06', 26.99),
(13, 5, 7, 2, 'Standard', '2023-11-07', 13.99),
(14, 6, 15, 3, 'VIP', '2023-11-07', 25.99),
(15, 3, 12, 3, 'Standard', '2023-11-08', 12.99),
(16, 5, 15, 2, 'VIP', '2023-11-08', 24.99),
(17, 4, 5, 1, 'Standard', '2023-11-09', 13.99),
(18, 6, 3, 2, 'VIP', '2023-11-09', 26.99),
(19, 2, 6, 1, 'Standard', '2023-11-10', 12.99),
(20, 1, 16, 3, 'VIP', '2023-11-10', 25.99),
(21, 5, 13, 4, 'Standard', '2023-11-11', 12.99),
(22, 5, 13, 4, 'Standard', '2023-11-11', 12.99);

--
-- DQL Statements
-- --------------

--
-- Output 1: movie's records in a given order
-- ------------------------------------------
-- find the movies names and genre in descending order of genre

SELECT title, genre
FROM Movie
ORDER BY genre DESC;
-- This query retrieves the "title" and "genre" columns from the "Movie" table and 
-- orders the result set based on the "genre" column in descending order.

--
-- Output 2: VIP tickets stats (average)
-- --------------------------------------
-- find the average purchase price of VIP tickets

SELECT AVG(purchase_price) AS avg_purchase_price_vip
FROM Ticket
WHERE ticket_type = 'VIP';
-- This query calculates the average purchase price for tickets with the ticket type 'VIP' and 
-- provides the result with the alias "avg_purchase_price_vip."

--
-- Output 3: total seating capacity (all rooms)
-- --------------------------------------------
-- find the total seating capacity for all rooms

SELECT SUM(seating_capacity) AS total_seating_capacity
FROM Room;
-- This query calculates the total seating capacity by summing up the values in the "seating_capacity" 
-- column for all rooms in the "Room" table and provides the result with the alias "total_seating_capacity."

--
-- Output 4: showtimes per movie (if exists)
-- -----------------------------------------
-- list the number of showtimes for each movie that has showtimes

SELECT m.title as movie_title, COUNT(s.showtime_id) AS showtime_count
FROM Movie m
LEFT JOIN Showtime s ON m.movie_id = s.movie_id
GROUP BY m.title
HAVING showtime_count > 0;
-- This query retrieves the movie title and the count of showtimes for each movie from the "Movie" and 
-- "Showtime" tables, respectively. It uses a left join to ensure all movies are included, 
-- even if they have no showtimes, and filters the result to include only movies with at least one showtime.

--
-- Output 5: standard tickets per customers with more than one tickets
-- -------------------------------------------------------------------
-- find the name and number of standard tickets per customer that has bought 
-- more than one ticket

SELECT c.first_name, c.last_name, COUNT(t.ticket_id) AS num_standard_tickets
FROM Customer c
LEFT JOIN Ticket t ON c.customer_id = t.customer_id
WHERE t.ticket_type = 'Standard'
GROUP BY c.first_name, c.last_name
HAVING COUNT(t.ticket_id) > 1;
-- This query retrieves the first name, last name, and the count of standard tickets for 
-- each customer from the "Customer" and "Ticket" tables, respectively. 
-- It uses a left join to ensure all customers are included, even if they have no standard tickets, 
-- and filters the result to include only customers with more than one standard ticket.

--
-- Output 6: number of showtimes per action movie
-- ----------------------------------------------
-- find the title, genre and number of showtimes for action movies

SELECT m.title, m.genre, COUNT(s.showtime_id)
FROM Movie m
LEFT JOIN Showtime s ON m.movie_id = s.movie_id
WHERE m.genre = 'Action'
GROUP BY m.title, m.genre;
-- This query retrieves the title, genre, and the count of showtimes for each action movie 
-- from the "Movie" and "Showtime" tables, respectively. 
-- It uses a left join to ensure all movies are included, even if they have no showtimes, 
-- and filters the result to include only movies with the genre 'Action'.

--
-- Output 7: all customers with the showtimes they attended (if any)
-- -----------------------------------------------------------------
--  list the names of all customers along with the showtimes (start time and
-- date) they attended, if any

SELECT c.first_name, c.last_name, s.start_time, s.show_date
FROM Customer c
LEFT JOIN Ticket t ON c.customer_id = t.customer_id
LEFT JOIN Showtime s ON t.showtime_id = s.showtime_id;
-- This query retrieves the first name and last name of customers along with the start time 
-- and show date of the showtimes they have tickets for. 
-- It uses left joins to ensure that all customers are included in the result, 
-- even if they have no tickets or corresponding showtimes.

--
-- Output 8: number of showtimes per title sorted by title
-- -------------------------------------------------------
-- list the name and genre of all movies, and if they have showtimes, list the 
-- number of showtimes

SELECT m.title, m.genre, COUNT(s.showtime_id) AS showtime_count
FROM Movie m
LEFT JOIN Showtime s ON m.movie_id = s.movie_id
GROUP BY m.title, m.genre
ORDER BY m.title;
-- This query retrieves the title, genre, and the count of showtimes for each movie from the "Movie" 
-- and "Showtime" tables, respectively. It uses a left join to ensure all movies are included, 
-- even if they have no showtimes, and orders the result by movie title in ascending order.

--
-- Output 9: average movies duration per room
-- ------------------------------------------
-- find the room id, name and average duration of movies shown in each room

SELECT r.room_id, r.room_name, AVG(m.duration) AS Average_Duration
FROM Room r
INNER JOIN Showtime s ON r.room_id = s.room_id
INNER JOIN Movie m ON s.movie_id = m.movie_id
GROUP BY r.room_id, r.room_name;
-- This query calculates the average duration of movies shown in each room by joining 
-- the "Room," "Showtime," and "Movie" tables. 
-- It uses inner joins to ensure that only rooms with scheduled showtimes and movies associated with 
-- those showtimes are included in the calculation. The result is grouped by room ID and room name.


--
-- Output 10: total purchase amount spent in Standard tickets per customer 
-- that spent more than 20 dollars in tickets
-- -----------------------------------------------------------------------
-- 

SELECT c.customer_id, c.first_name, c.last_name, SUM(t.purchase_price) AS total_purchase_amount
FROM Customer c
INNER JOIN Ticket t ON c.customer_id = t.customer_id
WHERE t.ticket_type = 'Standard'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_purchase_amount > 20;
-- This query retrieves the customer ID, first name, last name, and the total purchase amount of standard
-- tickets for each customer from the "Customer" and "Ticket" tables, respectively. 
-- It uses an inner join to link customers with their purchased tickets, 
-- filters the result to include only standard tickets, and includes only customers whose total purchase 
-- amount exceeds 20.

-- ----------------------------------------------------------------------------
-- ALL THE SUBQUERIES FROM HERE ON MUST INCLUDE AT LEAST ONE SUBQUERY
-- ----------------------------------------------------------------------------

--
-- Output 11: movies longer than the average duration of movies
-- ------------------------------------------------------------
-- find the movies where the duration is greater than the average duration
-- of all movies

SELECT movie_id, title, duration
FROM Movie
WHERE duration > (SELECT AVG(duration) FROM Movie);
-- This query retrieves the "movie_id," "title," and "duration" columns for movies from the "Movie" table 
-- where the duration is greater than the average duration of all movies in the same table.

--
-- Output 12: rooms that have never had a VIP ticket sold
-- ------------------------------------------------------
-- 

SELECT room_id, room_name
FROM Room
WHERE room_id NOT IN (SELECT DISTINCT room_id FROM Ticket WHERE ticket_type = 'VIP');
-- This query retrieves the "room_id" and "room_name" columns for rooms from the "Room" table where 
-- the room ID is not associated with VIP tickets in the "Ticket" table.

--
-- Output 13: customers who purchased tickets for movies directed by 
-- Christopher Nolan
-- -----------------------------------------------------------------
-- 

SELECT c.customer_id, c.first_name, c.last_name
FROM Customer c
JOIN Ticket t ON c.customer_id = t.customer_id
JOIN Showtime s ON t.showtime_id = s.showtime_id
JOIN Movie m ON s.movie_id = m.movie_id
WHERE m.director = 'Christopher Nolan'
ORDER BY c.customer_id;
-- This query retrieves the customer ID, first name, and last name for customers who have purchased 
-- tickets for showtimes featuring movies directed by 'Christopher Nolan'. 
-- It uses several inner joins to link customers, tickets, showtimes, and movies, 
-- and then filters the result to include only customers associated with Christopher Nolan's movies. 
-- The final result is sorted by customer ID.

--
-- Output 14: movies that have showtimes on the same date as 'The Godfather'
-- -------------------------------------------------------------------------
-- 

SELECT m.title, s.show_date
FROM Movie m
JOIN Showtime s ON m.movie_id = s.movie_id
WHERE (s.show_date, s.start_time) IN 
    (SELECT show_date, start_time FROM Showtime WHERE movie_id = (SELECT movie_id FROM Movie WHERE title = 'The Godfather'));
-- This query retrieves the title of movies and their corresponding show dates where the show date 
-- and start time match those of showtimes associated with the movie 'The Godfather.' 
-- The query uses joins to link movies with their showtimes and a subquery to get the relevant show date 
-- and start time for 'The Godfather.'

--
-- Output 15: Gold customer who only buys standard tickets
-- -------------------------------------------------------
-- 

SELECT DISTINCT c.first_name, c.last_name
FROM Customer c
JOIN Ticket t ON c.customer_id = t.customer_id
JOIN Showtime s ON t.showtime_id = s.showtime_id
JOIN Movie m ON s.movie_id = m.movie_id
WHERE c.membership_status = 'Gold'
    AND t.ticket_type = 'Standard'
    AND NOT EXISTS (
        SELECT 1
        FROM Ticket t2
        WHERE t2.customer_id = c.customer_id AND t2.ticket_type != 'Standard'
    );
-- This query retrieves distinct customer names (first name and last name) for customers with 
-- a 'Gold' membership status who have purchased only standard tickets and have no tickets of any other type. 
-- The query uses joins to link customers with their tickets, showtimes, 
-- and movies and conditions to filter the result based on membership status and ticket type.

--
-- end script
-- 