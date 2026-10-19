-- Name = Kunjan
-- Topic: Customer Purchase Streaks
-- Purpose:
-- Identify consecutive purchase days for each customer
-- using window functions and gaps-and-islands logic.

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    purchase_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO purchases VALUES
(1, 101, '2026-10-01', 40.00),
(2, 101, '2026-10-02', 25.00),
(3, 101, '2026-10-03', 60.00),
(4, 101, '2026-10-06', 35.00),
(5, 101, '2026-10-07', 50.00),
(6, 102, '2026-10-01', 20.00),
(7, 102, '2026-10-03', 30.00),
(8, 102, '2026-10-04', 45.00),
(9, 102, '2026-10-05', 55.00),
(10, 103, '2026-10-08', 70.00);

-- Step 1: Keep one record per customer per purchase day.
WITH distinct_days AS (
    SELECT DISTINCT
        customer_id,
        purchase_date
    FROM purchases
),

-- Step 2: Number each customer's purchase days.
numbered_days AS (
    SELECT
        customer_id,
        purchase_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY purchase_date
        ) AS day_number
    FROM distinct_days
),

-- Step 3: Consecutive dates share the same grouping key.
streak_groups AS (
    SELECT
        customer_id,
        purchase_date,
        DATE_SUB(
            purchase_date,
            INTERVAL day_number DAY
        ) AS streak_group
    FROM numbered_days
),

-- Step 4: Calculate the length of each streak.
streak_lengths AS (
    SELECT
        customer_id,
        MIN(purchase_date) AS streak_start,
        MAX(purchase_date) AS streak_end,
        COUNT(*) AS streak_length
    FROM streak_groups
    GROUP BY
        customer_id,
        streak_group
)

-- Step 5: Return each customer's longest streak.
SELECT
    customer_id,
    streak_start,
    streak_end,
    streak_length
FROM (
    SELECT
        streak_lengths.*,
        DENSE_RANK() OVER (
            PARTITION BY customer_id
            ORDER BY streak_length DESC
        ) AS streak_rank
    FROM streak_lengths
) ranked_streaks
WHERE streak_rank = 1
ORDER BY customer_id;
