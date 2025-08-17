/*
    Utilizado para fazer a contagem das linhas baseado em algum particionamento
*/
WITH seller as (

    SELECT
        seller_id,
        product_id,
        count(distinct(order_id)) as qntd_vendas,
        sum(price) as valor_vendas
    FROM tb_order_items

    Group by 1, 2

    order by 1
)

SELECT
    *,
    row_number() OVER(PARTITION BY seller_id ORDER BY qntd_vendas DESC, valor_vendas DESC) as ranking
FROM seller