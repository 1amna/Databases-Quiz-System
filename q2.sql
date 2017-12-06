SET SEARCH_PATH to a3;

-- 1. For all questions in the database, report the question ID, question text, and the number of hints associated with it. For True-False questions, report NULL as the number of hints (since True-False questions cannot have hints).  

DROP TABLE IF EXISTS q2 CASCADE;

-- create table into which you will later insert the values
CREATE TABLE q2(
  question_id BIGINT PRIMARY KEY,
  question_text VARCHAR(50) NOT NULL,
  number_of_hints BIGINT

);

--- split questions into their types, particularly into those with/without hints
-- according to the type, group by question.id 


DROP VIEW IF EXISTS MCQ_hint_num CASCADE;

---number of hints per MCQ THAT HAS HINTS
CREATE VIEW MCQ_hint_num AS
  SELECT question.id as id, count(answer_hint) AS counts 
  FROM MC_hint inner join question on MC_hint.question_id = question.id
  GROUP BY question.id;  

DROP VIEW IF EXISTS MC_noHint CASCADE;

-- find the MC questions whose answers do not have hints and then assign a zero for hint count
CREATE VIEW MC_noHint AS
  SELECT question.id AS id,  count(Null) AS counts 
  FROM question
  WHERE qtype = 'Multiple-Choice' AND question.id NOT IN (SELECT distinct question_id FROM MC_hint)
  GROUP BY question.id;

DROP VIEW IF EXISTS NumQ_hint_num CASCADE;

-- number of hints per numeric questions 
CREATE VIEW NumQ_hint_num AS
  SELECT question.id as id, count(hint) AS counts 
  FROM numeric inner join question on question.id = numeric.id
  GROUP BY question.id;


DROP VIEW IF EXISTS hintsTogether CASCADE;

-- Join all hint counts from different types together
CREATE VIEW hintsTogether AS
  (SELECT * FROM NumQ_hint_num) UNION (SELECT * FROM MC_noHint) UNION (SELECT * FROM MCQ_hint_num);

DROP VIEW IF EXISTS allTypes CASCADE;

-- Join all types of questions, including true/false and also include the question text
-- Truncate question text to 50 chars
CREATE VIEW allTypes AS
  SELECT question.id AS id, left(question.qtext, 50) AS qtext, hintsTogether.counts AS counts  
  FROM question left join hintsTogether on question.id = hintsTogether.id;


-- Final step.  Populate the q2 table we created previously with the allTypes query result
INSERT INTO q2 (
  SELECT * 
  FROM allTypes);
