-- Name = Kunjan
-- Topic: Sales Anomaly Detection
-- Purpose:
-- Compare daily sales with the previous three days'
-- average and flag unusually large deviations.

CREATE TABLE daily_sales (
    sale_date DATE PRIMARY KEY,
    total_sales DECIMAL(10, 2) NOT NULL
);

INSERT INTO daily_sales VALUES
('2026-09-01', 1000.00),
('2026-09-02', 1100.00),
('2026-09-03', 1050.00),
('2026-09-04', 1150.00),
('2026-09-05', 3200.00),
('2026-09-06', 1080.00),
('2026-09-07', 980.00),
('2026-09-08', 400.00),
('2026-09-09', 1020.00);

WITH sales_baseline AS (
    SELECT
        sale_date,
        total_sales,
        AVG(total_sales) OVER (
            ORDER BY sale_date
            ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
        ) AS previous_average
    FROM daily_sales
)
SELECT
    sale_date,
    total_sales,
    ROUND(previous_average, 2) AS previous_average,
    CASE
        WHEN previous_average IS NULL
            THEN 'INSUFFICIENT HISTORY'
        WHEN total_sales > previous_average * 1.5
            THEN 'UNUSUALLY HIGH'
        WHEN total_sales < previous_average * 0.5
            THEN 'UNUSUALLY LOW'
        ELSE 'NORMAL'
    END AS sales_status
FROM sales_baseline
ORDER BY sale_date;
