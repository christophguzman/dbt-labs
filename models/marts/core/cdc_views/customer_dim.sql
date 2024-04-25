{{
    config(
        materialized='view'
    )
}}

WITH customers AS (
    SELECT * 
    FROM {{ ref('stg_customers') }}
)

, customer_xwalk AS (
    SELECT * 
    FROM {{ ref('stg_customer_address_xwalk') }}
)

, addresses AS (
    SELECT * 
    FROM {{ ref('stg_customer_address') }}
)

SELECT 
    --SHA2(TO_VARCHAR(ARRAY_CONSTRUCT(*))) AS AUDIT_HASH_KEY,
    A.customer_id, 
    C.address_id,
    A.first_name, 
    A.last_name, 
    --C.address || ' ' || city || ', ' || state || ', ' || zip_code::TEXT || ', ' || country_code AS full_address,
    C.address, 
    C.city, 
    C.state, 
    SUBSTRING(C.zip_code::VARCHAR,0,5)::NUMBER AS zip_code, 
    C.country_code
FROM customers A 
LEFT JOIN customer_xwalk B 
    ON A.customer_id = B.customer_id 
LEFT JOIN addresses C 
    ON B.address_id = C.address_id 