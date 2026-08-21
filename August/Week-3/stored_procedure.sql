-- Name = kunjan
-- Topic: STORED PROCEDURES
-- Purpose:
-- Create reusable database logic that accepts
-- a parameter and returns filtered employee data.

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
(106, 'Neha', 'IT', 62000);

-- Change the delimiter so MySQL can process
-- multiple statements inside the procedure.
DELIMITER //

-- Create a procedure that receives
-- a department name as a parameter.
CREATE PROCEDURE GetEmployeesByDepartment
(
    IN DepartmentName VARCHAR(50)
)
BEGIN

    -- Return employees belonging to
    -- the requested department.
    SELECT
        EmployeeID,
        EmployeeName,
        Department,
        Salary
    FROM Employees
    WHERE Department = DepartmentName
    ORDER BY Salary DESC;

END //

DELIMITER ;

-- Call the procedure for the IT department.
CALL GetEmployeesByDepartment('IT');

-- Call the procedure for the HR department.
CALL GetEmployeesByDepartment('HR');