/*

    Monte a seguinte tabela:
|seller_id | alimentos | construcao | eletrodomesticos | fashion | livros | moveis | telefonia | outros |
|adsfsadfv | 0     | 11.52            | 
|adsfsasaw | 100     | 0            | 

QUAL O PERCENTUAL DE VENDA DE CADA SELLER_ID PARA CADA CATEGORIA

*/

-- Resolução
WITH sellers AS (
    SELECT
        t1.seller_id,
        t2.product_category_name,
        sum(t1.price) + sum(t1.freight_value) as valor_total
    FROM tb_order_items as t1

    LEFT JOIN tb_products as t2
    on t1.product_id = t2.product_id

    GROUP BY 1, 2
),

tratamento AS (
    SELECT
        seller_id,
        CASE WHEN product_category_name LIKE '%alimentos%' THEN SUM(valor_total) END AS alimentos,
        CASE WHEN product_category_name LIKE '%construcao%' THEN SUM(valor_total) END AS construcao,
        CASE WHEN product_category_name LIKE '%eletrodomesticos%' THEN SUM(valor_total) END AS eletrodomesticos,
        CASE WHEN product_category_name LIKE '%fashion%' THEN SUM(valor_total) END AS fashion,
        CASE WHEN product_category_name LIKE '%livros%' THEN SUM(valor_total) END AS livros,
        CASE WHEN product_category_name LIKE '%moveis%' THEN SUM(valor_total) END AS moveis,
        CASE WHEN product_category_name LIKE '%telefonia%' THEN SUM(valor_total) END AS telefonia,
        CASE WHEN product_category_name NOT LIKE '%alimentos%'
                AND product_category_name NOT LIKE '%construcao%'
                AND product_category_name NOT LIKE '%eletrodomesticos%'
                AND product_category_name NOT LIKE '%fashion%'
                AND product_category_name NOT LIKE '%livros%'
                AND product_category_name NOT LIKE '%moveis%'
                AND product_category_name NOT LIKE '%telefonia%'
        THEN sum(valor_total) END AS outros
    FROM sellers

    GROUP BY seller_id, product_category_name
),

valor_total AS (
    SELECT
        seller_id,
        SUM(valor_total) AS valor_total
    FROM sellers

    GROUP BY 1
)

SELECT
    t1.seller_id,
    COALESCE((SUM(alimentos) / t2.valor_total) * 100, 0) AS alimentos,
    COALESCE((SUM(construcao) / t2.valor_total) * 100, 0) AS construcao,
    COALESCE((SUM(eletrodomesticos) / t2.valor_total) * 100, 0) AS eletrodomesticos,
    COALESCE((SUM(fashion) / t2.valor_total) * 100, 0) AS fashion,
    COALESCE((SUM(livros) / t2.valor_total) * 100, 0) AS livros,
    COALESCE((SUM(moveis) / t2.valor_total) * 100, 0) AS moveis,
    COALESCE((SUM(telefonia) / t2.valor_total) * 100, 0) AS telefonia,
    COALESCE((SUM(outros) / t2.valor_total) * 100, 0) AS outros
FROM tratamento AS t1

LEFT JOIN valor_total AS t2
ON t1.seller_id = t2.seller_id

GROUP BY 1


-- QUERYS DE APOIO
SELECT * from tb_sellers -- seller_id
SELECT * from tb_order_items -- seller_id, order_id, product_id, price, freight_value	
SELECT * from tb_products -- product_id, product_category_name
