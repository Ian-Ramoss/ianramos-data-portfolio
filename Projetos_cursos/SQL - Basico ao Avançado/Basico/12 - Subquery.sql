-- Essa query precisa retornar apenas qntd_produtos acima de 500, para isso utilizaremos subquerys
SELECT
    product_category_name,
    count(distinct(product_id)) as qntd_produtos
FROM tb_products

GROUP BY product_category_name

ORDER BY qntd_produtos desc

-- agora com subquery

SELECT
    *
FROM (
    SELECT
    product_category_name,
    count(distinct(product_id)) as qntd_produtos
    FROM tb_products

    GROUP BY product_category_name

    ORDER BY qntd_produtos desc
)

WHERE qntd_produtos >= 500

-- isso acontece pq dentro do primeiro select, primeira query, a coluna qntd_produtos ainda não existe,
-- mas após fechar a primeira query, para a segunda query, o resultado da primeira é uma tabela e aí sim ja existe a coluna qntd_produtos

-- Outro exemplo

-- quero só valor total acima de 1000. Query simples:
SELECT
    order_id,
    SUM(price) as valor_total
FROM tb_order_items

GROUP BY 1

ORDER BY valor_total desc

-- SUBQUERY:

SELECT
    *
FROM (
    SELECT
        order_id,
        SUM(price) as valor_total
    FROM tb_order_items

    GROUP BY 1

    ORDER BY valor_total desc
)
WHERE valor_total >= 1000

/* 
Nem sempre a subquery vai ser interessante, na maioria dos casos não é a melhor opção
pq vai contra o nosso padrão de leitura, ja que a subquerie funciona de dentro pra fora.
em casos onde existem várias tabelas, isso pode se tornar complexo, com muitas linhas e 
muitas subqueries, praticamente impossibilitando a leitura. Ao pensar em manutenção,
também é maios difícil.
Para consultas rápidas, pode ser utilizada tranquilamente, mas para coisas que rodarão
frequentemente, pode precisar de manutenção etc não.
UM RECURSO QUE É MUITO MELHOR É O CTR
*/