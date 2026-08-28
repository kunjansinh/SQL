-- ==========================================
-- Name = Kunjan
-- Topic = CUSTOMER SALES ANALYSIS
-- ==========================================
-- Purpose:
-- Analyse how much each customer spends every month.
--
-- The report calculates:
-- 1. Monthly spending
-- 2. Previous month's spending
-- 3. Change from previous month
-- 4. Percentage change
-- 5. Customer ranking within each month
--
-- This combines several SQL concepts into
-- a realistic business analytics query.
-- ==========================================

-- Create Customers table
CREATE TABLE Customers 
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Create Orders table
CREATE TABLE Orders 
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderAmount DECIMAL(10,2),

    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

-- Insert customers
INSERT INTO Customers VALUES
(1, 'Rahul'),
(2, 'Priya'),
(3, 'Amit'),
(4, 'Sneha');

-- Insert orders
INSERT INTO Orders VALUES
(101, 1, '2026-01-05', 2500),
(102, 1, '2026-01-18', 3500),
(103, 2, '2026-01-10', 4200),
(104, 3, '2026-01-15', 1800),

(105, 1, '2026-02-05', 5000),
(106, 2, '2026-02-12', 3000),
(107, 2, '2026-02-20', 2500),
(108, 3, '2026-02-25', 4500),

(109, 1, '2026-03-04', 2000),
(110, 2, '2026-03-10', 6000),
(111, 3, '2026-03-15', 3200),
(112, 4, '2026-03-20', 7000);

-- ==========================================
-- Step 1:
-- Calculate total spending for each customer
-- in each month.
-- ==========================================

WITH MonthlyCustomerSales AS 
(
    SELECT
        C.CustomerID,
        C.CustomerName,

        DATE_FORMAT(
            O.OrderDate,
            '%Y-%m'
        ) AS SaleMonth,

        SUM(O.OrderAmount) AS MonthlySales

    FROM Customers AS C

    INNER JOIN Orders AS O
        ON C.CustomerID = O.CustomerID

    GROUP BY
        C.CustomerID,
        C.CustomerName,
        DATE_FORMAT(O.OrderDate, '%Y-%m')
),

-- ==========================================
-- Step 2:
-- Compare each customer's monthly sales
-- with their previous month's sales.
-- ==========================================

SalesComparison AS 
(
    SELECT
        CustomerID,
        CustomerName,
        SaleMonth,
        MonthlySales,

        LAG(MonthlySales) OVER (
            PARTITION BY CustomerID
            ORDER BY SaleMonth
        ) AS PreviousMonthSales

    FROM MonthlyCustomerSales
),

-- ==========================================
-- Step 3:
-- Rank customers within each month.
-- ==========================================

RankedSales AS 
(
    SELECT
        CustomerID,
        CustomerName,
        SaleMonth,
        MonthlySales,
        PreviousMonthSales,

        RANK() OVER 
        (
            PARTITION BY SaleMonth
            ORDER BY MonthlySales DESC
        ) AS MonthlyRank

    FROM SalesComparison
)

-- ==========================================
-- Step 4:
-- Generate the final business report.
-- ==========================================

SELECT
    CustomerName,
    SaleMonth,
    MonthlySales,
    PreviousMonthSales,

    -- Difference from previous month
    MonthlySales - PreviousMonthSales
        AS SalesChange,

    -- Percentage change from previous month
    ROUND
    (
        (
            (MonthlySales - PreviousMonthSales)
            * 100.0
        )
        / NULLIF(PreviousMonthSales, 0),
        2
    ) AS PercentageChange,

    MonthlyRank

FROM RankedSales
ORDER BY
    SaleMonth,
    MonthlyRank;