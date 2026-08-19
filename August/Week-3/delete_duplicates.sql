-- Name = kunjan
-- Topic: Removing Duplicate Records
-- Purpose:
-- Identify duplicate customer records and
-- remove duplicates while keeping the record
-- with the smallest CustomerID.

-- Create Customers table
CREATE TABLE Customers 
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(100),
    City VARCHAR(50)
);

-- Insert sample data.
-- Rahul and Amit have duplicate email addresses.
INSERT INTO Customers VALUES
(1, 'Rahul Sharma', 'rahul@example.com', 'Delhi'),
(2, 'Priya Patel', 'priya@example.com', 'Mumbai'),
(3, 'Amit Bhati', 'amit@example.com', 'Pune'),
(4, 'Rahul S', 'rahul@example.com', 'Delhi'),
(5, 'Sneha Singh', 'sneha@example.com', 'Belfast'),
(6, 'Amit B', 'amit@example.com', 'Pune');

-- Check the data before deleting anything.
SELECT *
FROM Customers
ORDER BY Email, CustomerID;

-- Find duplicate email addresses.
SELECT
    Email,
    COUNT(*) AS DuplicateCount
FROM Customers
GROUP BY Email
HAVING COUNT(*) > 1;

-- Create a temporary result containing
-- the duplicate records that should be removed.
--
-- The record with the smallest CustomerID
-- is kept. Any later record with the same
-- email address is considered a duplicate.
WITH DuplicateRecords AS 
(
    SELECT
        CustomerID,
        Email,
        ROW_NUMBER() OVER 
        (
            PARTITION BY Email
            ORDER BY CustomerID
        ) AS RecordNumber
    FROM Customers
)

-- Display the records that would be deleted.
-- Always verify these records before running
-- the DELETE statement.
SELECT
    CustomerID,
    Email
FROM DuplicateRecords
WHERE RecordNumber > 1;

-- Remove duplicate records.
DELETE FROM Customers
WHERE CustomerID IN 
(
    SELECT CustomerID
    FROM 
    (
        SELECT
            CustomerID,
            ROW_NUMBER() OVER 
            (
                PARTITION BY Email
                ORDER BY CustomerID
            ) AS RecordNumber
        FROM Customers
    ) AS DuplicateRecords
    WHERE RecordNumber > 1
);

-- Verify the cleaned table.
SELECT *
FROM Customers
ORDER BY CustomerID;