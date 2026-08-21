-- Name = kunjan
-- Topic: VIEWS
-- Purpose:
-- Create a reusable virtual table for frequently
-- used queries. Views are commonly used in
-- reporting and application databases.

-- Create Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert sample employee data
INSERT INTO Employees VALUES
(101, 'Rahul', 'IT', 55000),
(102, 'Priya', 'HR', 45000),
(103, 'Amit', 'IT', 68000),
(104, 'Sneha', 'Finance', 75000),
(105, 'Karan', 'HR', 52000),
(106, 'Neha', 'IT', 62000);

-- Create a view containing employees
-- earning more than 60000.
CREATE VIEW HighSalaryEmployees AS
SELECT
    EmployeeID,
    EmployeeName,
    Department,
    Salary
FROM Employees
WHERE Salary > 60000;

-- Query the view like a normal table.
SELECT *
FROM HighSalaryEmployees
ORDER BY Salary DESC;

-- Use the view to calculate the average
-- salary of high-earning employees.
SELECT
    AVG(Salary) AS AverageHighSalary
FROM HighSalaryEmployees;