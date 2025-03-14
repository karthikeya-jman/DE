
  
    

        create or replace transient table FITNESS_TRACKER.mart.kpi1
         as
        (WITH revenue_data AS (
    SELECT
        customer_id,
        payment_month,
        revenue
    FROM
      FITNESS_TRACKER.staging.stg_transactions
    WHERE
        revenue_type = 1
),
monthly_revenue AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', payment_month) AS month,
        SUM(revenue) AS total_revenue
    FROM
        revenue_data
    GROUP BY
        customer_id, month
),
all_months AS (
    SELECT
        DISTINCT DATE_TRUNC('month', payment_month) AS month
    FROM
FITNESS_TRACKER.staging.stg_transactions

),
customer_months AS (
    SELECT
        customer_id,
        month
    FROM
        monthly_revenue
    UNION
    SELECT
        customer_id,
        month
    FROM
        (SELECT DISTINCT customer_id FROM FITNESS_TRACKER.staging.stg_transactions) AS customers
    CROSS JOIN
        all_months
),
filled_revenue AS (
    SELECT
        cm.customer_id,
        cm.month,
        COALESCE(mr.total_revenue, 0) AS total_revenue
    FROM
        customer_months cm
    LEFT JOIN
        monthly_revenue mr
    ON
        cm.customer_id = mr.customer_id AND cm.month = mr.month
),
cde AS (
    SELECT
        *,
        EXTRACT(YEAR FROM month) AS year,
        EXTRACT(MONTH FROM month) AS only_month,
        LAG(total_revenue) OVER (PARTITION BY customer_id ORDER BY month) AS prev_month_revenue
    FROM
        filled_revenue
)
SELECT
    year,
    only_month,
    COUNT(CASE WHEN total_revenue > 0 AND (prev_month_revenue = 0 OR prev_month_revenue IS NULL) THEN 1 END) AS new_customers,
    COUNT(CASE WHEN total_revenue = 0 AND prev_month_revenue > 0 THEN 1 END) AS churned_customers
FROM
    cde
GROUP BY
    year, only_month
ORDER BY
    year, only_month
        );
      
  