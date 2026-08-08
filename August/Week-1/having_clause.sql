-- ==========================================
-- Name: Kunjan
-- File: having_clause.sql
-- Topic: HAVING Clause
-- Description:
-- Learn how to filter grouped data using
-- the HAVING clause.
-- ==========================================

-- Create Database
CREATE DATABASE SalesDB;

-- Select Database
USE SalesDB;

-- Create Orders Table
CREATE TABLE Orders 
(
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    OrderAmount DECIMAL(10,2)
);

-- Insert Sample Data
INSERT INTO Orders VALUES
(101, 'Rahul', 'Delhi', 1200),
(102, 'Priya', 'Mumbai', 2400),
(103, 'Rahul', 'Delhi', 1800),
(104, 'Amit', 'Pune', 900),
(105, 'Priya', 'Mumbai', 3200),
(106, 'Sneha', 'Delhi', 4100),
(107, 'Rahul', 'Delhi', 2600);

-- Display all records
SELECT * FROM Orders;

-- Total order amount for each customer
SELECT
    CustomerName,
    SUM(OrderAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerName;

-- Show customers whose total spending is greater than 3000
SELECT
    CustomerName,
    SUM(OrderAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerName
HAVING SUM(OrderAmount) > 3000;

-- Show cities with more than one order
SELECT
    City,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY City
HAVING COUNT(*) > 1;