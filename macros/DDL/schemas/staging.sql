{% macro staging() -%}
    {%- set sql -%}
        
        USE DATABASE {{target.database}};

        CREATE SCHEMA IF NOT EXISTS {{generate_schema_name('staging')}};

    {%- endset -%}

    {%- do run_query(sql) -%} 

{% endmacro %}