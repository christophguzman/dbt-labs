{% snapshot mock_orders_snapshot %}

{% set new_schema=target.schema %}
{% set new_database=target.database %}

    {{
        config(
            target_database=new_database,
            target_schema=new_schema,
            unique_key='order_id',
            strategy='check',
            check_cols='all'
        )
    }}

    select * from raw.{{target.schema}}.mock_orders
 {% endsnapshot %}