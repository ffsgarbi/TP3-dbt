with orders as (
    select * from {{ ref('at_stg_orders') }}
)

select distinct
    order_id,
    dt_compra,
    dt_aprovacao,
    dt_despacho,
    dt_entrega,
    dt_entrega_estimada,
    ano,
    mes,
    extract(day from dt_compra)::int        as dia,
    extract(quarter from dt_compra)::int    as trimestre,
    to_char(dt_compra, 'Day')               as dia_semana
from orders
where dt_compra is not null