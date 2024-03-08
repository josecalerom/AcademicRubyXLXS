-- Tabela contacts
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    contactable VARCHAR,
    type INTEGER,
    user_id INTEGER REFERENCES users(id)
);
