-- Name = kunjan

-- Create an employee table
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
(102, 'Priya', 'HR', 42000),
(103, 'Amit', 'IT', 68000),
(104, 'Sneha', 'Finance', 75000),
(105, 'Karan', 'HR', 48000),
(106, 'Neha', 'IT', 59000);

-- Classify employees according to their salary.
-- CASE allows us to create a new value based
-- on conditions in the data.
SELECT
    EmployeeName,
    Department,
    Salary,
    CASE
        WHEN Salary >= 70000 THEN 'High Salary'
        WHEN Salary >= 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS SalaryLevel
FROM Employees;

-- Calculate a potential bonus based on salary.
SELECT
    EmployeeName,
    Salary,
    CASE
        WHEN Salary >= 70000 THEN Salary * 0.10
        WHEN Salary >= 50000 THEN Salary * 0.05
        ELSE Salary * 0.02
    END AS Bonus
FROM Employees;

-- Categorise employees by department.
SELECT
    EmployeeName,
    Department,
    CASE
        WHEN Department = 'IT' THEN 'Technology'
        WHEN Department = 'HR' THEN 'Human Resources'
        WHEN Department = 'Finance' THEN 'Finance & Accounting'
        ELSE 'Other'
    END AS DepartmentCategory
FROM Employees;