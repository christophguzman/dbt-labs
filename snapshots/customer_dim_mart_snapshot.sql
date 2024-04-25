{% snapshot customer_dim_mart_snapshot %}

{% set new_schema=target.schema %}
{% set new_database=target.database %}

    {{
        config(
            target_database=new_database,
            target_schema=new_schema,
            unique_key='customer_id',
            strategy='check',
            check_cols='all'
        )
    }}

    select * from {{ ref('customer_dim_mart') }}

 {% endsnapshot %}