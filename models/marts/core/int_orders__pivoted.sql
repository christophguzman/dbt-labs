--Used for Jinja
{% set payment_methods = ['bank_transfer','coupon','credit_card','gift_card'] %}

with payments as (
    select * from {{ ref('stg_payments') }}
) 

--Jinja Based Code achieves the same thing
, pivoted_jinja AS (
    SELECT 
        order_id,
        {% for payment_method in payment_methods %}
        SUM(CASE WHEN payment_method = '{{ payment_method }}' THEN amount else 0 END) AS {% if not loop.last %} {{ payment_method }}_amount, {% else %} {{ payment_method }}_amount {% endif %}
        {% endfor %}
    FROM payments
    WHERE status = 'success'
    GROUP BY 1
) 

SELECT * 
FROM pivoted_jinja
