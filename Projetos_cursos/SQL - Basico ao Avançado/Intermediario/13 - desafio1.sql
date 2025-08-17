/* 
DESAFIO: Montar uma tabela com Seller ID = 024b564ae893ce8e9bfa02c10a401ece, seller state = sp,
    qntd_pedidos 2, vendas_totais = 706.4, frete 212.0 , total_pedido 918.4, credit_card 293.2, 
    boleto 625.2, voucher 0, debit_card 0
024b564ae893ce8e9bfa02c10a401ece
*/

SELECT * FROM tb_order_payments
SELECT * FROM tb_orders LIMIT 10
SELECT * FROM tb_order_items LIMIT 10
SELECT * FROM tb_sellers WHERE seller_id = '024b564ae893ce8e9bfa02c10a401ece'
ad1aeeb1a99c9f021e38a49865bb812c
-- tb_order_payments: payment_value payment_type(credit_card, boleto, voucher, debit_card)

WITH tipos_de_pagamento AS (
    SELECT
        order_id,
        CASE WHEN payment_type = 'credit_card' THEN payment_value ELSE 0 END AS credit_card,
        CASE WHEN payment_type = 'boleto' THEN payment_value ELSE 0 END AS boleto,
        CASE WHEN payment_type = 'voucher' THEN payment_value ELSE 0 END AS voucher,
        CASE WHEN payment_type = 'debit_card' THEN payment_value ELSE 0 END AS debit_card
    FROM tb_order_payments
)

SELECT 
    t1.seller_id,
    t1.seller_state,
    COUNT(DISTINCT(t4.order_id)) as qntd_pedidos,
    SUM(t2.price) as vendas_totais,
    SUM(t2.freight_value) as frete,
    SUM(t2.price + t2.freight_value) as total_pedido,
    t5.credit_card,
    t5.boleto,
    t5.voucher,
    t5.debit_card
FROM tb_sellers as t1

LEFT JOIN tb_order_items as t2
ON t1.seller_id = t2.seller_id

LEFT JOIN tb_orders as t3
on t2.order_id = t3.order_id

LEFT JOIN tb_order_payments as t4
on t3.order_id = t4.order_id

LEFT JOIN tipos_de_pagamento as t5
ON t4.order_id = t5.order_id

--WHERE t1.seller_id = '024b564ae893ce8e9bfa02c10a401ece'
GROUP BY t1.seller_id

--  Resultado do curso ******
WITH sellers as (
    SELECT
        seller_id,
        seller_state
    FROM tb_sellers
),

pedidos as (
    SELECT
        seller_id,
        order_id,
        COUNT(DISTINCT(order_id)) as qntd_pedidos,
        SUM(price) as vendas_totais,
        SUM(freight_value) as frete,
        SUM(price + freight_value) as total_pedido    
    FROM tb_order_items

    GROUP BY 1, 2
),

tipos_de_pagamento as (
    SELECT
        order_id,
        CASE WHEN payment_type = 'credit_card' THEN payment_value END AS credit_card,
        CASE WHEN payment_type = 'boleto' THEN payment_value END AS boleto,
        CASE WHEN payment_type = 'voucher' THEN payment_value END AS voucher,
        CASE WHEN payment_type = 'debit_card' THEN payment_value END AS debit_card
    FROM tb_order_payments

    GROUP BY order_id
)

SELECT
    t1.seller_id,
    t1.seller_state,
    SUM(t2.qntd_pedidos) as qntd_pedidos,
    SUM(t2.frete) as frete,
    SUM(t2.total_pedido) as total_pedido,
    COALESCE(SUM(t3.credit_card), 0) as credit_card,
    COALESCE(SUM(t3.boleto), 0) as boleto,
    COALESCE(SUM(t3.voucher), 0) as voucher,
    COALESCE(SUM(t3.debit_card), 0) as debit_card
FROM sellers as t1

LEFT JOIN pedidos as t2
ON t1.seller_id = t2.seller_id

LEFT JOIN tipos_de_pagamento as t3
ON t2.order_id = t3.order_id

GROUP BY 1, 2
