{{
  config(
     tags=['done']
  )
}}
WITH int_rank_customers AS(
SELECT
    t.customer_id,
    c.customer_name,
    SUM(t.revenue) AS total_revenue,
    rank() OVER(ORDER BY SUM(t.revenue) DESC) AS rank
FROM
    {{ref('stg_transactions')}} t
JOIN
    {{ref('stg_customers')}} c ON t.customer_id = c.customer_id
GROUP BY
    t.customer_id, c.customer_name
ORDER BY
    total_revenue DESC
)
SELECT * FROM int_rank_customers