{{
    config(
        materialized='table'
    )
}}

SELECT 
    {{ dbt_utils.surrogate_key('date_day') }} date_key, 
    date_day,
    EXTRACT(YEAR FROM date_day) AS date_year,
    EXTRACT(MONTH FROM date_day) AS date_month,
    DAYNAME(date_day) as day_name_abbr
FROM {{ ref('date_dim') }}