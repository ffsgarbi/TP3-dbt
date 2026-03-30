with source as (
    select * from {{ source('olist', 'olist_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_status as status,
        try_cast(order_purchase_timestamp as timestamp) as dt_compra,
        try_cast(order_approved_at as timestamp) as dt_aprovacao,
        try_cast(order_delivered_carrier_date as timestamp) as dt_despacho,
        try_cast(order_delivered_customer_date as timestamp) as dt_entrega,
        try_cast(order_estimated_delivery_date as timestamp) as dt_entrega_estimada,

        extract(year from try_cast(order_purchase_timestamp as timestamp)) as ano,
        extract(month from try_cast(order_purchase_timestamp as timestamp)) as mes

    from source
    where order_id is not null
)

select * from renamed