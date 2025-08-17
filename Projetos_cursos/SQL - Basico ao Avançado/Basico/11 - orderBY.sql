SELECT
    customer_state,
    count(distinct(customer_city)) as qntd_cidade
FROM tb_customers

GROUP BY customer_state

ORDER BY qntd_cidade desc -- asc para crescente


-- OUTRO EXEMPLO

SELECT
    order_id,
    SUM(price) as valor_total
FROM tb_order_items

GROUP BY order_id

ORDER BY valor_total desc

LIMIT 5

/* 
1 - Utilizando a tabela tb_products, ordene todas as categorias em ordem alfabética
2 - Ainda utilizando a tabela tb_products, selecione todos os produtos da categoria
    "perfumaria" e ordene do maior peso para o menor
3 - Ainda utilizando a tabela tb_products, liste as 5 categorias com a maior quantidade
    de produtos
*/

SELECT
    *
FROM tb_products

--1
SELECT
    distinct(product_category_name) as categorias_distintas
FROM tb_products

WHERE product_category_name is not null

ORDER BY categorias_distintas asc

-- 2
SELECT
    product_category_name,
    product_weight_g
FROM tb_products

WHERE product_category_name = 'perfumaria'

ORDER BY product_weight_g desc

-- 3 
SELECT
    product_category_name,
    count(distinct(product_id)) as qntd_produtos
FROM tb_products

GROUP BY product_category_name

ORDER BY qntd_produtos desc

LIMIT 5
