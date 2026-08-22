-- Name = kunjan
-- Topic: INDEXES
-- Purpose:
-- Learn how indexes can improve query performance.
-- Indexes are commonly used on columns that are
-- frequently searched, filtered, or joined.

-- Create an Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Email VARCHAR(100),
    Salary DECIMAL(10,2)
);

-- Insert sample employee data
INSERT INTO Employees VALUES
(101, 'Rahul', 'IT', 'rahul@example.com', 55000),
(102, 'Priya', 'HR', 'priya@example.com', 45000),
(103, 'Amit', 'IT', 'amit@example.com', 68000),
(104, 'Sneha', 'Finance', 'sneha@example.com', 75000),
(105, 'Karan', 'HR', 'karan@example.com', 52000),
(106, 'Neha', 'IT', 'neha@example.com', 62000);

-- Create an index on the Department column.
-- This can help queries that frequently search
-- employees by department.
CREATE INDEX idx_employee_department
ON Employees(Department);

-- Create an index on the Email column.
-- Email is commonly searched when finding a customer
-- or employee account.
CREATE INDEX idx_employee_email
ON Employees(Email);

-- Search for employees in the IT department.
SELECT
    EmployeeID,
    EmployeeName,
    Salary
FROM Employees
WHERE Department = 'IT';

-- Search for an employee by email.
SELECT
    EmployeeID,
    EmployeeName,
    Department
FROM Employees
WHERE Email = 'amit@example.com';

-- Display the indexes defined on the table.
SHOW INDEX FROM Employees;