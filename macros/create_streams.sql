{% macro create_streams(macro_name) -%}
    {%- set sql -%}
        
        USE DATABASE {{target.database}};
        
        USE SCHEMA {{generate_schema_name('MARTS')}};

        CREATE OR REPLACE STREAM {{ macro_name }}_STREAM ON TABLE {{ macro_name }} ;
        
    {%- endset -%}

    {%- do run_query(sql) -%} 

{% endmacro %}