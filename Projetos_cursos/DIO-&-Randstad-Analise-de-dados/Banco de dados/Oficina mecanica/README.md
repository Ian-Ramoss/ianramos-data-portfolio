# 🛠️ Projeto: Esquema Lógico de Banco de Dados para Oficina Mecânica

## 📌 Descrição do Projeto

Este projeto apresenta a modelagem lógica de um banco de dados para o contexto de uma **oficina mecânica**, partindo do modelo conceitual (ER) até a implementação física no banco de dados.

O objetivo é aplicar corretamente os conceitos de:
- Chaves primárias e estrangeiras  
- Relacionamentos 1:N e N:M  
- Restrições de integridade  
- Atributos derivados  
- Consultas SQL com filtros, agregações, junções, ordenações e subqueries  

Além disso, o projeto inclui:
- Script SQL de criação do esquema  
- Inserção de dados para testes  
- Consultas SQL mais complexas, conforme solicitado no desafio  

---

## 🧱 Modelo Lógico (Descrição)

### Entidades principais:
- **Cliente**: Pessoa que leva o veículo à oficina.
- **Veículo**: Veículo pertencente a um cliente.
- **Ordem_Servico**: Registro de atendimento do veículo.
- **Servico**: Tipo de serviço realizado (ex.: troca de óleo, alinhamento).
- **Mecanico**: Funcionário responsável por executar os serviços.
- **Pagamento**: Forma de pagamento associada a uma ordem de serviço.

### Relacionamentos:
- Um cliente pode possuir vários veículos.
- Um veículo pode ter várias ordens de serviço.
- Uma ordem de serviço pode conter vários serviços.
- Um serviço pode ser realizado em várias ordens de serviço (N:M).
- Um mecânico pode executar vários serviços.
- Cada ordem de serviço pode ter um ou mais pagamentos.

---

## 🗄️ Script SQL – Criação do Esquema

```sql
-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    id_veiculo INT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(100),
    ano INT,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Mecânico
CREATE TABLE Mecanico (
    id_mecanico INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);

-- Tabela Ordem de Serviço
CREATE TABLE Ordem_Servico (
    id_ordem INT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_mecanico INT NOT NULL,
    data_abertura DATE NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico)
);

-- Tabela Serviço
CREATE TABLE Servico (
    id_servico INT PRIMARY KEY,
    descricao VARCHAR(150) NOT NULL,
    valor DECIMAL(10,2) NOT NULL
);

-- Relacionamento N:M entre Ordem de Serviço e Serviço
CREATE TABLE Ordem_Servico_Servico (
    id_ordem INT,
    id_servico INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_ordem, id_servico),
    FOREIGN KEY (id_ordem) REFERENCES Ordem_Servico(id_ordem),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY,
    id_ordem INT NOT NULL,
    forma_pagamento VARCHAR(50),
    valor DECIMAL(10,2),
    data_pagamento DATE,
    FOREIGN KEY (id_ordem) REFERENCES Ordem_Servico(id_ordem)
);
```

## 🧪 Inserção de Dados para Testes

```sql
-- Clientes
INSERT INTO Cliente VALUES
(1, 'João Silva', '11999999999', 'joao@email.com'),
(2, 'Maria Souza', '11888888888', 'maria@email.com');

-- Veículos
INSERT INTO Veiculo VALUES
(1, 'ABC1D23', 'Toyota Corolla', 2018, 1),
(2, 'XYZ9Z99', 'Honda Civic', 2020, 2);

-- Mecânicos
INSERT INTO Mecanico VALUES
(1, 'Carlos Mecânico', 'Motor'),
(2, 'Ana Técnica', 'Suspensão');

-- Serviços
INSERT INTO Servico VALUES
(1, 'Troca de óleo', 150.00),
(2, 'Alinhamento', 120.00),
(3, 'Revisão completa', 500.00);

-- Ordens de Serviço
INSERT INTO Ordem_Servico VALUES
(1, 1, 1, '2024-01-10', 'Finalizada'),
(2, 2, 2, '2024-01-12', 'Em andamento');

-- Serviços realizados nas ordens
INSERT INTO Ordem_Servico_Servico VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1);

-- Pagamentos
INSERT INTO Pagamento VALUES
(1, 1, 'Cartão', 270.00, '2024-01-10'),
(2, 2, 'Pix', 500.00, '2024-01-12');

```
## 🔍 Queries SQL

```sql

-- 1. Recuperação simples com SELECT
SELECT * FROM Cliente;

-- 2. Filtro com WHERE
SELECT * FROM Veiculo
WHERE ano > 2019;

-- 3. Atributo derivado (valor total por serviço na ordem)
SELECT 
    oss.id_ordem,
    s.descricao,
    oss.quantidade,
    s.valor,
    oss.quantidade * s.valor AS valor_total_servico
FROM Ordem_Servico_Servico oss
JOIN Servico s ON oss.id_servico = s.id_servico;

-- 4. Ordenação com ORDER BY
SELECT nome, especialidade
FROM Mecanico
ORDER BY nome ASC;

-- 5. Agrupamento com HAVING
SELECT 
    os.id_ordem,
    SUM(oss.quantidade * s.valor) AS total_ordem
FROM Ordem_Servico os
JOIN Ordem_Servico_Servico oss ON os.id_ordem = oss.id_ordem
JOIN Servico s ON oss.id_servico = s.id_servico
GROUP BY os.id_ordem
HAVING SUM(oss.quantidade * s.valor) > 300;

-- 6. Junções entre várias tabelas
SELECT 
    c.nome AS cliente,
    v.modelo AS veiculo,
    os.id_ordem,
    os.status,
    m.nome AS mecanico
FROM Ordem_Servico os
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
JOIN Cliente c ON v.id_cliente = c.id_cliente
JOIN Mecanico m ON os.id_mecanico = m.id_mecanico;

-- 7. Subquery: Ordens com valor acima da média
SELECT *
FROM Ordem_Servico os
WHERE os.id_ordem IN (
    SELECT os2.id_ordem
    FROM Ordem_Servico os2
    JOIN Ordem_Servico_Servico oss ON os2.id_ordem = oss.id_ordem
    JOIN Servico s ON oss.id_servico = s.id_servico
    GROUP BY os2.id_ordem
    HAVING SUM(oss.quantidade * s.valor) > (
        SELECT AVG(total_ordem)
        FROM (
            SELECT SUM(oss2.quantidade * s2.valor) AS total_ordem
            FROM Ordem_Servico_Servico oss2
            JOIN Servico s2 ON oss2.id_servico = s2.id_servico
            GROUP BY oss2.id_ordem
        ) AS sub
    )
);

```
