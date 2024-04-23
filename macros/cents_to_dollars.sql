{% macro cents_to_dollars(column_name,decimal_precision=2) -%}
ROUND({{ column_name }} / 100,{{decimal_precision}})
{%- endmacro %}