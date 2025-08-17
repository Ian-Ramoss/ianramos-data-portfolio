/*
1- Quantos produtos temos da categoria artes?

2- Quantos produtos tem mais de 5 litros?

3- Quantos produtos de beleza_saude com menos de 1 litro?

4- Faça uma query que apresente o tamanho medio, máximo e mínimo da descrição do objeto
por categoria

5- Faça uma query que apresente o tamanho médio, máximo e mínimo da descrição do objeto
por categoria, considere apenas os que tem a descrição maior que 100

6- Faça uma query que apresente o tamanho médio, máximo e mínimo da descrição do objeto
por categoria, considere apenas os que tem a descrição maior que 100 e com tamanho médio
maior que 500
*/

SELECT
    *
FROM tb_products

-- 1
SELECT
    COUNT(distinct(product_id)) as total_produtos_artes
FROM tb_products

WHERE product_category_name = 'artes'


-- 2 - cm * cm * cm = cm3; cm3 / 1000 = litros
SELECT
    product_id,
    (product_length_cm * product_height_cm * product_width_cm) / 1000 as volume_litros
FROM tb_products

WHERE (product_length_cm * product_height_cm * product_width_cm) / 1000 >= 5

-- 3
SELECT
    product_id,
    product_category_name,
    (product_length_cm * product_height_cm * product_width_cm) / 1000 as volume_litros
FROM tb_products

WHERE (product_length_cm * product_height_cm * product_width_cm) / 1000 <= 1 
AND product_category_name = 'beleza_saude'

-- 4
SELECT
    product_category_name,
    AVG(product_description_lenght) as tamanho_medio,
    MIN(product_description_lenght) AS tamanho_minimo,
    MAX(product_description_lenght) AS tamanho_maximo
FROM tb_products

WHERE product_category_name IS NOT NULL

GROUP BY product_category_name

ORDER BY product_category_name asc


-- 5- Faça uma query que apresente o tamanho médio, máximo e mínimo da descrição do objeto
-- por categoria, considere apenas os que tem a descrição maior que 100

SELECT
    product_category_name,
    product_description_lenght,
    AVG(product_description_lenght) as tamanho_medio,
    MIN(product_description_lenght) AS tamanho_minimo,
    MAX(product_description_lenght) AS tamanho_maximo
FROM tb_products

WHERE product_category_name IS NOT NULL 
AND product_description_lenght > 100

GROUP BY product_category_name

ORDER BY product_description_lenght asc


/* 

6- Faça uma query que apresente o tamanho médio, máximo e mínimo da descrição do objeto
por categoria, considere apenas os que tem a descrição maior que 100 e com tamanho médio
maior que 500

*/
-- opção 1 subquery

SELECT
    *
FROM (
    SELECT
        product_category_name,
        product_description_lenght,
        AVG(product_description_lenght) as tamanho_medio,
        MIN(product_description_lenght) AS tamanho_minimo,
        MAX(product_description_lenght) AS tamanho_maximo
    FROM tb_products

    WHERE product_category_name IS NOT NULL AND product_description_lenght > 100

    GROUP BY product_category_name

   -- ORDER BY product_description_lenght asc
)
WHERE tamanho_medio > 500

ORDER BY tamanho_medio asc

-- opção 2 HAVING -- melhor opção

SELECT
    product_category_name,
    product_description_lenght,
    AVG(product_description_lenght) as tamanho_medio,
    MIN(product_description_lenght) AS tamanho_minimo,
    MAX(product_description_lenght) AS tamanho_maximo
FROM tb_products

WHERE product_category_name IS NOT NULL AND product_description_lenght > 100

GROUP BY product_category_name

HAVING tamanho_medio > 500

ORDER BY tamanho_medio asc