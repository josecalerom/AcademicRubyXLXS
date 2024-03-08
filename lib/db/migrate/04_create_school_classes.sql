-- Tabela school_classes
CREATE TABLE school_classes (
    id SERIAL PRIMARY KEY,
    external_id VARCHAR,
    description VARCHAR,
    academic_year DATE
);
