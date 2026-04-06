{{ config(
    materialized='table',
    dist='all',
    sort='canal'
) }}

WITH canais AS (
    SELECT DISTINCT canal
    FROM {{ ref('pb_tp2_stg_pedidos') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY canal) AS sk_canal,
    canal
FROM canais