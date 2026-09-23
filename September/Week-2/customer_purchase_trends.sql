-- Name = Kunjan
-- Topic: Customer Purchase Trends
-- Purpose:
-- Analyse customer spending over time.
--
-- The report calculates:
-- 1. Monthly spending
-- 2. Previous month's spending
-- 3. Spending change
-- 4. Spending growth percentage
-- 5. Monthly customer ranking
-- 6. Customer lifetime spending

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderAmount DECIMAL(10,2) NOT NULL
);

-- Insert sample order data.
INSERT INTO Orders VALUES
(101, 1, '2026-06-05', 2500),
(102, 1, '2026-06-15', 3500),
(103, 1, '2026-07-10', 4500),
(104, 1, '2026-08-05', 5200),

(105, 2, '2026-06-08', 1800),
(106, 2, '2026-07-12', 2800),
(107, 2, '2026-08-15', 3500),

(108, 3, '2026-06-10', 5000),
(109, 3, '2026-07-20', 6200),
(110, 3, '2026-08-18', 7500),

(111, 4, '2026-07-05', 2200),
(112, 4, '2026-08-20', 8500);

-- ==========================================
-- Step 1:
-- Calculate monthly spending for each customer.
-- ==========================================

WITH MonthlyCustomerSales AS (
    SELECT
        CustomerID,

        DATE_FORMAT(
            OrderDate,
            '%Y-%m'
        ) AS SaleMonth,

        SUM(OrderAmount) AS MonthlySpending

    FROM Orders

    GROUP BY
        CustomerID,
        DATE_FORMAT(
            OrderDate,
            '%Y-%m'
        )
),

-- ==========================================
-- Step 2:
-- Compare each customer's spending with
-- their previous active month.
-- ==========================================

CustomerTrends AS (
    SELECT
        CustomerID,
        SaleMonth,
        MonthlySpending,

        LAG(MonthlySpending) OVER (
            PARTITION BY CustomerID
            ORDER BY SaleMonth
        ) AS PreviousMonthSpending

    FROM MonthlyCustomerSales
),

-- ==========================================
-- Step 3:
-- Calculate lifetime spending and rank
-- customers within each month.
-- ==========================================

CustomerAnalysis AS (
    SELECT
        CustomerID,
        SaleMonth,
        MonthlySpending,
        PreviousMonthSpending,

        -- Total spending across all recorded months.
        SUM(MonthlySpending) OVER (
            PARTITION BY CustomerID
        ) AS LifetimeSpending,

        -- Rank customers within each month.
        RANK() OVER (
            PARTITION BY SaleMonth
            ORDER BY MonthlySpending DESC
        ) AS MonthlyRank

    FROM CustomerTrends
)

-- ==========================================
-- Step 4:
-- Generate the final customer report.
-- ==========================================

SELECT
    CustomerID,
    SaleMonth,
    MonthlySpending,
    PreviousMonthSpending,

    -- Calculate the spending difference.
    MonthlySpending - PreviousMonthSpending
        AS SpendingChange,

    -- Calculate percentage growth.
    ROUND(
        (
            MonthlySpending - PreviousMonthSpending
        ) * 100.0
        / NULLIF(
            PreviousMonthSpending,
            0
        ),
        2
    ) AS GrowthPercent,

    LifetimeSpending,
    MonthlyRank,

    -- Classify the spending trend.
    CASE
        WHEN PreviousMonthSpending IS NULL
            THEN 'First Active Month'

        WHEN MonthlySpending > PreviousMonthSpending
            THEN 'Increasing'

        WHEN MonthlySpending < PreviousMonthSpending
            THEN 'Decreasing'

        ELSE 'No Change'
    END AS SpendingTrend

FROM CustomerAnalysis

ORDER BY
    SaleMonth,
    MonthlyRank;