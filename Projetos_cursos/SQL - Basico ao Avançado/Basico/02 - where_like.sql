SELECT
    *
FROM tb_products

WHERE product_category_name LIKE '%construcao%'




/*  
    Atividade

    Utilizando a tabela tb_order_reviews, filtre todas as reviews que começam com "Parabéns..." 
    e depois filtre todas que contém a palavra "Parabéns"*/


SELECT
    *
FROM tb_order_reviews

WHERE review_comment_message LIKE 'Parabéns%'

SELECT
    *
FROM tb_order_reviews

WHERE review_comment_message LIKE '%Parabéns%'