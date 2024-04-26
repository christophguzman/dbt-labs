{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is not none -%}
        {%- set default_schema = custom_schema_name | trim %}
    {%- endif -%}

    {%- if var('division', 'none') != 'none' -%}
        {%- set division = var('division') -%}
        {%- set default_schema = default_schema | replace('-division-', division) -%}
    {%- endif -%}

    {%- if var('datasourcesystemcode', 'none') != 'none' -%}
        {%- set sourcesystem = var('datasourcesystemcode') -%}
        {%- set default_schema = default_schema | replace('-datasourcesystemcode-', sourcesystem) -%}
    {%- endif -%}

    {% if env_var('DBT_TARGET_NAME') != 'prod' %} 
        {% set default_schema = target.schema + '_' + default_schema  %}
    {% else %}
        {{ default_schema }}       
    {% endif %}
    
    {{ default_schema }} 
    
{%- endmacro %}
