-- Name = Kunjan
-- Topic: Product Restocking
-- Purpose:
-- Identify products below their reorder level
-- and increase their stock.
-- Practical use:
-- Inventory systems can use this logic to
-- automatically replenish low-stock products.

CREATE TABLE Products 
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    ReorderLevel INT NOT NULL
);

-- Insert sample product data.
INSERT INTO Products VALUES
(101, 'Basmati Rice', 18.50, 8, 20),
(102, 'Toor Dal', 7.50, 25, 15),
(103, 'Masala Powder', 4.25, 5, 10),
(104, 'Mango Pickle', 6.50, 12, 12),
(105, 'Coconut Oil', 12.00, 6, 15);

-- Restock products that are below
-- their reorder level.
--
-- Products with very low stock receive
-- a larger restock quantity.

UPDATE Products
SET Stock = Stock +
    CASE
        WHEN Stock <= 5 THEN 30
        WHEN Stock < ReorderLevel THEN 20
        ELSE 0
    END
WHERE Stock < ReorderLevel;

-- Display the updated inventory.
SELECT
    ProductID,
    ProductName,
    Price,
    Stock,
    ReorderLevel,

    -- Calculate the current inventory value.
    ROUND(Price * Stock, 2) AS InventoryValue,

    -- Show the current stock status.
    CASE
        WHEN Stock < ReorderLevel THEN 'Needs Restocking'
        ELSE 'Stock Sufficient'
    END AS StockStatus

FROM Products

ORDER BY Stock ASC;
