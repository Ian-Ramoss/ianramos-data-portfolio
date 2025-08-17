SELECT
    count(distinct(order_id)) as contagem_unica,
    count(order_id) as contagem_total
FROM tb_order_items

/* As linhas no order_id são duplicadas pq uma pessoa pode ter feito em uma única compra (mesmo order id)
    1 ou mais pedidos/produtos e em caso de mais pedidos, o order id se repete baseado nisso. */