/*
o CONCAT existe em muitos editores de código e é responsável por concatenar 2 colunas
    concat(coluna 1, coluna 2)

    No VSCODe é possível fazer com ||:
    coluna 1 || coluna 2
    
    e se precisar colocar um separador no meio:
    coluna 1 || '-' || coluna 
*/
SELECT
    order_id || '-' || order_status
FROM tb_orders