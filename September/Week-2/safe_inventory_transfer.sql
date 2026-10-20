-- Name = Kunjan
-- Topic: Safe Inventory Transfer
-- Purpose:
-- Demonstrate transactions, validation, and rollback
-- when transferring inventory between warehouses.

CREATE TABLE warehouse_inventory (
    warehouse_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (warehouse_id, product_id),
    CHECK (quantity >= 0)
);

INSERT INTO warehouse_inventory VALUES
(1, 501, 100),
(2, 501, 40);

-- Run the transaction statements together.
-- The application should validate that:
-- 1. Source and destination warehouses differ.
-- 2. Transfer quantity is positive.
-- 3. The source has sufficient stock.
-- 4. Both warehouse records exist.

START TRANSACTION;

-- Lock the source inventory record.
SELECT quantity
FROM warehouse_inventory
WHERE warehouse_id = 1
  AND product_id = 501
FOR UPDATE;

-- Reduce source stock only if sufficient inventory exists.
UPDATE warehouse_inventory
SET quantity = quantity - 20
WHERE warehouse_id = 1
  AND product_id = 501
  AND quantity >= 20;

-- Verify that exactly one source row was updated.
-- If not, the application must execute ROLLBACK.

-- Increase destination stock.
UPDATE warehouse_inventory
SET quantity = quantity + 20
WHERE warehouse_id = 2
  AND product_id = 501;

-- Verify that exactly one destination row was updated.
-- If either validation fails, execute ROLLBACK.
-- Otherwise, execute COMMIT.

COMMIT;
