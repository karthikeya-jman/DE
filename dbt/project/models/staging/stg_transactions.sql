{{
    config(
        tags=['staging']
    )
}}
WITH required_fields AS (
    SELECT
        customer_id ,
        product_id ,
        payment_month ,
        revenue_type ,
        revenue ,
        quantity
    FROM
        {{ source('fitness_tracker', 'transaction') }}
),
datatype_conversion AS (
    SELECT
        {{to_int('customer_id')}} AS customer_id,
        {{to_varchar('product_id')}} as product_id,
        {{to_date('payment_month')}} as payment_month,
        {{to_int('revenue_type')}} AS revenue_type,
        {{to_float('revenue')}} AS revenue,
        {{to_int('quantity')}} AS quantity
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