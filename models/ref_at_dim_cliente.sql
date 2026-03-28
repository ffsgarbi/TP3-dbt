{{ config(
    materialized = 'table',
    dist          = 'customer_id',
    sort          = 'estado'
) }}

with customers as (
    select * from {{ ref('at_stg_customers') }}
)

select
    customer_id,
    customer_unique_id,
    cep_prefixo,
    cidade,
    estado
from customers