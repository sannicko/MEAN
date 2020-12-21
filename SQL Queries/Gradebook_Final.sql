-- View: public.gradebook

-- DROP VIEW public.gradebook;

CREATE OR REPLACE VIEW public.gradebook
 AS
 SELECT s.student_id,
    s.name,
    s.level,
    c.course_id,
    c.description,
    c.level AS courses_level,
    e.grade
   FROM students s,
    courses c,
    enroll e
  WHERE s.student_id = e.student_id AND c.course_id = e.course_id;

ALTER TABLE public.gradebook
    OWNER TO fall20_yjime030;

