-- ==========================================
-- Name = Kunjan
-- File = upsert_inventory.sql
-- Topic = UPSERT
-- ==========================================
-- Purpose:
-- Insert a new product into inventory.
-- If the product already exists, update its
-- stock and price instead of creating a duplicate.
--
-- This is useful in real applications when
-- importing inventory or synchronising product data.
-- ==========================================

-- Create inventory table
CREATE TABLE Inventory 
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);

-- Add initial products
INSERT INTO Inventory VALUES
(101, 'Laptop', 80000, 10),
(102, 'Mouse', 1500, 25),
(103, 'Keyboard', 3000, 15);

-- Display the initial inventory
SELECT *
FROM Inventory;

-- Add a new product.
-- ProductID 104 does not exist, so a new row
-- will be inserted.
INSERT INTO Inventory 
(
    ProductID,
    ProductName,
    Price,
    Stock
)
VALUES 
(
    104,
    'Monitor',
    25000,
    8
)
ON DUPLICATE KEY UPDATE
    Price = VALUES(Price),
    Stock = VALUES(Stock);

-- Update an existing product.
-- ProductID 102 already exists, so the existing
-- record will be updated instead of inserting
-- another Mouse record.
INSERT INTO Inventory 
(
    ProductID,
    ProductName,
    Price,
    Stock
)
VALUES 
(
    102,
    'Mouse',
    1400,
    40
)
ON DUPLICATE KEY UPDATE
    Price = VALUES(Price),
    Stock = VALUES(Stock);

-- Display the final inventory.
SELECT *
FROM Inventory
ORDER BY ProductID;