with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (
    select * from {{ ref('fct_orders') }}
),

customer_orders as (

    select
        A.customer_id,
        min(A.order_date) as first_order_date,
        max(A.order_date) as most_recent_order_date,
        count(A.order_id) as number_of_orders,
        SUM(B.AMOUNT) AS lifetime_value

    from orders A 
    LEFT JOIN payments B
        ON A.ORDER_ID = B.ORDER_ID

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        customer_orders.lifetime_value

    from customers
    left join customer_orders using (customer_id)

)

select * from final