{{ config(materialized='view') }}

SELECT
    log_id,
    session_id,
    NULLIF(customer_id, '') AS customer_id,
    "timestamp"::TIMESTAMP AS evento_timestamp,
    evento,
    pagina,
    NULLIF(produto_id, '') AS produto_id,
    NULLIF(categoria, '') AS categoria,
    dispositivo,
    browser,
    duracao_segundos::INTEGER AS duracao_segundos,
    ip,
    cidade,
    estado,
    utm_source,
    NULLIF(utm_campaign, '') AS utm_campaign,
    NULLIF(referrer, '') AS referrer,
    NULLIF(search_query, '') AS search_query
FROM {{ source('mercamax_raw', 'logs_navegacao') }}