{% macro order_amounts_by_day_mart() -%}
    {%- set sql -%}
        
        USE DATABASE {{target.database}};

        USE SCHEMA {{generate_schema_name('marts')}};
        
        CREATE TABLE IF NOT EXISTS order_amounts_by_day_mart (
            order_date DATE,
            placed_amount number(18,2),
            shipped_amount number(18,2),
            completed_amount number(18,2),
            return_pending_amount number(18,2),
            returned_amount number(18,2),
            nbr_of_orders number,
            audit_hash_key varchar,
            audit_cdc_code varchar,
            created_date timestamp_ntz,
            LAST_UPDATED_DATE timestamp_ntz
        );
        
    {%- endset -%}

    {%- do run_query(sql) -%} 

{% endmacro %}