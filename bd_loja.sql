CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL
);

INSERT INTO
    produtos (nome, preco, quantidade_estoque)
VALUES
    ('Camiseta', 29.99, 50),
    ('Calça Jeans', 59.99, 30),
    ('Tênis', 89.99, 20);

-- Criação da tabela "clientes"
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL
);

INSERT INTO
    clientes (nome, email, telefone)
VALUES
    (
        'Ana Silva',
        'ana.silva@email.com',
        '(11) 1234-5678'
    ),
    (
        'José Santos',
        'jose.santos@email.com',
        '(21) 9876-5432'
    ),
    (
        'Mariana Oliveira',
        'mariana@email.com',
        '(31) 5555-1234'
    );

CREATE TABLE IF NOT EXISTS pedidos (
    id SERIAL PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

INSERT INTO
    pedidos (id_cliente, data_pedido, valor_total)
VALUES
    (1, '2023-01-15', 89.98),
    (2, '2023-02-10', 149.97),
    (3, '2023-03-05', 119.98);

CREATE TABLE IF NOT EXISTS itens_pedido (
    id SERIAL PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    valor_total_item DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);

INSERT INTO
    itens_pedido (
        id_pedido,
        id_produto,
        quantidade,
        valor_unitario,
        valor_total_item
    )
VALUES
    (1, 1, 2, 29.99, 59.98),
    (1, 3, 1, 89.99, 89.99),
    (2, 2, 3, 59.99, 179.97),
    (3, 1, 1, 29.99, 29.99),
    (3, 2, 2, 59.99, 119.98);

SELECT
    pedidos.id AS pedido_id,
    clientes.nome AS cliente_nome,
    pedidos.data_pedido,
    produtos.nome AS produto_nome,
    itens_pedido.quantidade,
    itens_pedido.valor_total_item
FROM
    pedidos
    JOIN clientes ON pedidos.id_cliente = clientes.id
    JOIN itens_pedido ON pedidos.id = itens_pedido.id_pedido
    JOIN produtos ON itens_pedido.id_produto = produtos.id;