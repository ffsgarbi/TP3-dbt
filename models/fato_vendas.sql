with orders as (
    select * from {{ ref('stg_orders') }}
),

items as (
    select * from {{ ref('stg_order_items') }}
),

joined as (
    select
        i.order_id,
        i.nr_item,
        i.product_id,
        i.seller_id,
        o.customer_id,
        o.dt_compra,
        o.status,
        i.dt_limite_envio,
        i.preco,
        i.valor_frete,
        i.preco + i.valor_frete              as valor_total
    from items i
    inner join orders o on i.order_id = o.order_id
)

select * from joined
