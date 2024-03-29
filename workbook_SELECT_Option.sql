

-- 1번 문제 --
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS 주소지
FROM TB_STUDENT
ORDER BY 1;


-- 2번 문제 --
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC;


-- 3번 문제 --
SELECT STUDENT_NAME, STUDENT_NO, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '강원%' OR STUDENT_ADDRESS LIKE '경기%')
AND SUBSTR( EXTRACT (YEAR FROM ENTRANCE_DATE),1,2 ) = '19'
ORDER BY 1;

-- 4번 문제 --
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO = '005'
ORDER BY 2;


-- 5번 문제 --
SELECT STUDENT_NO, POINT
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE TERM_NO = '200402'
AND CLASS_NO ='C3118100'
ORDER BY 2 DESC, 1;


-- 6번 문제 --
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY 2;


-- 7번 문제 --
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);


-- 8번 문제 --
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO);


-- 9번 문제 -- 
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS TC
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO)
WHERE TC.DEPARTMENT_NO BETWEEN 1 AND 21;
-- ORA-00918: 열의 정의가 애매합니다


-- 10번 문제 -- 
SELECT STUDENT_NO, STUDENT_NAME, ROUND (AVG (POINT),1)
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NO = '059'
GROUP BY STUDENT_NO , STUDENT_NAME ;
-- WHERE 조건절 밑에 GROUP BY 절


-- 11번 문제 --
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';


-- 12번 문제 --
SELECT STUDENT_NAME, TERM_NO "TERM_NAME"
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_CLASS USING (CLASS_NO)
WHERE TERM_NO LIKE '2007%'
AND CLASS_NAME = '인간관계론';


-- 13번 문제 --
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO) 
-- TB_CLASS 에는 있으나 
-- TB_CLASS_PROFESSOR 테이블에는 없는 CLASS
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE (DEPARTMENT_NO BETWEEN 56 AND 63)
AND PROFESSOR_NO IS NULL;


-- 14번 문제 --
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT TS
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE TS.DEPARTMENT_NO = '020'
ORDER BY STUDENT_NO;


-- 15번 문제 -- 
SELECT STUDENT_NO 학번, 
			 STUDENT_NAME 이름, 
			 DEPARTMENT_NAME "학과 이름", 
			 TRUNC( AVG(POINT), 2 ) 평점
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO , STUDENT_NAME, DEPARTMENT_NAME
HAVING  AVG(POINT) >= 4
ORDER BY STUDENT_NO;


-- 16번 문제 --
SELECT CLASS_NO, CLASS_NAME, TRUNC( AVG(POINT), 2 ) "AVG(POINT)"
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
WHERE DEPARTMENT_NO = '034'
AND CLASS_TYPE LIKE '전공%'
GROUP BY CLASS_NO , CLASS_NAME 
ORDER BY CLASS_NO;

--------------------------------------------------------------------------------------------------
-- 9번 문제 --
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
JOIN TB_PROFESSOR USING (PROFESSOR_NO)
JOIN TB_DEPARTMENT ON (TB_PROFESSOR.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회';


-- 10번 문제 --
SELECT STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND (AVG(POINT), 1) "전체 평점"
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1;


-- 13번 문제 --
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING (CLASS_NO)
LEFT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO BETWEEN 56 AND 63
AND PROFESSOR_NO IS NULL;
---------------------------------------------------------------------------------------------------

































