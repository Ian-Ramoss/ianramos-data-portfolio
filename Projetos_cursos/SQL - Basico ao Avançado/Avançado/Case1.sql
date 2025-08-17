/*

Monte uma tabela que mostre o seller_id, a categoria do produto mais vendido,
a quantidade de vendas desse produto e o valor total de vendas.

*/

WITH sellers as (
    SELECT
        t1.seller_id,
        t1.product_id,
        t2.product_category_name,
        COUNT(distinct(t1.order_id)) as qntd_vendas,
        SUM(t1.price) as valor_total_venda
    FROM tb_order_items as t1

    LEFT JOIN tb_products as t2
    ON t1.product_id = t2.product_id

    GROUP BY 1, 2, 3
),

rankeamento as(
    SELECT
        *,
        row_number() OVER(PARTITION BY seller_id ORDER BY qntd_vendas DESC, valor_total_venda DESC) as ranking
    FROM sellers
)
SELECT
    *
FROM rankeamento

WHERE ranking = 1


-- Querys de apoio
SELECT * FROM tb_order_items -- seller_id, product_id, order_id, price
SELECT * FROM tb_products -- product_id, product_category_name, 