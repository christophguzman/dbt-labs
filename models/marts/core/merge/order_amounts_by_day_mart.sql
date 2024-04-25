{{
    config(
        materialized='incremental',
        unique_key='order_date'
    )
}}

WITH src_data AS (
SELECT * 
FROM {{ ref('order_amount_by_day_view') }}
) 

--Build AUDIT_HASH_KEY
, get_hash_key AS (
SELECT 
    A.*,
    SHA2(TO_VARCHAR(ARRAY_CONSTRUCT(A.*))) AS AUDIT_HASH_KEY
FROM src_data A 
) 

SELECT 
    A.*,
    CASE WHEN B.AUDIT_HASH_KEY IS NULL THEN 'I' ELSE 'U' END AS AUDIT_CDC_CODE,
    COALESCE(B.CREATED_DATE, CURRENT_TIMESTAMP(0)::TIMESTAMP_NTZ) AS CREATED_DATE, 
    CURRENT_TIMESTAMP(0)::TIMESTAMP_NTZ AS LAST_UPDATED_DATE
FROM get_hash_key A
LEFT JOIN {{target.database}}.{{target.schema}}.order_amounts_by_day_mart B
    ON A.ORDER_DATE = B.ORDER_DATE --Need to param this
WHERE A.AUDIT_HASH_KEY <> COALESCE(B.AUDIT_HASH_KEY,'n/a')

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  

{% endif %}