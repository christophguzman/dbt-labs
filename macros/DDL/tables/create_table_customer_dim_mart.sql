{% macro customer_dim_mart() -%}
    {%- set sql -%}
        
        USE DATABASE {{target.database}};
        
        USE SCHEMA {{generate_schema_name('MARTS')}};

        CREATE TABLE IF NOT EXISTS {{target.database}}.{{generate_schema_name('MARTS')}}.customer_dim_mart (
            CUSTOMER_ID	NUMBER(38,0),
            ADDRESS_ID	NUMBER(1,0),
            FIRST_NAME	VARCHAR(16777216),
            LAST_NAME	VARCHAR(16777216),
            ADDRESS	VARCHAR(11),
            CITY	VARCHAR(7),
            STATE	VARCHAR(2),
            ZIP_CODE	NUMBER(38,0),
            COUNTRY_CODE	VARCHAR(2),
            audit_hash_key varchar,
            audit_cdc_code varchar,
            created_date timestamp_ntz,
            LAST_UPDATED_DATE timestamp_ntz
        );
        
    {%- endset -%}

    {%- do run_query(sql) -%} 

{% endmacro %}