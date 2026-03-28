{{ config(
    materialized = 'table',
    dist          = 'location_id',
    sort          = 'estado'
) }}

with customers as (
    select * from {{ ref('at_stg_customers') }}
)

select distinct
    md5(cep_prefixo || cidade || estado)    as location_id,
    cep_prefixo,
    cidade,
    estado
from customers