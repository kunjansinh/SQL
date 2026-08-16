-- Name = kunjan
-- Topic: Finding Duplicate Records
-- Purpose:
-- Identify duplicate customer records using
-- GROUP BY and HAVING.

-- Create Customers table
CREATE TABLE Customers 
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100),
    City VARCHAR(50)
);

-- Insert sample customer data.
-- Some email addresses are intentionally duplicated.
INSERT INTO Customers VALUES
(1, 'Rahul Sharma', 'rahul@example.com', 'Delhi'),
(2, 'Priya Patel', 'priya@example.com', 'Mumbai'),
(3, 'Amit Bhati', 'amit@example.com', 'Pune'),
(4, 'Rahul S', 'rahul@example.com', 'Delhi'),
(5, 'Sneha Singh', 'sneha@example.com', 'Belfast'),
(6, 'Amit B', 'amit@example.com', 'Pune');

-- Display all customers.
SELECT *
FROM Customers;

-- Find email addresses that appear more than once.
SELECT
    Email,
    COUNT(*) AS NumberOfRecords
FROM Customers
GROUP BY Email
HAVING COUNT(*) > 1;

-- Display the complete records that have
-- duplicate email addresses.
SELECT *
FROM Customers
WHERE Email IN 
(
    SELECT Email
    FROM Customers
    GROUP BY Email
    HAVING COUNT(*) > 1
)
ORDER BY Email, CustomerID;