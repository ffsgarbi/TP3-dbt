{{ config(
    materialized='table',
    dist='all',
    sort='estado'
) }}

WITH locais AS (
    SELECT DISTINCT
        estado,
        cidade
    FROM {{ ref('pb_tp2_stg_clientes') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY estado, cidade) AS sk_localizacao,
    estado,
    cidade,
    CASE
        WHEN estado IN ('SP','RJ','MG','ES') THEN 'Sudeste'
        WHEN estado IN ('PR','SC','RS') THEN 'Sul'
        WHEN estado IN ('BA','PE','CE','MA','PB') THEN 'Nordeste'
        WHEN estado IN ('GO') THEN 'Centro-Oeste'
        WHEN estado IN ('PA','AM') THEN 'Norte'
        ELSE 'Outros'
    END AS regiao
FROM locais