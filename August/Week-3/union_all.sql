-- Name = kunjan
-- Topic: UNION ALL
-- Purpose:
-- Combine sales from two different branches
-- and calculate the total sales by city.

-- Create first branch sales table
CREATE TABLE DelhiSales 
(
    SaleID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Amount DECIMAL(10,2)
);

-- Create second branch sales table
CREATE TABLE MumbaiSales 
(
    SaleID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Amount DECIMAL(10,2)
);

-- Insert Delhi sales
INSERT INTO DelhiSales VALUES
(1, 'Rahul', 2500),
(2, 'Amit', 4200),
(3, 'Sneha', 1800);

-- Insert Mumbai sales
INSERT INTO MumbaiSales VALUES
(4, 'Priya', 3200),
(5, 'Karan', 1500),
(6, 'Neha', 5000);

-- Combine sales from both branches.
-- UNION ALL keeps every record.
SELECT
    'Delhi' AS City,
    CustomerName,
    Amount
FROM DelhiSales

UNION ALL

SELECT
    'Mumbai' AS City,
    CustomerName,
    Amount
FROM MumbaiSales;

-- Calculate total sales for each city.
SELECT
    City,
    SUM(Amount) AS TotalSales
FROM 
(
    SELECT
        'Delhi' AS City,
        Amount
    FROM DelhiSales

    UNION ALL

    SELECT
        'Mumbai' AS City,
        Amount
    FROM MumbaiSales
) AS AllSales
GROUP BY City
ORDER BY TotalSales DESC;