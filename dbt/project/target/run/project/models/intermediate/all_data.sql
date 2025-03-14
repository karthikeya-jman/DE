
  
    

        create or replace transient table FITNESS_TRACKER.intermediate.all_data
         as
        (WITH source_products AS (
    SELECT *
    FROM FITNESS_TRACKER.staging.stg_products
),

source_customers AS (
    SELECT DISTINCT
        customer_id,
        customer_name
    FROM FITNESS_TRACKER.staging.stg_customers
),

source_transactions AS (
    SELECT
        customer_id,
        product_id,
        payment_month,
        revenue_type,
        revenue,
        quantity
    FROM FITNESS_TRACKER.staging.stg_transactions
)

SELECT 
    t.customer_id,
    c.customer_name,
    t.product_id,
    p.product_family,
    p.product_sub_family,
    t.payment_month,
    t.revenue_type,
    t.revenue,
    t.quantity
FROM source_transactions t
LEFT JOIN source_customers c 
    ON t.customer_id = c.customer_id
LEFT JOIN source_products p 
    ON t.product_id = p.product_id
        );
      
  