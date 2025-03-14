
WITH required_fields AS (
    SELECT
        product_id,
        product_family,
        product_sub_family
    FROM
        FITNESS_TRACKER.RAW.products
),
datatype_conversion AS (
    SELECT
       
     CAST(product_id AS VARCHAR) 
 AS product_id, 
       
     CAST(product_family AS VARCHAR) 
 AS product_family,
       
     CAST(product_sub_family AS VARCHAR) 
 AS product_sub_family
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