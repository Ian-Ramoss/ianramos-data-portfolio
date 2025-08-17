SELECT
    count(product_id) as contagem_produtos
FROM tb_products

SELECT
    count(order_id) as contagem_produtos_entregues
FROM tb_orders

WHERE order_status = 'delivered'



/*  
    Atividade usando count 

    1. Utilizando a tabela tb_order_reviews, conte a quantidade de reviews com um
    score maior ou igual a 4;

    2. Utilizando a tabela tb_products, conte a quantidade de produtos do nicho de construção que 
    tenham um peso maior que 350    
*/


-- 1.

SELECT
    count(review_id) as qtd_pedidos
FROM tb_order_reviews

WHERE review_score >= 4

-- 2.

-- product_description_lenght	
-- product_category_name

SELECT
    count(product_id) as construcao_pesa_mais_que_350
FROM tb_products

WHERE product_category_name LIKE '%construcao%'
AND product_weight_g > 350