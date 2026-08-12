-- Name = kunjan
-- Topic: String Functions
-- Purpose:
-- Clean and transform text stored in a database.

-- Create a Customers table
CREATE TABLE Customers 
(
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50)
);

-- Insert sample customer data
INSERT INTO Customers VALUES
(1, 'rahul', 'sharma', 'delhi'),
(2, 'PRIYA', 'patel', 'mumbai'),
(3, 'Amit', 'bhati', 'belfast'),
(4, 'sneha', 'singh', 'pune'),
(5, 'KARAN', 'mehta', 'ahmedabad');

-- Display customer names in uppercase.
SELECT
    CustomerID,
    UPPER(FirstName) AS FirstName,
    UPPER(LastName) AS LastName
FROM Customers;

-- Display customer names in lowercase.
SELECT
    CustomerID,
    LOWER(FirstName) AS FirstName,
    LOWER(LastName) AS LastName
FROM Customers;

-- Combine first and last names into
-- a single FullName column.
SELECT
    CustomerID,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;

-- Create a customer email address.
-- LOWER() makes the email consistent.
SELECT
    CustomerID,
    CONCAT
    (
        LOWER(FirstName),
        '.',
        LOWER(LastName),
        '@example.com'
    ) AS Email
FROM Customers;

-- Display the first three characters
-- of each customer's city.
SELECT
    CustomerID,
    City,
    LEFT(City, 3) AS CityCode
FROM Customers;