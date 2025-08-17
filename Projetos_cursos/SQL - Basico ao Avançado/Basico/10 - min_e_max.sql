SELECT
    product_category_name,
    min(product_photos_qty) as qntd_minima,
    max(product_photos_qty) as qntd_max
FROM tb_products

WHERE product_category_name is not null

GROUP BY product_category_name

/* 
    1 - Utilizando a tabela tb_order_payments, verifique qual é o valor min e max
    em cada tipo de pagamento (crédito, boleto ..)
*/

SELECT
    payment_type,
    min(payment_value) as valor_minima,
    max(payment_value) as valor_max
FROM tb_order_payments

GROUP BY payment_type