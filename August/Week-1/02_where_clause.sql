/*
-------------------------------------------------
Name    : Kunjan
Language: SQL
Purpose : Filter records using the WHERE clause
-------------------------------------------------
*/

-- =====================================================
-- Problem Statement:
-- Create an Employee table, insert sample records,
-- and display employees whose salary is greater
-- than 50000.
-- =====================================================

-- Create the Employee table
CREATE TABLE Employee 
(
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(30),
    Salary DECIMAL(10,2)
);

-- Insert sample records into the Employee table
INSERT INTO Employee (EmployeeID, Name, Department, Salary)
VALUES
(1, 'John', 'HR', 45000),
(2, 'Alice', 'IT', 62000),
(3, 'David', 'Finance', 55000),
(4, 'Emma', 'Marketing', 48000),
(5, 'Chris', 'IT', 70000);

-- Display employees whose salary is greater than 50000
SELECT *
FROM Employee
WHERE Salary > 50000;

-- End of Program