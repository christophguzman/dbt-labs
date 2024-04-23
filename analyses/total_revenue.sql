SELECT 
    payment_id, 
    order_id, 
    payment_method,
    status, 
    amount
FROM {{ ref('stg_payments') }}
WHERE status = 'success'