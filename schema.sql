-- Unenforced constraints: 
-- teachers and rooms: We can only make the room unique to a teacher if we make the room unique, 
-- But if we make the room unique a teacher can't teach two classes in the same room
-- so that is not enforced.
-- Also, enrolled and class: 
-- A student can't enroll in a class unless it exists 
-- And a class can only exist if it has at least one student in it 
-- rooms, teacher and classes: 
-- can't implement one teacher per room AS WELL AS the two classes per room constraint as having a uniqueness
-- between teacher and room implies that the row cannot be repeated again, therefore the same room occupied by teacher 
-- cannot be used for more than 1 class.
-- we are implementing the uniqueness of teacher and room but not the two classes per room for the above reasons. 


DROP SCHEMA IF EXISTS Quiz_sys CASCADE;
CREATE SCHEMA Quiz_sys;

SET SEARCH_PATH to Quiz_sys;

-- A student
CREATE TABLE student(
  id BIGINT primary key,
  -- The first name of the student.
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL
);

-- A class which a student can enroll in.
CREATE TABLE class(
  id BIGINT PRIMARY KEY,
  room BIGINT NOT NULL, 
  grade BIGINT NOT NULL, 
  teacher VARCHAR(50),
  Unique(room, teacher)
  
);


-- A class which a student can enroll in.
CREATE TABLE enrolled(
  sid BIGINT REFERENCES student(id),
  cid BIGINT REFERENCES class(id),
  UNIQUE(sid, cid)
  
);

-- question bank details, including each question's correct answer
CREATE TABLE question(
  id BIGINT PRIMARY KEY,
  qtext VARCHAR(1000) NOT NULL, 
  answer VARCHAR(100) NOT NULL,
  qtype VARCHAR(50) NOT NULL
);

-- table for all answers for  multiple choice questions aside from
--  the correct one, inlcuding the option for hints
CREATE TABLE multipleChoice(
  id BIGINT REFERENCES question(id),
  qoption_id BIGINT NOT NULL,
  qoption VARCHAR(1000) NOT NULL,
  has_hint VARCHAR(1000) NOT NULL, -- eg. 'Yes' or 'No'
  UNIQUE(id, qoption_id)
);

-- numeric questions' hints
CREATE TABLE numeric(
  id BIGINT REFERENCES question(id),
  lbound VARCHAR(1000) NOT NULL, 
  ubound VARCHAR(1000) NOT NULL, 
  hint VARCHAR(1000) NOT NULL 
);

-- table for MC questions options that have hints 
CREATE TABLE MC_hint(
  question_id BIGINT, -- not sure about unique here and qoption_id, want them both to be the primary key
  qoption_id BIGINT, -- not null? primary key? we DONT want it to give multiple hints for same option in the same question 
  answer_hint VARCHAR(1000) NOT NULL,
  FOREIGN KEY(question_id, qoption_id) REFERENCES multipleChoice(id, qoption_id)
);

-- a typical quiz layout for a class
CREATE TABLE quiz(
  id VARCHAR(1000) PRIMARY KEY,
  title VARCHAR(1000) NOT NULL, 
  start_date DATE NOT NULL, --format YYYY-MM-DD
  start_time TIME NOT NULL,
  cid BIGINT REFERENCES class(id) NOT NULL,
  hintFlag VARCHAR(1000)  -- Show hint for this quiz? 'True' or 'False'
);

-- instances of questions from question bank used in the specific quiz 
-- identified by quiz_id, including the weight of individual questions on that quiz 
CREATE TABLE quiz_content(
  id BIGINT PRIMARY KEY,
  quiz_id VARCHAR(1000) REFERENCES quiz(id), 
  question_id BIGINT REFERENCES question(id),
  weight INT NOT NULL
);

-- the students of a class who respond to a quiz's content 
CREATE TABLE response(
  sid BIGINT NOT NULL,
  cid BIGINT REFERENCES class(id), 
  response VARCHAR(1000) NOT NULL,
  quiz_content_id BIGINT  REFERENCES quiz_content(id), 

  foreign key (sid,cid) REFERENCES enrolled(sid,cid)


);

