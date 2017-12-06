SET SEARCH_PATH TO a3;

--Compute the grade and total score on quiz Pr1-220310 for every student in the grade 8 class in room 120 with Mr Higgins. Report the student number, last name, and total grade.

-- we want the weighted total
DROP TABLE IF EXISTS q3 CASCADE;
CREATE TABLE q3(
	StudentNumber BIGINT  PRIMARY KEY,
	LastName VARCHAR(1000),
	total_grade BIGINT
);


DROP VIEW IF EXISTS find_classID CASCADE;

-- find the id of class using the room, teacher, grade attributes
CREATE VIEW find_classID AS -- A
	SELECT cid
	FROM class
	WHERE room = 120 AND teacher = 'Mr Higgins' AND grade = 8;

DROP VIEW IF EXISTS class_students CASCADE;

-- find all students enrolled in class mentioned above
CREATE VIEW class_students AS -- B
	SELECT enrolled.sid AS sid, enrolled.cid AS cid 
	FROM enrolled 
	WHERE cid = (SELECT find_classID.cid 	
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
CREATE VIEW quiz_answers AS




--INSERT INTO q3


--;
