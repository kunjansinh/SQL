-- Name = kunjan
-- Topic: TRIGGERS
-- Purpose:
-- Automatically record important changes made
-- to a database.
--
-- Practical example:
-- Whenever an employee's salary is changed,
-- store the old and new salary in an audit table.

-- Create Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Create an audit table
-- to store salary changes.
CREATE TABLE SalaryAudit 
(
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample employees
INSERT INTO Employees VALUES
(101, 'Rahul', 'IT', 55000),
(102, 'Priya', 'HR', 45000),
(103, 'Amit', 'IT', 68000);

-- Change the delimiter so MySQL can process
-- the trigger body correctly.
DELIMITER //

-- Create a trigger that runs automatically
-- before an employee's salary is updated.
CREATE TRIGGER BeforeSalaryUpdate
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN

    -- Record the old and new salary
    -- in the audit table.
    IF OLD.Salary <> NEW.Salary THEN

        INSERT INTO SalaryAudit 
        (
            EmployeeID,
            OldSalary,
            NewSalary
        )
        VALUES 
        (
            OLD.EmployeeID,
            OLD.Salary,
            NEW.Salary
        );

    END IF;

END //

DELIMITER ;

-- Update Rahul's salary.
-- The trigger automatically creates
-- an audit record.
UPDATE Employees
SET Salary = 60000
WHERE EmployeeID = 101;

-- Update Amit's salary.
UPDATE Employees
SET Salary = 72000
WHERE EmployeeID = 103;

-- Display current employee salaries.
SELECT *
FROM Employees;

-- Display the salary-change history.
SELECT
    AuditID,
    EmployeeID,
    OldSalary,
    NewSalary,
    ChangedAt
FROM SalaryAudit
ORDER BY ChangedAt;