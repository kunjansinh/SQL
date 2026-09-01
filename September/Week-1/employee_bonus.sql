-- Name = Kunjan
-- Topic: Conditional Employee Bonus
-- Purpose:
-- Apply different salary bonuses based on
-- an employee's performance rating.

CREATE TABLE Employees 
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    PerformanceRating INT NOT NULL
);

-- Insert sample employees.
INSERT INTO Employees VALUES
(101, 'Rahul', 50000, 5),
(102, 'Priya', 45000, 3),
(103, 'Amit', 65000, 4),
(104, 'Sneha', 70000, 5),
(105, 'Karan', 52000, 2);

-- Display salaries before applying bonuses.
SELECT
    EmployeeID,
    EmployeeName,
    Salary,
    PerformanceRating
FROM Employees
ORDER BY EmployeeID;

-- Apply a bonus based on performance.
--
-- Rating 5  -> 10% bonus
-- Rating 4  -> 7% bonus
-- Rating 3  -> 5% bonus
-- Rating 2  -> 2% bonus
-- Other     -> no bonus
UPDATE Employees
SET Salary = Salary * CASE
    WHEN PerformanceRating = 5 THEN 1.10
    WHEN PerformanceRating = 4 THEN 1.07
    WHEN PerformanceRating = 3 THEN 1.05
    WHEN PerformanceRating = 2 THEN 1.02
    ELSE 1.00
END;

-- Display the updated salaries.
SELECT
    EmployeeID,
    EmployeeName,
    Salary,
    PerformanceRating
FROM Employees
ORDER BY Salary DESC;