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
        o.dt_aprovacao,
        o.dt_despacho,
        o.dt_entrega,
        o.dt_entrega_estimada,
        o.ano,
        o.mes,
        oi.dt_limite_envio,
        oi.preco,
        oi.valor_frete,
        coalesce(oi.preco, 0) + coalesce(oi.valor_frete, 0) as valor_total_item,
        case
            when o.dt_entrega is not null and o.dt_compra is not null
            then datediff(day, o.dt_compra, o.dt_entrega)
            else null
        end as prazo_entrega_dias,
        case
            when o.dt_entrega is not null
             and o.dt_entrega_estimada is not null
             and o.dt_entrega > o.dt_entrega_estimada
            then 1
            else 0
        end as fl_atraso_entrega
    from order_items oi
    inner join orders o on oi.order_id = o.order_id
)

select * from joined