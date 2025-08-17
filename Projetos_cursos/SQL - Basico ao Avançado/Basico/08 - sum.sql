SELECT
    order_id,
    count(product_id) as produtos_vendidos, -- contagem de produtos vendidos por pedido
    SUM(price) as valor_total,
    SUM(price) / count(product_id) as tkt_medio -- não é possível usar o nome de uma coluna nova em alguns editores de código. Ideal fazer dessa forma
FROM tb_order_items

GROUP BY order_id -- group by sempre depois do where


-- ATIVIDADE SUM

/* 
1 - UTILIZANDO A TABELA tb_order_payments, calcule o valor total
vendido por cartão de crédito, boleto, débito e não definido.

2 - Ainda utilizando a tabela tb_order_payments, calcule quantas 
parcelas totais foram utilizadas na categoria cartão de crédito e 
também calcule o valor médio de cada parcela.
*/

SELECT
    *
FROM tb_order_payments
LIMIT 100

-- para descobrir quais os tipos de pagamento, usar o distinct 
SELECT
    distinct(payment_type)
FROM tb_order_payments

-- 1
SELECT
    order_id,
    payment_type,
    SUM(payment_value) as valor_total
FROM tb_order_payments

GROUP BY payment_type

-- caso necessário filtrar, usar o where
SELECT
    order_id,
    payment_type,
    SUM(payment_value) as valor_total
FROM tb_order_payments

WHERE payment_type	= 'credit_card'

GROUP BY payment_type


-- 2
SELECT
    order_id,
    payment_type,
    SUM(payment_installments) as parcelas_totais,
    SUM(payment_value) as valor_total,
    SUM(payment_value) / SUM(payment_installments) as tkt_medio_parcelas
FROM tb_order_payments

WHERE payment_type = 'credit_card'