WITH revenue_drop as(
    SELECT
        PRODUCT_ID,
        PAYMENT_MONTH,
        REVENUE,
        LAG(REVENUE) OVER (
            PARTITION BY PRODUCT_ID
            ORDER BY
                PAYMENT_MONTH
        ) AS PREV_REVENUE
    FROM
        { { ref('stg_transactions') } }
),
replace_null as(
    SELECT
        COALESCE(PREV_REVENUE, 0) as Previous_Revenue,
        PRODUCT_ID,
        PAYMENT_MONTH,
        PREV_REVENUE,
        REVENUE,
    FROM
        revenue_drop
)
SELECT
    PRODUCT_ID,
    PAYMENT_MONTH,
    SUM(Previous_Revenue) as Previous_Revenue,
    SUM(REVENUE) as Current_Revenue,
    SUM(Previous_Revenue) - SUM(REVENUE) as Revenue_Loss,
FROM
    replace_null
GROUP BY
    PRODUCT_ID,
    PAYMENT_MONTH
ORDER BY
    Revenue_Loss DESC