--
-- Homework 6: SQL-DML
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
FOREIGN KEY (departure_airport) REFERENCES Airport(acronym) ON
DELETE CASCADE,
FOREIGN KEY (destination_airport) REFERENCES Airport(acronym)
ON DELETE CASCADE);
-- create the table Stopover
CREATE TABLE Stopover(flight_number VARCHAR(6) NOT NULL,
flight_date DATE NOT NULL,
pilot_id INT NOT NULL,
aircraft VARCHAR(30),
PRIMARY KEY(flight_number, flight_date),
FOREIGN KEY (flight_number) REFERENCES Flight(flight_number) ON
DELETE CASCADE,
FOREIGN KEY (pilot_id) REFERENCES Pilot(identification) ON
DELETE CASCADE
);

-- IMPORTANT NOTE: add the DDL statements here. After Module's 4 assignment 
-- deadline has passed, the statements to be added here will be provided on 
-- Canvas.

--
-- DML Statements (add your solutions here)
-- ----------------------------------------

--
-- Output 1: Pilot is populated with data
-- --------------------------------------
-- 

INSERT INTO Pilot(identification, pilot_name, salary, gratification, airline_name, country) 
	VALUES (279, 'Steven Grant Rogers', 30000.00, 500.00, 'American Airlines', 'USA'),
		   (602, 'Stephen Vincent Strange', 28000.00, 800.00, 'Westjet', 'Canada'),
           (628, 'Carol Susan Jane Danvers', 30000.00, 500.00, 'Air France', 'France'),
           (832, 'Clinton Francis Barton', 21000.00, NULL, NULL, 'Canada'),
           (947, 'Natasha Romanoff', 21000.00, NULL, 'United', 'USA');

SELECT * FROM Pilot;

--
-- Output 2: Airport is populated with data
-- ----------------------------------------
-- 

INSERT INTO Airport(acronym, airport_name, city, country)
	VALUE ('CDG', 'Aéroport Paris-Charles de Gaulle', 'Paris', 'France'),
		  ('DFW', 'Dallas Fort Worth Airport', 'Dallas', 'USA'),
          ('LAS', 'Las Vegas International Airport', 'Las Vegas', 'USA'),
          ('LYS', 'Aéroport Lyon Saint-Exupéry', 'Lyon', 'France'),
          ('MRS', 'Marseille Provence Airport', 'Marselha', 'France'),
          ('PHX', 'Phoenix Sky Harbor Airport', 'Phoenix', 'USA'),
          ('YVR', 'Vancouver International Airport', 'Richmond', NULL),
          ('YYZ', 'Toronto Pearson International Airport', 'Toronto', NULL);

SELECT * FROM Airport;

--
-- Output 3: Flight is populated with data
-- ---------------------------------------
-- 

INSERT INTO Flight(flight_number, departure_airport, destination_airport, departure_time)
	VALUE ('AV431', 'YVR', 'LYS', '02:10:00'),
		  ('KI356', 'MRS', 'YVR', '23:55:00'),
          ('PR231', 'PHX', 'LAS', '12:15:00'),
          ('RG230', 'LAS', 'PHX', '23:05:00'),
          ('TG331', 'LAS', 'YYZ', '17:22:00');
          
SELECT * FROM Flight;

--
-- Output 4: Stopover is populated with data
-- -----------------------------------------
-- 

INSERT INTO Stopover(flight_number, flight_date, pilot_id, aircraft)
	VALUE ('AV431', '2023-10-30', 832, 'Airbus A380'),
		  ('KI356', '2023-09-07', 602, 'Embraer 195'),
          ('PR231', '2023-01-12', 947, 'Airbus A380'),
          ('PR231', '2023-10-15', 279, 'Airbus A380'),
          ('RG230', '2023-10-30', 279, 'Boeing 747'),
          ('TG331', '2023-01-12', 628, 'Airbus A380'),
          ('TG331', '2023-10-05', 947, 'Boeing 747');

SELECT * FROM Stopover;

--
-- Output 5: Las Vegas airport has changed
-- ---------------------------------------
-- 

UPDATE Airport SET airport_name = 'Harry Reid International Airport' WHERE acronym LIKE 'LAS';

SELECT * FROM Airport;

--
-- Output 6: All the pilots whose salary is lower than 22,000.00 has changed
-- -------------------------------------------------------------------------
-- 

UPDATE Pilot SET salary = 25000.00  WHERE salary < 22000.00;

SELECT * FROM Pilot;

--
-- Output 7: Pilot's gratification with NULL values have changed
-- -----------------------------------------------------
-- 

UPDATE Pilot SET gratification = 500.00  WHERE gratification IS NULL;

SELECT * FROM Pilot;

--
-- Output 8: Pilot's from Canada have changed
-- -------------------------------------------
-- 

UPDATE Pilot SET airline_name = 'Air Canada' WHERE country = 'Canada';

SELECT * FROM Pilot;

--
-- Output 9: Airport's country have changed based on the city names
-- -----------------------------------------------------------------
-- 

UPDATE Airport SET country = 'Canada' WHERE acronym LIKE "Y%";

SELECT * FROM Airport;

--
-- Output 10: Stopover's dates has changed based on their month (as a substring)
-- ---------------------------------------------------------------------------
-- 

UPDATE Stopover SET flight_date = '2023-09-07' WHERE flight_date LIKE "____-10%";

SELECT * FROM Stopover;

--
-- Output 11: Stopover's aircraft has changed based on the pilot's id
-- ------------------------------------------------------------------
-- 

UPDATE Stopover SET aircraft = 'Embraer 195' WHERE pilot_id = 279;

SELECT * FROM Stopover;

--
-- Output 12: Pilot's salary has changed based on a given range
-- ------------------------------------------------------------
-- 

UPDATE Pilot SET salary = (salary + 100) WHERE salary BETWEEN 25000.00 AND 28000.00;

SELECT * FROM Pilot;

--
-- Output 13: the number of records in the Flight table has changed based on 
-- the departure_airport
-- -------------------------------------------------------------------------
-- 

DELETE FROM Flight WHERE departure_airport = 'LAS';

SELECT * FROM Flight;

--
-- Output 14: the number of records in the Flight table has changed based on 
-- the departure_airport and destination_airport
-- -------------------------------------------------------------------------
-- 

DELETE FROM Flight WHERE departure_airport = 'YVR' AND destination_airport = 'LYS';

SELECT * FROM Flight;

--
-- Output 15: the number of records in the Pilot table has changed based on 
-- the gratification and country
-- ---------------------------------------------------------------
-- 

DELETE FROM Pilot WHERE gratification = 800.00 AND Country = 'Canada';

SELECT * FROM Pilot;

--
-- Output 16: the number of records in the Pilot table has changed based on 
-- pilot's names first character
-- ---------------------------------------------------------------
-- 

DELETE FROM Pilot WHERE pilot_name LIKE "C%";

SELECT * FROM Pilot;

--
-- Output 17: the number of records in the Airport table has changed based on 
-- airport's acronym
-- --------------------------------------------------------------------------
-- 

DELETE FROM Airport WHERE acronym LIKE "L%" OR acronym LIKE "M%";

SELECT * FROM Airport;

--
-- Output 18: the number of records in the Pilot table has changed with no
-- particular condition
-- -----------------------------------------------------------------------
-- 

DELETE FROM Pilot;
SELECT * FROM Pilot;
--
-- Output 19: the number of records in the Airport table has changed based
-- on country
-- -----------------------------------------------------------------------
-- 

DELETE FROM Airport WHERE NOT country = 'Canada';

SELECT * FROM Airport;

--
-- Output 20: the number of records in the Airport table has changed based
-- on the existence of the word International in their names
-- -----------------------------------------------------------------------
--

DELETE FROM Airport WHERE airport_name LIKE "%International%";

SELECT * FROM Airport;
--
-- CHECK YOUR WORK: use the following statements to check if your tables
-- contains the expected output.
-- ---------------------------------------------------------------------
--
-- read data from table Pilot
SELECT * FROM Pilot;
-- read data from table Flight
SELECT * FROM Flight;
-- read data from table Stopover
SELECT * FROM Stopover;
-- read data from table Airport
SELECT * FROM Airport;

--
-- end script
-- 