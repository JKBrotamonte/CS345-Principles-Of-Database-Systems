--
-- Homework 7.2: SQL-DML
-- @author: Jared Brotamonte 6072572
-- NAU, CS 345, Fall 2023
--

--
-- DDL Statements
-- --------------
-- IMPORTANT NOTE: use the following DDL statements to create your initial
-- database.

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
--
-- DML Statements
-- --------------
-- IMPORTANT NOTE: use the following DML statements to populate your initial
-- database.
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
-- passed, the statements to be added here will be provided on Canvas (same
-- script used in hw7-1).


--
-- DQL Statements
-- --------------

--
-- Output 1: flight information for flights to Brazil or France
-- ------------------------------------------------------------
-- 

SELECT f.flight_number, a.country, f.departure_time, s.flight_date
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Airport a ON f.destination_airport = a.acronym
WHERE a.country IN ('Brazil', 'France');
-- This query retrieves information about flights, including the flight number, destination country, departure time, and flight date. 
-- It achieves this by joining the "Flight" table with the "Stopover" and "Airport" tables based on common columns (flight_number and destination_airport, respectively) 
-- and filtering the results to include only flights with destinations in Brazil or France. The result will include information about flights that have stopovers,
-- and the output columns will be flight number, destination country, departure time, and stopover flight date.

--
-- Output 2: pilot information for pilots in Wanda Maximoff's airline
-- ------------------------------------------------------------------
-- 

SELECT p.pilot_name, p.airline_name
FROM Pilot p
WHERE p.airline_name = (SELECT airline_name FROM Pilot WHERE pilot_name = 'Wanda Maximoff');
-- This query returns the names of pilots and their respective airlines for those who work for the same airline as 'Wanda Maximoff'. 
-- The subquery is used to find the airline name associated with 'Wanda Maximoff', and the outer query filters the pilots based on this airline name.

--
-- Output 3: airlines that have France as destination
-- --------------------------------------------------
-- 

SELECT DISTINCT p.airline_name
FROM Pilot p
JOIN Stopover s ON p.identification = s.pilot_id
JOIN Flight f ON s.flight_number = f.flight_number
JOIN Airport a ON f.destination_airport = a.acronym
WHERE a.country = 'France';
-- This query retrieves distinct airline names for pilots who have been involved in flights with destinations in France.
-- It involves joins between the "Pilot," "Stopover," "Flight," and "Airport" tables, with the final results being filtered to include only those pilots associated with flights to France.
-- The use of DISTINCT ensures that only unique airline names are included in the result set.

--
-- Output 4: American Airlines' destination airports
-- -------------------------------------------------
-- 

SELECT DISTINCT f.flight_number, a.airport_name, a.city, a.country
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Airport a ON f.destination_airport = a.acronym
JOIN Pilot p ON s.pilot_id = p.identification
WHERE p.airline_name = 'American Airlines';
-- This query retrieves distinct flight information for flights where the pilot associated with the stopover works for 'American Airlines'.
-- The use of DISTINCT ensures that only unique combinations of flight number, airport name, city, and country are included in the result set.
-- The joins are used to establish relationships between the "Flight," "Stopover," "Airport," and "Pilot" tables.

--
-- Output 5: destination of flights with more than two stopovers
-- -------------------------------------------------------------
-- 

SELECT DISTINCT a.airport_name
FROM Airport a
WHERE a.acronym IN (
SELECT DISTINCT f.destination_airport
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
GROUP BY f.flight_number
HAVING COUNT(s.flight_number) > 2
);
-- The main query retrieves distinct airport names for airports that are destinations for flights with more than two stopovers.
--  The subquery is used to find the destination airports for flights meeting the specified criteria.
--  The outer query then filters the results based on the airport acronym.
--  The use of DISTINCT ensures that only unique airport names are included in the result set.

--
-- Output 6: airports for flights on 2022-01-12
-- --------------------------------------------
-- 

SELECT f.flight_number, d.airport_name AS departure, a.airport_name AS destination
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Airport d ON f.departure_airport = d.acronym
JOIN Airport a ON f.destination_airport = a.acronym
WHERE s.flight_date = '2022-01-12';
-- This query retrieves flight information for flights that have a stopover on the specified date.
-- The use of joins with the "Stopover," "Flight," and "Airport" tables connects information about flights, stopovers, departure airports, and destination airports.
-- The output includes the flight number, departure airport name, and destination airport name.

--
-- Output 7: destination of United operated flights in Embraer aircrafts
-- ---------------------------------------------------------------------
-- 

SELECT DISTINCT f.flight_number, a.airport_name, a.city
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Airport a ON f.destination_airport = a.acronym
JOIN Pilot p ON s.pilot_id = p.identification
WHERE p.airline_name = 'United' AND s.aircraft LIKE 'Embraer%';
-- This query retrieves distinct flight information for flights associated with pilots from the 'United' airline who operated an aircraft starting with 'Embraer'.
-- The use of DISTINCT ensures that only unique combinations of flight number, airport name, and city are included in the result set.
-- The joins connect information about flights, stopovers, airports, and pilots. The output includes flight number, airport name, and city.

--
-- Output 8: domestic flights
-- --------------------------
-- 

SELECT f.flight_number, f.departure_time, da.country AS departureCountry, aa.country AS destinationCountry
FROM Flight f
JOIN Airport da ON f.departure_airport = da.acronym
JOIN Airport aa ON f.destination_airport = aa.acronym
WHERE da.country = aa.country
ORDER BY f.flight_number;
-- This query retrieves information about flights where the departure and destination airports are in the same country.
-- The output includes the flight number, departure time, and the countries of the departure and destination airports.
-- The results are then ordered by flight number in ascending order.

--
-- Output 9: airports where American Airlines operates
-- ---------------------------------------------------
-- 

SELECT DISTINCT a.airport_name
FROM Airport a
JOIN Flight f ON a.acronym = f.destination_airport OR a.acronym = f.departure_airport
JOIN Pilot p ON f.flight_number IN (SELECT flight_number FROM Stopover WHERE pilot_id = p.identification)
WHERE p.airline_name = 'American Airlines';
-- This query retrieves distinct airport names for airports that are either departure or destination airports for flights associated with pilots from 'American Airlines'.
-- The use of DISTINCT ensures that only unique airport names are included in the result set.
-- The joins connect information about airports, flights, and pilots.
-- The output includes airport names that are associated with flights flown by pilots from 'American Airlines'.

--
-- Output 10: total income for pilots with the lowest gratification
-- ----------------------------------------------------------------
-- 

SELECT identification, (salary + gratification)
FROM Pilot
WHERE gratification = (SELECT MIN(gratification) FROM Pilot);
-- This query retrieves the identification and total compensation for pilots whose gratification is equal to the minimum gratification in the entire "Pilot" table.
-- The output includes pilots with the lowest gratification in terms of their identification and total compensation.

--
-- Output 11: pilots who flights to their own country in Boing aircrafts
-- ---------------------------------------------------------------------
-- 

SELECT DISTINCT p.identification, p.pilot_name
FROM Pilot p
JOIN Stopover s ON p.identification = s.pilot_id
JOIN Flight f ON s.flight_number = f.flight_number
JOIN Airport departure_airport ON f.departure_airport = departure_airport.acronym
JOIN Airport destination_airport ON f.destination_airport = destination_airport.acronym
WHERE p.country = destination_airport.country
  AND s.aircraft LIKE 'Boeing%';
-- This query retrieves distinct pilot identification and names for pilots who have operated Boeing aircraft
-- and have their country of origin matching the country of the destination airport of the flights they operated.
-- The use of DISTINCT ensures that only unique combinations of identification and pilot name are included in the result set.
-- The joins connect information about pilots, stopovers, flights, and airports.

--
-- Output 12: international flights departuring from the pilot's country
-- ----------------------------
-- 

SELECT DISTINCT f.flight_number
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Pilot p ON s.pilot_id = p.identification
JOIN Airport departure_airport ON f.departure_airport = departure_airport.acronym
JOIN Airport destination_airport ON f.destination_airport = destination_airport.acronym
WHERE p.country = departure_airport.country
  AND departure_airport.country <> destination_airport.country;
-- This query retrieves distinct flight numbers for flights where the pilot's country of origin matches the country of the departure airport,
-- but the departure and destination airports are in different countries.
-- The use of DISTINCT ensures that only unique flight numbers are included in the result set.
-- The joins connect information about flights, stopovers, pilots, and airports.
-- The output represents flights meeting the specified criteria.

--
-- Output 13: flight information for flights by American pilots with greater
-- salary than the average salaries of American pilots
-- --------------------------------------------------------------------------
-- 

SELECT DISTINCT f.flight_number, f.departure_time, s.aircraft
FROM Flight f
JOIN Stopover s ON f.flight_number = s.flight_number
JOIN Pilot p ON s.pilot_id = p.identification
WHERE p.country = 'USA'
  AND p.salary > (SELECT AVG(salary) FROM Pilot WHERE country = 'USA');
-- This query retrieves distinct flight information for flights where the pilot's country of origin is the USA,
-- and the pilot's salary is greater than the average salary of pilots in the USA.
-- The use of DISTINCT ensures that only unique combinations of flight number, departure time, and aircraft are included in the result set.
-- The joins connect information about flights, stopovers, and pilots.
-- The output represents flights meeting the specified criteria.

--
-- Output 14: salaries per airlines who have pilots who have not flown
-- -------------------------------------------------------------------
-- 

SELECT p.airline_name, AVG(salary)
FROM Pilot p
WHERE p.identification NOT IN (SELECT s.pilot_id FROM Stopover s)
GROUP BY p.airline_name;
-- This query calculates the average salary for pilots in each airline whose identification does not appear in the "Stopover" table.
-- The results are grouped by airline name, and the AVG(salary) provides the average salary for each airline.
-- This can help identify the average salary for pilots in airlines where there are no stopovers associated with them.

--
-- Output 15: airlines with the highest salary's average 
-- -----------------------------------------------------
-- 

SELECT airline_name, AVG(salary) AS average_salary
FROM Pilot
GROUP BY airline_name
ORDER BY average_salary DESC
LIMIT 1;
-- This query calculates the average salary for pilots in each airline,
-- orders the results by the average salary in descending order,
-- and returns only the top row,
-- representing the airline with the highest average salary for its pilots.

--
-- end script
-- 