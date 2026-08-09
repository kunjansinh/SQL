-- Name = kunjan

-- Create a table containing customer orders
CREATE TABLE Orders 
(
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    OrderAmount DECIMAL(10,2)
);

-- Insert sample order data
INSERT INTO Orders VALUES
(101, 'Rahul', 'Delhi', 1200),
(102, 'Priya', 'Mumbai', 2500),
(103, 'Rahul', 'Delhi', 1800),
(104, 'Amit', 'Pune', 900),
(105, 'Priya', 'Mumbai', 3200),
(106, 'Sneha', 'Delhi', 4100),
(107, 'Rahul', 'Delhi', 2600);

-- Calculate total spending for each customer
-- using a Common Table Expression (CTE)
WITH CustomerTotals AS 
(
    SELECT
        CustomerName,
        SUM(OrderAmount) AS TotalSpent
    FROM Orders
    GROUP BY CustomerName
)

-- Display customers who spent more than 4000
SELECT
    CustomerName,
    TotalSpent
FROM CustomerTotals
WHERE TotalSpent > 4000
ORDER BY TotalSpent DESC;