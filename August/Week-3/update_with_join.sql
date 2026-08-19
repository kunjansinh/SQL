-- Name = kunjan
-- Topic: UPDATE with JOIN
-- Purpose:
-- Update records using information from
-- another related table.

-- Create Departments table
CREATE TABLE Departments 
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    BonusRate DECIMAL(5,2)
);

-- Create Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

-- Insert department data
INSERT INTO Departments VALUES
(1, 'IT', 10.00),
(2, 'HR', 5.00),
(3, 'Finance', 8.00);

-- Insert employee data
INSERT INTO Employees VALUES
(101, 'Rahul', 1, 55000),
(102, 'Priya', 2, 45000),
(103, 'Amit', 1, 68000),
(104, 'Sneha', 3, 70000),
(105, 'Karan', 2, 52000);

-- Display employees before the update
SELECT *
FROM Employees;

-- Update each employee's salary by applying
-- the bonus rate belonging to their department.
UPDATE Employees AS E
JOIN Departments AS D
    ON E.DepartmentID = D.DepartmentID
SET E.Salary = E.Salary + (E.Salary * D.BonusRate / 100);

-- Display employees after the update
SELECT
    E.EmployeeID,
    E.EmployeeName,
    D.DepartmentName,
    D.BonusRate,
    E.Salary
FROM Employees AS E
JOIN Departments AS D
    ON E.DepartmentID = D.DepartmentID
ORDER BY E.EmployeeID;