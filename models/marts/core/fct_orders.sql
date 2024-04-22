SELECT 
    A.order_id AS order_id,
    B.customer_id,
    A.amount
FROM {{ ref('stg_payments') }} A 
JOIN {{ ref('stg_orders') }} B
    ON A.order_id = B.order_id