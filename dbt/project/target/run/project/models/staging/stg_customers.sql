
  
    

        create or replace transient table FITNESS_TRACKER.staging.stg_customers
         as
        (
WITH required_fields AS (
    SELECT
        company,
        customer_id,
        customername as customer_name
    FROM
        FITNESS_TRACKER.RAW.customers
),
datatype_conversion AS (
    SELECT
        
     CAST(company AS VARCHAR) 
 AS company,
        
     CAST(customer_id AS INT) 
 AS customer_id,
        
     CAST(customer_name AS VARCHAR) 
 AS customer_name
    FROM
        required_fields
)
SELECT
    DISTINCT
    company,
    customer_id,
    customer_name
FROM
    datatype_conversion
WHERE
    company IS NOT NULL AND customer_id IS NOT NULL AND customer_name IS NOT NULL
        );
      
  