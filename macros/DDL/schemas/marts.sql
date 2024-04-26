{% macro marts() -%}
    {%- set sql -%}
        
        USE DATABASE {{target.database}};

        CREATE SCHEMA IF NOT EXISTS {{generate_schema_name('MARTS')}};

    {%- endset -%}

    {%- do run_query(sql) -%} 

{% endmacro %}