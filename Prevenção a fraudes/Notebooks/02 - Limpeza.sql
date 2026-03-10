CREATE OR REPLACE TABLE paysim_clean AS
SELECT
    step,
    -- converte step em data simulada a partir de 01/01/2026
    DATE_ADD('2026-01-01', CAST((step - 1) / 24 AS INT)) as data_simulada,
    -- extrai a hora do dia
    MOD(step - 1, 24) as hora_do_dia,
    type,
    ROUND(amount, 2) as amount,
    nameOrig,
    ROUND(oldbalanceOrg, 2) as saldo_antes_origem,
    ROUND(newbalanceOrig, 2) as saldo_depois_origem,
    nameDest,
    ROUND(oldbalanceDest, 2) as saldo_antes_destino,
    ROUND(newbalanceDest, 2) as saldo_depois_destino,
    isFraud,
    isFlaggedFraud,
    -- coluna nova: conta zerada após transação?
    CASE 
        WHEN newbalanceOrig = 0 AND oldbalanceOrg > 0 THEN 1 
        ELSE 0 
    END as conta_zerada
-- Renomeei colunas para português, arredondei valores, e já criei uma coluna derivada (`conta_zerada`) que vai facilitar todas as análises futuras.
FROM paysim_raw
WHERE amount > 0  -- remove transações com valor zero que não fazem sentido

