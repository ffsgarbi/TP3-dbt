with orders as (
    select * from {{ ref('stg_orders') }}
),

dim as (
    select distinct
        order_id,
        dt_compra,
        dt_aprovacao,
        dt_despacho,
        dt_entrega,
        dt_entrega_estimada,
        extract(day   from dt_compra)::int      as dia,
        extract(month from dt_compra)::int      as mes,
        extract(year  from dt_compra)::int      as ano,
        extract(quarter from dt_compra)::int    as trimestre,
        to_char(dt_compra, 'Day')               as dia_semana
    from orders
    where dt_compra is not null
)

select * from dim
