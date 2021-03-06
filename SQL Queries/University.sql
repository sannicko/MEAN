PGDMP     
                
    x            fall20_yjime030    9.5.3    12.4 5    +           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ,           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            -           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            .           1262    1588246    fall20_yjime030    DATABASE     �   CREATE DATABASE fall20_yjime030 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE fall20_yjime030;
                fall20_yjime030    false            /           0    0    DATABASE fall20_yjime030    ACL     �   REVOKE ALL ON DATABASE fall20_yjime030 FROM PUBLIC;
REVOKE ALL ON DATABASE fall20_yjime030 FROM fall20_yjime030;
GRANT ALL ON DATABASE fall20_yjime030 TO fall20_yjime030;
                   fall20_yjime030    false    3118            0           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM root;
GRANT ALL ON SCHEMA public TO root;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   root    false    6                        2615    1588520    universityacme    SCHEMA        CREATE SCHEMA universityacme;
    DROP SCHEMA universityacme;
                fall20_yjime030    false            �            1255    1604098    courses_enrolled(integer)    FUNCTION     �  CREATE FUNCTION public.courses_enrolled(p_studentid integer) RETURNS SETOF record
    LANGUAGE sql
    AS $$
  SELECT s.name, c.course_id, c.description, c.level, fc.name as instructor
  FROM courses c, students s, facultycourses fc  
  WHERE s.student_id = P_StudentId
    AND c.course_id IN (SELECT g.course_id FROM gradebook g where g.student_id = s.student_id)
	AND fc.course_id = c.course_id
$$;
 <   DROP FUNCTION public.courses_enrolled(p_studentid integer);
       public          fall20_yjime030    false            �            1255    1604097 "   courses_pending_to_enroll(integer)    FUNCTION     R  CREATE FUNCTION public.courses_pending_to_enroll(p_studentid integer) RETURNS SETOF record
    LANGUAGE sql
    AS $$
  SELECT s.name, c.course_id, c.description, c.level
  FROM courses c, students s  
  WHERE s.student_id = P_StudentId
  AND c.course_id NOT IN (select g.course_id FROM gradebook g WHERE g.student_id = s.student_id)
$$;
 E   DROP FUNCTION public.courses_pending_to_enroll(p_studentid integer);
       public          fall20_yjime030    false            �            1255    1604104 !   get_count_student_grades(integer)    FUNCTION     �   CREATE FUNCTION public.get_count_student_grades(p_studentid integer) RETURNS SETOF record
    LANGUAGE sql
    AS $$
  SELECT grade, COUNT(grade) 
  FROM gradebook  
  WHERE student_id = P_StudentId
  GROUP BY grade
  ORDER BY grade;
$$;
 D   DROP FUNCTION public.get_count_student_grades(p_studentid integer);
       public          fall20_yjime030    false            �            1255    1604102 &   get_course_with_highest_grade(integer)    FUNCTION     
  CREATE FUNCTION public.get_course_with_highest_grade(p_studentid integer) RETURNS record
    LANGUAGE sql
    AS $$
  SELECT g.course_id, g.description, g.courses_level, g.grade
  FROM gradebook g
  WHERE g.student_id = P_StudentId
  ORDER BY g.grade 
  LIMIT 1
$$;
 I   DROP FUNCTION public.get_course_with_highest_grade(p_studentid integer);
       public          fall20_yjime030    false            �            1255    1604103    get_level_grades(integer)    FUNCTION     �   CREATE FUNCTION public.get_level_grades(p_studentid integer) RETURNS SETOF record
    LANGUAGE sql
    AS $$
  SELECT * FROM gradelevel 
  WHERE LEVEL = (SELECT LEVEL FROM students WHERE student_id = P_StudentId)
$$;
 <   DROP FUNCTION public.get_level_grades(p_studentid integer);
       public          fall20_yjime030    false            �            1255    1604106    getallstudentinfo(integer)    FUNCTION     s  CREATE FUNCTION public.getallstudentinfo(p_studentid integer) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
DECLARE
  r_studentinfo record;
  r_courses record;
  r_pend_courses record;
  r_highest_grade record;
  r_count_student_grades record;
  r_level_grades record;
BEGIN
  r_studentinfo := getstudentinfo(p_studentid);
  r_courses := courses_enrolled(p_studentid);
  r_pend_courses := courses_pending_to_enroll(p_studentid);
  r_highest_grade := get_course_with_highest_grade(P_studentid);
  r_count_student_grades := get_count_student_grades(p_studentid);
  r_level_grades := get_level_grades(p_studentid);
END;
$$;
 =   DROP FUNCTION public.getallstudentinfo(p_studentid integer);
       public          fall20_yjime030    false            �            1255    1598923    getfinalresult()    FUNCTION     �  CREATE FUNCTION public.getfinalresult() RETURNS TABLE(school text, grade text, std numeric)
    LANGUAGE plpgsql
    AS $$
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
END;$$;
 '   DROP FUNCTION public.getfinalresult();
       public          fall20_yjime030    false            �            1259    1589531    students    TABLE     �   CREATE TABLE public.students (
    student_id integer NOT NULL,
    name text NOT NULL,
    date_of_birth date,
    address text,
    email text,
    level text NOT NULL
);
    DROP TABLE public.students;
       public            fall20_yjime030    false            �            1255    1604086    getstudentinfo(integer)    FUNCTION     �   CREATE FUNCTION public.getstudentinfo(p_studentid integer) RETURNS public.students
    LANGUAGE sql
    AS $$
  SELECT student_id, name, date_of_birth, address, email, level
  FROM students
  WHERE student_id = P_StudentId;
$$;
 :   DROP FUNCTION public.getstudentinfo(p_studentid integer);
       public          fall20_yjime030    false    182            �            1255    1602425    insertgrades()    FUNCTION     4  CREATE FUNCTION public.insertgrades() RETURNS void
    LANGUAGE plpgsql
    AS $$
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
END;$$;
 %   DROP FUNCTION public.insertgrades();
       public          fall20_yjime030    false            �            1259    1589551    courses    TABLE     �   CREATE TABLE public.courses (
    course_id integer NOT NULL,
    description text NOT NULL,
    level text NOT NULL,
    instructor integer,
    semester text
);
    DROP TABLE public.courses;
       public            fall20_yjime030    false            �            1259    1589564    enroll    TABLE     y   CREATE TABLE public.enroll (
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    grade text NOT NULL
);
    DROP TABLE public.enroll;
       public            fall20_yjime030    false            �            1259    1589541 	   faculties    TABLE     �   CREATE TABLE public.faculties (
    faculty_id integer NOT NULL,
    name text NOT NULL,
    date_of_birth date,
    address text,
    email text,
    level text NOT NULL
);
    DROP TABLE public.faculties;
       public            fall20_yjime030    false            �            1259    1604077    facultycourses    VIEW     �   CREATE VIEW public.facultycourses AS
 SELECT f.faculty_id,
    f.name,
    f.level,
    c.course_id,
    c.description,
    c.level AS course_level
   FROM (public.faculties f
     JOIN public.courses c ON ((f.faculty_id = c.instructor)));
 !   DROP VIEW public.facultycourses;
       public          fall20_yjime030    false    184    184    183    184    183    183    184            �            1259    1598892    grade_values    TABLE     p   CREATE TABLE public.grade_values (
    id integer NOT NULL,
    score text NOT NULL,
    grade text NOT NULL
);
     DROP TABLE public.grade_values;
       public            fall20_yjime030    false            �            1259    1604073 	   gradebook    VIEW     +  CREATE VIEW public.gradebook AS
 SELECT s.student_id,
    s.name,
    s.level,
    c.course_id,
    c.description,
    c.level AS courses_level,
    e.grade
   FROM public.students s,
    public.courses c,
    public.enroll e
  WHERE ((s.student_id = e.student_id) AND (c.course_id = e.course_id));
    DROP VIEW public.gradebook;
       public          fall20_yjime030    false    182    182    182    184    184    184    185    185    185            �            1259    1603933 
   gradelevel    VIEW     �   CREATE VIEW public.gradelevel AS
 SELECT s.level,
    e.grade,
    count(*) AS count
   FROM (public.students s
     JOIN public.enroll e USING (student_id))
  GROUP BY s.level, e.grade;
    DROP VIEW public.gradelevel;
       public          fall20_yjime030    false    182    185    185    182            �            1259    1598884    school_probs    TABLE     ~   CREATE TABLE public.school_probs (
    school_code bigint NOT NULL,
    school text NOT NULL,
    probs numeric[] NOT NULL
);
     DROP TABLE public.school_probs;
       public            fall20_yjime030    false            �            1259    1598900    simulated_records    TABLE     |   CREATE TABLE public.simulated_records (
    record_id bigint NOT NULL,
    school text NOT NULL,
    grade text NOT NULL
);
 %   DROP TABLE public.simulated_records;
       public            fall20_yjime030    false            �            1259    1602418 
   temp_table    TABLE     J   CREATE TABLE public.temp_table (
    score text,
    std_probs numeric
);
    DROP TABLE public.temp_table;
       public            fall20_yjime030    false            �            1259    1596882    title    TABLE     M   CREATE TABLE public.title (
    name text NOT NULL,
    abbreviation text
);
    DROP TABLE public.title;
       public            fall20_yjime030    false            "          0    1589551    courses 
   TABLE DATA           V   COPY public.courses (course_id, description, level, instructor, semester) FROM stdin;
    public          fall20_yjime030    false    184   �L       #          0    1589564    enroll 
   TABLE DATA           >   COPY public.enroll (student_id, course_id, grade) FROM stdin;
    public          fall20_yjime030    false    185   bM       !          0    1589541 	   faculties 
   TABLE DATA           [   COPY public.faculties (faculty_id, name, date_of_birth, address, email, level) FROM stdin;
    public          fall20_yjime030    false    183   �M       &          0    1598892    grade_values 
   TABLE DATA           8   COPY public.grade_values (id, score, grade) FROM stdin;
    public          fall20_yjime030    false    188   �N       %          0    1598884    school_probs 
   TABLE DATA           B   COPY public.school_probs (school_code, school, probs) FROM stdin;
    public          fall20_yjime030    false    187   O       '          0    1598900    simulated_records 
   TABLE DATA           E   COPY public.simulated_records (record_id, school, grade) FROM stdin;
    public          fall20_yjime030    false    189   �O                  0    1589531    students 
   TABLE DATA           Z   COPY public.students (student_id, name, date_of_birth, address, email, level) FROM stdin;
    public          fall20_yjime030    false    182   �b       (          0    1602418 
   temp_table 
   TABLE DATA           6   COPY public.temp_table (score, std_probs) FROM stdin;
    public          fall20_yjime030    false    190   d       $          0    1596882    title 
   TABLE DATA           3   COPY public.title (name, abbreviation) FROM stdin;
    public          fall20_yjime030    false    186   ad       �           2606    1589558    courses courses_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);
 >   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_pkey;
       public            fall20_yjime030    false    184            �           2606    1589571    enroll enroll_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.enroll
    ADD CONSTRAINT enroll_pkey PRIMARY KEY (student_id, course_id);
 <   ALTER TABLE ONLY public.enroll DROP CONSTRAINT enroll_pkey;
       public            fall20_yjime030    false    185    185            �           2606    1589550    faculties faculties_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_email_key UNIQUE (email);
 G   ALTER TABLE ONLY public.faculties DROP CONSTRAINT faculties_email_key;
       public            fall20_yjime030    false    183            �           2606    1589548    faculties faculties_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_pkey PRIMARY KEY (faculty_id);
 B   ALTER TABLE ONLY public.faculties DROP CONSTRAINT faculties_pkey;
       public            fall20_yjime030    false    183            �           2606    1598899    grade_values grade_values_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.grade_values
    ADD CONSTRAINT grade_values_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.grade_values DROP CONSTRAINT grade_values_pkey;
       public            fall20_yjime030    false    188            �           2606    1598891    school_probs school_probs_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.school_probs
    ADD CONSTRAINT school_probs_pkey PRIMARY KEY (school_code);
 H   ALTER TABLE ONLY public.school_probs DROP CONSTRAINT school_probs_pkey;
       public            fall20_yjime030    false    187            �           2606    1598907 (   simulated_records simulated_records_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.simulated_records
    ADD CONSTRAINT simulated_records_pkey PRIMARY KEY (record_id);
 R   ALTER TABLE ONLY public.simulated_records DROP CONSTRAINT simulated_records_pkey;
       public            fall20_yjime030    false    189            �           2606    1589540    students students_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.students DROP CONSTRAINT students_email_key;
       public            fall20_yjime030    false    182            �           2606    1589538    students students_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);
 @   ALTER TABLE ONLY public.students DROP CONSTRAINT students_pkey;
       public            fall20_yjime030    false    182            �           2606    1596889    title title_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.title
    ADD CONSTRAINT title_pkey PRIMARY KEY (name);
 :   ALTER TABLE ONLY public.title DROP CONSTRAINT title_pkey;
       public            fall20_yjime030    false    186            �           1259    1604084    enroll_grade_idx    INDEX     D   CREATE INDEX enroll_grade_idx ON public.enroll USING btree (grade);
 $   DROP INDEX public.enroll_grade_idx;
       public            fall20_yjime030    false    185            �           1259    1603941    index_student    INDEX     C   CREATE INDEX index_student ON public.students USING btree (email);
 !   DROP INDEX public.index_student;
       public            fall20_yjime030    false    182            �           1259    1604083    student_email_idx    INDEX     G   CREATE INDEX student_email_idx ON public.students USING btree (email);
 %   DROP INDEX public.student_email_idx;
       public            fall20_yjime030    false    182            �           2606    1589789    courses courses_instructor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_instructor_fkey FOREIGN KEY (instructor) REFERENCES public.faculties(faculty_id) ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_instructor_fkey;
       public          fall20_yjime030    false    2970    184    183            �           2606    1589577    enroll enroll_course_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.enroll
    ADD CONSTRAINT enroll_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);
 F   ALTER TABLE ONLY public.enroll DROP CONSTRAINT enroll_course_id_fkey;
       public          fall20_yjime030    false    184    2972    185            �           2606    1589572    enroll enroll_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.enroll
    ADD CONSTRAINT enroll_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);
 G   ALTER TABLE ONLY public.enroll DROP CONSTRAINT enroll_student_id_fkey;
       public          fall20_yjime030    false    2966    182    185            "   �   x�uλ�0����|��QVT�RWCL��8U��{�Pf�{3(;6����A/�o;���K@g#Ƞn�c��a6S9�� g��Wl=n��?x��M7��<��%�������!:9�?���5�uK��~+�F��~�.)9�O2�����9!���%
�0�;�϶��k_�      #   C   x����0��w� �Q�~[S��>�e9Z5m�xRn�:���R᥁���~y��Oʢ|�s�~��
�      !   �   x�m�An�0E��)�F����k����*�n��$H`*R����Uڮ�o����.�l�q��
l�v�j�
`��e�mo1�c�O��a�gV�q�.�lv�kZ|4hM�$\��ºG��5��?|Oƍv��j\��(�
��"ݏ;���(���p�h�r��l�k�M�	�	e��@�4�����%���Z���� y�50�T���K�X�����J��i͌���&�$�΁IE��0jn�G,|��_�,˾�Yl�      &   D   x�Ǳ� ���
r�����C>ۭ���j)�������ycD��6�Hߡ��.<tMx��$�%�      %   �   x�����0�g�Y�*�M�6B��t�MP��R*+9}>�Y��L/3�8��2��+���N�PRYբ����b��=���m��P��P���� �6��ԿN�V@�
&ÞӔ��|&ʄ��6�.S}��^>��z��뽧*G*���92��gC�      '      x�U�I��n�Ǖ[q���_��a{���� q|'�]�a#�R�!��������������N��q!o�lԻ������o��^x�g/l�U��J+\�[���K=�K�M}om���U�3�Y�d���c]��lE�E�B>��]Ƀ�}��e�d-v�}�V�qF�(�1
���J�U|�2����/�3�r�{��K��o�Ia��,횣�K��
��g�Y�yJ�)E�%~�SY�곰.�Q4��%����.-qJ�eE�p�_�4ꥌ��~�Y��Y�_ʹ �O����P��셵0���Wa֠�W��s�
�9��e�Z�h�(����FJ+/�\x>�V�S�y��>	fm���a�����N�n��߽�g�7����&�z�ȳ���7�Rp��<	V�3�����������[�}#�4A�$�|͓���_�GG���,}Bڿ���?�����[���³���X����Z�ߊ/|��m6��5Y�wZ/���urz+\��㕃xx^��*�����\jX��å��žG5Rj�ɼRb��6�l��ʽ0cjg.�����⫬S7}���:���2��ʸ�3��q��'s���^�ܵ���Κ�rC.��k���e���³0��M�o_���#�?�����v|��'+<��M�蜍�����<�b�W|���yHᢙ�^j��.��%�hl���ޫ�m���g��[��'CK.e[����v���\���v杣�K���9K=���Ԣ���Ԭ�V_��9�f/��V���p��ʥc��i�
v�y��1�2o�i׶
ka��^���9��Ç�]�N�6_-v-q����+�M��A�b�UX�3��F�w�b%�MXaaW��_��|��kS�&��������k�ߕGa�����<���>��<t>���4&�C��2��ݵ<���@^�~:=����z�F[IݓFO��	<Ē�=�-��[�$��<�٣�|n�v� ��vv.�I>��G��&-ج�`s�v{tn��R'��G��:�nwP֬-+UԬ�Yl�U�Yy	�+�ם�XO�!�����^3��yf����|���.�����4A�W]�o�!?�4-�D8�l=�'�v-�{�X �^9g�����< �B��{�8�ӷ���N� }�(����z6�wE�I;��S@8:�w �;I�r?@Y�pxxfh�l�m"�;q�	�ѕ�&�tj�2]@�1ۦ-��6Aَ5(k^�5�[�(��:d��AO0s3GV��HA����(zWvF�6@Y�����{.�����ݓ�)�x�5�%mD��OW��z�9�2݂���=g�v�!�������"G6�3�\��?�������p��=A��~	Z �6C��g{�n�����徟�}~s�~�����6��S��7�����5*a$HBj�k��,K��`���gg��4�a��ҲR�t�m줯K�4I�{�k�!{4��h�����@Y����k�!D6���,%IY��Y�C�?��� Y���I��=�h�����"Щ�2�� ����	�Ⱥd ��zuDq�zz����],P�ڜ���ۂNE;�|�����6@�{e�e;��s��C�.۝u���+���	�`k���ۯ<��'�#5+AS�����؃L�3�~�u�Kz}t��ݐ��G�9�N��_G�Q�РRP���5w����!�y��GQ�wUIڨ ��[M'(s��0�A�5O�c����g��s4<&l�ɉ�MT�V�����j�yW��]ȱ&t3�綏$[������s���x��[N�.�M�Zc)h�6e(椎��:T�6@y��Ϲ�Z���Y�4POR�̓�l
��ΣoM
��g<
߳���tG&HA8z�
� x(�p��� Ļ���푺=3�F[��}{#6I����x�^z�+��XZ�&8`��lE�y�=��� ɥ?��@���
tXG��A�@����-ѐ�|'�p�F��|���w
�gg��`���z�[d<���I4�+=v%�tsZ_����뒃�8�&���ܬ>d�x~����v'q�X{#�:��Ty��Nd���P�.Q���Y���q�(D�5�ъ��z8�B�{����ʌ�9�9�9g��Ϝ}�Į�{V �ϝZg��f�w��E��ĉ�[�&H�U��Nȳ�yҳ�Q`�D!n�vQ������)�tc�m?�zh�hD
&�� .%�m�MP��(psZYo��Y�`�!h���K4#�m"*����75�5�H�d'R`H��b5�a�;OmQ��A8 �DA�բ�tS'2.Kg0G+�3J�[|�҈�h��zb�@��Z񭂱�����D��݉l��؅�D��ܘ�8��@FX�-v=��'�R��D��l��LF�!�iC<4���A8[�~?���\g�ϧ������ӯߟ�=�>@�Ų��$O[||id�x�{i��[G�0��<r��8I/�hL�C��R����
�mA'[L�K�ط��=m�AO���mp��JK��ȫ�۷��r��&X�s��♇fz��K����퉵���KGZ&�y�뚟f񚑭�2�K�hc$�N�g���c�[	�2��CoĿm����Ϟ]�35�.��bM��z<��9��_a;#������9{��lI�L�3i|����`�����f��b�|i'MKZ8��k��S��sa ���G�
�m�d�����9��x��$h-P��A���i��0�ZF�m�2�Ds��w����%�:�QO�ճ�����,�h�E+�#A���m��eA��r����:����} ��K���٥NJ�b�(FU}���������P��Rø��-$�?��-x<�@�U�0�#m�x8{�V.ط�C�'���K����E&QGQv�w%���ZI��9�P�[�b�9�C�q�����_��̃3��L8i.�����#)>��;���,iK�y��ء�� �g�xȨqk�H�i�C�u3��I\�o��FT"���'�&��)�Z�FqwO���뇃Z��wg݈��!���=d��.��jDԻ������7KkD�-��Dj͔9��.�	���E��iuX��A��+��7UZ-V+�D�� 2�[�g6&m����o�JAj��8K��c�{��!�s>8'�s�Q�h||���Env�� lN�o�
w2~�
?��D�96gK���Q8�@n�o�[�a���go�zΰ�)ƀ ��xl��DfW""ĭ�Åz'[<�Z�x:R̽�Ю����Khjw'"�IC��V�?O0
.�aa,D��-�8ݜ���WJ���m(R�$B�����I-ۦ7�A,V���\��k,�-��D%R�F36O�V�@F؈�'q��*DF0jY�;���7'��̶ٶ=PΞ�H��}ۢ�_��I�D
����;�}�Td	�`&�Ipa?8'X���s�9{/d�x`�(������Ak�=O�htK�_�?�H� N�B��=�CE�PC<�MD��4��[�8/)�[�NT�^���('��㻇��iUZ��Ԉh�� :�X���`���1�,R�nB���Q`lc��F���Y�quQ�Po��>q�Q���6����_�%���(ǔVf3v��CJ �|��V�-��2�+�Tgbg3����́=;	���ś��������w��r����^'�m��h]��:8��`FA����b����v���$"X�p;�Ld]�ͳ�l�(0�����r�f��r6⎜��V'�:hH7ٓ��a��O�8׺�lq|��Бb5$^�X�5��DZ�Z���`�;��5Vf�����:�a���Q|��݅�+���K)�X��v�q95���h��ϔ���8Ϸް|W�x6�o�	\��:n�)贎FT�Q�)�oX���9�r� ľ���>��B��n�!��x�Հ��@
ެ��_�h��>�s/'n��������R{"��Q�>�}���!�{%�iO�zB:���	O2`��>�2�'�։F��/�8���6)X,&^N7�v_�M�p�F�Nk�D
�.
D���   h�`��N�#�l�8�H_'$��mN�t�̶��M�@FP
ؠ����x����/�J��b9kR�L
���C����j~�a�;(m�c��G��	v��\ Mx����g�P�8<r :(��_�<ʪ�oP�7��S� �Gs���MP�lfͶH���9�&8�����/.�Z��pr���q������!�-<9���ö/��Y�n��6ψhtj�&�׈�&O���'�������h|���Wx �op7p3�f��j�aMh���@��D����H!2��݌��)6�6�!O�@���,ϕ���E�"�QV�މ��ʬ{#"�q`�5��2c��1��`�QdN�@jg֛��.��������K�~��6�Qf�,�d�£�$��ɗJůq�^����צ�\����6c�|iO�Qe��l����n2߬�I��V�oM[^���n/�:O8�0�K��Wa�9
���N�bW�&���z65Z���7�i�+-��L�o�J+����9w�^y.�Q4��K�Xy�)�`gV��)�`��O{�����xy�k�2\K��f����K��k�rC�۸�n�o�~�p���yY�����
N�(�@\ÿ�<�3��.��E�w\�$
��{qE��dn�w�m�J�:qy�m�.DB�l����QI:_�%r���r��Z"Ԏ��\��H�3.ֶ�kw�*7z�Q�O��*v��9/y�x�^Mx��K�n�`m^Xrb�-*�<�mh"�l9q����������(�          #  x�}��J�0��ӧ�d�4I��9dC&�l�!xS۴�V�V���d�^�9�?A��6d�}X�����YpE�vD �l�:ǘ1���q��qf��.TM�Ãq�r_u&	�2As(O�J@_�t��#�{�Ӽ�)+AqL�Z����ǘ3&' �P��`]lẛ�9e
���LDd�9��[HX�lky�7DSĄp�ّ�PuC�c�������u_������2��d�](\b�۸
��݄y�>��ϘO
:��?u���W-)S�#h�c2�����O&��Y�e_��q      (   >   x�ȹ !�X����<�V/�_8�Yy�Z7C��=ka���rF1�p��F��/��'y��      $   6   x���+.)*M.�/��1����3KR���R��"N� .������ ���     