SELECT
    seller_state,
    count(distinct(seller_city)) as cidades_por_estado,
    count(seller_city) as qntd_total
FROM tb_sellers

group by seller_state


-- GROUP BY 2

SELECT
    order_id,
    count(product_id) as qntd_produtos
FROM tb_order_items

GROUP BY order_id -- é possível colocar qual o nº da coluna: GROUP BY 1 
