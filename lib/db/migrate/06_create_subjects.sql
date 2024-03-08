-- Tabela subjects
CREATE TABLE subjects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    teacher_id INTEGER REFERENCES users(id)
);
