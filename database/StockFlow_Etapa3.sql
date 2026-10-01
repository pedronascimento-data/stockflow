-- ============================================================
-- PROJETO INTEGRADOR - ETAPA 3
-- Sistema: StockFlow
-- Objetivo: criação, povoamento, consulta, edição e exclusão
-- Banco: MySQL
-- ============================================================

DROP DATABASE IF EXISTS stockflow;
CREATE DATABASE stockflow CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE stockflow;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    perfil ENUM('ADMINISTRADOR', 'ESTOQUISTA', 'VENDEDOR') NOT NULL,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE,
    descricao VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(150) NOT NULL,
    nome_fantasia VARCHAR(150),
    cnpj VARCHAR(18) UNIQUE,
    email VARCHAR(150),
    telefone VARCHAR(20),
    ativo TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf_cnpj VARCHAR(18) UNIQUE,
    email VARCHAR(150),
    telefone VARCHAR(20),
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(255),
    codigo_barras VARCHAR(50) UNIQUE,
    preco_custo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    preco_venda DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    quantidade_estoque INT NOT NULL DEFAULT 0,
    estoque_minimo INT NOT NULL DEFAULT 0,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    id_categoria INT NOT NULL,
    id_fornecedor INT NOT NULL,
    CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
) ENGINE=InnoDB;

CREATE TABLE movimentacao_estoque (
    id_movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('ENTRADA', 'SAIDA') NOT NULL,
    quantidade INT NOT NULL,
    data_movimentacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacao VARCHAR(255),
    id_produto INT NOT NULL,
    id_usuario INT NOT NULL,
    CONSTRAINT fk_movimentacao_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    CONSTRAINT fk_movimentacao_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE=InnoDB;

CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status ENUM('ABERTA', 'FINALIZADA', 'CANCELADA') NOT NULL DEFAULT 'ABERTA',
    id_cliente INT,
    id_usuario INT NOT NULL,
    CONSTRAINT fk_venda_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_venda_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE=InnoDB;

CREATE TABLE item_venda (
    id_item_venda INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    CONSTRAINT fk_item_venda_venda FOREIGN KEY (id_venda) REFERENCES venda(id_venda) ON DELETE CASCADE,
    CONSTRAINT fk_item_venda_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
) ENGINE=InnoDB;

-- 6 registros em cada tabela; após a exclusão de 1, permanecem 5.
INSERT INTO usuario (nome,email,senha_hash,perfil,ativo) VALUES
('Ana Souza','ana@stockflow.com','hash_ana_123','ADMINISTRADOR',1),
('Bruno Lima','bruno@stockflow.com','hash_bruno_123','ESTOQUISTA',1),
('Carla Mendes','carla@stockflow.com','hash_carla_123','VENDEDOR',1),
('Diego Alves','diego@stockflow.com','hash_diego_123','VENDEDOR',1),
('Elisa Rocha','elisa@stockflow.com','hash_elisa_123','ESTOQUISTA',1),
('Fabio Nunes','fabio@stockflow.com','hash_fabio_123','VENDEDOR',1);

INSERT INTO categoria (nome,descricao) VALUES
('Tintas','Tintas e complementos para pintura'),
('Hidráulica','Tubos, conexões e acessórios hidráulicos'),
('Elétrica','Materiais elétricos e acessórios'),
('Cerâmica','Pisos e revestimentos cerâmicos'),
('Ferragens','Ferramentas, parafusos e ferragens'),
('Temporária','Categoria criada para demonstrar exclusão');

INSERT INTO fornecedor (razao_social,nome_fantasia,cnpj,email,telefone,ativo) VALUES
('Amston Tintas LTDA','Amston','11.111.111/0001-11','contato@amston.com','77 3000-1001',1),
('Fortlev Indústria LTDA','Fortlev','22.222.222/0001-22','vendas@fortlev.com','77 3000-1002',1),
('Jomarca Industrial LTDA','Jomarca','33.333.333/0001-33','comercial@jomarca.com','77 3000-1003',1),
('Icasa Cerâmica LTDA','Icasa','44.444.444/0001-44','pedidos@icasa.com','77 3000-1004',1),
('Belgo Arames LTDA','Belgo','55.555.555/0001-55','atendimento@belgo.com','77 3000-1005',1),
('Fornecedor Temporário LTDA','Temporário','66.666.666/0001-66','temporario@email.com','77 3000-1006',1);

INSERT INTO cliente (nome,cpf_cnpj,email,telefone) VALUES
('João Pereira','111.111.111-11','joao@email.com','77 98111-1111'),
('Maria Oliveira','222.222.222-22','maria@email.com','77 98222-2222'),
('Carlos Santos','333.333.333-33','carlos@email.com','77 98333-3333'),
('Fernanda Costa','444.444.444-44','fernanda@email.com','77 98444-4444'),
('Rafael Martins','555.555.555-55','rafael@email.com','77 98555-5555'),
('Cliente Temporário','666.666.666-66','temporario.cliente@email.com','77 98666-6666');

INSERT INTO produto (nome,descricao,codigo_barras,preco_custo,preco_venda,quantidade_estoque,estoque_minimo,ativo,id_categoria,id_fornecedor) VALUES
('Tinta Acrílica 15L','Tinta acrílica branca para áreas internas e externas','789100000001',120.00,169.90,30,10,1,1,1),
('Caixa d''Água 500L','Reservatório de água com capacidade de 500 litros','789100000002',250.00,349.90,12,5,1,2,2),
('Tomada 10A','Tomada elétrica padrão brasileiro','789100000003',6.00,9.90,100,20,1,3,3),
('Piso Cerâmico 58x58','Piso cerâmico para ambientes internos','789100000004',22.00,31.90,200,50,1,4,4),
('Arame Recozido 1kg','Arame recozido para construção civil','789100000005',12.00,18.50,60,15,1,5,5),
('Produto Temporário','Produto criado apenas para demonstrar exclusão','789100000006',5.00,8.00,10,2,1,6,6);

INSERT INTO movimentacao_estoque (tipo,quantidade,observacao,id_produto,id_usuario) VALUES
('ENTRADA',30,'Entrada inicial da tinta',1,2),
('ENTRADA',12,'Entrada inicial da caixa d''água',2,2),
('ENTRADA',100,'Entrada inicial das tomadas',3,5),
('SAIDA',10,'Separação de piso para venda',4,2),
('ENTRADA',60,'Entrada inicial do arame',5,5),
('ENTRADA',10,'Movimentação temporária',6,2);

INSERT INTO venda (data_venda,valor_total,status,id_cliente,id_usuario) VALUES
('2026-08-01 09:30:00',169.90,'FINALIZADA',1,3),
('2026-08-01 11:00:00',349.90,'FINALIZADA',2,4),
('2026-08-02 10:15:00',19.80,'FINALIZADA',3,3),
('2026-08-02 14:20:00',63.80,'FINALIZADA',4,4),
('2026-08-03 16:00:00',37.00,'FINALIZADA',5,3),
('2026-08-03 17:30:00',8.00,'ABERTA',6,6);

INSERT INTO item_venda (quantidade,preco_unitario,subtotal,id_venda,id_produto) VALUES
(1,169.90,169.90,1,1),
(1,349.90,349.90,2,2),
(2,9.90,19.80,3,3),
(2,31.90,63.80,4,4),
(2,18.50,37.00,5,5),
(1,8.00,8.00,6,6);

-- Exibição de todos os registros
SELECT * FROM usuario;
SELECT * FROM categoria;
SELECT * FROM fornecedor;
SELECT * FROM cliente;
SELECT * FROM produto;
SELECT * FROM movimentacao_estoque;
SELECT * FROM venda;
SELECT * FROM item_venda;

-- Buscas específicas com WHERE
SELECT * FROM usuario WHERE perfil='VENDEDOR';
SELECT * FROM categoria WHERE nome='Tintas';
SELECT * FROM fornecedor WHERE ativo=1;
SELECT * FROM cliente WHERE nome LIKE 'M%';
SELECT * FROM produto WHERE quantidade_estoque <= estoque_minimo;
SELECT * FROM movimentacao_estoque WHERE tipo='ENTRADA';
SELECT * FROM venda WHERE status='FINALIZADA';
SELECT * FROM item_venda WHERE quantidade>=2;

-- Atualização de pelo menos um registro de cada tabela
UPDATE usuario SET nome='Ana Souza Silva' WHERE id_usuario=1;
UPDATE categoria SET descricao='Tintas, massas, seladores e complementos para pintura' WHERE id_categoria=1;
UPDATE fornecedor SET telefone='77 3333-1001' WHERE id_fornecedor=1;
UPDATE cliente SET telefone='77 99999-1111' WHERE id_cliente=1;
UPDATE produto SET preco_venda=174.90 WHERE id_produto=1;
UPDATE movimentacao_estoque SET observacao='Entrada inicial conferida pelo estoquista' WHERE id_movimentacao=1;
UPDATE venda SET valor_total=174.90 WHERE id_venda=1;
UPDATE item_venda SET preco_unitario=174.90, subtotal=174.90 WHERE id_item_venda=1;

-- Conferência das atualizações
SELECT * FROM usuario WHERE id_usuario=1;
SELECT * FROM categoria WHERE id_categoria=1;
SELECT * FROM fornecedor WHERE id_fornecedor=1;
SELECT * FROM cliente WHERE id_cliente=1;
SELECT * FROM produto WHERE id_produto=1;
SELECT * FROM movimentacao_estoque WHERE id_movimentacao=1;
SELECT * FROM venda WHERE id_venda=1;
SELECT * FROM item_venda WHERE id_item_venda=1;

-- Exclusões em ordem compatível com as chaves estrangeiras
DELETE FROM item_venda WHERE id_item_venda=6;
DELETE FROM movimentacao_estoque WHERE id_movimentacao=6;
DELETE FROM venda WHERE id_venda=6;
DELETE FROM produto WHERE id_produto=6;
DELETE FROM cliente WHERE id_cliente=6;
DELETE FROM fornecedor WHERE id_fornecedor=6;
DELETE FROM categoria WHERE id_categoria=6;
DELETE FROM usuario WHERE id_usuario=6;

-- Conferência final: permanecem 5 registros em cada tabela
SELECT * FROM usuario;
SELECT * FROM categoria;
SELECT * FROM fornecedor;
SELECT * FROM cliente;
SELECT * FROM produto;
SELECT * FROM movimentacao_estoque;
SELECT * FROM venda;
SELECT * FROM item_venda;

SELECT 'usuario' AS tabela, COUNT(*) AS total FROM usuario
UNION ALL SELECT 'categoria', COUNT(*) FROM categoria
UNION ALL SELECT 'fornecedor', COUNT(*) FROM fornecedor
UNION ALL SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL SELECT 'produto', COUNT(*) FROM produto
UNION ALL SELECT 'movimentacao_estoque', COUNT(*) FROM movimentacao_estoque
UNION ALL SELECT 'venda', COUNT(*) FROM venda
UNION ALL SELECT 'item_venda', COUNT(*) FROM item_venda;