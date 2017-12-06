-- Schema for storing a subset of the Parliaments and Governments database
-- available at http://www.parlgov.org/


DROP SCHEMA IF EXISTS a3 CASCADE;
CREATE SCHEMA a3;

SET SEARCH_PATH to a3;

-- A student
CREATE TABLE student(
  id BIGINT primary key,
  -- The first name of the student.
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL
);

-- A class which a studet can enroll in.
CREATE TABLE class(
  id BIGINT PRIMARY KEY,
  room BIGINT NOT NULL, 
  grade BIGINT NOT NULL, 
  teacher VARCHAR(50)
);


-- A class which a student can enroll in.
CREATE TABLE enrolled(
  sid BIGINT REFERENCES student(id),
  cid BIGINT REFERENCES class(id),
  UNIQUE(sid, cid)
  
);

-- A class which a studet can enroll in.
-- Check type, then turn answer into int for
CREATE TABLE question(
  id BIGINT PRIMARY KEY,
  qtext VARCHAR(1000) NOT NULL, 
  answer VARCHAR(100) NOT NULL,
  qtype VARCHAR(50) NOT NULL
);


-- A class which a studet can enroll in.
CREATE TABLE multipleChoice(
  id BIGINT REFERENCES question(id),
  qoption_id BIGINT NOT NULL,
  qoption VARCHAR(1000) NOT NULL,
  has_hint VARCHAR(1000) NOT NULL,  --true/false? 
  UNIQUE(id, qoption_id)
);

-- A class which a studet can enroll in.
CREATE TABLE numeric(
  id BIGINT REFERENCES question(id),
  lbound VARCHAR(1000) NOT NULL, 
  ubound VARCHAR(1000) NOT NULL, 
  hint VARCHAR(1000) NOT NULL 
);

CREATE TABLE MC_hint(
  question_id BIGINT, -- not sure about unique here and qoption_id, want them both to be the primary key
  qoption_id BIGINT, -- not null? primary key? we DONT want it to give multiple hints for same option in the same question 
  answer_hint VARCHAR(1000) NOT NULL,
  FOREIGN KEY(question_id, qoption_id) REFERENCES multipleChoice(id, qoption_id)
);

-- A class which a studet can enroll in.

CREATE TABLE quiz(
  id VARCHAR(1000) PRIMARY KEY,
  title VARCHAR(1000) NOT NULL, 
  start_date DATE NOT NULL, --format YYYY-MM-DD
  start_time TIME NOT NULL,
  cid BIGINT REFERENCES class(id) NOT NULL,
  hintFlag VARCHAR(1000) -- default this to 'False' to avoid nulls?
);

-- A class which a studet can enroll in.
CREATE TABLE quiz_content(
  id BIGINT PRIMARY KEY,
  quiz_id VARCHAR(1000) REFERENCES quiz(id), 
  question_id BIGINT REFERENCES question(id),
  weight INT NOT NULL
);

-- response is answer in whiteboard pictures
CREATE TABLE response(
  sid BIGINT NOT NULL,
  cid BIGINT REFERENCES class(id), 
  response VARCHAR(1000) NOT NULL,
  quiz_content_id BIGINT  REFERENCES quiz_content(id), --Maybe question_id? we need to know which question they answered

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
