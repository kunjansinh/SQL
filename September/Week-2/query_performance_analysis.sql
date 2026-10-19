-- Name = Kunjan
-- Topic: Query Performance Analysis
-- Purpose:
-- Practise EXPLAIN, composite indexes, and
-- query optimisation using customer orders.

CREATE TABLE sales_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO sales_orders VALUES
(1, 101, '2026-10-01', 'COMPLETED', 150.00),
(2, 102, '2026-10-02', 'PENDING', 80.00),
(3, 101, '2026-10-04', 'COMPLETED', 220.00),
(4, 103, '2026-10-05', 'CANCELLED', 60.00),
(5, 104, '2026-10-08', 'COMPLETED', 310.00),
(6, 102, '2026-10-10', 'COMPLETED', 125.00),
(7, 101, '2026-10-12', 'PENDING', 95.00),
(8, 105, '2026-10-14', 'COMPLETED', 400.00);

-- Step 1: Inspect the execution plan before adding an index.
EXPLAIN
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM sales_orders
WHERE customer_id = 101
  AND status = 'COMPLETED'
ORDER BY order_date DESC;

-- Step 2: Create a composite index matching
-- the filtering and sorting requirements.
CREATE INDEX idx_orders_customer_status_date
ON sales_orders (
    customer_id,
    status,
    order_date
);

-- Step 3: Inspect the execution plan again.
EXPLAIN
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM sales_orders
WHERE customer_id = 101
  AND status = 'COMPLETED'
ORDER BY order_date DESC;

-- Step 4: Use EXPLAIN ANALYZE to inspect actual
-- execution behaviour on supported MySQL versions.
EXPLAIN ANALYZE
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM sales_orders
WHERE customer_id = 101
  AND status = 'COMPLETED'
ORDER BY order_date DESC;
