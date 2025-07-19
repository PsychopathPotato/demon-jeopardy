-- init.sql
CREATE TABLE categories (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  category_id INTEGER,
  value INTEGER,
  question TEXT,
  answer TEXT,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Insert some sample data
INSERT INTO categories (name) VALUES ('Demons'), ('Spells'), ('Mythology');

INSERT INTO questions (category_id, value, question, answer) VALUES
(1, 100, 'Who is the first demon you encounter in SMT III?', 'Pixie'),
(2, 200, 'What element counters force?', 'Electric'),
(3, 300, 'Which god fought Tiamat?', 'Marduk');
