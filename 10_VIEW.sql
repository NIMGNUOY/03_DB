/*
 *	<< VIEW >> 
 * - SELECT 문의 실행결과(RESULT SET)를 화면에 저장하고 있는 객체
 * - 논리적 가상 테이블
 * --> 테이블 모양을 하고는 있지만, 실제로 값을 저장하고 있지는 않다
 * 
 * 
 * < VIEW 사용목적 >
 * 1) 복잡한 SELECT 문을 쉽게 재사용하기 위해서 사용
 * 2) 테이블의 진짜 모습을 감출 수 있어 보안상 유리하다.
 * 
 * 
 * *** VIEW 사용시 주의사항 ***
 * 1) 가상 테이블(실제 테이블X) --> ALTER 등 구문 사용 불가
 * 2) VIEW를 이용한 DML(INSERT, UPDATE, DELETE)이 가능한 경우도 있지만
 * 		많은 제약이 따르기 때문에 SELECT 용도로 사용하는 것을 권장
 * 
 * 
 * [VIEW 생성 방법]
 * CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름
 * AS SUBQUERY(만들고 싶은 뷰 모양의 SUBQUERY)
 * [WITH CHECK OPTION]
 * [WITH READ ONLY];
 * 
 * -- 1) OR REPLACE : 기존에 동일한 뷰 이름이 존재하는 경우는 덮어쓰고,
 * 										존재하지 않으면 새로 생성.
 * 
 * -- 2) FORCE | NOFORCE
 * 			- FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
 * 			- NOFORCE : 서브쿼리에 사용된 테이블이 반드시 존재해야만 뷰 생성(기본값)
 * 
 * -- 3) WITH CHECK OPTION : 옵션을 설정한 컬럼의 값을 수정 불가능하게 함.
 * 
 * -- 4) WITH READ ONLY : 뷰에 대해 조회만 가능(DML 수행 불가)
 * 
 */


-- 사번, 이름, 부서명, 직급명 조회 결과를 저장하는 VIEW 생성
CREATE VIEW V_EMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
	 FROM EMPLOYEE
	 NATURAL JOIN JOB
	 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
	
-- ORA-01031: 권한이 불충분합니다
-- 1) SYS 관리자 계정 접속
-- 2) ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- 3) GRANT CREATE VIEW TO kh_sym;
-- 4) 권한 부여받은 kh_sym 계정으로 접속하여 위 VIEW 생성구문 다시 실행

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

GRANT CREATE VIEW TO kh_sym;



-- 생성된 VIEW를 이용하여 조회 --
SELECT * FROM V_EMP;


-----------------------------------------------------------------------------------------------------------------


-- OR REPLACE 확인 + 별칭 등록

CREATE OR REPLACE VIEW V_EMP
AS SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_TITLE 부서명, JOB_NAME 직급명
	 FROM EMPLOYEE
	 NATURAL JOIN JOB
	 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- ORA-00955: 기존의 객체가 이름을 사용하고 있습니다. --> 뷰 이름 중복
-- OR REPLACE 추가 후 실행 --> 성공
	--> 기존 V_EMP 를 새로운 VIEW 로 덮어쓰기
	
SELECT * FROM V_EMP;


-----------------------------------------------------------------------------------------------------------------

-- < VIEW 를 이용한 DML 확인 > -- 

-- 테이블 복사
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY2;

-- 복사한 테이블을 이용해서 VIEW 생성
CREATE OR REPLACE VIEW V_DCOPY2
AS SELECT DEPT_ID, LOCATION_ID FROM DEPT_COPY2;


-- 뷰 생성 확인
SELECT * FROM V_DCOPY2;


-- 뷰를 이용한 INSERT
INSERT INTO V_DCOPY2 VALUES ('D0', 'L3');		-- 1행이 삽입되었음

SELECT * FROM V_DCOPY2;		-- VIEW에  'D0'	'L3' 행 추가 확인
--> 가상의 테이블인 VIEW 에 데이터 삽입이 가능한걸까 ? NO

-- 원본 테이블 확인
SELECT * FROM DEPT_COPY2;		-- 'D0' 	NULL	'L3'	추가
--> VIEW 에 삽입한 내용이 원본 테이블에 존재함
--> VIEW 를 이용한 DML 구문이 원본에 영향을 미친다.


-- VIEW 의 본래 목적인 보여지는 것(조회)라는 용도에 맞게 사용하는 것을 권장
--> WITH READ ONLY 옵션 사용

CREATE OR REPLACE VIEW V_DCOPY2
AS SELECT DEPT_ID, LOCATION_ID FROM DEPT_COPY2
WITH READ ONLY;		-- 읽기 전용 VIEW 생성(SELECT 만 가능) => DML 구문 불가능

INSERT INTO V_DCOPY2 VALUES ('D0', 'L3');
-- ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

SELECT * FROM V_DCOPY2;






























