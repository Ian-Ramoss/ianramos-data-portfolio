# 📦 Projeto: Modelagem Lógica de Banco de Dados para E-commerce

## 📌 Descrição

Este projeto apresenta a modelagem lógica de um banco de dados para um cenário de e-commerce, incluindo clientes pessoa física (PF) e pessoa jurídica (PJ), pedidos, pagamentos, entregas, produtos, fornecedores, vendedores e controle de estoque.

O objetivo é aplicar os conceitos de modelagem conceitual, lógica e relacional, respeitando:
- Chaves primárias e estrangeiras
- Constraints de integridade
- Relacionamentos 1:1, 1:N e N:M
- Especializações (PJ/PF)
- Regras de negócio como múltiplas formas de pagamento e status de entrega

Além disso, o projeto inclui:
- Script SQL de criação do esquema
- Inserção de dados para testes
- Queries SQL com filtros, junções, agregações, atributos derivados, ordenações e subqueries

---

## 🧱 Modelo Lógico (Descrição)

### Entidades principais:
- **Cliente** (especialização em PF ou PJ — nunca ambos)
- **Pedido**
- **Produto**
- **Fornecedor**
- **Vendedor**
- **Pagamento**
- **Entrega**
- **Estoque**

### Regras de negócio:
- Um cliente pode ser **PF ou PJ**, mas não os dois.
- Um pedido pode ter **mais de uma forma de pagamento**.
- Cada pedido possui **uma entrega**, com status e código de rastreio.
- Um fornecedor pode fornecer vários produtos.
- Um produto pode estar vinculado a vários fornecedores.
- Um vendedor pode ou não ser também fornecedor.

---

## 🗄️ Script SQL – Criação do Esquema

```sql
-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    tipo_cliente CHAR(2) CHECK (tipo_cliente IN ('PF', 'PJ')) NOT NULL
);

-- Cliente Pessoa Física
CREATE TABLE Cliente_PF (
    id_cliente INT PRIMARY KEY,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Cliente Pessoa Jurídica
CREATE TABLE Cliente_PJ (
    id_cliente INT PRIMARY KEY,
    cnpj CHAR(14) UNIQUE NOT NULL,
    razao_social VARCHAR(150),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY,
    id_pedido INT NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY,
    id_pedido INT UNIQUE NOT NULL,
    status_entrega VARCHAR(50) NOT NULL,
    codigo_rastreio VARCHAR(100),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- Tabela Produto
CREATE TABLE Produto (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE
);

-- Tabela Vendedor
CREATE TABLE Vendedor (
    id_vendedor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

-- Relacionamento Produto x Fornecedor (N:M)
CREATE TABLE Produto_Fornecedor (
    id_produto INT,
    id_fornecedor INT,
    PRIMARY KEY (id_produto, id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    id_estoque INT PRIMARY KEY,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    localizacao VARCHAR(100),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Itens do Pedido (N:M entre Pedido e Produto)
CREATE TABLE Item_Pedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Relacionamento Vendedor x Fornecedor (vendedor pode ser fornecedor)
CREATE TABLE Vendedor_Fornecedor (
    id_vendedor INT,
    id_fornecedor INT,
    PRIMARY KEY (id_vendedor, id_fornecedor),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);
```

## 📥 Inserção de Dados para Testes

```sql

-- Clientes
INSERT INTO Cliente VALUES
(1, 'João Silva', 'joao@email.com', '11999999999', 'PF'),
(2, 'Empresa Alpha Ltda', 'contato@alpha.com', '1133334444', 'PJ');

INSERT INTO Cliente_PF VALUES
(1, '12345678901', '1990-05-10');

INSERT INTO Cliente_PJ VALUES
(2, '12345678000199', 'Empresa Alpha Ltda');

-- Produtos
INSERT INTO Produto VALUES
(1, 'Notebook', 'Notebook i5, 16GB RAM', 4500.00),
(2, 'Mouse', 'Mouse sem fio', 80.00),
(3, 'Teclado', 'Teclado mecânico', 350.00);

-- Fornecedores
INSERT INTO Fornecedor VALUES
(1, 'Fornecedor Tech', '11111111000111'),
(2, 'Distribuidora Info', '22222222000122');

-- Vendedores
INSERT INTO Vendedor VALUES
(1, 'Carlos Vendas', 'carlos@vendas.com', '11988887777'),
(2, 'Ana Comercial', 'ana@comercial.com', '11977776666');

-- Produto x Fornecedor
INSERT INTO Produto_Fornecedor VALUES
(1, 1),
(2, 1),
(3, 2);

-- Estoque
INSERT INTO Estoque VALUES
(1, 1, 20, 'Depósito A'),
(2, 2, 100, 'Depósito B'),
(3, 3, 50, 'Depósito A');

-- Pedidos
INSERT INTO Pedido VALUES
(1, 1, '2024-01-10', 'Finalizado'),
(2, 2, '2024-01-12', 'Em processamento');

-- Itens do Pedido
INSERT INTO Item_Pedido VALUES
(1, 1, 1, 4500.00),
(1, 2, 2, 80.00),
(2, 3, 5, 350.00);

-- Pagamentos
INSERT INTO Pagamento VALUES
(1, 1, 'Cartão de Crédito', 3000.00),
(2, 1, 'Pix', 1660.00),
(3, 2, 'Boleto', 1750.00);

-- Entregas
INSERT INTO Entrega VALUES
(1, 1, 'Entregue', 'BR123456789'),
(2, 2, 'Em transporte', 'BR987654321');

-- Vendedor x Fornecedor
INSERT INTO Vendedor_Fornecedor VALUES
(1, 1);

```

## 🔍 Queries SQL

```sql

-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT c.nome, COUNT(p.id_pedido) AS total_pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.nome;

-- 2. Algum vendedor também é fornecedor?
SELECT v.nome AS vendedor, f.nome AS fornecedor
FROM Vendedor v
JOIN Vendedor_Fornecedor vf ON v.id_vendedor = vf.id_vendedor
JOIN Fornecedor f ON vf.id_fornecedor = f.id_fornecedor;

-- 3. Relação de produtos, fornecedores e estoque
SELECT 
    pr.nome AS produto,
    f.nome AS fornecedor,
    e.quantidade,
    e.localizacao
FROM Produto pr
JOIN Produto_Fornecedor pf ON pr.id_produto = pf.id_produto
JOIN Fornecedor f ON pf.id_fornecedor = f.id_fornecedor
JOIN Estoque e ON pr.id_produto = e.id_produto;

-- 4. Valor total por item de pedido (atributo derivado)
SELECT 
    id_pedido,
    id_produto,
    quantidade,
    preco_unitario,
    quantidade * preco_unitario AS valor_total_item
FROM Item_Pedido;

-- 5. Total gasto por cliente (com HAVING)
SELECT 
    c.nome,
    SUM(ip.quantidade * ip.preco_unitario) AS total_gasto
FROM Cliente c
JOIN Pedido p ON c.id_cliente = p.id_cliente
JOIN Item_Pedido ip ON p.id_pedido = ip.id_pedido
GROUP BY c.nome
HAVING SUM(ip.quantidade * ip.preco_unitario) > 1000;

-- 6. Pedidos e status da entrega
SELECT 
    p.id_pedido,
    c.nome AS cliente,
    e.status_entrega,
    e.codigo_rastreio
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
JOIN Entrega e ON p.id_pedido = e.id_pedido;

