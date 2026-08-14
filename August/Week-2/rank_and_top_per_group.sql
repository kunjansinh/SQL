-- Name = kunjan
-- Topic: RANKING WITHIN GROUPS
-- Purpose:
-- Find the highest-paid employees in each department.
-- This combines CTEs, window functions, PARTITION BY,
-- and filtering.

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
(106, 'Neha', 'IT', 62000),
(107, 'Riya', 'Finance', 70000),
(108, 'Arjun', 'HR', 58000);

-- Rank employees within each department.
-- PARTITION BY creates a separate ranking
-- for every department.
WITH RankedEmployees AS 
(
    SELECT
        EmployeeID,
        EmployeeName,
        Department,
        Salary,
        RANK() OVER 
        (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS DepartmentRank
    FROM Employees
)

-- Display the top two highest-paid employees
-- from each department.
SELECT
    EmployeeID,
    EmployeeName,
    Department,
    Salary,
    DepartmentRank
FROM RankedEmployees
WHERE DepartmentRank <= 2
ORDER BY Department, DepartmentRank;