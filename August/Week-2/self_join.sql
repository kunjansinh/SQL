-- Name = kunjan
-- Topic: SELF JOIN
-- Purpose:
-- Compare records within the same table.
-- Practical example: finding each employee's manager.

-- Create Employees table
CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    JobTitle VARCHAR(50),
    ManagerID INT,
    Salary DECIMAL(10,2)
);

-- Insert employee data.
-- ManagerID refers to another EmployeeID
-- in the same table.
INSERT INTO Employees VALUES
(101, 'Rahul', 'Manager', NULL, 75000),
(102, 'Priya', 'Developer', 101, 55000),
(103, 'Amit', 'Developer', 101, 60000),
(104, 'Sneha', 'HR Manager', NULL, 70000),
(105, 'Karan', 'HR Assistant', 104, 45000),
(106, 'Neha', 'Developer', 101, 58000);

-- Display each employee together with their manager.
-- The Employees table is joined to itself.
SELECT
    Employee.EmployeeName AS Employee,
    Employee.JobTitle,
    Manager.EmployeeName AS Manager,
    Manager.JobTitle AS ManagerJobTitle
FROM Employees AS Employee
LEFT JOIN Employees AS Manager
    ON Employee.ManagerID = Manager.EmployeeID
ORDER BY Manager.EmployeeName, Employee.EmployeeName;

-- Find employees who earn less than their manager.
SELECT
    Employee.EmployeeName AS Employee,
    Employee.Salary AS EmployeeSalary,
    Manager.EmployeeName AS Manager,
    Manager.Salary AS ManagerSalary
FROM Employees AS Employee
INNER JOIN Employees AS Manager
    ON Employee.ManagerID = Manager.EmployeeID
WHERE Employee.Salary < Manager.Salary;