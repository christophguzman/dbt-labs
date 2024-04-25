{% macro clean_stale_models(database=target.database,schema=target.schema,days=7,dry_run=True) %}
    {% set query %}
        
        SELECT 
            'DROP ' || CASE WHEN table_type = 'VIEW' THEN table_type ELSE 'TABLE' END || ' IF EXISTS ' || table_catalog || '.' || table_schema || '.' || table_name || ';'
        FROM {{database}}.INFORMATION_SCHEMA.TABLES 
        WHERE TABLE_SCHEMA = UPPER('{{schema}}')
        AND last_altered::DATE = '2024-04-18'

    {% endset %}

    {{ log('\nGenerating cleanup queries...', info=True) }}
    {% set drop_queries=run_query(query).columns[0].values() %}
    
    {% for drop_stmt in drop_queries %}
    
        {% if dry_run %}
            {{ log(drop_stmt, info=True) }}
        {% else %}
            {{ log('Dropping object with command: ' ~ drop_stmt, info=True) }}
            {% do run_query(drop_stmt) %}
        {% endif %}
        
        
    {% endfor %}
{% endmacro %}