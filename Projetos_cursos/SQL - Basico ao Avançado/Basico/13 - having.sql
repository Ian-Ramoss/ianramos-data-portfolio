-- query anterior com subquery
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
WHERE valor_total >= 4000


-- query com having sem subquery
-- WHERE serve para filtrar colunas que ja existem na tabela
-- HAVING serve para filtrar valores e colunas que criamos na tabela

SELECT
    order_id,
    sum(price) as valor_total
FROM tb_order_items

GROUP BY 1 

-- não muito utilizado, mas muito bom: Having
HAVING valor_total >= 4000

ORDER BY 2 DESC