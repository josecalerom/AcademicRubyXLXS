-- Tabela school_class_subjects
CREATE TABLE school_class_subjects (
    id SERIAL PRIMARY KEY,
    school_class_id INTEGER REFERENCES school_classes(id),
    subject_id INTEGER REFERENCES subjects(id),
    teacher_id INTEGER REFERENCES users(id)
);
