-- Name : kunjan

-- Create tables for a simple company database
CREATE TABLE Departments 
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

-- Insert department data
INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert employee data
INSERT INTO Employees VALUES
(101, 'Rahul', 1, 55000),
(102, 'Priya', 2, 45000),
(103, 'Amit', 1, 62000),
(104, 'Sneha', 3, 70000),
(105, 'Karan', 2, 48000),
(106, 'Neha', 4, 52000);

-- Display employees with their department names
SELECT
    Employees.EmployeeID,
    Employees.EmployeeName,
    Departments.DepartmentName,
    Employees.Salary
FROM Employees
INNER JOIN Departments
    ON Employees.DepartmentID = Departments.DepartmentID;

-- Find employees working in the IT department
SELECT
    Employees.EmployeeName,
    Departments.DepartmentName,
    Employees.Salary
FROM Employees
INNER JOIN Departments
    ON Employees.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'IT';

-- Display employees earning more than 50000
SELECT
    Employees.EmployeeName,
    Departments.DepartmentName,
    Employees.Salary
FROM Employees
INNER JOIN Departments
    ON Employees.DepartmentID = Departments.DepartmentID
WHERE Employees.Salary > 50000;