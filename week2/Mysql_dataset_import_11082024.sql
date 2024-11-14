--Create DATABASE for week2

CREATE DATABASE week2;
USE week2;
--Create table for cab_trips
CREATE TABLE cab_trips (
    Transaction_ID INT PRIMARY KEY,
    Date_of_Travel DATE,
    Company VARCHAR(50),
    City VARCHAR(50),
    KM_Travelled DECIMAL(6, 2),
    Price_Charged DECIMAL(8, 2),
    Cost_of_Trip DECIMAL(8, 3)
);

--Alter the format of Cost_of_Trip of the table of cab_trips
ALTER TABLE cab_trips MODIFY COLUMN Cost_of_Trip DECIMAL(15,4);

--remove all of the data from cab_trips to re-insert the data
TRUNCATE TABLE cab_trips;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cab_Data_rvsd_date.csv'
IGNORE INTO TABLE cab_trips
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


--Create table for city
CREATE TABLE city (
    City VARCHAR(50),
    Population INT,
    Users INT  
);

ALTER TABLE city
MODIFY COLUMN Population DECIMAL(10, 2),
MODIFY COLUMN Users DECIMAL(10, 2);

ALTER TABLE city
MODIFY COLUMN Population int,
MODIFY COLUMN Users int;

--remove all of the data from city to re-insert the data
TRUNCATE TABLE city;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/City_rvsd.csv'
IGNORE INTO TABLE city
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

--Create table for customer_id
CREATE TABLE customer_id (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT  CHECK (Age >= 0),
    Income_USD_Month INT  NOT NULL CHECK (Income_USD_Month >= 0)
);

TRUNCATE TABLE customer;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer_ID.csv'
IGNORE INTO TABLE customer
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

RENAME TABLE customer_id TO customer;

--Create table for transaction
CREATE TABLE transaction (
    Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID VARCHAR(50),
    Payment_Mode VARCHAR(10)
);

TRUNCATE TABLE transaction;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Transaction_ID.csv'
IGNORE INTO TABLE transaction
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;



--Join all tables
select t.Transaction_ID, c.Date_of_Travel, c.Company, c.City, c.KM_Travelled, c.Price_Charged, c.Cost_of_Trip, t.Customer_ID, t.Payment_Mode, u.Gender, u.Age, u.Income_USD_Month, i.Population, i.Users
from cab_trips c
left join transaction t
on c.Transaction_ID = t.Transaction_ID
left join customer u
on t.Customer_ID = u.Customer_ID
left join city i
on c.City = i.City

INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/output.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';









