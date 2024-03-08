-- Tabela parent_student_school_classes
CREATE TABLE parent_student_school_classes (
    id SERIAL PRIMARY KEY,
    parent_student_id INTEGER REFERENCES parent_student_relationships(id),
    school_class_id INTEGER REFERENCES school_classes(id)
);
