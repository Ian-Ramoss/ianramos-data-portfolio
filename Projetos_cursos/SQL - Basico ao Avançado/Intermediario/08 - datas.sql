-- STRFTIME(identificador do campo de data que queremos, coluna)
-- é possível alterar o campo também (ao invés de %d, digitar 01) ou especificar se quer só mês, ano ou dia 
SELECT
    order_id,
    STRFTIME('%Y-%m-%d',order_approved_at) as date
FROM tb_orders