CREATE INDEX enroll_grade_idx ON enroll (grade);
EXPLAIN SELECT * FROM enroll where grade ='A';