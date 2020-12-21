CREATE OR REPLACE FUNCTION getallstudentinfo(p_studentid integer)
RETURNS SETOF record
AS $$
DECLARE
  r_studentinfo record;
  r_courses record;
  r_pend_courses record;
  r_highest_grade record;
  r_count_student_grades record;
  r_level_grades record;
BEGIN
  r_studentinfo := getstudentinfo(p_studentid);
  r_courses := courses_enrolled(p_studentid);
  r_pend_courses := courses_pending_to_enroll(p_studentid);
  r_highest_grade := get_course_with_highest_grade(P_studentid);
  r_count_student_grades := get_count_student_grades(p_studentid);
  r_level_grades := get_level_grades(p_studentid);
END;
$$
LANGUAGE PLPGSQL;


