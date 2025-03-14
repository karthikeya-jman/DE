{{
  config(
     tags=['done']
  )
}}
WITH int_rank_products AS(
SELECT
    p.product_id,
    SUM(t.revenue) AS total_revenue,
    RANK() OVER(ORDER BY SUM(t.revenue) DESC) AS rank
FROM
    {{ref('stg_transactions')}} t
JOIN
    {{ref('stg_products')}} p ON t.product_id = p.product_id
GROUP BY
    p.product_id
ORDER BY
    total_revenue DESC
)
SELECT * FROM int_rank_products