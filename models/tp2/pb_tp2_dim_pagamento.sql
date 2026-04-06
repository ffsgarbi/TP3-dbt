{{ config(
    materialized='table',
    dist='all',
    sort='pagamento'
) }}

WITH pagamentos AS (
    SELECT DISTINCT pagamento
    FROM {{ ref('pb_tp2_stg_pedidos') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY pagamento) AS sk_pagamento,
    pagamento
FROM pagamentos