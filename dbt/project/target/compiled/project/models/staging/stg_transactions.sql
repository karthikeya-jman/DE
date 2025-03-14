
WITH required_fields AS (
    SELECT
        customer_id ,
        product_id ,
        payment_month ,
        revenue_type ,
        revenue ,
        quantity
    FROM
        FITNESS_TRACKER.RAW.transaction
),
datatype_conversion AS (
    SELECT
        
     CAST(customer_id AS INT) 
 AS customer_id,
        
     CAST(product_id AS VARCHAR) 
 as product_id,
        
    CAST(payment_month AS DATE)
 as payment_month,
        
     CAST(revenue_type AS INT) 
 AS revenue_type,
        
     CAST(revenue AS FLOAT) 
 AS revenue,
        
     CAST(quantity AS INT) 
 AS quantity
    FROM
        required_fields
)
SELECT
    DISTINCT *
FROM
    datatype_conversion
WHERE
    customer_id IS NOT NULL
    AND product_id IS NOT NULL
    AND payment_month IS NOT NULL
    AND revenue_type IS NOT NULL
    AND revenue IS NOT NULL
    AND quantity IS NOT NULL