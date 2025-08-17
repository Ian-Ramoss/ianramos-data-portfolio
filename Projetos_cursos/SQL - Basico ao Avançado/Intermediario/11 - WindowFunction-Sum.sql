/*
Utilizado para somar os valores, mas também particionando
*/
WITH vendas as (
    SELECT
        t1.seller_id,
        strftime('%Y-%m-%d', t2.order_approved_at) as data_venda,
        sum(t1.price) as valor_venda
    FROM tb_order_items as t1

    LEFT JOIN tb_orders as t2
    ON t1.order_id = t2.order_id

    GROUP BY 1, 2
    ORDER BY 1, 2
)

SELECT
    *,
    SUM(valor_venda) OVER(PARTITION BY seller_id ORDER BY data_venda ASC) AS vendas_acc
FROM vendas