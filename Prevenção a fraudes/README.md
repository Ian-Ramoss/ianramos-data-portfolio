# Análise de Detecção de Fraudes — PaySim

## Sobre o Projeto
Este projeto foi desenvolvido como parte do meu processo de estudos 
para Analytics, com foco em fraude financeira — área onde atuei 
profissionalmente por 2 anos. O objetivo foi aplicar SQL e Power BI em um 
problema real de detecção de fraudes usando o dataset PaySim.

## Problema de Negócio
Um sistema de pagamentos mobile processa 6,3 milhões de transações 
por mês. O modelo atual de detecção de fraudes falha em identificar 
99,8% das fraudes reais, resultando em R$ 11,98 bilhões em prejuízo 
não detectado.

## Perguntas Respondidas
- Qual o volume total de fraudes não detectadas?
- Qual tipo de transação concentra o prejuízo?
- Quantos clientes legítimos foram bloqueados por engano?
- Como o prejuízo evoluiu ao longo do mês?

## Principais Descobertas
- 8.181 de 8.197 fraudes reais passaram sem detecção (99,8%)
- 100% do prejuízo concentrado em Transferência e Saque
- Ticket médio de fraude é 8x maior que transações legítimas - Ou seja, valores bem altos
- 0 falsos positivos — sistema ultra-conservador, mas sacrifica detecção

## Tecnologias
- Databricks Community Edition (SQL)
- Power BI Desktop
- Dataset: PaySim (Kaggle)

## Dashboard
![Preview do Dashboard](imagens/dashboard.png)

O arquivo `.pbix` está disponível na pasta `/dashboard` para visualização local no Power BI Desktop.

## Aprendizados Técnicos
- Arquitetura Medallion (Bronze → Silver → Gold) para organização de dados
- Window Functions na prática (SUM OVER) para cálculo de métricas acumuladas
- Matriz de Confusão aplicada à avaliação de modelos de detecção
- Databricks como camada de processamento e armazenamento distribuído de dados (Lakehouse)
- DATE_ADD para criação de datas simuladas no projeto, pois a base contém apenas STEP

## Como Reproduzir
1. Baixar o dataset PaySim no Kaggle (~500MB)
2. Criar conta gratuita no Databricks Community Edition
3. Fazer upload do CSV e registrar como tabela `paysim_raw`
4. Executar os notebooks na ordem: Ingestão → Limpeza → Análise Exploratória → Fraude Acumulada
5. Importar os CSVs exportados no Power BI Desktop
6. Construir os gráficos com base no objetivo