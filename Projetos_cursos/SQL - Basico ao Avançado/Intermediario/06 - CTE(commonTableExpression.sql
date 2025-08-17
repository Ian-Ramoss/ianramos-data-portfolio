/*
    Substituem as subqueries
    "Criam" uma tabela nova
*/
-- após o with, coloca o nome da tabela e dentro do parentese o select com os dados da tabela nova
WITH categorias as(
    SELECT
        product_category_name,
        count(DISTINCT(product_id)) as qntd_produtos
    FROM tb_products

    group BY 1

    Order BY 2 DESC
)

-- agora um select na nova tabela criada (categorias)

SELECT
    *
FROM categorias
WHERE qntd_produtos >= 1400