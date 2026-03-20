with orders as (
    select * from {{ ref('stg_orders') }}
)

select distinct
    {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
    status                                             as order_status
from orders
where status is not null
