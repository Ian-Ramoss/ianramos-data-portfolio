/*
CAST  tranforma variáveis pelo tipo dela:
inteiras (int64) em float(float64), float em data(date) e vice versa
CAST(variável as tipo)
*/

SELECT
    product_id,
    CAST((product_height_cm * product_width_cm) / 7 as int64)
FROM tb_products


/*
ROUND serve para arredondar os números
round(campo, qntd de casas decimais)
*/


SELECT
    product_id,
    ROUND((product_height_cm * product_width_cm) / 7, 2)
FROM tb_products