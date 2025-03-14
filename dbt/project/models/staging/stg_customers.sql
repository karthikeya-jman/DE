{{
    config(
        tags=['staging']
    )
}}
WITH required_fields AS (
    SELECT
        company,
        customer_id,
        customername as customer_name
    FROM
        {{ source('fitness_tracker', 'customers') }}
),
datatype_conversion AS (
    SELECT
        {{ to_varchar('company') }} AS company,
        {{ to_int('customer_id') }} AS customer_id,
        {{ to_varchar('customer_name') }} AS customer_name
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