-- View: public.facultycourses

-- DROP VIEW public.facultycourses;

CREATE OR REPLACE VIEW public.facultycourses
 AS
 SELECT f.faculty_id,
    f.name,
    f.level,
    c.course_id,
    c.description,
    c.level AS course_level
   FROM faculties f
     JOIN courses c ON f.faculty_id = c.instructor;

ALTER TABLE public.facultycourses
    OWNER TO fall20_yjime030;

