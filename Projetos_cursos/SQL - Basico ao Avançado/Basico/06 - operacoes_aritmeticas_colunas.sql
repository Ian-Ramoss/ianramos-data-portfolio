SELECT
    product_id,
    product_name_lenght,
    product_description_lenght,

    product_name_lenght - product_description_lenght as subtracao_colunas,
    product_name_lenght + product_description_lenght as soma_colunas,
    product_name_lenght * product_description_lenght as multiplicacao_colunas,
    product_name_lenght / product_description_lenght as divisao_colunas,

    product_description_lenght + 20 as soma_20,

    (product_description_lenght * product_name_lenght) / 2 

FROM tb_products


/* EXERCÍCIOS DE OPERAÇÕES ARITMÉTICAS */

-- Utilizando a tabela tb_products, calcule o volume de cada produto
-- Volume = comprimento * largura * altura (cm3)

SELECT
    *
FROM tb_products 
LIMIT 10

SELECT
    product_id,
    product_category_name,
    --cálculo:
    product_length_cm * product_height_cm * product_width_cm AS product_volume_cm3
FROM tb_products
