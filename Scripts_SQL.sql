-- DDL DE LIMPEZA E CRIAÇÃO DA BASE DE DADOS
-- 
-- Este comando remove a base de dados techdia se ela existir.
DROP DATABASE IF EXISTS techdia; 

-- 1. Cria a base de dados
CREATE DATABASE techdia;

-- 2. Seleciona a base de dados para uso. A partir daqui, tudo será criado dentro de 'techdia'.
USE techdia;

-- CRIAÇÃO DAS TABELAS (DDL) EM ORDEM CORRETA

-- Tabelas PAIS (sem dependências de outras tabelas do projeto)
CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro DATE
);

CREATE TABLE PRODUTO (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco_unitario DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE SERVICO (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    nome_servico VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco_padrao DECIMAL(10, 2) NOT NULL
);

-- Tabelas FILHAS (dependem de CLIENTE)
CREATE TABLE VENDA (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    status_pagamento VARCHAR(50),
    valor_total DECIMAL(10, 2) NOT NULL,
    FK_id_cliente INT NOT NULL,
    FOREIGN KEY (FK_id_cliente) REFERENCES CLIENTE(id_cliente)
);

-- Tabela FILHA (depende de CLIENTE e SERVICO)
CREATE TABLE ORDEM_SERVICO (
    id_os INT PRIMARY KEY AUTO_INCREMENT,
    data_abertura DATE NOT NULL,
    data_fechamento DATE,
    preco_cobrado DECIMAL(10, 2),
    status_os VARCHAR(50) NOT NULL,
    modelo_smartphone VARCHAR(100),
    imei VARCHAR(50),
    FK_id_cliente INT NOT NULL,
    FK_id_servico INT NOT NULL,
    FOREIGN KEY (FK_id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (FK_id_servico) REFERENCES SERVICO(id_servico)
);

-- Tabela ASSOCIATIVA (depende de VENDA e PRODUTO)
CREATE TABLE ITEM_VENDA (
    FK_id_venda INT NOT NULL,
    FK_id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (FK_id_venda, FK_id_produto),
    FOREIGN KEY (FK_id_venda) REFERENCES VENDA(id_venda),
    FOREIGN KEY (FK_id_produto) REFERENCES PRODUTO(id_produto)
);

-- DML: INSERÇÃO DE DADOS DE TESTE

-- 1. Inserir Clientes
INSERT INTO CLIENTE (nome, cpf, telefone, email, data_cadastro) VALUES
('João Silva', '111.111.111-11', '(11) 98888-1111', 'joao.s@email.com', '2023-10-01'),
('Maria Santos', '222.222.222-22', '(11) 97777-2222', 'maria.s@email.com', '2023-10-05');

-- 2. Inserir Produtos
INSERT INTO PRODUTO (nome_produto, descricao, preco_unitario, estoque) VALUES
('Capa Protetora Transparente', 'Capa de silicone para iPhone 13', 49.90, 50),
('Carregador Rápido USB-C', 'Carregador 20W', 99.90, 30);

-- 3. Inserir Serviços
INSERT INTO SERVICO (nome_servico, descricao, preco_padrao) VALUES
('Troca de Tela', 'Substituição de display danificado', 350.00),
('Troca de Bateria', 'Substituição de bateria padrão', 180.00);

-- 4. Inserir Vendas (Depende de CLIENTE, FK_id_cliente = 1)
INSERT INTO VENDA (data_venda, status_pagamento, valor_total, FK_id_cliente) VALUES
('2023-10-10', 'Pago', 149.80, 1); 

-- 5. Inserir Itens de Venda (Depende de VENDA 1 e PRODUTO 1 e 2)
INSERT INTO ITEM_VENDA (FK_id_venda, FK_id_produto, quantidade, preco_venda) VALUES
(1, 1, 1, 49.90),
(1, 2, 1, 99.90);

-- 6. Inserir Ordem de Serviço (Depende de CLIENTE 2 e SERVICO 1)
INSERT INTO ORDEM_SERVICO (data_abertura, preco_cobrado, status_os, modelo_smartphone, FK_id_cliente, FK_id_servico) VALUES
('2023-10-15', 350.00, 'Em Reparo', 'Samsung Galaxy S20', 2, 1);

-- DML: CONSULTA SIMPLES

-- Verifique se o João e a Maria foram inseridos:
SELECT * FROM CLIENTE;

-- Verifique os produtos:
SELECT * FROM PRODUTO;

-- DML: CONSULTA COM RELACIONAMENTO (JOIN)

-- Consulta 1: Listar Vendas e o nome do Cliente 
SELECT
    V.id_venda,
    C.nome AS Nome_Cliente,
    V.data_venda,
    V.valor_total
FROM VENDA V
JOIN CLIENTE C ON V.FK_id_cliente = C.id_cliente;

-- DML: ATUALIZAÇÃO (UPDATE)

-- Atualizar o status da Ordem de Serviço 1 para 'Finalizada' e registrar a data de conclusão
UPDATE ORDEM_SERVICO
SET status_os = 'Finalizada', data_fechamento = CURDATE() 
WHERE id_os = 1;

-- Atualizar o preço do Carregador Rápido (Produto 2) para 105.00
UPDATE PRODUTO
SET preco_unitario = 105.00
WHERE id_produto = 2;

SELECT id_os, status_os, data_fechamento FROM ORDEM_SERVICO WHERE id_os = 1;

-- DML: TESTE DE INTEGRIDADE (DELETE)

-- Tentar deletar o Cliente 1, que tem uma VENDA associada.
-- ESTE COMANDO DEVE FALHAR!
DELETE FROM CLIENTE 
WHERE id_cliente = 1;

-- DML: DIAGNÓSTICO DE INTEGRIDADE

-- 1. Verifique se as verificações de FK estão ativas (deve retornar 1)
SHOW VARIABLES LIKE 'foreign_key_checks';

-- 2. Verifique o motor da tabela CLIENTE (deve retornar InnoDB)
SHOW CREATE TABLE CLIENTE;