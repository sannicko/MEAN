CREATE OR REPLACE FUNCTION GetStudentInfo(P_StudentId students.student_id%type)
RETURNS students
AS $$
  SELECT student_id, name, date_of_birth, address, email, level
  FROM students
  WHERE student_id = P_StudentId;
$$ language SQL;


CREATE OR REPLACE FUNCTION courses_pending_to_enroll(P_StudentId students.student_id%type)
RETURNS SETOF record 
AS $$
  SELECT s.name, c.course_id, c.description, c.level
  FROM courses c, students s  
  WHERE s.student_id = P_StudentId
  AND c.course_id NOT IN (select g.course_id FROM gradebook g WHERE g.student_id = s.student_id)
$$
language SQL;


CREATE OR REPLACE FUNCTION courses_enrolled(P_StudentId students.student_id%type)
RETURNS SETOF record 
AS $$
  SELECT s.name, c.course_id, c.description, c.level, fc.name as instructor
  FROM courses c, students s, facultycourses fc  
  WHERE s.student_id = P_StudentId
    AND c.course_id IN (SELECT g.course_id FROM gradebook g where g.student_id = s.student_id)
	AND fc.course_id = c.course_id
$$
language SQL;


CREATE OR REPLACE FUNCTION get_course_with_highest_grade(P_StudentId students.student_id%type)
RETURNS record 
AS 
$$
  SELECT g.course_id, g.description, g.courses_level, g.grade
  FROM gradebook g
  WHERE g.student_id = P_StudentId
  ORDER BY g.grade 
  LIMIT 1
$$
language SQL;


CREATE OR REPLACE FUNCTION get_level_grades(P_StudentId students.student_id%type)
RETURNS setof record 
AS 
$$
  SELECT * FROM gradelevel 
  WHERE LEVEL = (SELECT LEVEL FROM students WHERE student_id = P_StudentId)
$$
language SQL;


CREATE OR REPLACE FUNCTION get_count_student_grades(P_StudentId students.student_id%type)
RETURNS SETOF record 
AS 
$$
  SELECT grade, COUNT(grade) 
  FROM gradebook  
  WHERE student_id = P_StudentId
  GROUP BY grade
  ORDER BY grade;
$$
language SQL;