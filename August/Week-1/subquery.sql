-- Name : kunjan

-- Create a table containing employee information
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
(106, 'Neha', 'IT', 59000);

-- Find the average salary of all employees
SELECT AVG(Salary) AS AverageSalary
FROM Employees;

-- Find employees earning more than the average salary
SELECT
    EmployeeName,
    Department,
    Salary
FROM Employees
WHERE Salary > 
(
    SELECT AVG(Salary)
    FROM Employees
);

-- Find the employee with the highest salary
SELECT
    EmployeeName,
    Department,
    Salary
FROM Employees
WHERE Salary = 
(
    SELECT MAX(Salary)
    FROM Employees
);

-- Find employees earning more than the highest HR salary
SELECT
    EmployeeName,
    Department,
    Salary
FROM Employees
WHERE Salary > 
(
    SELECT MAX(Salary)
    FROM Employees
    WHERE Department = 'HR'
);