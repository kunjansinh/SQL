-- Name = kunjan
-- Topic: FOREIGN KEYS
-- Purpose:
-- Learn how to connect related tables while
-- preventing invalid references.

-- Create the Departments table first because
-- Employees will reference it.
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Create the Employees table.
-- DepartmentID is a foreign key that references
-- DepartmentID in the Departments table.
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2),

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

-- Insert valid departments.
INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

-- Insert employees using valid DepartmentIDs.
INSERT INTO Employees VALUES
(101, 'Rahul', 1, 55000),
(102, 'Priya', 2, 45000),
(103, 'Amit', 1, 68000),
(104, 'Sneha', 3, 75000);

-- Display employees with their departments.
SELECT
    E.EmployeeID,
    E.EmployeeName,
    D.DepartmentName,
    E.Salary
FROM Employees AS E
INNER JOIN Departments AS D
    ON E.DepartmentID = D.DepartmentID;

-- The following statement should fail because
-- DepartmentID 99 does not exist in Departments.
-- Uncomment it to test the foreign-key constraint.

-- INSERT INTO Employees VALUES
-- (105, 'Karan', 99, 52000);