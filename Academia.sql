CREATE TABLE assinantes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE planos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    valor_mensal_base DECIMAL(10,2) CHECK (valor_mensal_base > 0) NOT NULL
);

CREATE TABLE modalidades (
    id SERIAL PRIMARY KEY,
    plano_id INT REFERENCES planos(id),
    nome VARCHAR(100) NOT NULL,
    sala VARCHAR(20) NOT NULL,
    capacidade_maxima INT CHECK (capacidade_maxima > 0) NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);

CREATE TABLE matriculas (
    id SERIAL PRIMARY KEY,
    assinantes_id INT REFERENCES assinantes(id),
    data_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Ativa' CHECK (status IN ('Ativa', 'Cancelada', 'Trancada'))
);

CREATE TABLE itens_matricula (
    id SERIAL PRIMARY KEY,
    matricula_id INT REFERENCES matriculas(id),
    modalidade_id INT REFERENCES modalidades(id),
    duracao_meses INT CHECK (duracao_meses > 0) NOT NULL,
    valor_mensal_aplicado DECIMAL(10,2) CHECK (valor_mensal_aplicado > 0) NOT NULL,
    taxa_adesao DECIMAL(10,2) CHECK (taxa_adesao >= 0) DEFAULT 0.00
);

INSERT INTO planos (nome, valor_mensal_base) VALUES 
('VIP', 220.00), 
('Fit', 140.00), 
('Essencial', 90.00);

INSERT INTO modalidades (plano_id, nome, sala, capacidade_maxima, disponivel) VALUES 
(1, 'Crossfit', 'Arena 01', 15, TRUE),
(2, 'Pilates', 'Studio 02', 10, TRUE),
(3, 'Musculação', 'Andar 02', 50, TRUE);

INSERT INTO assinantes (nome, email, cpf, telefone) VALUES 
('Miguel Santos', 'miguel@email.com', '11122233344', '11999990000'),
('Marcos Costa', 'marcos@email.com', '22233344455', '11988880000'),
('Luiza Silva', 'luiza@email.com', '33344455566', '11977770000');

INSERT INTO matriculas (assinantes_id, status) VALUES 
(1, 'Ativa'), 
(1, 'Ativa'), 
(2, 'Ativa'), 
(3, 'Cancelada');