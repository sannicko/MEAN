CREATE OR REPLACE FUNCTION getFinalResult()
	RETURNS TABLE 
	(
		school text,
		grade text,
		std numeric
	)
	LANGUAGE plpgsql
AS $func$
DECLARE
	_index integer:= 1;
	std numeric[];
	finalGrades numeric:= 0;
	school_name Text;
	School_count integer := 0;
	Std_count integer := 0;
BEGIN
	SELECT COUNT(school_code) INTO School_count FROM school_probs;

LOOP
	EXIT WHEN School_count = 0;
	SELECT school_probs.school INTO school_name FROM school_probs WHERE school_code = School_count;
	SELECT COUNT(record_id) INTO Std_count FROM simulated_records WHERE simulated_records.school = school_name GROUP BY simulated_records.school;
	DROP TABLE IF EXISTS temp_table;
	CREATE TABLE temp_table( score text,std_probs numeric);
	LOOP
		EXIT WHEN _index = 7;
			SELECT probs[_index]*Std_count into finalGrades
			FROM school_probs WHERE school_code = School_count;
			std[_index] := ROUND(finalGrades);
			_index := _index+1;
	END LOOP;
		_index:=1;
		INSERT INTO temp_table VALUES('95 - 100',std[1]),('90 - 94',std[2]),('80 - 89',std[3]),('70 - 79',std[4]),('60 - 69',std[5]),('0 - 59',std[6]);
		std := Null;
	RETURN QUERY
		SELECT
			school_name,
			score,
			std_probs
		FROM
			temp_table;
School_count := School_count - 1;
END LOOP;
END;$func$;

SELECT * FROM getFinalResult()
ORDER BY
	school ASC,
	grade DESC;