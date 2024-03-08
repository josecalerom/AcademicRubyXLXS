-- Tabela parent_student_relationships
CREATE TABLE parent_student_relationships (
    id SERIAL PRIMARY KEY,
    parent_id INTEGER REFERENCES users(id),
    student_id INTEGER REFERENCES users(id),
    school_class_id INTEGER REFERENCES school_classes(id)
);
