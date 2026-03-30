{{ config(
    materialized = 'table',
    dist          = 'status_id',
    sort          = 'order_status'
) }}

with orders as (
    select * from {{ ref('at_stg_orders') }}
)

select distinct
    md5(status)     as status_id,
    status          as order_status
from orders
where status is not null