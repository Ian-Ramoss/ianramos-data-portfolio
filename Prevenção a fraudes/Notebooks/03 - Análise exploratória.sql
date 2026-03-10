-- Qtd de fraudes
SELECT COUNT(*) as total_fraudes 
FROM paysim_clean 
WHERE isFraud = 1

-- Matriz de confusão: Falso positivo e falso negativo - utilizada no Power BI
WITH falso_negativo AS(
      SELECT 
        count(*) as falso_negativo
      FROM paysim_clean
      WHERE isFraud = 1
      AND isFlaggedFraud = 0
),
falsos_positivos AS (
  SELECT 
      count(*) as falso_positivo
  FROM paysim_clean
  WHERE isFraud = 0
  AND isFlaggedFraud = 1
),
fraud AS (
  SELECT 
      count(*) as verdadeiro_positivo
  FROM paysim_clean
  WHERE isFraud = 1
  AND isFlaggedFraud = 1
),
transacoes_ok AS (
  SELECT 
      count(*) as verdadeiro_negativo
  FROM paysim_clean
  WHERE isFraud = 0
  AND isFlaggedFraud = 0
),
total AS (
  SELECT 
      count(*) as total
  FROM paysim_clean
)
SELECT *
FROM falso_negativo, falsos_positivos, fraud, total, transacoes_ok


-- Fraude (prejuízo) por tipo de transação - utilizada no Power BI
SELECT
    type,
    COUNT(*) as total_transacoes,
    SUM(isFraud) as total_fraudes,
    ROUND(SUM(CASE WHEN isFraud = 1 
                    AND isFlaggedFraud = 0 THEN amount 
                    ELSE 0 END), 2) as prejuizo_real,
    ROUND(SUM(isFraud) * 100.0 / COUNT(*), 2) as taxa_fraudes
FROM paysim_clean
GROUP BY type
ORDER BY prejuizo_real DESC

-- Média, menor e maior valor fraudado vs legitimo
SELECT 
    isFraud,
    ROUND(AVG(amount), 2) as ticket_medio,
    ROUND(MIN(amount), 2) as menor_valor,
    ROUND(MAX(amount), 2) as maior_valor
FROM paysim_clean
GROUP BY isFraud


-- Valor de fraude perdido (não flaggado) 
SELECT
    SUM(amount) as valor_perdido,
    COUNT(*) as qtd_perdido
FROM paysim_clean
WHERE isFraud = 1
AND isFlaggedFraud = 0