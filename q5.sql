SET SEARCH_PATH to Quiz_sys;

--Report the full name and student number of all students in the database.
-- must concatenate the first and last name, split by space and rename resulting coloumns

DROP VIEW IF EXISTS get_id CASCADE;
DROP VIEW IF EXISTS all_quiz_questions CASCADE;
DROP VIEW IF EXISTS response_join_content CASCADE;
DROP VIEW IF EXISTS grade8_sid CASCADE;
DROP VIEW IF EXISTS expected_responses CASCADE;
DROP VIEW IF EXISTS response_grade8 CASCADE;
DROP VIEW IF EXISTS match_content CASCADE;
DROP VIEW IF EXISTS match_answer CASCADE;
DROP VIEW IF EXISTS actual_responses CASCADE;
DROP VIEW IF EXISTS not_answered CASCADE;
DROP VIEW IF EXISTS did_not_answer CASCADE;
DROP VIEW IF EXISTS correct_answer CASCADE;
DROP VIEW IF EXISTS incorrect_answer CASCADE;
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
	SELECT r.sid, quiz_content_id, response
	FROM response as r
		INNER JOIN grade8_sid as g
	ON r.sid = g.sid;

-- Matches the response to its corresponding question
CREATE VIEW match_content AS
	SELECT sid, response, q.id, q.question_id
	FROM response_grade8 as r
		INNER JOIN quiz_content as q
	ON r.quiz_content_id = q.id;

--Matches each row with the right answer for the question_id of that row
CREATE VIEW match_answer AS
	SELECT sid, question_id, response, answer
	FROM match_content as m
		INNER JOIN question as q
	ON m.question_id = q.id;

-- Reports the responses that each students gave for the quiz
CREATE VIEW actual_responses AS
	SELECT sid, question_id
	FROM match_answer;

--Reports all questions that a student has not answered on quiz Pr1-220310
CREATE VIEW not_answered AS
	(SELECT * FROM expected_responses)
		EXCEPT
	(SELECT * FROM actual_responses);

-- Reports the number of students per question who didnt answer the question
CREATE VIEW did_not_answer AS
	SELECT question_id as questionID, count(*) as didNotAnswer
	FROM not_answered
	GROUP BY question_id;

-- Reports the number of students who answered each question correctly
CREATE VIEW correct_answer AS
	SELECT question_id as questionID, count(*) as correctAnswer
	FROM match_answer
	WHERE response = answer
	GROUP BY question_id;

-- Reports the number of students who answered each question incorrectly
CREATE VIEW incorrect_answer AS
	SELECT question_id as questionID, count(*) as incorrectAnswer
	FROM match_answer
	WHERE response != answer
	GROUP BY question_id;

-- Matches each question with its correct, incorrect and did not answer statistics (count)
SELECT correct_answer.questionID AS questionID, correct_answer.correctAnswer AS
	correctAnswers, incorrect_answer.incorrectAnswer AS incorrectAnswers
	, did_not_answer.didNotAnswer AS didNotAnswer
FROM correct_answer
	NATURAL JOIN incorrect_answer
	NATURAL JOIN did_not_answer;



