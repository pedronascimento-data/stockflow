# StockFlow

Sistema de gerenciamento de estoque e vendas desenvolvido como **Projeto Integrador**, com evolução planejada de banco de dados para uma aplicação Java.

O projeto simula necessidades comuns de pequenas e médias empresas: cadastro de produtos, fornecedores e clientes, controle de estoque, registro de vendas e perfis de acesso.

## Visão técnica

A etapa atual implementa um banco relacional em **MySQL** com oito tabelas de negócio, integridade referencial por chaves estrangeiras, dados de exemplo e operações de consulta, atualização e exclusão.

### Entidades

`usuario` • `categoria` • `fornecedor` • `cliente` • `produto` • `movimentacao_estoque` • `venda` • `item_venda`

### Relacionamentos principais

- categoria 1:N produto
- fornecedor 1:N produto
- produto 1:N movimentação de estoque
- usuário 1:N movimentação de estoque
- cliente 1:N venda
- usuário 1:N venda
- venda 1:N item de venda
- produto 1:N item de venda

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

## Perfis de acesso

| Perfil | Responsabilidade |
|---|---|
| **Administrador** | Gerenciamento geral |
| **Estoquista** | Operações de estoque |
| **Vendedor** | Operações de vendas |

## Status

| Etapa | Entrega | Status |
|---|---|---|
| 1 | Documentação técnica e requisitos | ✅ Concluída |
| 2 | Modelagem do banco / DER | ✅ Concluída |
| 3 | Criação, povoamento e manipulação em MySQL | ✅ Concluída |
| Próximas | Aplicação Java e evolução do sistema | 🚧 Em desenvolvimento |

## Tecnologias

- Java
- MySQL
- SQL
- MySQL Workbench
- Git e GitHub

## Evidências técnicas

O script atual demonstra:

- criação de banco e tabelas;
- `PRIMARY KEY`, `FOREIGN KEY` e `UNIQUE`;
- tipos `ENUM`, `DECIMAL`, datas e valores padrão;
- relacionamentos entre entidades;
- carga de dados fictícios;
- consultas com `SELECT` e `WHERE`;
- atualizações com `UPDATE`;
- exclusões respeitando dependências entre tabelas.

## Estrutura

```text
stockflow/
├── README.md
├── .gitignore
├── database/
│   └── StockFlow_Etapa3.sql
└── docs/
    ├── etapa-1/
    └── etapa-2/
```

## Executando o banco

1. Abra o MySQL Workbench e conecte-se a uma instância MySQL.
2. Abra `database/StockFlow_Etapa3.sql`.
3. Execute o script completo.
4. O banco `stockflow` será recriado, povoado e as operações demonstrativas serão executadas.

> O script utiliza `DROP DATABASE IF EXISTS stockflow` para permitir a recriação completa da base em ambiente de estudo. Execute apenas em um ambiente em que esse banco possa ser removido.

## Próximas evoluções

- Camada de aplicação em Java
- Persistência integrada à aplicação
- Validações de regras de negócio
- Interface para operações de estoque e vendas
- Consultas e relatórios voltados à gestão

---

Desenvolvido por **Pedro Nascimento**.
