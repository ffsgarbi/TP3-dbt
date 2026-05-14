{{ config(
    materialized='table',
    dist='customer_id',
    sort='evento_timestamp'
) }}

SELECT
    lg.log_id,
    lg.session_id,
    t.sk_tempo,
    c.sk_cliente,
    pr.sk_produto,
    l.sk_localizacao,
    lg.evento,
    lg.pagina,
    lg.dispositivo,
    lg.browser,
    lg.duracao_segundos,
    lg.ip,
    lg.utm_source,
    lg.utm_campaign,
    lg.referrer,
    lg.search_query,
    lg.evento_timestamp,
    lg.customer_id
FROM {{ ref('pb_tp2_stg_logs') }} lg
LEFT JOIN {{ ref('pb_tp2_dim_tempo') }} t
    ON lg.evento_timestamp::DATE = t.data
LEFT JOIN {{ ref('pb_tp2_dim_cliente') }} c
    ON lg.customer_id = c.customer_id
LEFT JOIN {{ ref('pb_tp2_dim_produto') }} pr
    ON lg.produto_id = pr.produto_id
LEFT JOIN {{ ref('pb_tp2_dim_localizacao') }} l
    ON lg.estado = l.estado AND lg.cidade = l.cidade