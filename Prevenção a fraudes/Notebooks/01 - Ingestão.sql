-- Tabela já criada via upload. Verificações abaixo:

-- Verifica se chegou completo
SELECT COUNT(*) as total_linhas FROM paysim_raw;

-- Verifica se tem nulos em colunas críticas
SELECT 
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) as nulos_amount,
    SUM(CASE WHEN isFraud IS NULL THEN 1 ELSE 0 END) as nulos_isfraud,
    SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) as nulos_type
FROM paysim_raw;