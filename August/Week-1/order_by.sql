/*
-------------------------------------------------
Name     : Kunjan
Language : SQL
Purpose  : Sort records using ORDER BY
-------------------------------------------------
*/

-- =====================================================
-- Problem Statement:
-- Create a Product table and display products
-- in ascending order of price.
-- =====================================================

-- Create the Product table
CREATE TABLE Product 
(
    ProductID INT,
    ProductName VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(10,2)
);

-- Insert sample records
INSERT INTO Product (ProductID, ProductName, Category, Price)
VALUES
(101, 'Laptop', 'Electronics', 65000),
(102, 'Keyboard', 'Electronics', 1200),
(103, 'Chair', 'Furniture', 3500),
(104, 'Mouse', 'Electronics', 800),
(105, 'Table', 'Furniture', 7000);

-- Display products sorted by price (lowest to highest)
SELECT *
FROM Product
ORDER BY Price ASC;

-- End of Program