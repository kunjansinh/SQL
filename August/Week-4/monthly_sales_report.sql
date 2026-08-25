-- Name = kunjan
-- Topic: MONTHLY SALES REPORT
-- Purpose:
-- Build a practical sales report that calculates:
-- 1. Monthly sales
-- 2. Previous month's sales
-- 3. Change from the previous month
-- 4. Percentage change
-- 5. Running total
--
-- This combines several SQL concepts into
-- one realistic business-analysis query.

-- Create Sales table
CREATE TABLE Sales 
(
    SaleID INT PRIMARY KEY,
    SaleDate DATE,
    Amount DECIMAL(10,2)
);

-- Insert sample sales data
INSERT INTO Sales VALUES
(1, '2026-01-05', 5000),
(2, '2026-01-12', 7500),
(3, '2026-01-20', 6200),
(4, '2026-02-03', 8200),
(5, '2026-02-14', 9100),
(6, '2026-02-25', 7800),
(7, '2026-03-04', 10500),
(8, '2026-03-15', 11200),
(9, '2026-03-28', 9800),
(10, '2026-04-05', 12500),
(11, '2026-04-18', 11800),
(12, '2026-04-25', 13200);

-- Step 1:
-- Group individual sales into monthly totals.
WITH MonthlySales AS 
(
    SELECT
        DATE_FORMAT(SaleDate, '%Y-%m') AS SaleMonth,
        SUM(Amount) AS MonthlySales
    FROM Sales
    GROUP BY DATE_FORMAT(SaleDate, '%Y-%m')
),

-- Step 2:
-- Compare each month with the previous month.
SalesComparison AS 
(
    SELECT
        SaleMonth,
        MonthlySales,

        LAG(MonthlySales) OVER (
            ORDER BY SaleMonth
        ) AS PreviousMonthSales

    FROM MonthlySales
)

-- Step 3:
-- Produce the final business report.
SELECT
    SaleMonth,
    MonthlySales,
    PreviousMonthSales,

    -- Difference between this month
    -- and the previous month.
    MonthlySales - PreviousMonthSales
        AS SalesChange,

    -- Percentage change compared
    -- with the previous month.
    ROUND(
        (
            (MonthlySales - PreviousMonthSales)
            * 100.0
        )
        / NULLIF(PreviousMonthSales, 0),
        2
    ) AS PercentageChange,

    -- Running total of sales.
    SUM(MonthlySales) OVER 
    (
        ORDER BY SaleMonth
    ) AS RunningTotal

FROM SalesComparison
ORDER BY SaleMonth;