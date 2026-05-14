{{ config(
    materialized='table',
    dist='customer_id',
    sort='data_pedido'
) }}

SELECT
    ped.order_id,
    ROW_NUMBER() OVER (PARTITION BY ped.order_id ORDER BY ped.produto_id) AS item_seq,
    dim_t.sk_tempo,
    dim_c.sk_cliente,
    dim_p.sk_produto,
    dim_l.sk_localizacao,
    dim_cn.sk_canal,
    dim_pg.sk_pagamento,
    dim_s.sk_status,
    ped.vendedor_id,
    ped.quantidade,
    ped.preco_unitario,
    ped.total AS valor_total,
    ped.frete,
    ped.avaliacao,
    ped.data_entrega_prevista,
    ped.data_entrega_real,
    ped.estado_entrega,
    ped.data_pedido,
    ped.customer_id
FROM {{ ref('pb_tp2_stg_pedidos') }} ped
LEFT JOIN {{ ref('pb_tp2_stg_clientes') }} cli
    ON ped.customer_id = cli.customer_id
LEFT JOIN {{ ref('pb_tp2_dim_tempo') }} dim_t
    ON ped.data_pedido::DATE = dim_t.data
LEFT JOIN {{ ref('pb_tp2_dim_cliente') }} dim_c
    ON ped.customer_id = dim_c.customer_id
LEFT JOIN {{ ref('pb_tp2_dim_produto') }} dim_p
    ON ped.produto_id = dim_p.produto_id
LEFT JOIN {{ ref('pb_tp2_dim_localizacao') }} dim_l
    ON cli.estado = dim_l.estado AND cli.cidade = dim_l.cidade
LEFT JOIN {{ ref('pb_tp2_dim_canal') }} dim_cn
    ON ped.canal = dim_cn.canal
LEFT JOIN {{ ref('pb_tp2_dim_pagamento') }} dim_pg
    ON ped.pagamento = dim_pg.pagamento
LEFT JOIN {{ ref('pb_tp2_dim_status') }} dim_s
    ON ped.status = dim_s.status