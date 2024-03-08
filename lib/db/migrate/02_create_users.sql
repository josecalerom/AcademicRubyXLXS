-- Tabela users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(120),
    cpf VARCHAR(11) UNIQUE,
    birthdate DATE,
    external_id VARCHAR UNIQUE,
    role_id INTEGER REFERENCES roles(id)
);
