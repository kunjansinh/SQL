-- Name = kunjan
-- Topic: DEPARTMENT PERFORMANCE REPORT
-- Purpose:
-- Build a practical report combining:
-- 1. Multiple tables
-- 2. JOIN
-- 3. GROUP BY
-- 4. Aggregation
-- 5. CTE
-- 6. Window functions
--
-- The goal is to identify department performance
-- and rank departments by average salary.

-- Create Departments table.
CREATE TABLE Departments 
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Create Employees table.
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2),

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

-- Insert departments.
INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert employees.
INSERT INTO Employees VALUES
(101, 'Rahul', 1, 55000),
(102, 'Amit', 1, 68000),
(103, 'Neha', 1, 62000),
(104, 'Priya', 2, 45000),
(105, 'Karan', 2, 52000),
(106, 'Arjun', 2, 58000),
(107, 'Sneha', 3, 75000),
(108, 'Riya', 3, 70000),
(109, 'Vikram', 4, 48000);

-- Step 1:
-- Calculate employee count and average salary
-- for each department.
WITH DepartmentStats AS 
(
    SELECT
        D.DepartmentID,
        D.DepartmentName,
        COUNT(E.EmployeeID) AS EmployeeCount,
        AVG(E.Salary) AS AverageSalary,
        MAX(E.Salary) AS HighestSalary,
        MIN(E.Salary) AS LowestSalary
    FROM Departments AS D
    LEFT JOIN Employees AS E
        ON D.DepartmentID = E.DepartmentID
    GROUP BY
        D.DepartmentID,
        D.DepartmentName
),

-- Step 2:
-- Rank departments according to their
-- average employee salary.
RankedDepartments AS 
(
    SELECT
        DepartmentID,
        DepartmentName,
        EmployeeCount,
        AverageSalary,
        HighestSalary,
        LowestSalary,

        RANK() OVER 
        (
            ORDER BY AverageSalary DESC
        ) AS SalaryRank

    FROM DepartmentStats
)

-- Step 3:
-- Produce the final department report.
SELECT
    DepartmentName,
    EmployeeCount,
    ROUND(AverageSalary, 2) AS AverageSalary,
    HighestSalary,
    LowestSalary,
    SalaryRank
FROM RankedDepartments
ORDER BY SalaryRank;