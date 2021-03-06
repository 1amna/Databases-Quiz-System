SET SEARCH_PATH TO Quiz_sys;

--Compute the grade and total score on quiz Pr1-220310 for every student in the grade 8 class in room 120 with Mr Higgins. Report the student number, last name, and total grade.

-- we want the weighted total

DROP VIEW IF EXISTS find_classID CASCADE;

-- find the id of class using the room, teacher, grade attributes
CREATE VIEW find_classID AS -- A
	SELECT id
	FROM class
	WHERE room = 120 AND teacher = 'Mr Higgins' AND grade = 8;

DROP VIEW IF EXISTS class_students CASCADE;

-- find all students enrolled in class mentioned above
CREATE VIEW class_students AS -- B
	SELECT enrolled.sid AS sid, enrolled.cid AS cid 
	FROM enrolled 
	WHERE cid = (SELECT distinct find_classID.id 	
			FROM find_classID);

DROP VIEW IF EXISTS class_quiz CASCADE;

-- give the quiz details including weights and quiz content 
CREATE VIEW class_quiz AS -- C
	SELECT quiz.id as quiz_id, quiz.cid AS cid, quiz_content.id AS quiz_content_id, 
		quiz_content.question_id AS question_id, quiz_content.weight AS weight 
	FROM quiz INNER JOIN quiz_content ON quiz.id = quiz_content.quiz_id
	WHERE quiz.id = 'Pr1-220310'; 

DROP VIEW IF EXISTS quiz_answers CASCADE;

-- give weights and answers per questino on quiz
CREATE VIEW quiz_answers AS  -- D
	SELECT class_quiz.quiz_id, class_quiz.cid, class_quiz.quiz_content_id AS quiz_content_id, 
		class_quiz.question_id, class_quiz.weight, question.answer 
	FROM question INNER JOIN class_quiz ON question.id = class_quiz.question_id;
	
DROP VIEW IF EXISTS all_took CASCADE;
  
-- join quiz_answers with class_students to get the "ideal" situation of
-- all students in the class taking the quiz and answering all questions
CREATE VIEW all_took AS -- E
	SELECT class_students.sid, quiz_answers.*
	FROM quiz_answers CROSS JOIN class_students;
	
DROP VIEW IF EXISTS quiz_responses CASCADE;

-- find students in the said class who actually responded to any question on the 
-- quiz
CREATE VIEW quiz_responses AS -- F
	SELECT class_students.*, response.response, response.quiz_content_id -- FROM .SID 
	FROM response INNER JOIN class_students ON response.sid = class_students.sid AND
		response.cid = class_students.cid;

DROP VIEW IF EXISTS weighted_responses CASCADE;

-- include the weights to each answered question on the quiz, 
-- as well as correct answers 
CREATE VIEW weighted_responses AS -- G
	SELECT quiz_responses.sid, quiz_answers.* 
	FROM quiz_responses INNER JOIN quiz_answers ON 
		quiz_responses.quiz_content_id = quiz_answers.quiz_content_id; 

DROP VIEW IF EXISTS no_response CASCADE;
		 
DROP VIEW IF EXISTS correct_response CASCADE;

-- find those who correctly responded to at least one question on the quiz
CREATE VIEW correct_response AS -- H
	SELECT weighted_responses.*
	FROM weighted_responses INNER JOIN response ON response.sid = weighted_responses.sid 
		AND response.cid = weighted_responses.cid 
			AND response.quiz_content_id = weighted_responses.quiz_content_id
	WHERE weighted_responses.answer = response.response;


--Find all the SID's of students in class but did  not respond to not even
-- one question
CREATE VIEW no_response AS
	SELECT all_Took.sid AS sid, 0 AS total_score -- zero as default?
	FROM all_Took 
	WHERE all_Took.sid NOT IN (SELECT correct_response.sid
					FROM correct_response)
	GROUP BY all_Took.sid;

DROP VIEW IF EXISTS join_students CASCADE;

CREATE VIEW correct_counts AS
	SELECT correct_response.sid AS sid, sum(correct_response.weight)
  		 AS total_score
	FROM correct_response
	GROUP BY correct_response.sid;

DROP VIEW IF EXISTS scores_all CASCADE;

-- JOIN both responders and non-responders
CREATE VIEW scores_all AS
	(SELECT * FROM correct_counts) UNION (SELECT * FROM no_response);
 
	
SELECT scores_all.sid AS Student_Number, student.lname 
AS Last_Name, scores_all.total_score AS total_grade  
FROM scores_all INNER JOIN student ON student.id = scores_all.sid;


--;
