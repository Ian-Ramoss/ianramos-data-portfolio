/*
 O JOIN serve para cruzar várias tabelas

********O LEFT JOIN seta a tabela inicial como referência, ou seja Tabela 1 com a Tabela 2; 
        Pega a tabela 1 e adiciona o conteúdo que quer da tabela 2 na tabela 1

********O RIGHT JOIN funciona igual ao left, mas a referência é a tabela 2 (da direita);
        Pega a tabela 2 e adiciona o conteúdo que quer da tabela 1 na tabela 2.

        o Right join é pouco usado pq para ter o mesmo resultado, basta mudar a ordem da tabela no 
        left join (da 2 pra 1) e pronto.

********INNER JOIN - Puxa todas as informações que são iguais nas tabelas (junta tudo que tem nas duas
        em uma só)

*/

-- exemplo com tb_products e tb_order_items
-- a primeira tabela do from é a da esquerda e a após o join é a da direita
--sintaxe: 1- puxe o que ta dentro do select da tabela 1
SELECT
    t1.product_id as id_do_produto,
    t1.product_category_name as categoria_do_produto,
    t2.price
FROM tb_products AS t1

-- o join vem logo abaixo do from
--sintaxe: 2- cruze com a tabela 2
LEFT JOIN tb_order_items as t2
--sintaxe: 3- onde a coluna determinada da tabela 1 (PRimary key) seja igual À coluna determinada na tabela 2
ON t1.product_id = t2.product_id


SELECT
    t1.seller_id,
    SUM(t2.price) as total
FROM tb_sellers as t1

LEFT JOIN tb_order_items as t2
ON t1.seller_id = t2.seller_id

GROUP BY t1.seller_id

-- para identificar um vendedor que ta na tb_sellers mas nao ta na tb_order_items,
-- bastaria usar o Having

Having total is null

-- outro exemplo INNER JOIN (vai pegar o que existe nas 2 tabelas, desconsiderando nulos)
SELECT
    t1.order_id,
    t1.order_status,
    t2.payment_type
FROM tb_orders as t1

INNER JOIN tb_order_payments as t2
ON t1.order_id = t2.order_id



-- **************** Mais de 2 tabelas

SELECT
    t2.customer_state,
    sum(t3.price) as valor_total
FROM tb_orders as t1

LEFT JOIN tb_customers as t2
ON t1.customer_id = t2.customer_id

LEFT JOIN tb_order_items as t3
on t1.order_id = t3.order_id

GROUP BY t2.customer_state

ORDER BY valor_total desc

-- MAIS de 2 tabelas - outro exemplo

SELECT
    t1.seller_state,
    sum(t2.price) as valor_total

FROM tb_sellers as t1

LEFT join tb_order_items as t2
on t1.seller_id = t2.seller_id

LEFT JOIN tb_orders as t3
on t2.order_id = t3.order_id

where t3.order_status = 'delivered'

GROUP BY 1

ORDER BY 2