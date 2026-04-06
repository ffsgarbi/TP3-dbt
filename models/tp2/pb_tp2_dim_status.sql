{{ config(
    materialized='table',
    dist='all',
    sort='status'
) }}

WITH status_list AS (
    SELECT DISTINCT status
    FROM {{ ref('pb_tp2_stg_pedidos') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY status) AS sk_status,
    status
FROM status_list