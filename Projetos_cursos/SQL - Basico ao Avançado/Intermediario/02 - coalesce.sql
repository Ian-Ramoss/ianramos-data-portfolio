-- o coalesce serve para substituir valores nulos

SELECT
    DISTINCT
    coalesce(product_category_name,'Sem categoria') as categoria
FROM tb_products

ORDER BY 1

-- OUTRO EXEMPLO:

SELECT
    review_id,
    review_score,
    coalesce(review_comment_title,'Sem titulo') as titulo,
    coalesce(review_comment_message,'Sem comentario') as comentario
FROM tb_order_reviews

/* o coalesce serve também para identificar e priorizar os retornos. Se existem diversas colunas onde 
 pode ter o telefone, 
 O coalesce SEMPRE retorna o primeiro valor não nulo, então se várias colunas podem ter o telefone, mas algumas
 podem estar nulas, podemos usar o coalesce(coluna1, coluna2, coluna3, 'Sem telefone encontrado') as telefone.
 Assim ele percorre todas, retorna o número onde quer que ele esteja  (dentro das colunas parametrizadas) e substitui
 os nulos pela mensagem setada no final.
 */