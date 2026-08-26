-- Name = kunjan
-- Topic: SQL CONSTRAINTS
-- Purpose:
-- Learn how constraints protect data integrity.
-- This example uses a practical product inventory.

-- Create Products table with multiple constraints.
CREATE TABLE Products 
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Stock INT DEFAULT 0 CHECK (Stock >= 0),
    SKU VARCHAR(30) UNIQUE
);

-- Insert valid products.
INSERT INTO Products
    (ProductID, ProductName, Category, Price, Stock, SKU)
VALUES
    (101, 'Laptop', 'Electronics', 80000, 10, 'LAP-001'),
    (102, 'Mouse', 'Electronics', 1500, 25, 'MOU-001'),
    (103, 'Keyboard', 'Electronics', 3000, 15, 'KEY-001'),
    (104, 'Notebook', 'Stationery', 120, 50, 'NOT-001');

-- Display all products.
SELECT *
FROM Products;

-- Try the following statements one at a time
-- to understand how constraints protect the data.

-- Price cannot be zero or negative.
-- INSERT INTO Products
-- VALUES (105, 'Monitor', 'Electronics', -500, 5, 'MON-001');

-- Stock cannot be negative.
-- INSERT INTO Products
-- VALUES (106, 'USB Cable', 'Electronics', 500, -2, 'USB-001');

-- SKU must be unique.
-- INSERT INTO Products
-- VALUES (107, 'Another Mouse', 'Electronics', 1200, 5, 'MOU-001');

-- ProductName cannot be NULL.
-- INSERT INTO Products
-- VALUES (108, NULL, 'Electronics', 2000, 5, 'PRD-001');