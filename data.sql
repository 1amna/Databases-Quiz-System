SET SEARCH_PATH to Quiz_sys;

INSERT INTO question VALUES (782, 'What do you promise when you take the oath of citizenship?', 'To pledge your loyalty to the Sovereign, Queen Elizabeth II', 'Multiple-Choice');

INSERT INTO multipleChoice VALUES (782, 1, 'To pledge your allegiance to the flag and fulfill the duties of a Canadian', 'No');

INSERT INTO multipleChoice VALUES (782, 2, 'To pledge your allegiance to the flag and fulfill the duties of a Canadian','Yes');

INSERT INTO MC_hint VALUES (782, 2, 'Think regally.');

INSERT INTO multipleChoice VALUES (782, 3, 'To pledge your loyalty to Canada from sea to sea', 'No' );

INSERT INTO question VALUES (601, 'During the "Quiet Revolution," Quebec experienced rapid change. In what decade did this occur? (Enter the year that began the decade, e.g., 1840.)', '1960', 'Numeric');

INSERT INTO numeric VALUES (601, '1800', '1900', 'The Quiet Revolution happened during the 20th Century.');

INSERT INTO numeric VALUES (601, '2000', '2010', 'The Quiet Revolution happened some time ago.');

INSERT INTO numeric VALUES (601, '2020', '3000', 'The Quiet Revolution has already happened!');

INSERT INTO question VALUES (625, 'What is the Underground Railroad?', 'A network used by slaves who escaped the United States into Canada', 'Multiple-Choice');

INSERT INTO multipleChoice VALUES (625, 1, 'The first railway to cross Canada', 'Yes');

INSERT INTO MC_hint VALUES (625, 1, 'The Underground Railroad was generally south to north, not east-west.');

INSERT INTO multipleChoice VALUES (625, 2, 'The CPRi''s secret railway line', 'Yes');

INSERT INTO MC_hint VALUES (625, 2, 'The Underground Railroad was secret, but it had nothing to do with trains.');

INSERT INTO multipleChoice VALUES (625, 3, 'The TTC subway system', 'Yes');

INSERT INTO MC_hint VALUES (625, 3, 'The TTC is relatively recent; the Underground Railroad was in operation over 100 years ago.');

INSERT INTO question VALUES (566,'The Prime Minister, Justin Trudeau, is Canada''s Head of State.' ,'False', 'True-False');

INSERT INTO question VALUES (790, 'During the War of 1812 the Americans burned down the Parliament Buildings in York (now Toronto). What did the British and Canadians do in return?', 'They burned down the White House in Washington D.C.', 'Multiple-Choice');

INSERT INTO multipleChoice VALUES (790, 1, 'They attacked American merchant ships', 'No');

INSERT INTO multipleChoice VALUES (790, 2, 'They expanded their defence system, including Fort York' ,'No');

INSERT INTO multipleChoice VALUES (790, 3, 'They captured Niagara Falls','No');

INSERT INTO class VALUES (8120, 120, 8, 'Mr Higgins');

INSERT INTO class VALUES (5366, 366, 5, 'Miss Nyers');

INSERT INTO quiz VALUES ('Pr1-220310', 'Citizenship Test Practise Questions', '2017-10-01', '13:30:00', 8120,'True');

INSERT INTO quiz_content VALUES (1, 'Pr1-220310', 601,2);

INSERT INTO quiz_content VALUES (2, 'Pr1-220310', 566, 1);

INSERT INTO quiz_content VALUES (4, 'Pr1-220310', 625, 2);

INSERT INTO quiz_content VALUES (3, 'Pr1-220310', 790, 4);

INSERT INTO student VALUES (0998801234, 'Lena', 'Headey');

INSERT INTO student VALUES (0010784522, 'Peter', 'Dinklage' );

INSERT INTO student VALUES (0997733991, 'Emilia', 'Clarke');

INSERT INTO student VALUES (5555555555, 'Kit', 'Harrington');

INSERT INTO student VALUES (1111111111, 'Sophie', 'Turner');

INSERT INTO student VALUES (2222222222, 'Maisie', 'Williams');

INSERT INTO enrolled VALUES (0998801234, 8120);

INSERT INTO enrolled VALUES (0010784522, 8120);

INSERT INTO enrolled VALUES (0997733991, 8120);

INSERT INTO enrolled VALUES (5555555555, 8120);

INSERT INTO enrolled VALUES (1111111111, 8120);

INSERT INTO enrolled VALUES (2222222222, 5366);

INSERT INTO response VALUES (0998801234, 8120, '1950', 1);

INSERT INTO response VALUES (0998801234, 8120, 'False', 2);

INSERT INTO response VALUES (0998801234, 8120, 'They expanded their defence system, including Fort York', 3);

INSERT INTO response VALUES (0998801234, 8120, 'A network used by slaves who escaped the United States into Canada', 4);

INSERT INTO response VALUES (0010784522, 8120, '1960', 1);

INSERT INTO response VALUES (0010784522, 8120, 'False', 2);

INSERT INTO response VALUES (0010784522, 8120, 'They burned down the White House in Washington D.C.', 3);

INSERT INTO response VALUES (0010784522, 8120, 'A network used by slaves who escaped the United States into Canada', 4);

INSERT INTO response VALUES (0997733991, 8120, '1960', 1);

INSERT INTO response VALUES (0997733991, 8120, 'True', 2);

INSERT INTO response VALUES (0997733991, 8120, 'They burned down the White House in Washington D.C.', 3);

INSERT INTO response VALUES (0997733991, 8120, 'The CPR''s secret railway line', 4);

INSERT INTO response VALUES (5555555555, 8120, 'False', 2);

INSERT INTO response VALUES (5555555555, 8120, 'They captured Niagara Falls', 3);
