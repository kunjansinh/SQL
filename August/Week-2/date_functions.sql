-- Name = kunjan
-- Topic: Date Functions
-- Purpose:
-- Learn how to work with dates in practical
-- business and employee records.

-- Create an Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    JoinDate DATE,
    Salary DECIMAL(10,2)
);

-- Insert sample employee data
INSERT INTO Employees VALUES
(101, 'Rahul', '2024-01-15', 55000),
(102, 'Priya', '2023-06-20', 48000),
(103, 'Amit', '2025-03-10', 62000),
(104, 'Sneha', '2022-11-05', 70000),
(105, 'Karan', '2025-08-18', 45000);

-- Display all employees
SELECT *
FROM Employees;

-- Extract the year from each joining date
SELECT
    EmployeeName,
    JoinDate,
    YEAR(JoinDate) AS JoinYear
FROM Employees;

-- Extract the month from each joining date
SELECT
    EmployeeName,
    JoinDate,
    MONTH(JoinDate) AS JoinMonth
FROM Employees;

-- Find employees who joined during 2025
SELECT
    EmployeeName,
    JoinDate
FROM Employees
WHERE YEAR(JoinDate) = 2025;

-- Calculate how many days each employee
-- has worked since their joining date.
SELECT
    EmployeeName,
    JoinDate,
    DATEDIFF(CURDATE(), JoinDate) AS DaysWorked
FROM Employees;

-- Sort employees from newest to oldest
-- based on their joining date.
SELECT
    EmployeeName,
    JoinDate
FROM Employees
ORDER BY JoinDate DESC;