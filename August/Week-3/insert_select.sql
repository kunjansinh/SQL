-- Name = kunjan
-- Topic: INSERT INTO SELECT
-- Purpose:
-- Copy selected records from one table into another.
-- This is useful for archiving, reporting, and
-- transferring filtered data.

-- Create the main Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert sample employees
INSERT INTO Employees VALUES
(101, 'Rahul', 'IT', 55000),
(102, 'Priya', 'HR', 45000),
(103, 'Amit', 'IT', 68000),
(104, 'Sneha', 'Finance', 75000),
(105, 'Karan', 'HR', 52000);

-- Create an archive table for high-salary employees
CREATE TABLE HighSalaryEmployees 
(
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Copy employees earning more than 60000
-- into the archive/reporting table.
INSERT INTO HighSalaryEmployees 
(
    EmployeeID,
    EmployeeName,
    Department,
    Salary
)
SELECT
    EmployeeID,
    EmployeeName,
    Department,
    Salary
FROM Employees
WHERE Salary > 60000;

-- Verify the copied records.
SELECT *
FROM HighSalaryEmployees
ORDER BY Salary DESC;