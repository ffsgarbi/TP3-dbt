{{ config(
    materialized='table',
    dist='customer_id',
    sort='customer_id'
) }}

SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS sk_cliente,
    customer_id,
    nome,
    email,
    telefone,
    data_cadastro,
    data_nascimento,
    segmento,
    origem_cadastro,
    genero,
    ativo,
    cep
FROM {{ ref('pb_tp2_stg_clientes') }}