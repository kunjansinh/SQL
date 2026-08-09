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
(102, 'Priya', 'HR', 45000),
(103, 'Amit', 'IT', 62000),
(104, 'Sneha', 'Finance', 70000),
(105, 'Karan', 'HR', 48000),
(106, 'Neha', 'IT', 59000),
(107, 'Riya', 'Finance', 65000);

-- Rank employees based on salary
-- without combining their rows like GROUP BY does
SELECT
    EmployeeName,
    Department,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- Rank employees separately within each department
SELECT
    EmployeeName,
    Department,
    Salary,
    RANK() OVER 
    (
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS DepartmentRank
FROM Employees;

-- Calculate the average salary for each department
-- while keeping every employee row
SELECT
    EmployeeName,
    Department,
    Salary,
    AVG(Salary) OVER 
    (
        PARTITION BY Department
    ) AS DepartmentAverage
FROM Employees;