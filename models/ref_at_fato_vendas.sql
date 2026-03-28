{{ config(
    materialized  = 'table',
    dist          = 'order_id',
    sort          = 'dt_compra'
) }}

with orders as (
    select * from {{ ref('at_stg_orders') }}
),
order_items as (
    select * from {{ ref('at_stg_order_items') }}
),
joined as (
    select
        oi.order_id,
        oi.nr_item,
        oi.product_id,
        oi.seller_id,
        o.customer_id,
        o.status,
        o.dt_compra,
        o.ano,
        o.mes,
        oi.preco,
        oi.valor_frete,
        coalesce(oi.preco, 0) + coalesce(oi.valor_frete, 0)            as valor_total,
        {{ real_to_dolar ('coalesce(oi.preco, 0) + coalesce(oi.valor_frete, 0)') }} as valor_total_usd,
        {{ limpar_texto('o.status') }}                                  as status_padronizado
    from order_items oi
    inner join orders o on oi.order_id = o.order_id
)

select * from joined