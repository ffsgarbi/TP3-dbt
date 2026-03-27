with source as (
    select * from {{ source('olist', 'olist_customers') }}
),

renamed as (
    select
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix            as cep_prefixo,
        lower(trim(customer_city))          as cidade,
        upper(trim(customer_state))         as estado
    from source
    where customer_id is not null
)

select * from renamed
