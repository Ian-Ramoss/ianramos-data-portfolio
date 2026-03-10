-- Fraude acumulada no período

SELECT
    step,
    data_simulada,
    hora_do_dia,
    ROUND(SUM(amount), 2) as fraude_no_periodo,
    ROUND(SUM(SUM(amount))OVER (ORDER BY step), 2) as fraude_acumulada
FROM paysim_clean
WHERE isFraud = 1
AND isFlaggedFraud = 0
GROUP BY step, data_simulada, hora_do_dia
ORDER BY step
