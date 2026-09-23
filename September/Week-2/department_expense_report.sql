-- Name = Kunjan
-- Topic: Department Expense Report
-- Purpose:
-- Calculate total expenses for each department
-- and compare them with the department budget.

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Budget DECIMAL(10,2) NOT NULL
);

CREATE TABLE Expenses (
    ExpenseID INT PRIMARY KEY,
    DepartmentID INT NOT NULL,
    ExpenseName VARCHAR(100) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

-- Insert department data.
INSERT INTO Departments VALUES
(1, 'IT', 20000),
(2, 'HR', 12000),
(3, 'Finance', 15000),
(4, 'Marketing', 18000);

-- Insert expense data.
INSERT INTO Expenses VALUES
(101, 1, 'Cloud Services', 6500),
(102, 1, 'Software Licences', 4200),
(103, 1, 'Hardware', 3500),
(104, 2, 'Recruitment', 4000),
(105, 2, 'Training', 2500),
(106, 3, 'Accounting Software', 5000),
(107, 3, 'Audit Services', 3500),
(108, 4, 'Advertising', 7500),
(109, 4, 'Social Media', 4200);

-- Calculate total expenses for every department.
WITH DepartmentExpenses AS (
    SELECT
        D.DepartmentID,
        D.DepartmentName,
        D.Budget,

        -- Calculate total departmental expenses.
        COALESCE(
            SUM(E.Amount),
            0
        ) AS TotalExpenses

    FROM Departments AS D

    LEFT JOIN Expenses AS E
        ON D.DepartmentID = E.DepartmentID

    GROUP BY
        D.DepartmentID,
        D.DepartmentName,
        D.Budget
)

-- Compare expenses against the department budget.
SELECT
    DepartmentID,
    DepartmentName,
    Budget,
    TotalExpenses,

    -- Calculate the remaining budget.
    Budget - TotalExpenses AS RemainingBudget,

    -- Calculate percentage of budget used.
    ROUND(
        TotalExpenses * 100.0 / NULLIF(Budget, 0),
        2
    ) AS BudgetUsedPercent,

    -- Classify the department's spending.
    CASE
        WHEN TotalExpenses > Budget
            THEN 'Over Budget'

        WHEN TotalExpenses >= Budget * 0.80
            THEN 'Near Budget Limit'

        ELSE 'Within Budget'
    END AS BudgetStatus

FROM DepartmentExpenses

ORDER BY BudgetUsedPercent DESC;