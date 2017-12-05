SET SEARCH_PATH to a3;

--Report the full name and student number of all students in the database.
-- must concatenate the first and last name, split by space and rename resulting coloumns
DROP TABLE IF EXISTS q1 CASCADE; 
CREATE TABLE q1(
  FullName VARCHAR(1000),
  StudentNumber BIGINT PRIMARY KEY 
);

DROP VIEW IF EXISTS allStudents CASCADE;
CREATE VIEW allStudents AS 
  SELECT fname || ' ' || lname AS FullName, id 
    AS StudentNumber
  FROM student;

INSERT INTO q1 
SELECT * 
FROM allStudents;
