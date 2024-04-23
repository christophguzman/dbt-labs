SELECT 
    id as payment_id, 
    orderid as order_id, 
    paymentmethod as payment_method,
    status,
    {{ cents_to_dollars('amount') }} as amount,
    created as created_at
FROM {{source('stripe','payment')}}
{{ limit_data_in_dev('created_at',1000000)}}