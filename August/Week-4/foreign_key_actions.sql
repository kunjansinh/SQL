-- Name = kunjan
-- Topic: FOREIGN KEY ACTIONS
-- Purpose:
-- Learn how a database automatically handles
-- related records when a parent record changes.
--
-- This is useful for designing reliable relational
-- databases where related data must remain consistent.

-- Create the parent table
CREATE TABLE Departments 
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Create the child table.
-- ON DELETE CASCADE means employees belonging
-- to a deleted department will also be deleted.
--
-- ON UPDATE CASCADE means changes to the parent
-- DepartmentID are automatically reflected here.
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    DepartmentID INT,

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert departments
INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

-- Insert employees
INSERT INTO Employees VALUES
(101, 'Rahul', 1),
(102, 'Priya', 2),
(103, 'Amit', 1),
(104, 'Sneha', 3);

-- Display the current data
SELECT *
FROM Departments;

SELECT *
FROM Employees;

-- Delete the IT department.
--
-- Because ON DELETE CASCADE is enabled,
-- employees belonging to department 1
-- will also be removed.
DELETE FROM Departments
WHERE DepartmentID = 1;

-- Verify the result.
SELECT *
FROM Departments;

SELECT *
FROM Employees;