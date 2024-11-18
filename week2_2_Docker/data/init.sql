--Create DATABASE for week2

CREATE DATABASE IF NOT EXISTS week2;

USE week2;

--Create table for cab_trips
CREATE TABLE IF NOT EXISTS cab_trips(
    Transaction_ID INT PRIMARY KEY,
    Date_of_Travel DATE,
    Company VARCHAR(50),
    City VARCHAR(50),
    KM_Travelled DECIMAL(6, 2),
    Price_Charged DECIMAL(8, 2),
    Cost_of_Trip DECIMAL(15, 4)
);

--remove all of the data from cab_trips to re-insert the data
TRUNCATE TABLE cab_trips;

LOAD DATA INFILE '/docker-entrypoint-initdb.d/DataSets/Cab_Data_rvsd_date.csv'
IGNORE INTO TABLE cab_trips
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


--Create table for city
CREATE TABLE IF NOT EXISTS city (
    City VARCHAR(50),
    Population INT,
    Users INT  
);


--remove all of the data from city to re-insert the data
TRUNCATE TABLE city;

LOAD DATA INFILE '/docker-entrypoint-initdb.d/DataSets/City_rvsd.csv'
IGNORE INTO TABLE city
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--Create table for customer
CREATE TABLE IF NOT EXISTS customer (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT  CHECK (Age >= 0),
    Income_USD_Month INT NOT NULL CHECK (Income_USD_Month >= 0)
);

TRUNCATE TABLE customer;

LOAD DATA INFILE '/docker-entrypoint-initdb.d/DataSets/Customer_ID.csv'
IGNORE INTO TABLE customer
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


--Create table for transaction
CREATE TABLE IF NOT EXISTS transaction (
    Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID VARCHAR(50),
    Payment_Mode VARCHAR(10)
);

TRUNCATE TABLE transaction;

LOAD DATA INFILE '/docker-entrypoint-initdb.d/DataSets/Transaction_ID.csv'
IGNORE INTO TABLE transaction
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;



--Join all tables
SELECT 
    t.Transaction_ID, 
    c.Date_of_Travel, 
    c.Company, 
    c.City, 
    c.KM_Travelled, 
    c.Price_Charged, 
    c.Cost_of_Trip, 
    t.Customer_ID, 
    t.Payment_Mode, 
    u.Gender, 
    u.Age, 
    u.Income_USD_Month, 
    i.Population, 
    i.Users
FROM cab_trips c
LEFT JOIN transaction t ON c.Transaction_ID = t.Transaction_ID
LEFT JOIN customer u ON t.Customer_ID = u.Customer_ID
LEFT JOIN city i ON c.City = i.City


-- Save to CSV file as a result of query
INTO OUTFILE '/var/lib/mysql-files/output.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';









