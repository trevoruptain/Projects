DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS questions_follows;

CREATE TABLE questions_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id TEXT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  parent_id INTEGER,
  user_id INTEGER,
  questions_id INTEGER,

  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Trevor', 'Uptain');

INSERT INTO
  users (fname, lname)
VALUES
  ('Alison', 'Cheng');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('What color is the sun?', 'I tried to look at it directly but was nearly blinded.', (SELECT id FROM users WHERE fname = 'Alison'));

INSERT INTO
  replies (body, parent_id, user_id, questions_id)
VALUES
  ('It''s blue', NULL, (SELECT id FROM users WHERE fname = 'Trevor'), (SELECT id FROM questions WHERE title = 'What color is the sun?'));

INSERT INTO
  replies (body, parent_id, user_id, questions_id)
VALUES
  ('You suck', 1, (SELECT id FROM users WHERE fname = 'Alison'), (SELECT id FROM questions WHERE title = 'What color is the sun?'));

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'What color is the sun?'), (SELECT id FROM users WHERE fname = 'Trevor'));
