SET SEARCH_PATH to a3;

--Report the full name and student number of all students in the database.
-- must concatenate the first and last name, split by space and rename resulting coloumns
DROP TABLE IF EXISTS q4 CASCADE; 
CREATE TABLE q4(
	studentID BIGINT,
	questionID BIGINT,
	text VARCHAR(1000)
);

DROP VIEW IF EXISTS get_id CASCADE;
DROP VIEW IF EXISTS all_quiz_questions CASCADE;
DROP VIEW IF EXISTS response_join_content CASCADE;

--NOTE a large portion of these views do not need to be made since we can hardcode
-- the class id of Mr Higgins class for example. The reason we chose to implement 
-- our queries as such is because we want them to be applicable to broader data sets.

-- Gets the ID for the class with the specified fields.
CREATE VIEW get_id AS
	SELECT id
	FROM class
	WHERE room = 120 AND
			grade = 8 AND
			teacher = 'Mr Higgins';

--Gets the sid of all students enrolled in the grade 8 class in room 120 taught 
-- by Mr Higgins
CREATE VIEW grade8_sid AS
	SELECT sid, e.cid
	FROM enrolled as e
		INNER JOIN get_id as g
	ON e.cid = g.id; 

--Use this with all students in the class to get the EXPECTED
CREATE VIEW all_quiz_questions AS
	SELECT question_id
	FROM quiz_content
	WHERE quiz_id = 'Pr1-220310';

--Creates a view which is the expected table with every student answering every question
-- which we will use to see who didnt answer which questions.(RA approach)
CREATE VIEW expected_responses AS
	SELECT sid, question_id
	FROM all_quiz_questions, grade8_sid;

-- Reports the responses of every student in the grade 8 class.
CREATE VIEW response_grade8 AS
	SELECT r.sid, quiz_content_id
	FROM response as r
		INNER JOIN grade8_sid as g
	ON r.sid = g.sid;
	
--Matches each response with its corresponding question
CREATE VIEW response_join_content AS
	SELECT sid, question_id
	FROM response_grade8 as r
		INNER JOIN quiz_content as q
	ON r.quiz_content_id = q.id;

--Reports all questions that a student has not answered on quiz Pr1-220310
CREATE VIEW not_answered AS
	(SELECT * FROM expected_responses)
		EXCEPT
	(SELECT * FROM response_join_content);

--Matches the question_id of questions not answered with their corresponding
-- question text.
CREATE VIEW na_match_qtext AS
	SELECT sid, question_id, qtext
	FROM not_answered as n
		INNER JOIN question as q
	ON n.question_id = q.id;	

-- Maybe order by student# then question#
INSERT INTO q4 SELECT sid as studentID, question_id as questionID, qtext as text FROM na_match_qtext;
