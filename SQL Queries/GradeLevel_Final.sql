-- View: public.gradelevel

-- DROP VIEW public.gradelevel;

CREATE OR REPLACE VIEW public.gradelevel
 AS
 SELECT s.level,
    e.grade,
    count(*) AS count
   FROM students s
     JOIN enroll e USING (student_id)
  GROUP BY s.level, e.grade;

ALTER TABLE public.gradelevel
    OWNER TO fall20_yjime030;

