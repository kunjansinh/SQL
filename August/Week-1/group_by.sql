-- ==========================================
-- Name: Kunjan
-- File: group_by.sql
-- Topic: GROUP BY Clause
-- Description:
-- Learn how to group records and use
-- aggregate functions like COUNT() and AVG().
-- ==========================================

-- Create Database
CREATE DATABASE CompanyDB;

-- Select Database
USE CompanyDB;

-- Create Employees Table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert Sample Data
INSERT INTO Employees VALUES
(1, 'Rahul', 'IT', 55000),
(2, 'Priya', 'HR', 45000),
(3, 'Amit', 'IT', 62000),
(4, 'Sneha', 'Finance', 70000),
(5, 'Karan', 'HR', 48000),
(6, 'Neha', 'IT', 59000);

-- Display all records
SELECT * FROM Employees;

-- Count employees in each department
SELECT
    Department,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department;

-- Calculate average salary for each department
SELECT
    Department,
    AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department;