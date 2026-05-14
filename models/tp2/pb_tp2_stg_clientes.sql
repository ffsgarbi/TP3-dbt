{{ config(materialized='view') }}

SELECT
    customer_id,
    nome,
    email,
    telefone,
    data_cadastro::DATE AS data_cadastro,
    segmento,
    cidade,
    estado,
    cep,
    CASE WHEN ativo = 'True' THEN TRUE ELSE FALSE END AS ativo,
    origem_cadastro,
    data_nascimento::DATE AS data_nascimento,
    genero,
    total_pedidos::INTEGER AS total_pedidos,
    total_gasto::DECIMAL(12,2) AS total_gasto,
    NULLIF(ultima_compra, '')::DATE AS ultima_compra
FROM {{ source('mercamax_raw', 'clientes') }}