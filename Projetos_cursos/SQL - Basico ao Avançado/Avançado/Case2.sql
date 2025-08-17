/*

Monte uma tabela que mostre o customer_id, a categoria do produto mais vendida, 
a quantidade de vendas desse produto e o valor total de vendas.

-- Utilize o customer_unique_id
*/

--Resolução
WITH customers as (
    SELECT
        t1.customer_unique_id,
        t4.product_category_name,
        count(t2.order_id) as qntd,
        SUM(t3.price) as valor_total

    FROM tb_customers as t1

    LEFT JOIN tb_orders as t2
    ON t1.customer_id = t2.customer_id

    LEFT JOIN tb_order_items as t3
    ON t2.order_id = t3.order_id

    LEFT JOIN tb_products as t4
    ON t3.product_id = t4.product_id

    GROUP BY 1, 2
    order by qntd desc
),

rankeamento as(
    SELECT
        *,
        row_number() OVER(PARTITION BY customer_unique_id ORDER BY qntd DESC, valor_total DESC) as ranking
    FROM customers
)

SELECT
    *
FROM rankeamento

WHERE ranking = 1



--Querys de apoio 
-- tb_customers: customer_id, customer_unique_id,  
-- tb_orders: customer_id, order_id
-- tb_order_items: order_id, product_id, price
-- tb_products: product_id, product_category_name

SELECT
    *
FROM tb_customers

SELECT
    *
FROM tb_orders