# Etapa 2 — Modelo de dados

A Etapa 2 estrutura o banco de dados do StockFlow em oito tabelas relacionadas.

## Tabelas

- usuario
- categoria
- fornecedor
- cliente
- produto
- movimentacao_estoque
- venda
- item_venda

## Relacionamentos

- categoria 1:N produto
- fornecedor 1:N produto
- produto 1:N movimentacao_estoque
- usuario 1:N movimentacao_estoque
- cliente 1:N venda
- usuario 1:N venda
- venda 1:N item_venda
- produto 1:N item_venda

O arquivo `stockflow_etapa2.sql` pode ser importado no MySQL Workbench para reconstruir o modelo e gerar o diagrama EER.
