SELECT * 
FROM {{ source('jaffle_shop', 'customer_address_xwalk') }}