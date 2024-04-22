with base_data AS (
    SELECT 
        orders.ORDER_ID,
        orders.customer_id,
        customers.customer_id AS ref_id
    FROM {{ ref('stg_orders') }} orders
    LEFT JOIN {{ ref('stg_customers') }} customers
        ON orders.customer_id = customers.customer_id

)

SELECT * 
FROM base_data
WHERE REF_ID IS NULL