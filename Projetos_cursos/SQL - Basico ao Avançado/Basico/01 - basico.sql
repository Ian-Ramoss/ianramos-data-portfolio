SELECT
    *
FROM tb_products

WHERE product_category_name = 'perfumaria'


/* Exercícios com WHERE:
/*
    Utilizando a tabela tb_orders, filtre todos os pedidos
    que foram entregues
*/
SELECT
    *
FROM tb_orders

WHERE order_status = 'delivered'

/*Se fosse só para retornar os IDs dos que foram entregues:*/
SELECT
    order_id
FROM tb_orders

WHERE order_status = 'delivered'


/*
    Utilizando a tabela tb_customers, filtre todos os clientes
    que são de SP
*/

SELECT
    *
FROM tb_customers

WHERE customer_state = 'SP'


/*
    Utilizando a tabela tb_order_payments, filtre todos os pagamentos
    por cartão de crédito.
*/

SELECT
    *
FROM tb_order_payments

WHERE payment_type = 'credit_card'


/*********************************/

/*
OPERADOR AND
*/

SELECT 
    *
from tb_order_payments

WHERE payment_installments <= 3 
AND payment_type = 'credit_card'
AND payment_value >= 100

/*Exercícios com WHERE e AND: */

SELECT
    *
FROM tb_products

WHERE product_category_name = 'perfumaria'
AND  product_weight_g > 100



SELECT
    *
FROM tb_order_items

WHERE price > 50

AND freight_value < 15

/*********************************/

/*
OPERADOR OR
*/

/*
    Utilizando a tabela tb_customers, filtre todos os clientes de SP e RJ
*/
SELECT
    *
FROM tb_customers

WHERE customer_state = 'SP'
OR customer_state = 'RJ'


/*
    Utilizando a tabela tb_order_reviews, filtre todos os pedidos que tiveram um 
    review_score de 4 ou 5
*/

SELECT
    *
FROM tb_order_reviews

WHERE review_score = 4
OR review_score = 5


/*********************************/

/*TRABALHANDO COM OR E AND JUNTOS */

SELECT
    *
from tb_order_payments

WHERE payment_value > 100 
AND (payment_type = 'boleto' or payment_type = 'voucher')


SELECT
    *
from tb_products

WHERE (product_category_name = 'perfumaria' OR product_category_name = 'artes')
AND product_weight_g >= 600

/*********************************/

/*OPERADOR IN*/

/*MELHOR OPÇÃO PARA NÃO FICAR REPETINDO CÓDIGO, como "and" e "or" */
SELECT
    *
from tb_products

WHERE product_category_name in ('perfumaria', 'artes')

/* com in...
    Utilizando a tabela tb_customers, filtre todos os clientes de SP e RJ
*/

SELECT
    *
FROM tb_customers

WHERE customer_state in ('SP', 'RJ')

/* com in...
    Utilizando a tabela tb_order_reviews, filtre todos os pedidos que tiveram um 
    review_score de 3, 4 ou 5
*/

SELECT
    *
FROM tb_order_reviews

WHERE review_score in (3, 4, 5)