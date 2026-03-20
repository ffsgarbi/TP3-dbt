with customers as (
    select * from {{ ref('stg_customers') }}
),

localizacao as (
    select * from {{ ref('dim_localizacao') }}
)

select
    c.customer_id,
    c.customer_unique_id,
    l.location_id
from customers c
left join localizacao l
    on  c.cep_prefixo = l.cep_prefixo
    and c.cidade      = l.cidade
    and c.estado      = l.estado
