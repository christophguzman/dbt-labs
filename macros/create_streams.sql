{% macro create_streams(macro_name) -%}
    {%- set sql -%}
        
        CREATE OR REPLACE STREAM {{ macro_name }}_STREAM ON TABLE {{ macro_name }} ;
        
    {%- endset -%}

    {%- do run_query(sql) -%} 

{% endmacro %}