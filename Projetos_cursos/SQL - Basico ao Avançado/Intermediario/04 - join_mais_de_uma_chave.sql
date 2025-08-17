-- é possível adicionar mais chaves em um join utilizando "AND"

WITH data_limite as (
    SELECT
        order_id,
        STRFTIME('%Y-%m-%d', shipping_limit_date) as data_limite
    FROM tb_order_items
),

data_entrega as (
    SELECT
        order_id,
        STRFTIME('%Y-%m-%d',order_delivered_customer_date) as data_entrega
    FROM tb_orders
)

SELECT
    t1.order_id,
    t1.data_limite,
    t2.data_entrega
FROM data_limite as t1
LEFT JOIN data_entrega as t2
on t1.order_id = t2.order_id and t1.data_limite >= t2.data_entrega

WHERE t2.data_entrega is not null