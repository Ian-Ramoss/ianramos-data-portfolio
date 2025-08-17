SELECT
    payment_type,
    AVG(payment_installments) as media_qntd_parcelas,
    AVG(payment_value) as valor_medio_compra
FROM tb_order_payments

WHERE payment_type = 'credit_card'

GROUP BY payment_type

-- ATIVIDADE MEDIA (AVG)
/*
    1 - Utilizando a tabela tb_products, calcule o peso médio dos produtos de perfumaria.
    2 - Ainda utilizando a tabela tb_products, calcule a quantidade total de fotos e o comprimento 
    médio dos produtos do nicho de construção
*/

SELECT
    *
FROM tb_products

-- 1
SELECT
    product_category_name,
    AVG(product_weight_g) as peso_medio_produtos
FROM tb_products

WHERE product_category_name = 'perfumaria'

-- 2
SELECT
    product_category_name,
    SUM(product_photos_qty) as total_fotos,
    AVG(product_length_cm) as comprimento_medio
FROM tb_products

WHERE product_category_name LIKE '%construcao%'

GROUP BY product_category_name