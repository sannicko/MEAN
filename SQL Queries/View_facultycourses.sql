CREATE or replace VIEW facultycourses as
SELECT faculty_id, f.name, f.level, c.course_id, c.description, c.level as course_level
FROM faculties f
INNER JOIN courses c ON f.faculty_id = c.instructor;

select * from facultycourses;