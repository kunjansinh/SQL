-- Name = kunjan
-- Topic: LEAD() and LAG()
-- Purpose:
-- Compare sales with previous and next records.
-- This is useful for business dashboards,
-- financial analysis, and trend detection.

-- Create Sales table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    SaleDate DATE,
    Amount DECIMAL(10,2)
);

-- Insert sample sales data.
INSERT INTO Sales VALUES
(1, '2026-01-05', 5000),
(2, '2026-01-10', 6500),
(3, '2026-01-15', 5200),
(4, '2026-01-20', 8000),
(5, '2026-01-25', 7200),
(6, '2026-01-30', 9500);

-- Display the previous and next sale.
SELECT
    SaleDate,
    Amount,

    -- Get the previous sale amount.
    LAG(Amount) OVER (
        ORDER BY SaleDate
    ) AS PreviousSale,

    -- Get the next sale amount.
    LEAD(Amount) OVER (
        ORDER BY SaleDate
    ) AS NextSale

FROM Sales
ORDER BY SaleDate;

-- Calculate the change from the previous sale.
SELECT
    SaleDate,
    Amount,

    LAG(Amount) OVER (
        ORDER BY SaleDate
    ) AS PreviousSale,

    Amount - LAG(Amount) OVER (
        ORDER BY SaleDate
    ) AS ChangeFromPrevious

FROM Sales
ORDER BY SaleDate;

-- Calculate the percentage change from
-- the previous sale.
--
-- NULLIF() prevents division by zero.
SELECT
    SaleDate,
    Amount,

    LAG(Amount) OVER (
        ORDER BY SaleDate
    ) AS PreviousSale,

    ROUND(
        (
            Amount - LAG(Amount) OVER (
                ORDER BY SaleDate
            )
        ) * 100.0
        / NULLIF(
            LAG(Amount) OVER (
                ORDER BY SaleDate
            ),
            0
        ),
        2
    ) AS PercentageChange

FROM Sales
ORDER BY SaleDate;