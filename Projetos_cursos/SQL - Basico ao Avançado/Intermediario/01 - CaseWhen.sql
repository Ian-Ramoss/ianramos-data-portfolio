SELECT
    distinct -- para não duplicar os nulos
    CASE -- semelhante ao IF do excel/programação
        WHEN product_category_name LIKE '%construcao%' THEN 'construcao'
        WHEN product_category_name LIKE '%fashion%' THEN 'fashion'
        WHEN product_category_name LIKE '%moveis%' THEN 'moveis'      
        WHEN product_category_name LIKE '%casa%' THEN 'casa'        
        WHEN product_category_name LIKE '%telefonia%' THEN 'telefonia'        
        WHEN product_category_name is null THEN 'Produto sem categoria'        
    ELSE product_category_name -- posso setar um nome diferente os demais tbm, exemplo: Else 'Não classificado'
    END as categorias_tratadas
FROM tb_products

ORDER BY 1


-- OUTRO EXEMPLO
-- ruim = 1 ou 2
-- neutra = 3
-- Boa = 4 ou 5


SELECT
    distinct
    review_id,
    review_score,
    count(review_id) as contagem,
    CASE
        WHEN review_score < 3 THEN 'Ruim'
        WHEN review_score = 3 THEN 'Neutro'
        WHEN review_score > 3 THEN 'Bom'
    ELSE 'Sem score'
    END as reviews_quali
FROM tb_order_reviews

GROUP BY reviews_quali


/*
As empresas coletam o NPS dos clientes.
NPS - Net Promoter Score (nota de 0 a 10 que os clientes dão para os produtos - formulário se está
satisfeito, se indicaria etc)
Essa nota é separada em uma classificação qualitativa:

Detrator - 0 a 6 ( clientes q n gostaram e n recomendariam)
NEUTRO - 7 e 8
Promotor - 9 e 10

Após coletar, é feita uma conta que é a quantidade de clientes promotores menos detratores divididos
pelo total de clientes que responderam a pesquisa que é igual ao NPS
*/

-- ATIVIDADE CASE WHEN
/*
    Utilizando a tabela tb_sellers, crie um campo com o nome inteiro do estado, ex:
        a. SP -> São Paulo
        b. MG -> Minas Gerais
    e assim por diante...
*/

SELECT
    seller_state
FROM tb_sellers

GROUP BY seller_state


SELECT
    *,
    CASE
        WHEN seller_state = 'AC' THEN 'Acre'
        WHEN seller_state = 'AM' THEN 'Amazonas'
        WHEN seller_state = 'BA' THEN 'Bahia'
        WHEN seller_state = 'CE' THEN 'Ceará'
        WHEN seller_state = 'DF' THEN 'Distrito Federal'
        WHEN seller_state = 'ES' THEN 'Espirito Santo'
        WHEN seller_state = 'GO' THEN 'Goiás'
        WHEN seller_state = 'MA' THEN 'Maranhão'
        WHEN seller_state = 'MG' THEN 'Minas Gerais'
        WHEN seller_state = 'MS' THEN 'Mato Grosso do Sul'
        WHEN seller_state = 'MT' THEN 'Mato Grosso'
        WHEN seller_state = 'PA' THEN 'Pará'
        WHEN seller_state = 'PB' THEN 'Paraíba'
        WHEN seller_state = 'PE' THEN 'Pernambuco'
        WHEN seller_state = 'PI' THEN 'Piauí'
        WHEN seller_state = 'PR' THEN 'Paraná'
        WHEN seller_state = 'RJ' THEN 'Rio de Janeiro'
        WHEN seller_state = 'RN' THEN 'Rio Grande do norte'
        WHEN seller_state = 'RO' THEN 'Rondônia'
        WHEN seller_state = 'RS' THEN 'Rio Grande do Sul'
        WHEN seller_state = 'SC' THEN 'Santa Catarina'
        WHEN seller_state = 'SE' THEN 'Sergipe'
        WHEN seller_state = 'SP' THEN 'São Paulo'
    ELSE 'SEM CLASSIFICAÇÃO'
    END as Estado_classificado
FROM tb_sellers

GROUP BY Estado_classificado