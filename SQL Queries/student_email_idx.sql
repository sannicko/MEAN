CREATE INDEX student_email_idx ON students (email);
EXPLAIN SELECT * FROM students where email ='awood001@cis.fiu.edu';