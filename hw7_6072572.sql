--
-- Homework 7: SQL-DML
-- @author: Jared Brotamonte, 6072572
-- NAU, CS 345, Fall 2023
--

--
-- DDL Statements
-- --------------
-- 

-- drop the database
DROP DATABASE IF EXISTS airline_db;
-- create the database
CREATE DATABASE IF NOT EXISTS airline_db;
-- select airline_db as the context
USE airline_db;
-- create the table Pilot
CREATE TABLE Pilot (
identification INT PRIMARY KEY NOT NULL,
pilot_name VARCHAR(100) NOT NULL,
salary DECIMAL(10, 2),
gratification DECIMAL(10, 2),
airline_name VARCHAR(30),
country VARCHAR(15)
);
-- create the table Airport
CREATE TABLE Airport(acronym VARCHAR(3) PRIMARY KEY NOT NULL,
airport_name VARCHAR(100) NOT NULL,
city VARCHAR(50),
country VARCHAR(15));
-- create the table Flight
CREATE TABLE Flight(flight_number VARCHAR(6) PRIMARY KEY NOT NULL,
departure_airport VARCHAR(3) NOT NULL,
destination_airport VARCHAR(3) NOT NULL,
departure_time TIME,
FOREIGN KEY (departure_airport) REFERENCES
Airport(acronym) ON DELETE CASCADE,
FOREIGN KEY (destination_airport) REFERENCES
Airport(acronym) ON DELETE CASCADE);
-- create the table Stopover
CREATE TABLE Stopover(flight_number VARCHAR(6) NOT NULL,
flight_date DATE NOT NULL,
pilot_id INT NOT NULL,
aircraft VARCHAR(30),
PRIMARY KEY(flight_number, flight_date),
FOREIGN KEY (flight_number) REFERENCES
Flight(flight_number) ON DELETE CASCADE,
FOREIGN KEY (pilot_id) REFERENCES Pilot(identification) ON
DELETE CASCADE
);

-- IMPORTANT NOTE: add the DDL statements here. After Module's 4 assignment 
-- deadline has passed, the statements to be added here will be provided on 
-- Canvas.

--
-- DML Statements
-- --------------
-- 

insert into Pilot values
(279, "Steven Grant Rogers", 30000.00, 500.00, "American Airlines", "USA"),
(627, "Wanda Maximoff", 30000.00, 500.00, "American Airlines", "USA"),
(947, "Natasha Romanoff", 25000.00, 800.00, "United", "USA"),
(463, "Anthony Edward Stark", 20000.00, 800.00, "United", "USA"),
(839, "Robert Bruce Banner", 35000.00, 500.00, "American Airlines", "USA"),
(628, "Carol Susan Jane Danvers", 30000.00, 500.00, "Air France", "France"),
(832, "Clinton Francis Barton", 20000.00, 800.00, "Air Canada", "Canada"),
(602, "Stephen Vincent Strange", 25000.00, 800.00, "Air Canada", "Canada"),
(633, "Victor Shade", 28000.00, 600.00, "Air France", "France"),
(382, "Jessica Jones", 35000.00, 700.00, "Japan Airlines", "Japan"),
(489, "Clark Joseph Kent", 29000.00, 500.00, "American Airlines", "USA"),
(847, "Oliver Jonas Queen", 32000.00, 400.00, "Air Canada", "Canada"),
(932, "Wade Winston Wilson", 35000.00, 200.00, "Air France", "France"),
(887, "Stephen Vincent Strange", 29000.00, 500.00, "Japan Airlines", "Japan");
insert into Airport values
("LAS", "Harry Reid International Airport", "Las Vegas", "USA"),
("PHX", "Phoenix Sky Harbor Airport", "Phoenix", "USA"),
("DFW", "Dallas Fort Worth Airport", "Dallas", "USA"),
("IAH", "George Bush Intercontinental Airport", "Houston", "USA"),
("LAX", "Los Angeles International Airport", "Los Angeles", "USA"),
("GRU", "Guarulhos International Airport", "Guarulhos", "Brazil"),
("BSB", "Presidente Juscelino Kubitschek International Airport", "Brasilia",
"Brazil"),
("MAO", "Eduardo Gomes International Airport", "Manaus", "Brazil"),
("CDG", "Aéroport Paris-Charles de Gaulle", "Paris", "France"),
("LYS", "Aéroport Lyon Saint-Exupéry", "Lyon", "France"),
("MRS", "Marseille Provence Airport", "Marselha", "France");
insert into Flight values
("RG230", "LAX", "PHX", "23:05"),
("PR231", "IAH", "LAS", "12:15"),
("TG331", "DFW", "LAX", "17:22"),
("AV431", "PHX", "GRU", "02:10"),
("KI356", "IAH", "MAO", "23:55"),
("OD468", "BSB", "LAX", "11:45"),
("PS324", "PHX", "GRU", "22:19"),
("OO677", "GRU", "DFW", "18:52"),
("TW873", "GRU", "LYS", "18:52"),
("IE832", "LYS", "MRS", "04:40"),
("JD646", "CDG", "LYS", "05:00"),
("MD342", "CDG", "BSB", "08:34"),
("UJ658", "LAS", "IAH", "08:34"),
("GF774", "LAS", "DFW", "08:34");
insert into Stopover values
("RG230", "2022-12-30", 279, "Boeing 747"),
("RG230", "2022-09-24", 628, "Boeing 747"),
("PR231", "2022-08-15", 279, "Airbus A380"),
("PR231", "2022-01-12", 947, "Airbus A380"),
("TG331", "2022-02-05", 947, "Boeing 747"),
("TG331", "2022-01-12", 627, "Airbus A380"),
("AV431", "2022-12-04", 463, "Embraer 195"),
("AV431", "2022-10-30", 839, "Airbus A380"),
("KI356", "2022-09-07", 463, "Embraer 195"),
("KI356", "2022-08-13", 463, "Embraer 175"),
("OD468", "2022-03-13", 839, "Airbus A330"),
("OD468", "2022-04-01", 839, "Airbus A330"),
("OD468", "2022-04-02", 839, "Airbus A330"),
("PS324", "2022-03-15", 627, "Airbus A320"),
("PS324", "2022-03-18", 627, "Embraer 195"),
("OO677", "2022-02-09", 832, "Embraer 195"),
("OO677", "2022-02-01", 832, "Boeing 797"),
("TW873", "2022-12-11", 602, "Boeing 797"),
("TW873", "2022-11-17", 633, "Boeing 797"),
("IE832", "2022-05-17", 633, "Embraer 195"),
("IE832", "2022-08-16", 602, "Embraer 175"),
("JD646", "2022-09-27", 602, "Embraer 175"),
("JD646", "2022-09-29", 832, "Airbus A320"),
("MD342", "2022-09-29", 382, "Airbus A320"),
("MD342", "2022-10-31", 382, "Airbus A330"),
("UJ658", "2022-03-30", 633, "Boeing 797"),
("UJ658", "2022-02-25", 279, "Boeing 797"),
("GF774", "2022-01-22", 602, "Boeing 747"),
("GF774", "2022-01-12", 633, "Boeing 747");

-- IMPORTANT NOTE: add the DML statements here. After Homework 6 deadline has 
-- passed, the statements to be added here will be provided on Canvas.

--
-- Output 1: pilot's records in a given order
-- ------------------------------------------
-- 

SELECT pilot_name, salary FROM pilot ORDER BY Salary;

--
-- Output 2: pilot's records in a given order
-- ------------------------------------------
-- 

SELECT pilot_name, salary FROM pilot ORDER BY pilot_name DESC;
 
--
-- Output 3: airport stats (total)
-- -------------------------------
-- 

SELECT COUNT(*) AS "#airports" FROM airport;

--
-- Output 4: employees per airline
-- -------------------------------
-- 

SELECT airline_name, COUNT(*) AS "#pilot" FROM pilot GROUP BY airline_name;

--
-- Output 5: airports per country
-- ------------------------------
-- 

SELECT country, COUNT(*) FROM airport GROUP BY country;

--
-- Output 6: airports per city (USA only)
-- --------------------------------------
-- 

SELECT city, COUNT(*) FROM airport WHERE country = 'USA' GROUP BY city;

--
-- Output 7: number of distinct aircrafts per flights with a single pilot
-- ----------------------------------------------------------------------
-- 

SELECT flight_number, COUNT(DISTINCT aircraft) AS "#aircrafts" FROM stopover GROUP BY flight_number HAVING COUNT(DISTINCT pilot_id) = 1;

--
-- Output 8: pilot stats (average)
-- -------------------------------
-- 

SELECT AVG(salary) AS 'Average salary' FROM pilot;
 
--
-- Output 9: USA pilot stats (average)
-- -----------------------------------
-- 

SELECT AVG(salary) AS 'Average salary' FROM pilot WHERE country = 'USA';

--
-- Output 10: stats per airline
-- ----------------------------
-- 

SELECT airline_name, MIN(salary) AS 'lowest_salary', MAX(salary) AS 'greatest_salary', AVG(salary) AS 'average_salary' FROM pilot GROUP BY airline_name;

--
-- Output 11: number of pilots per airline with average salary greater 
-- than 25000
-- -------------------------------------------------------------------
-- 

SELECT airline_name, COUNT(*) AS '#pilots' FROM pilot GROUP BY airline_name HAVING AVG(salary) > 25000;

--
-- Output 12: destination airports with more than one distinct flight
-- ------------------------------------------------------------------
-- 

SELECT destination_airport FROM flight GROUP BY destination_airport HAVING COUNT(DISTINCT flight_number) > 1;
 
--
-- Output 13: pilot's total income (salary + gratification) for pilots with
-- flight date before 2022-11-14
-- ------------------------------------------------------------------------
-- 

SELECT p.identification, p.pilot_name, (p.salary + p.gratification) FROM pilot p
	WHERE p.identification IN (SELECT s.pilot_id FROM Stopover s WHERE s.flight_date < '2022-11-14')
	GROUP BY p.identification;

--
-- Output 14: airport info for flight RG230
-- ----------------------------------------
-- 

SELECT a.city, a.country FROM airport a
	WHERE a.acronym IN (SELECT f.destination_airport FROM flight f WHERE f.flight_number = 'RG230');
 
--
-- Output 15: airlines of pilots who flew on 2022-01-12
-- ----------------------------------------------------
-- 

SELECT p.airline_name FROM pilot p
	WHERE p.identification IN (SELECT s.pilot_id FROM stopover s WHERE s.flight_date = '2022-01-12');

--
-- Output 16: detailed stopover information
-- ----------------------------------------
-- 

SELECT DISTINCT s.flight_number, p.pilot_name, s.aircraft, p.airline_name
	FROM stopover s
	JOIN pilot p ON s.pilot_id = p.identification
    ORDER BY s.flight_number, p.pilot_name DESC;

--
-- Output 17: detailed stopover information for airlines with pilots from 
-- outside the USA
-- ---------------------------------------------------------------------
-- 

SELECT s.flight_number, p.pilot_name, s.aircraft, p.airline_name
	FROM stopover s
	JOIN pilot p ON s.pilot_id = p.identification
	WHERE p.country != "USA"
    ORDER BY s.flight_number, p.pilot_name DESC;

--
-- Output 18: pilot's name with flight information, if any
-- -------------------------------------------------------
-- 

SELECT p.pilot_name, s.flight_number, s.flight_date
	FROM pilot p
	LEFT JOIN stopover s ON p.identification = s.pilot_id;

--
-- Output 19: flights that departure in the morning (0-11) OR in January
-- (month 01)
-- --------------------------------------------------------------
-- 

SELECT DISTINCT f.flight_number FROM flight f 
	JOIN stopover s ON f.flight_number = s.flight_number
	WHERE(HOUR(f.departure_time) BETWEEN 0 AND 11) OR (MONTH(s.flight_date) = 01);

--
-- Output 20: Canadian pilots who have flown more than three flights
-- in order of salary
-- --------------------------------------------------------------
-- 

SELECT p.pilot_name, COUNT(s.flight_number) AS total_flights, AVG(p.salary) AS avg_salary
	FROM pilot p
	JOIN stopover s ON p.identification = s.pilot_id
	WHERE p.country = 'Canada'
	GROUP BY p.pilot_name
	HAVING COUNT(s.flight_number) >= 3
	ORDER BY AVG(p.salary) DESC;

--
-- end script
-- 