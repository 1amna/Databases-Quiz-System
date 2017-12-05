-- Schema for storing a subset of the Parliaments and Governments database
-- available at http://www.parlgov.org/


DROP SCHEMA IF EXISTS a3 CASCADE;
CREATE SCHEMA a3;

SET SEARCH_PATH to a3;

-- A student
CREATE TABLE student(
  id INT primary key,
  -- The first name of the student.
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL
);

-- A class which a studet can enroll in.
CREATE TABLE class(
  id INT PRIMARY KEY,
  room INT NOT NULL, 
  grade INT NOT NULL, 
  teacher VARCHAR(50)
);


-- A class which a studet can enroll in.
CREATE TABLE enrolled(
  sid INT REFERENCES student(id),
  cid INT REFERENCES class(id),
  UNIQUE(sid, cid)
  
);

-- A class which a studet can enroll in.
-- Check type, then turn answer into int for
CREATE TABLE question(
  id INT PRIMARY KEY,
  qtext VARCHAR(100) NOT NULL, 
  answer VARCHAR(100) NOT NULL,
  qtype VARCHAR(8) NOT NULL
);


-- A class which a studet can enroll in.
CREATE TABLE multipleChoice(
  id INT REFERENCES question(id),
  qoption_id INT PRIMARY KEY,
  qoption VARCHAR(100) NOT NULL,
  has_hint VARCHAR(100) NOT NULL  --true/false? 
);

-- A class which a studet can enroll in.
CREATE TABLE numeric(
  id INT REFERENCES question(id),
  lbound VARCHAR(100) NOT NULL, 
  ubound VARCHAR(100) NOT NULL, 
  hint VARCHAR(100) 
);

CREATE TABLE MC_hint(
  question_id INT REFERENCES mulipleChoice(id) UNIQUE, -- not sure about unique here and qoption_id, want them both to be the primary key
  qoption_id INT REFERENCES multipleChoice(qoption_id) UNIQUE, -- null? primary key? we DONT want it to give multiple hints for same option in the same question 
  answer_hint VARCHAR(100) NOT NULL
);

-- A class which a studet can enroll in.
CREATE TABLE quiz(
  id VARCHAR(100) PRIMARY KEY,
  title VARCHAR(100) NOT NULL, 
  start_date DATE NOT NULL, --format YYYY-MM-DD
  start_time TIME NOT NULL,
  cid INT REFERENCES class(id) NOT NULL,
  hintFlag VARCHAR(10) -- default this to 'False' to avoid nulls?
);

-- A class which a studet can enroll in.
CREATE TABLE quiz_content(
  id INT PRIMARY KEY,
  quiz_id VARCHAR(100) REFERENCES quiz(id), 
  question_id INT REFERENCES question(id),
  weight INT NOT NULL
);

-- response is answer in whiteboard pictures
CREATE TABLE response(
  sid INT NOT NULL,
  cid INT REFERENCES class(id), 
  response VARCHAR(100) NOT NULL,
  quiz_content_id VARCHAR(100) REFERENCES quiz_content(id), --Maybe question_id? we need to know which question they answered

  foreign key (sid,cid) REFERENCES enrolled(sid,cid)


);


/*
ALTER TABLE cabinet ADD CONSTRAINT 
  fk_election_id 
  FOREIGN KEY (election_id) REFERENCES election;
*/

/*
CREATE INDEX cabinet_party_party_id_inx ON cabinet_party(party_id);
CREATE INDEX cabinet_party_cabinet_id_inx ON cabinet_party(cabinet_id);
CREATE INDEX election_result_party_id_inx ON election_result(party_id);
CREATE INDEX election_result_election_id_inx ON election_result(election_id);
*/
