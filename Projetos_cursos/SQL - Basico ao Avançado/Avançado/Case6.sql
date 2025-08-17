/*

DE acordo com o resultado da tabela gerada no Case 5, crie uma coluna a mais que indique
o seguinte:

1 - Quanto o seller ainda não havia feito nenhuma venda no mês referência, classifique ele
como Prior Entry;
2 - No mês da primeira venda dele, classifique-o como Novo;
3 - Nos meses posteriores a primeira venda, caso ele continue vendendo, classifique-o como
Regular;
4 - Após as primeiras vendas, caso ele fique um ou mais meses sem fazer vendas,
classifique-o como Churn;
5 - Caso ele tenha sido classificado como churn e, no próximo mês ele volte a fazer uma venda,
classifique-o como Recuperado.

*/

-- Minha resolução
WITH meses as (
    SELECT
        DISTINCT
        STRFTIME('%Y-%m-01', order_approved_at) as mes_referencia,
        1 AS KEY
    FROM tb_orders

    WHERE mes_referencia IS NOT NULL
    ORDER BY 1 ASC
),
sellers as (
    SELECT
        t1.seller_id,
        min(STRFTIME('%Y-%m-01', t2.order_approved_at)) as mes_primeira_venda,
        1 AS KEY
    FROM tb_order_items AS t1

    LEFT JOIN tb_orders AS t2
    ON t1.order_id = t2.order_id

    GROUP BY 1
),

cruzamento AS(

    SELECT
        t1.mes_referencia,
        t2.seller_id,
        t2.mes_primeira_venda
    FROM meses as t1

    LEFT JOIN sellers AS t2 
    on t1.KEY = t2.KEY

    ORDER BY seller_id, mes_referencia ASC
),

vendas AS (
    SELECT
        seller_id,
        STRFTIME('%Y-%m-01', t2.order_approved_at) as mes_venda,
        SUM(price) + SUM(freight_value) as valor_venda
    FROM tb_order_items AS t1

    LEFT JOIN tb_orders AS t2
    ON t1.order_id = t2.order_id

    GROUP BY 1, 2
),

case5 AS (
    SELECT
        t1.mes_referencia,
        t1.seller_id,
        t1.mes_primeira_venda,
        COALESCE(SUM(t2.valor_venda), 0) AS valor_venda
    FROM cruzamento AS t1

    LEFT JOIN vendas AS t2
    ON t1.seller_id = t2.seller_id AND t1.mes_referencia = t2.mes_venda

    GROUP BY 1, 2, 3

    ORDER BY t1.seller_id, t1.mes_referencia

)
SELECT 
    mes_referencia,
    seller_id,
    mes_primeira_venda,
    valor_venda,

    CASE 
        WHEN mes_referencia < mes_primeira_venda THEN 'Prior Entry'
        WHEN mes_referencia = mes_primeira_venda THEN 'Novo'
        WHEN mes_referencia > mes_primeira_venda AND valor_venda <> 0 AND LAG(valor_venda) OVER (PARTITION BY seller_id order BY mes_referencia) <> 0 THEN 'Regular'
        WHEN mes_referencia > mes_primeira_venda AND valor_venda = 0 THEN 'Churn'
        WHEN mes_referencia > mes_primeira_venda AND valor_venda <> 0 AND LAG(valor_venda) OVER (PARTITION BY seller_id order BY mes_referencia) = 0 THEN 'Recuperado'
    END AS classificacao
FROM case5

-- RESULTADO DO PROFESSOR (Continuação da query acima, removendo o último SELECT)
/*
),
ativo as (
    SELECT
        *,
        CASE
            WHEN valor_venda > 0 THEN 1
        ELSE 0
        END AS ativo
    from case5
),

ativo_lag as (
    SELECT
        *,
        LAG(ativo) OVER(PARTITION BY seller_id order BY mes_referencia) AS ativo_lag
    FROM ativo
)

SELECT
    *,
    CASE
        WHEN mes_primeira_venda > mes_referencia THEN 'Prior Entry'
        WHEN mes_referencia = mes_primeira_venda THEN 'Novo'
        WHEN ativo = 1 AND ativo_lag = 1 THEN 'Regular'
        WHEN ativo = 0 THEN 'Churn'
        WHEN ativo = 1 AND ativo_lag = 0 THEN 'Recuperado'
    END AS classificacao
FROM ativo_lag
*/