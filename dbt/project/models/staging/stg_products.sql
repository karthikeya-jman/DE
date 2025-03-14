{{
    config(
        tags=['staging']
    )
}}
WITH required_fields AS (
    SELECT
        product_id,
        product_family,
        product_sub_family
    FROM
        {{ source('fitness_tracker', 'products') }}
),
datatype_conversion AS (
    SELECT
       {{to_varchar('product_id')}} AS product_id, 
       {{to_varchar('product_family')}} AS product_family,
       {{to_varchar('product_sub_family')}} AS product_sub_family
    FROM
        required_fields
)
SELECT
    DISTINCT *
FROM
    datatype_conversion
WHERE
    product_id IS NOT NULL
    AND product_family IS NOT NULL
    AND product_sub_family IS NOT NULL