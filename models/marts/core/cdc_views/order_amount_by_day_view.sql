{{
    config(
        materialized='view'
    )
}}

SELECT 
    A.ORDER_DATE,
    SUM(CASE WHEN A.status = 'placed' THEN B.amount ELSE 0 END) AS PLACED_AMOUNT,
    SUM(CASE WHEN A.status = 'shipped' THEN B.amount ELSE 0 END) AS shipped_amount,
    SUM(CASE WHEN A.status = 'completed' THEN B.amount ELSE 0 END) AS completed_amount,
    SUM(CASE WHEN A.status = 'return_pending' THEN B.amount ELSE 0 END) AS return_pending_amount,
    SUM(CASE WHEN A.status = 'returned' THEN B.amount ELSE 0 END) AS returned_amount,
    COUNT(1) AS NBR_OF_ORDERS
FROM {{ ref('stg_orders') }} A 
JOIN {{ ref('stg_payments') }} B 
    ON A.ORDER_ID = B.ORDER_ID
GROUP BY 1