-- Name = Kunjan
-- Topic: Customer Sales Ranking
-- Purpose:
-- Calculate customer spending, rank customers,
-- and determine each customer's contribution
-- to total company revenue.

CREATE TABLE Customers 
  (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(50)
);

CREATE TABLE Orders 
  (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderAmount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

-- Insert customers.
INSERT INTO Customers VALUES
(1, 'Rahul', 'Delhi'),
(2, 'Priya', 'Mumbai'),
(3, 'Amit', 'Pune'),
(4, 'Sneha', 'Belfast'),
(5, 'Karan', 'Delhi');

-- Insert orders.
INSERT INTO Orders VALUES
(101, 1, 2500),
(102, 1, 4200),
(103, 2, 1800),
(104, 2, 5200),
(105, 3, 7500),
(106, 3, 2500),
(107, 4, 3000),
(108, 5, 4800),
(109, 5, 3200);

-- Step 1:
-- Calculate total spending for every customer.
WITH CustomerTotals AS 
  (
    SELECT
        C.CustomerID,
        C.CustomerName,
        C.City,
        SUM(O.OrderAmount) AS TotalSpent
    FROM Customers AS C
    INNER JOIN Orders AS O
        ON C.CustomerID = O.CustomerID
    GROUP BY
        C.CustomerID,
        C.CustomerName,
        C.City
),

-- Step 2:
-- Rank customers by their total spending.
CustomerRanking AS 
  (
    SELECT
        CustomerID,
        CustomerName,
        City,
        TotalSpent,

        RANK() OVER 
        (
            ORDER BY TotalSpent DESC
        ) AS SpendingRank,

        -- Calculate the total company sales
        -- while keeping each customer's row.
        SUM(TotalSpent) OVER () AS CompanySales

    FROM CustomerTotals
)

-- Step 3:
-- Produce the final customer report.
SELECT
    CustomerName,
    City,
    TotalSpent,
    SpendingRank,

    -- Calculate the customer's percentage
    -- contribution to total company sales.
    ROUND
  (
        (TotalSpent * 100.0)
        / NULLIF(CompanySales, 0),
        2
    ) AS SalesContributionPercent

FROM CustomerRanking

ORDER BY SpendingRank;
