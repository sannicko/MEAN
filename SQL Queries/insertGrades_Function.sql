CREATE OR REPLACE FUNCTION insertGrades()
RETURNS VOID
LANGUAGE plpgsql
AS $func$
DECLARE
_index integer:= 1;
std numeric[];
stdGradeCnt numeric:= 0;
school_name Text;
School_count integer := 0;
Std_count integer := 0;
stdGrade Text;
BEGIN
SELECT COUNT(school_code) INTO School_count FROM school_probs;
LOOP
EXIT WHEN School_count = 0;

SELECT school_probs.school INTO school_name FROM school_probs WHERE school_code = School_count;
SELECT COUNT(record_id) INTO Std_count FROM simulated_records WHERE simulated_records.school = school_name GROUP BY simulated_records.school;

LOOP
EXIT WHEN _index = 7;
SELECT round(probs[_index]*Std_count) into stdGradeCnt
FROM school_probs WHERE school_code = School_count;

SELECT grade INTO stdGrade
FROM grade_values WHERE ID=_index;

_index := _index+1;

UPDATE simulated_records SET grade=stdGrade
WHERE record_id IN 
(SELECT record_id FROM simulated_records 
  WHERE school=school_name 
  AND grade='-'
  ORDER BY record_id
 LIMIT stdGradeCnt
);

END LOOP;

_index:=1;
std := Null;
School_count := School_count - 1;
END LOOP;
END;$func$;

SELECT insertGrades();