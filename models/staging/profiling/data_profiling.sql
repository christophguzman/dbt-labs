SELECT * FROM ({{ data_profile('stg_payments') }})
UNION ALL
SELECT * FROM ({{ data_profile('stg_orders') }})
UNION ALL
SELECT * FROM ({{ data_profile('stg_customers') }})
