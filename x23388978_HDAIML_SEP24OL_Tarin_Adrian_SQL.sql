-- PART 2: Physical Design:
-- 1. Create the corresponding database using DDL

CREATE DATABASE OnlineFoodDeliverySystem;
USE OnlineFoodDeliverySystem;

-- 2. Create all the necessary tables using DDL
-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Address TEXT NOT NULL,
    DateOfBirth DATE NOT NULL
);

-- To calculate the Age as derived attribute in queries when needed, eliminating the need to store it explicitly.
SELECT 
    CustomerID, 
    FirstName, 
    LastName, 
    TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) AS Age 
FROM Customer;

-- Create the Restaurant table
CREATE TABLE Restaurant (
    RestaurantID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address TEXT NOT NULL
);

-- Create the Menu table
CREATE TABLE Menu (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    ItemName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID) ON DELETE CASCADE
);

-- Create the Vehicle table
CREATE TABLE Vehicle (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    LicensePlate VARCHAR(20) NOT NULL,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year INT NOT NULL
);

-- Create the Courier table
CREATE TABLE Courier (
    CourierID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    VehicleID INT UNIQUE NOT NULL,
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID) ON DELETE CASCADE
);

-- Create the Order table
CREATE TABLE `Order` (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CourierID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID) ON DELETE CASCADE
);

-- Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
	ItemTotal DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ItemID),
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ItemID) REFERENCES Menu(ItemID) ON DELETE CASCADE
);

-- Trigger to populate OrderDetails.ItemTotal
DELIMITER $$
CREATE TRIGGER CalculateItemTotal
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE itemPrice DECIMAL(10, 2);
    SELECT Price INTO itemPrice
    FROM Menu
    WHERE ItemID = NEW.ItemID;
    SET NEW.ItemTotal = NEW.Quantity * itemPrice;
END $$
DELIMITER ;

-- 3. Populate at least three of your tables with some data using DML (insert into statement)
-- Insert data into the Customer table
INSERT INTO Customer (FirstName, LastName, Phone, Email, Address, DateOfBirth)
VALUES 
('Walter', 'White', '1234567890', 'heisenberg10@gmail.com', '123 Elm Street', '1961-1-1'),
('Jesse', 'Pinkman', '0987654321', 'kaptain_cook@hotmail.com', '456 Maple Avenue', '1986-1-1'),
('Gus', 'Fring', '1122334455', 'pollos.hermanos@yahoo.com', '789 Oak Lane', '1968-1-1');

-- Insert data into the Restaurant table
INSERT INTO Restaurant (RestaurantName, Phone, Address)
VALUES 
('Pizza Paradise', '9876543210', '321 Main Street'),
('Burger Haven', '8765432109', '654 Second Avenue'),
('Sushi World', '7654321098', '987 Third Boulevard');

-- Insert data into the Menu table
INSERT INTO Menu (RestaurantID, ItemName, Price)
VALUES 
(1, 'Pepperoni Pizza', 12.99),
(1, 'Margherita Pizza', 10.99),
(2, 'Classic Burger', 8.99),
(2, 'Cheese Fries', 4.99),
(3, 'California Roll', 9.99),
(3, 'Tempura', 7.99);

-- Insert data into the Vehicle table
INSERT INTO Vehicle (LicensePlate, Make, Model, Year)
VALUES 
('ABC123', 'Toyota', 'Corolla', 2020),
('XYZ789', 'Honda', 'Civic', 2021),
('LMN456', 'Yamaha', 'R3', 2019);

-- Insert data into the Courier table
INSERT INTO Courier (FirstName, LastName, Phone, VehicleID)
VALUES 
('Sam', 'Brown', '5551234567', 1),
('Ella', 'Green', '5559876543', 2),
('Tom', 'White', '5555678910', 3);

-- Insert data into the Order table
INSERT INTO `Order` (CustomerID, CourierID, OrderDate)
VALUES 
(1, 1, '2024-11-25'),
(2, 2, '2024-11-26'),
(3, 3, '2024-11-27');

-- Insert data into the OrderDetails table
INSERT INTO OrderDetails (OrderID, ItemID, Quantity)
VALUES 
(1, 1, 2), -- 2 Pepperoni Pizzas
(1, 2, 1), -- 1 Margherita Pizza
(2, 3, 3), -- 3 Classic Burgers
(2, 4, 2), -- 2 Cheese Fries
(3, 5, 4); -- 4 California Rolls

-- Populate your database with a large data set representing a one-year transaction (01/01/2022 - 31/12/2022) on each table.
-- Load data from CSV to table Customer
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\Customer.csv'
INTO TABLE Customer
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CustomerID, FirstName, LastName, Phone, Email, Address, DateOfBirth);

-- Load data from CSV to Restaurant table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\Restaurant.csv'
INTO TABLE Restaurant
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(RestaurantName, Phone, Address);

-- Load data from CSV to Menu table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\Menu.csv'
INTO TABLE Menu
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(RestaurantID, ItemName, Price);

-- Load data from CSV to Vehicle table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\Vehicle.csv'
INTO TABLE Vehicle
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(VehicleID, LicensePlate, Make, Model, Year);

-- Load data from CSV to Courier table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.0/Uploads/Courier.csv'
INTO TABLE Courier
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CourierID, FirstName, LastName, Phone, VehicleID);

-- Load data from CSV to Order table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.0/Uploads/Order.csv'
INTO TABLE `Order`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID, CustomerID, CourierID, OrderDate);

-- Load data from CSV to OrderDetails table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.0/Uploads/OrderDetails.csv'
INTO TABLE OrderDetails
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID, ItemID, Quantity);

-- PART 3: Write SQL Statements to answer the following queries:
-- 1. Update a column in a table of your choice.
-- Increase the price of all the items by 1€.
UPDATE Menu
SET Price = Price + 1;

-- 2. Delete a column in a table of your choice.
ALTER TABLE Vehicle
DROP COLUMN Model;

-- 3. Show the total number of transactions your database is storing and, depending on your
-- database, the most sold/listed item or customer with the highest number of purchases.
-- Total number of transactions:
SELECT COUNT(*) AS TotalTransactions
FROM `Order`;

-- Customer with more orders:
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS NumberOfOrders
FROM `Order` o
JOIN Customer c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY NumberOfOrders DESC
LIMIT 1;

-- 4. Write a query statement that includes “Order by” and “Group by”.
-- Top 10 Costumers with more Total Amount Spent:
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(od.ItemTotal) AS TotalAmountSpent
FROM `Order` o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Customer c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalAmountSpent DESC
LIMIT 10;

-- 5. Write a query statement that uses pattern matching. 
-- Find all customers with the first name "Matias".
SELECT COUNT(*) AS NumberOfMatias
FROM Customer
WHERE FirstName LIKE 'Matias';

-- 6. Show information from three tables based on criteria of your choice.
-- Retrieve the top 10 orders by total spent in 2022, showing data from 4 tables (Customer, Order, OrderDetails, Menu).
SELECT 
    c.CustomerID,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    o.OrderID,
    o.OrderDate,
    SUM(od.ItemTotal) AS TotalSpent,
    SUM(od.Quantity) AS NumberOfProducts,
    GROUP_CONCAT(m.ItemName) AS ProductsPurchased
FROM 
    Customer c
JOIN 
    `Order` o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Menu m ON od.ItemID = m.ItemID
WHERE 
    YEAR(o.OrderDate) = 2022  
GROUP BY 
    c.CustomerID, o.OrderID
ORDER BY 
    TotalSpent DESC
LIMIT 10;

-- 7. Create a view that includes information from the most frequent seven transactions
-- View for Most Frequent Customers (Top 7 customers who placed the most orders)
CREATE VIEW MostFrequentCustomers AS
SELECT 
    c.FirstName, 
    c.LastName, 
    COUNT(o.OrderID) AS TotalOrders
FROM 
    Customer c
JOIN 
    `Order` o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID
ORDER BY 
    TotalOrders DESC
LIMIT 7;

SELECT * FROM MostFrequentCustomers;

-- View for Most Frequent Items.
CREATE VIEW MostFrequentItems AS
SELECT 
	m.ItemID,
    m.ItemName, 
    COUNT(od.ItemID) AS TotalSold
FROM 
    Menu m
JOIN 
    OrderDetails od ON m.ItemID = od.ItemID
GROUP BY 
    m.ItemID
ORDER BY 
    TotalSold DESC
LIMIT 7;

SELECT * FROM MostFrequentItems;

-- 8. Create a set of queries that summarises the annual transactions.
-- Total Number of Transactions per Month
SELECT 
    MONTH(OrderDate) AS Month,
    YEAR(OrderDate) AS Year,
    COUNT(OrderID) AS TotalTransactions
FROM `Order`
WHERE YEAR(OrderDate) = 2022
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year, Month;

-- Customer Purchase Value Per Month
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    MONTH(o.OrderDate) AS Month,
    YEAR(o.OrderDate) AS Year,
    SUM(od.ItemTotal) AS TotalPurchase
FROM `Order` o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY Year, Month, CustomerName;

-- Name of Product and Number Sold Each Month
SELECT 
	MONTH(o.OrderDate) AS Month,
    YEAR(o.OrderDate) AS Year,
	m.ItemID,
    m.ItemName,
    SUM(od.Quantity) AS TotalQuantitySold
FROM OrderDetails od
JOIN Menu m ON od.ItemID = m.ItemID
JOIN `Order` o ON od.OrderID = o.OrderID
GROUP BY m.ItemID, YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY Year, Month, TotalQuantitySold DESC;

