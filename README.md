# 💾 TechDia - Projeto de Modelagem e Implementação de Banco de Dados

## 🌟 Visão Geral do Projeto

Este repositório contém os artefatos de modelagem, normalização e implementação em SQL para o sistema de gestão da loja **TechDia**, especializada na venda de acessórios e prestação de serviços de reparo de smartphones.

O projeto foi desenvolvido para garantir a **integridade referencial** e a **otimização de dados** por meio da aplicação das Formas Normais.

---

## 🛠️ Entregáveis e Estrutura do Repositório

O repositório está estruturado para apresentar o ciclo completo de desenvolvimento de um banco de dados relacional.

| Pasta / Arquivo | Conteúdo | Objetivo Principal |
| :--- | :--- | :--- |
| **Documentacao/** | Relatórios finais (Experiência Prática 1, 2 e 3). | Análise e validação do modelo até a **3ª Forma Normal (3FN)**. |
| **Diagramas/** | Imagens do Modelo Conceitual e Lógico Final. | Representação visual das entidades, atributos e relacionamentos. |
| **Scripts_SQL/** | **`techdia_database_script.sql`** | Código executável para recriar o banco de dados do zero. |

---

## 🔗 Modelo de Dados e Integridade

O modelo implementado consiste nas seguintes entidades e seus relacionamentos:

* **Entidades Principais:** `CLIENTE`, `PRODUTO`, `SERVICO`, `VENDA`, `ORDEM_SERVICO`.
* **Entidade Associativa:** `ITEM_VENDA` (resolve o relacionamento N:M entre `PRODUTO` e `VENDA`).
* **Validação da Integridade:** Foi comprovada no ambiente MySQL o funcionamento das **Chaves Estrangeiras (FKs)**, que impedem a exclusão de registros "pai" que possuam registros "filho" associados (ex.: impedir a exclusão de um cliente que possui vendas registradas).

## ⚙️ Como Utilizar o Script SQL

O arquivo `techdia_database_script.sql` é um script auto-executável, ideal para recriar o banco de dados em qualquer ambiente MySQL.

### Instruções de Execução:

1.  **Requisitos:** MySQL Server (ou compatível) e MySQL Workbench.
2.  **Preparação:** Abra o arquivo `techdia_database_script.sql` no MySQL Workbench.
3.  **Execução:** Execute o script completo (clique no ícone de raio/`Ctrl + Shift + Enter`).

O script realiza automaticamente as seguintes ações:
1.  Limpa a base de dados anterior (`DROP DATABASE IF EXISTS techdia`).
2.  Cria a base de dados (`CREATE DATABASE techdia`).
3.  Cria a estrutura de 6 tabelas (DDL) utilizando o motor **`InnoDB`** e definindo as FKs.
4.  Insere dados de teste (DML) para popular as tabelas.
5.  Executa consultas com `JOIN` para validar os relacionamentos.

Resultados da Consulta DML (Teste de Relacionamento JOIN)

Demonstra que as Chaves Estrangeiras (FK) estão a ligar as entidades (Ex: Cliente e Venda) corretamente.

<img width="903" height="364" alt="JOIN" src="https://github.com/user-attachments/assets/7c77c8d4-6c86-4b3f-a39c-5bef7919690b" />

Estrutura Final do Modelo Lógico (6 Tabelas em 3FN)

Prova que todos os componentes do modelo (CLIENTE, VENDA, etc.) foram criados no SGBD.

<img width="908" height="359" alt="image" src="https://github.com/user-attachments/assets/2afb9921-5fbb-4d0b-9407-bdf9f8b1e68d" />

Validação da Integridade Referencial (Erro 1451)

Esta é a prova mais importante: demonstra que a regra de negócio (3FN) foi implementada e protege os dados de exclusões não permitidas.

<img width="947" height="21" alt="image" src="https://github.com/user-attachments/assets/1f9de194-d317-45c8-9d0e-0a873a109125" />

Código Fonte SQL (DDL e DML)

Indica que este é o script completo que foi executado para criar e popular o banco de dados.

<img width="951" height="126" alt="image" src="https://github.com/user-attachments/assets/954c3530-23ec-4059-9e06-d64a737e4d9c" />


---

Feito por Pedro Santana
