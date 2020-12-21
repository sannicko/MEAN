
CREATE OR REPLACE FUNCTION GetStudentInfo(P_StudentId students.student_id%type)
RETURNS students
AS $$
  SELECT student_id, name, date_of_birth, address, email, level
  FROM students
  WHERE student_id = P_StudentId;
$$ language SQL;


