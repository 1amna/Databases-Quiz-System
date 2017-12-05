ET SEARCH_PATH to a3;

--Report the full name and student number of all students in the database.
-- must concatenate the first and last name, split by space and rename resulting coloumns
SELECT fname || ' ' || lname AS FullName, id AS StudentNumber
FROM student;
