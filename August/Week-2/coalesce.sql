-- Name = kunjan
-- Topic: COALESCE
-- Purpose:
-- Replace NULL values with a useful default value.
-- This is common when working with incomplete or missing data.

-- Create an Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Phone VARCHAR(20),
    Bonus DECIMAL(10,2)
);

-- Insert sample employee data.
-- Some employees have missing phone numbers
-- or have not received a bonus.
INSERT INTO Employees VALUES
(101, 'Rahul', 'IT', '9876543210', 5000),
(102, 'Priya', 'HR', NULL, 3000),
(103, 'Amit', 'IT', '9123456780', NULL),
(104, 'Sneha', 'Finance', NULL, 7000),
(105, 'Karan', 'HR', '9988776655', NULL);

-- Display all employees.
SELECT *
FROM Employees;

-- Replace missing phone numbers with
-- 'Not Provided'.
SELECT
    EmployeeName,
    COALESCE(Phone, 'Not Provided') AS Phone
FROM Employees;

-- Replace a missing bonus with 0.
SELECT
    EmployeeName,
    Bonus,
    COALESCE(Bonus, 0) AS ActualBonus
FROM Employees;

-- Calculate total compensation.
-- If Bonus is NULL, treat it as 0.
SELECT
    EmployeeName,
    COALESCE(Bonus, 0) AS Bonus,
    50000 + COALESCE(Bonus, 0) AS TotalCompensation
FROM Employees;