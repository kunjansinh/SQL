-- Name = Kunjan
-- Topic: Monthly Cohort Retention
-- Purpose:
-- Group customers by their first purchase month and
-- calculate how many return in subsequent months.

CREATE TABLE cohort_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO cohort_orders VALUES
(1, 101, '2026-01-05', 100.00),
(2, 101, '2026-02-10', 120.00),
(3, 101, '2026-03-15', 90.00),
(4, 102, '2026-01-12', 80.00),
(5, 102, '2026-03-18', 150.00),
(6, 103, '2026-02-03', 200.00),
(7, 103, '2026-03-22', 100.00),
(8, 104, '2026-02-20', 75.00),
(9, 105, '2026-03-08', 300.00);

-- Identify each customer's first purchase month.
WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(
            DATE_SUB(
                order_date,
                INTERVAL DAYOFMONTH(order_date) - 1 DAY
            )
        ) AS cohort_month
    FROM cohort_orders
    GROUP BY customer_id
),

-- Create one record per customer per active month.
customer_activity AS (
    SELECT DISTINCT
        customer_id,
        DATE_SUB(
            order_date,
            INTERVAL DAYOFMONTH(order_date) - 1 DAY
        ) AS activity_month
    FROM cohort_orders
),

-- Measure the month offset from each customer's cohort.
cohort_activity AS (
    SELECT
        fp.cohort_month,
        ca.activity_month,
        TIMESTAMPDIFF(
            MONTH,
            fp.cohort_month,
            ca.activity_month
        ) AS month_number,
        ca.customer_id
    FROM first_purchase fp
    INNER JOIN customer_activity ca
        ON fp.customer_id = ca.customer_id
),

-- Count customers active in each cohort month.
retention_counts AS (
    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT customer_id) AS active_customers
    FROM cohort_activity
    GROUP BY cohort_month, month_number
),

-- Calculate the original size of each cohort.
cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_size
    FROM first_purchase
    GROUP BY cohort_month
)

SELECT
    rc.cohort_month,
    rc.month_number,
    cs.cohort_size,
    rc.active_customers,
    ROUND(
        100.0 * rc.active_customers / cs.cohort_size,
        2
    ) AS retention_percentage
FROM retention_counts rc
INNER JOIN cohort_sizes cs
    ON rc.cohort_month = cs.cohort_month
ORDER BY rc.cohort_month, rc.month_number;
