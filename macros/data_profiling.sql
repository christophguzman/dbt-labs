{% macro data_profile(model_name) %}
    

{% set model_name=model_name %}

{% set get_column_names %}
SELECT 
    TABLE_CATALOG || '.' || TABLE_SCHEMA || '.' || TABLE_NAME AS FULL_TABLE_NAME, 
    COLUMN_NAME , 
    DATA_TYPE, 
    ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS
WHERE FULL_TABLE_NAME = UPPER('{{ ref(model_name) }}')
ORDER BY ORDINAL_POSITION
{% endset %}

{% set results = run_query(get_column_names) %}
{% if execute %}
{# Return the first column #}
{% set column_names = results.columns[1].values() %}
{% else %}
{% set column_names = [] %}
{% endif %}



{%- for column in column_names %}
SELECT 
'{{ ref(model_name) }}' AS TABLE_NAME, '{{ column }}' AS COLUMN_NAME, SUM(CASE WHEN {{ column }} IS NOT NULL THEN 1 ELSE 0 END) AS not_null_cnt, COUNT(DISTINCT {{ column }}) AS unique_val_cnt, MIN({{ column }})::TEXT AS min_value, MAX({{ column }})::TEXT AS max_value
FROM {{ ref(model_name) }} {% if not loop.last %} UNION ALL {% endif %}
{%- endfor -%}

{% endmacro %}


