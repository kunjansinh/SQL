-- Name = Kunjan
-- Topic: Customer Retention Analysis
-- Purpose:
-- Identify customers who made purchases in consecutive months.

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO orders VALUES
(101, 1, '2026-01-10', 120.00),
(102, 1, '2026-02-15', 180.00),
(103, 1, '2026-03-20', 150.00),
(104, 2, '2026-01-12', 90.00),
(105, 2, '2026-03-05', 200.00),
(106, 3, '2026-02-08', 250.00),
(107, 3, '2026-03-18', 100.00),
(108, 4, '2026-01-22', 75.00);

-- Find customers who purchased in consecutive calendar months.

WITH customer_months AS (
    SELECT DISTINCT
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS purchase_month
    FROM orders
),
monthly_activity AS (
    SELECT
        customer_id,
        purchase_month,
        LAG(purchase_month) OVER (
            PARTITION BY customer_id
            ORDER BY purchase_month
        ) AS previous_month
    FROM customer_months
)
SELECT
    customer_id,
    previous_month,
    purchase_month
FROM monthly_activity
WHERE previous_month IS NOT NULL
  AND STR_TO_DATE(
      CONCAT(purchase_month, '-01'), '%Y-%m-%d'
  ) = DATE_ADD(
      STR_TO_DATE(
          CONCAT(previous_month, '-01'), '%Y-%m-%d'
      ),
      INTERVAL 1 MONTH
  )
ORDER BY customer_id, purchase_month;
