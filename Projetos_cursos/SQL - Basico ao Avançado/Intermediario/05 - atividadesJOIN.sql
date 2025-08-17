/*
    1- Qual a receita por estado dos sellers apenas dos produtos 
    da categoria de perfumaria?

    2- Qual a receita dos sellers por estado, considerando apenas os
    pedidos que tiveram um review_score maior ou igual a 4?

    3- Qual a receita por estado dos customers apenas dos produtos da 
    categoria de perfumaria?
*/

SELECT
-- product_category_name (T2)
    *
FROM tb_products

SELECT
-- price (T1)
    *
FROM tb_order_items

SELECT
-- order_status = 'delivered' (t3)
    *
from tb_orders

SELECT
-- seller_state (T4)
    *
from tb_sellers

select
    sum(t1.price) as valor_total,
    t2.product_category_name,
 --   t3.order_status,
    t4.seller_state
FROM tb_order_items as t1

LEFT JOIN tb_products as t2
on t1.product_id = t2.product_id

--LEFT JOIN tb_orders as t3 
--on t1.order_id = t3.order_id

LEFT JOIN tb_sellers as t4
on t1.seller_id = t4.seller_id

WHERE t2.product_category_name = 'perfumaria'

GROUP BY 3

ORDER BY 1 desc


/* EXERCÍCIO 2

    2- Qual a receita dos sellers por estado, considerando apenas os
    pedidos que tiveram um review_score maior ou igual a 4?
*/

SELECT
    sum(t1.price) as valor_total,
    t2.seller_state,
    t4.review_score
FROM tb_order_items as t1

LEFT JOIN tb_sellers as t2
on t1.seller_id = t2.seller_id

LEFT JOIN tb_orders as t3
ON t1.order_id = t3.order_id

LEFT JOIN tb_order_reviews as t4
ON t1.order_id = t4.order_id


WHERE t4.review_score >= 4

GROUP BY t2.seller_state

ORDER BY 1 desc



----------------------------- testee

SELECT
    sum(t1.price) as valor_total,
    t2.seller_state,
    t3.review_score
FROM tb_order_items as t1

LEFT JOIN tb_sellers as t2
on t1.seller_id = t2.seller_id

LEFT JOIN tb_order_reviews as t3
ON t1.order_id = t3.order_id


WHERE t3.review_score >= 4

GROUP BY t2.seller_state

ORDER BY 1 desc




/*
    EXERCICIO 3

    3- Qual a receita por estado dos customers apenas dos produtos da 
    categoria de perfumaria?
*/

-- Referência de colunas: SELECT * FROM tb_order_payments LIMIT 5

SELECT
    t1.order_status,
    Sum(t2.price) as valor_total,
    t3.customer_state,
    t4.product_category_name
FROM tb_orders as t1

LEFT JOIN tb_order_items as t2
on t1.order_id = t2.order_id

LEFT JOIN tb_customers as t3
ON t1.customer_id = t3.customer_id

LEFT JOIN tb_products as t4
ON t2.product_id = t4.product_id

WHERE t4.product_category_name = 'perfumaria'

GROUP BY customer_state

ORDER BY valor_total DESC