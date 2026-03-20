with customers as (
    select * from {{ ref('stg_customers') }}
)

select distinct
    md5(cep_prefixo || cidade || estado)    as location_id,
    cep_prefixo,
    cidade,
    estado
from customers
