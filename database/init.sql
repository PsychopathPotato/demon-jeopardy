CREATE TABLE IF NOT EXISTS questions (
  id INTEGER PRIMARY KEY,
  category TEXT NOT NULL,
  question TEXT NOT NULL,
  answer TEXT NOT NULL,
  points INTEGER NOT NULL
);

INSERT INTO questions (category, question, answer, points) VALUES
('Science', 'What planet is known as the Red Planet?', 'Mars', 100),
('History', 'Who was the first U.S. president?', 'George Washington', 100);