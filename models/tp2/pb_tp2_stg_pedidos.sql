{{ config(materialized='view') }}

SELECT
    p.order_id,
    p.customer_id,
    p.vendedor_id,
    p.data_pedido::TIMESTAMP AS data_pedido,
    p.data_entrega_prevista::DATE AS data_entrega_prevista,
    p.data_entrega_real::DATE AS data_entrega_real,
    p.status,
    p.canal,
    p.total::DECIMAL(12,2) AS total,
    p.frete::DECIMAL(8,2) AS frete,
    p.pagamento,
    p.estado_entrega,
    p.avaliacao::INTEGER AS avaliacao,
    item.produto_id::VARCHAR AS produto_id,
    item.categoria::VARCHAR AS categoria,
    item.quantidade::INTEGER AS quantidade,
    item.preco_unit::DECIMAL(12,2) AS preco_unitario
FROM {{ source('mercamax_raw', 'pedidos') }} p,
     p.itens AS item