-- Name = kunjan
-- Topic: Correlated Subquery
-- Purpose:
-- Find employees whose salary is higher than
-- the average salary of their own department.

-- Create Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Insert employee data
INSERT INTO Employees VALUES
(101, 'Rahul', 'IT', 55000),
(102, 'Amit', 'IT', 68000),
(103, 'Neha', 'IT', 62000),
(104, 'Priya', 'HR', 45000),
(105, 'Karan', 'HR', 58000),
(106, 'Arjun', 'HR', 52000),
(107, 'Sneha', 'Finance', 75000),
(108, 'Riya', 'Finance', 70000);

-- Find employees earning more than
-- their department's average salary.
--
-- The inner query is correlated with the
-- current employee's department.

SELECT
    EmployeeName,
    Department,
    Salary
FROM Employees AS E
WHERE Salary > 
(
    SELECT AVG(E2.Salary)
    FROM Employees AS E2
    WHERE E2.Department = E.Department
)
ORDER BY Department, Salary DESC;

-- Display each employee together with
-- their department's average salary.
SELECT
    E.EmployeeName,
    E.Department,
    E.Salary,
    (
        SELECT AVG(E2.Salary)
        FROM Employees AS E2
        WHERE E2.Department = E.Department
    ) AS DepartmentAverage
FROM Employees AS E
ORDER BY Department, Salary DESC;