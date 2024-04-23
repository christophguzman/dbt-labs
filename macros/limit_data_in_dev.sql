{% macro limit_data_in_dev(column_name,number_of_days=3) %}
{% if target.name=='default' %}
    WHERE {{column_name}}::timestamp_ntz >= dateadd(day,-{{number_of_days}},current_timestamp(0)::timestamp_ntz)
{% endif %}
    
{% endmacro %}