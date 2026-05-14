{{ config(materialized='view') }}

SELECT
    order_id,
    customer_id,
    data_pedido,
    total,
    status
FROM {{ source('mercamax_databricks', 'pedidos_validados') }}