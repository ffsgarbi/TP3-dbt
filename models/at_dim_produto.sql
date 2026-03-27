with products as (
    select * from {{ ref('at_stg_products') }}
)

select
    product_id,
    categoria,
    tamanho_nome,
    tamanho_descricao,
    qtd_fotos,
    peso_g,
    comprimento_cm,
    altura_cm,
    largura_cm
from products