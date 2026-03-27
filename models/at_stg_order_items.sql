with source as (
    select * from {{ source('olist', 'olist_order_items') }}
),

renamed as (
    select
        order_id,
        order_item_id                       as nr_item,
        product_id,
        seller_id,
        shipping_limit_date::timestamp      as dt_limite_envio,
        price::decimal(10,2)                as preco,
        freight_value::decimal(10,2)        as valor_frete
    from source
    where order_id is not null
      and product_id is not null
)

select * from renamed
