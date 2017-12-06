SET SEARCH_PATH to a3;

-- 1. For all questions in the database, report the question ID, question text, and the number of hints associated with it. For True-False questions, report NULL as the number of hints (since True-False questions cannot have hints).  

DROP TABLE IF EXISTS q2 CASCADE;
CREATE TABLE q2(
  question_id BIGINT PRIMARY KEY,
  question_text VARCHAR(1000) NOT NULL,
  number_of_hints BIGINT

);

--- split questions into their types.
-- according to the type, group by question id



DROP VIEW IF EXISTS allQuestions CASCADE;
-- show all questions in the bank with their individual id's and question text 
CREATE VIEW allQuestions AS
  SELECT id, qtexts
  FROM question;
  

DROP VIEW IF EXISTS MCQ_hint_num CASCADE;
---number of hints per MCQ THAT HAS HINTS
CREATE VIEW MCQ_hint_num AS
  SELECT question_id AS id , count(answer_hint) AS counts 
  FROM MC_hint
  GROUP BY question_id;  

DROP VIEW IF EXISTS MC_noHint CASCADE;
-- find the MC questions whose answers do not have hints and then assign a zero for hint count
CREATE VIEW MC_noHint AS
  SELECT question.id AS id, count(Null) AS counts 
  FROM question
  WHERE qtype = 'Multiple-Choice' AND question.id NOT IN (SELECT distinct question_id FROM MC_hint)
  GROUP BY question.id;

DROP VIEW IF EXISTS NumQ_hint_num CASCADE;
-- number of hints per numeric question (assuming they all do)
  CREATE VIEW NumQ_hint_num AS
  SELECT id, count(hint) AS counts 
  FROM numeric
  GROUP BY id;

--DROP VIEW IF EXISTS withCountsMC CASCADE; 
--DROP VIEW IF EXISTS withCountsNUM CASCADE;
--DROP VIEW IF EXISTS withCountsMCnoH CASCADE;
--DROP VIEW IF EXISTS withAllCounts CASCADE;
 
--CREATE VIEW withCountsMC AS
 -- SELECT allQuestions.id, allQuestions.qtext, MCQ_hint_num.counts 
  --FROM allQuestions FULL OUTER JOIN MCQ_hint_num ON allQuestions.id = MCQ_hint_num.id;

--CREATE VIEW withCountsMCnoH AS
 -- SELECT withCountsMC.id, withCountsMC.qtext, MC_noHint.counts
  --FROM withCountsMC FULL OUTER JOIN MC_noHint ON withCountsMC.id = MC_noHint.id; 

--CREATE VIEW withCountsNum AS
 -- SELECT withCountsMCnoH.id, withCountsMCnoH.qtext, NumQ_hint_num.counts
  --FROM withCountsMCnoH FULL OUTER JOIN NumQ_hint_num ON withCountsMCnoH.id = NumQ_hint_num.id;



--FULL OUTER JOIN MC_noHint ON allQuestions.id = MC_noHint.id FULL JOIN NumQ_hint_num ON allQuestions.id = NumQ_hint_num.id;

--CREATE VIEW withCountsNum AS
  -- (SELECT id,counts from allQuestions) UNION (select id, counts from MCQ_hint_num); 
   
insert into q2 select * from withCountsNum;


