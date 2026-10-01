# StockFlow

Sistema de gerenciamento de estoque e vendas desenvolvido como **Projeto Integrador** do curso.

O StockFlow foi planejado para pequenas e médias empresas e centraliza o controle de produtos, categorias, fornecedores, clientes, usuários, movimentações de estoque e vendas.

## Status do projeto

| Etapa | Conteúdo | Status |
|---|---|---|
| 1 | Documentação técnica e requisitos | Concluída |
| 2 | Modelagem do banco de dados / DER | Concluída |
| 3 | Criação, povoamento e manipulação do banco MySQL | Concluída |
| Próximas etapas | Aplicação Java e evolução do sistema | Em desenvolvimento |

## Funcionalidades previstas

- Cadastro e gerenciamento de produtos
- Cadastro de categorias e fornecedores
- Cadastro de clientes
- Controle de usuários e perfis de acesso
- Registro de entradas e saídas de estoque
- Controle de saldo e estoque mínimo
- Registro de vendas e itens vendidos
- Consultas e relatórios
- Autenticação de usuários

## Perfis de usuário

- **Administrador** — gerenciamento geral do sistema
- **Estoquista** — operações relacionadas ao estoque
- **Vendedor** — operações relacionadas às vendas

## Banco de dados

O modelo atual possui oito tabelas:

`usuario`, `categoria`, `fornecedor`, `cliente`, `produto`, `movimentacao_estoque`, `venda` e `item_venda`.

Principais relacionamentos:

- categoria 1:N produto
- fornecedor 1:N produto
- produto 1:N movimentacao_estoque
- usuario 1:N movimentacao_estoque
- cliente 1:N venda
- usuario 1:N venda
- venda 1:N item_venda
- produto 1:N item_venda

## Tecnologias

- Java
- MySQL
- MySQL Workbench
- Git e GitHub

A tecnologia de interface será consolidada conforme as próximas etapas do curso.

## Estrutura

```
stockflow/
├── README.md
├── .gitignore
├── database/
│   └── StockFlow_Etapa3.sql
└── docs/
    ├── etapa-1/
    │   └── README.md
    └── etapa-2/
        ├── README.md
        └── stockflow_etapa2.sql
```

## Executando o banco

1. Abra o MySQL Workbench e conecte-se ao MySQL.
2. Abra `database/StockFlow_Etapa3.sql`.
3. Execute o script completo.
4. O banco `stockflow` será recriado, povoado e serão executados os exemplos de SELECT, WHERE, UPDATE e DELETE da Etapa 3.

> O script da Etapa 3 começa com `DROP DATABASE IF EXISTS stockflow`; portanto, ele recria a base para permitir a demonstração completa da atividade.

## Projeto Integrador

O repositório será atualizado progressivamente conforme as próximas etapas do Projeto Integrador forem desenvolvidas.

---
Desenvolvido por **Pedro Nascimento**.
