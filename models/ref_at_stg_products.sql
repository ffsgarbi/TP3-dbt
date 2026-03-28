{{ config(materialized = 'view') }}

with source as (
    select * from {{ source('olist', 'olist_products') }}
),

renamed as (
    select
        product_id,
        product_category_name               as categoria,
        product_name_lenght::int            as tamanho_nome,
        product_description_lenght::int     as tamanho_descricao,
        product_photos_qty::int             as qtd_fotos,
        product_weight_g::int               as peso_g,
        product_length_cm::int              as comprimento_cm,
        product_height_cm::int              as altura_cm,
        product_width_cm::int               as largura_cm
    from source
    where product_id is not null
)

select * from renamed