{{ config(
    materialized='table',
    dist='all',
    sort='produto_id'
) }}

WITH produtos AS (
    SELECT DISTINCT
        produto_id,
        categoria
    FROM {{ ref('pb_tp2_stg_pedidos') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY produto_id) AS sk_produto,
    produto_id,
    categoria
FROM produtos