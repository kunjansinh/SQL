-- Name = kunjan
-- Topic: Conditional Aggregation
-- Purpose:
-- Analyse business data using aggregate functions
-- together with CASE expressions.

-- Create an Orders table
CREATE TABLE Orders 
(
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Category VARCHAR(50),
    OrderAmount DECIMAL(10,2)
);

-- Insert sample order data
INSERT INTO Orders VALUES
(101, 'Rahul', 'Electronics', 2500),
(102, 'Priya', 'Clothing', 1800),
(103, 'Amit', 'Electronics', 4200),
(104, 'Sneha', 'Furniture', 3500),
(105, 'Karan', 'Clothing', 1200),
(106, 'Rahul', 'Furniture', 5000),
(107, 'Priya', 'Electronics', 3200),
(108, 'Amit', 'Clothing', 900);

-- Count the total number of orders
-- and count high-value orders separately.
SELECT
    COUNT(*) AS TotalOrders,
    SUM
    (
        CASE
            WHEN OrderAmount >= 3000 THEN 1
            ELSE 0
        END
    ) AS HighValueOrders
FROM Orders;

-- Calculate total sales and high-value sales.
SELECT
    SUM(OrderAmount) AS TotalSales,
    SUM
    (
        CASE
            WHEN OrderAmount >= 3000 THEN OrderAmount
            ELSE 0
        END
    ) AS HighValueSales
FROM Orders;

-- Analyse orders by category.
SELECT
    Category,
    COUNT(*) AS TotalOrders,
    SUM(OrderAmount) AS TotalSales,
    SUM
    (
        CASE
            WHEN OrderAmount >= 3000 THEN 1
            ELSE 0
        END
    ) AS HighValueOrders
FROM Orders
GROUP BY Category
ORDER BY TotalSales DESC;

-- Categorise each order by value.
SELECT
    OrderID,
    CustomerName,
    OrderAmount,
    CASE
        WHEN OrderAmount >= 4000 THEN 'Very High'
        WHEN OrderAmount >= 3000 THEN 'High'
        WHEN OrderAmount >= 1500 THEN 'Medium'
        ELSE 'Low'
    END AS OrderValue
FROM Orders;