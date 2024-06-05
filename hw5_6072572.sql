--
-- Homework 5: SQL-DDL
-- @author: Jared Brotamonte, 6072572
-- NAU, CS 345, Fall 2023
--

--
-- Output 1: start fresh
-- ---------------------
-- 

DROP DATABASE airline_db;
SHOW DATABASES;

--
-- Output 2: initialization
-- ------------------------
-- 

CREATE DATABASE IF NOT EXISTS airline_db;

--
-- Output 3: inspect the database
-- ---------------------------
-- 

USE airline_db;
SHOW TABLES;

--
-- Output 4: the Pilot table
-- -------------------------
-- 

CREATE TABLE IF NOT EXISTS pilot(
identification INT PRIMARY KEY,
pilot_name VARCHAR(100) NOT NULL,
salary DECIMAL(10,2),
gratification DECIMAL(10,2),
airline_name VARCHAR(30),
airline_address VARCHAR(255),
country VARCHAR(15)
);
DESC pilot;

--
-- Output 5: the Airport table
-- ---------------------------
-- 

CREATE TABLE IF NOT EXISTS airport(
acronym VARCHAR(3) PRIMARY KEY,
airport_name VARCHAR(100) NOT NULL,
city VARCHAR(50),
country VARCHAR(15)
);
DESC airport;

--
-- Output 6: the Flight table
-- --------------------------
-- 

CREATE TABLE IF NOT EXISTS flight(
flight_number VARCHAR(6) PRIMARY KEY,
departure_airport VARCHAR(3) NOT NULL,
destination_airport VARCHAR(3) NOT NULL,
departure_time TIME,
FOREIGN KEY(departure_airport) REFERENCES airport(acronym),
FOREIGN KEY(destination_airport) REFERENCES airport(acronym)
);
DESC flight;

--
-- Output 7: the Connect table
-- ---------------------------
-- 

CREATE TABLE IF NOT EXISTS connect(
flight_number VARCHAR(6) NOT NULL UNIQUE,
flight_date DATE NOT NULL,
aircraft VARCHAR(30),
PRIMARY KEY(flight_number, flight_date)
);
DESC connect;

--
-- Output 8: check the work so far
-- -------------------------------
-- 

SHOW TABLES;

--
-- Output 9: change Connect
-- ------------------------
-- 

ALTER TABLE connect ADD pilot_identification VARCHAR(10) NOT NULL;
DESC connect;

-- 
-- Output 10: change Connect
-- -------------------------
-- 

ALTER TABLE connect CHANGE pilot_identification pilot_id VARCHAR(10) NOT NULL;
DESC connect;

--
-- Output 11: change Connect
-- -------------------------
-- 

ALTER TABLE connect MODIFY pilot_id INT NOT NULL;
DESC connect;

--
-- Output 12: change Connect
-- -------------------------
-- 

ALTER TABLE connect ADD CONSTRAINT fk_pilot_id FOREIGN KEY (pilot_id) REFERENCES pilot(identification);
DESC connect;

--
-- Output 13: change Pilot
-- ----------------------------
-- 

ALTER TABLE pilot DROP airline_address;
DESC pilot;

--
-- Output 14: change Connect
-- -------------------------
-- 

ALTER TABLE connect RENAME TO stopover;
SHOW TABLES;

--
-- Output 15: clean up
-- -------------------
-- 

DROP TABLE stopover;
DROP TABLE pilot;
DROP TABLE flight;
DROP TABLE airport;
SHOW TABLES;

--
-- Output 16: clean up
-- -------------------
-- 

DROP DATABASE IF EXISTS airline_db;
SHOW DATABASES;

--
-- end script
-- 