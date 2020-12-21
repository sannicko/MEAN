CREATE OR REPLACE VIEW gradebook AS
SELECT s.student_id, 
        s.name, 
		s.level, 
		c.course_id, 
		c.description,
		c.level as courses_level,
		e.grade 		
FROM students s, 
      courses c, 
	  enroll e
where s.student_id = e.student_id
  and c.course_id = e.course_id;

 SELECT * FROM grade;