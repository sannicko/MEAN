CREATE VIEW gradelevel AS (
  SELECT s.level, e.grade, COUNT(*)
  FROM enroll e
  INNER JOIN students s USING (student_id)
	GROUP BY s.level, e.grade
  order by s.level, e.grade;

SELECT * FROM gradelevel;