with source as (
    select * from {{ source('olist', 'olist_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_status                                    as status,
        order_purchase_timestamp::timestamp             as dt_compra,
        order_approved_at::timestamp                    as dt_aprovacao,
        order_delivered_carrier_date::timestamp         as dt_despacho,
        order_delivered_customer_date::timestamp        as dt_entrega,
        order_estimated_delivery_date::timestamp        as dt_entrega_estimada
    from source
    where order_id is not null
)

select * from renamed
