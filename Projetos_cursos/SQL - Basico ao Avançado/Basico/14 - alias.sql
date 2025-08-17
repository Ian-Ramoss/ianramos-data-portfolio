/* O conceito de alias serve para renomear as colunas e/ou tabelas (muito utilizando com joins, várias tabelas,
    evitando conflitos com tabelas contendo colunas com nomes iguais)
    para isso, usamos o "AS"
*/

SELECT
    product_id as id_produto,
    product_category_name as categoria_produto
FROM tb_products

SELECT
    count(product_id) as contagem_produtos
FROM tb_products