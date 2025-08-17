/*

Monte a seguinte tabela:
| mes_referencia | seller_id | mes_primeira_venda | valor_venda |
| 2016-09-01 | 0015a82c2 | 2017-09-01 | 0 |
| 2017-09-01 | 0015a82c2 | 2017-09-01 | 895.0 |

*/

--tb_sellers seller_id  seller_zip_code_prefix	 seller_city	 seller_state
-- tb_order_items order_id	order_item_id	product_id	seller_id	shipping_limit_date	price	freight_value
-- tb_orders order_id	customer_id	order_status	order_purchase_timestamp	order_approved_at	
--  order_delivered_carrier_date	order_delivered_customer_date	

-- tb_order_items order_id seller_id
--tb_sellers: seller_id 
-- tb_orders: order_id order_purchase_timestamp


-- RESOLUÇÃO 
WITH meses as (
    SELECT
        DISTINCT
        STRFTIME('%Y-%m-01', order_approved_at) as mes_referencia,
        1 AS KEY
    FROM tb_orders

    WHERE mes_referencia IS NOT NULL
    ORDER BY 1 ASC
),
sellers as (
    SELECT
        t1.seller_id,
        min(STRFTIME('%Y-%m-01', t2.order_approved_at)) as mes_primeira_venda,
        1 AS KEY
    FROM tb_order_items AS t1

    LEFT JOIN tb_orders AS t2
    ON t1.order_id = t2.order_id

    GROUP BY 1
),

cruzamento AS(

    SELECT
        t1.mes_referencia,
        t2.seller_id,
        t2.mes_primeira_venda
    FROM meses as t1

    LEFT JOIN sellers AS t2 
    on t1.KEY = t2.KEY

    ORDER BY seller_id, mes_referencia ASC
),

vendas AS (
    SELECT
        seller_id,
        STRFTIME('%Y-%m-01', t2.order_approved_at) as mes_venda,
        SUM(price) + SUM(freight_value) as valor_venda
    FROM tb_order_items AS t1

    LEFT JOIN tb_orders AS t2
    ON t1.order_id = t2.order_id

    GROUP BY 1, 2
)

SELECT
    t1.mes_referencia,
    t1.seller_id,
    t1.mes_primeira_venda,
    COALESCE(SUM(t2.valor_venda), 0) AS valor_venda
FROM cruzamento AS t1

LEFT JOIN vendas AS t2
ON t1.seller_id = t2.seller_id AND t1.mes_referencia = t2.mes_venda

GROUP BY 1, 2, 3

ORDER BY t1.seller_id, t1.mes_referencia