-- Name = kunjan
-- Topic: LAG()
-- Purpose:
-- Compare the current sale with the previous sale.
-- This is useful for analysing changes over time.

-- Create Sales table
CREATE TABLE Sales 
(
    SaleID INT PRIMARY KEY,
    SaleDate DATE,
    Product VARCHAR(50),
    Amount DECIMAL(10,2)
);

-- Insert sample sales data
INSERT INTO Sales VALUES
(1, '2026-01-05', 'Laptop', 80000),
(2, '2026-01-10', 'Mouse', 1500),
(3, '2026-01-15', 'Keyboard', 3000),
(4, '2026-02-03', 'Monitor', 25000),
(5, '2026-02-12', 'Laptop', 75000),
(6, '2026-02-20', 'Headphones', 5000),
(7, '2026-03-05', 'Keyboard', 3500);

-- Display each sale and the amount
-- from the previous sale.
SELECT
    SaleDate,
    Product,
    Amount,
    LAG(Amount) OVER 
    (
        ORDER BY SaleDate, SaleID
    ) AS PreviousSale
FROM Sales
ORDER BY SaleDate, SaleID;

-- Calculate the difference between
-- the current sale and previous sale.
SELECT
    SaleDate,
    Product,
    Amount,
    LAG(Amount) OVER 
    (
        ORDER BY SaleDate, SaleID
    ) AS PreviousSale,
    Amount - LAG(Amount) OVER 
    (
        ORDER BY SaleDate, SaleID
    ) AS DifferenceFromPrevious
FROM Sales
ORDER BY SaleDate, SaleID;