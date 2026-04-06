{{ config(
    materialized='table',
    dist='all',
    sort='data'
) }}

WITH datas_pedidos AS (
    SELECT DISTINCT data_pedido::DATE AS data
    FROM {{ ref('pb_tp2_stg_pedidos') }}
),
datas_logs AS (
    SELECT DISTINCT evento_timestamp::DATE AS data
    FROM {{ ref('pb_tp2_stg_logs') }}
),
todas_datas AS (
    SELECT data FROM datas_pedidos
    UNION
    SELECT data FROM datas_logs
)

SELECT
    ROW_NUMBER() OVER (ORDER BY data) AS sk_tempo,
    data,
    EXTRACT(YEAR FROM data) AS ano,
    EXTRACT(MONTH FROM data) AS mes,
    EXTRACT(QUARTER FROM data) AS trimestre,
    EXTRACT(DOW FROM data) AS dia_semana,
    CASE WHEN EXTRACT(DOW FROM data) IN (0, 6) THEN TRUE ELSE FALSE END AS e_fim_semana
FROM todas_datas