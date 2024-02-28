SELECT * FROM EMPLOYEE;
-- EMPLOYEE 테이블의 모든 컬럼(*) 조회

/*
 *	SELECT (DQL 또는 DML) : 조회
 *	  
 * - 데이터를 조회(SELECT)하면 조건에 맞는 행들이 조회된다.
 *  이때, 조회된 행들의 집합을 "RESULT SET"(조회 결과의 집합)이라고 함.
 * 
 * - RESULT SET 은 0개 이상의 행을 포함할 수 있다.
 *  조건에 맞는 행이 없을 경우 0개(에러 X)
 * 
 */

-- [작성법] --
-- SELECT 컬럼명 FROM 테이블명;
--> 어떤 테이블의 특정 컬럼을 조회하겠다.

-- '*' : ALL, 모든, 모두 ... 

SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

--------------------------------------------------------------------------

-- <컬럼 값 산술 연산> --
-- 컬럼값 : 테이블 내 한 칸(== 한 셀)에 작성된 값(DATA)

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 급여, 연봉(급여 * 12) 조회
SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 FROM EMPLOYEE;


SELECT EMP_NAME + 10 FROM EMPLOYEE;
-- ORA-01722 : 수치가 부적합합니다
--> 산술 연산은 숫자(NUMBER 타입)만 가능하다

-----------------------------------------------------------------------------

-- 날짜(DATE) 타입 조회

-- EMPLOYEE 테이블에서 이름, 입사일, 오늘 날짜 조회
SELECT EMP_NAME, HIRE_DATE, SYSDATE FROM EMPLOYEE;

-- SYSDATE : 시스템상의 현재 시간(날짜)를 나타내는 상수

-- 현재 시간만 조회하기
SELECT SYSDATE FROM DUAL;

-- DUAL(DUmmy tAbLe) 테이블 : 가짜 테이블(임시 조회용 테이블)

-- 날짜 + 산술 연산( + / -)
SELECT SYSDATE - 1, SYSDATE, SYSDATE + 1 FROM DUAL;

-- 날짜에 + / - 연산시 일(DAY) 단위로 계산이 진행된다

------------------------------------------------------------------------------

-- <컬럼 별칭 지정> --

-- SELECT 조회 결과 집합인 RESULT SET 에 출력되는 컬럼명을 지정

/* 
 * 컬럼명 AS 별칭 : 별칭 띄어쓰기 X(에러), 특수문자 X, 문자만 O
 * 
 * 컬럼명 AS "별칭" : 별칭 띄어쓰기 O, 특수문자 O, 문자만 O
 * 
 * AS 는 생략 가능
 * 
 */

SELECT SYSDATE - 1 "하루 전", 
			 SYSDATE AS 현재시간, 
			 SYSDATE + 1 내일 
			 FROM DUAL;

---------------------------------------------------------------------------
			
-- JAVA 리터럴 : 값 자체를 의미

-- DB 리터럴 : 임의로 지정한 값을 기존 테이블에 존재하는 값처럼 사용하는 것
--> (필수) DB의 리터럴 표기법은 '' 홑따옴표
			
SELECT EMP_NAME, SALARY, '원 입니다'
FROM EMPLOYEE;

---------------------------------------------------------------------------

-- DISTINCT : 조회 시 컬럼에 포함된 중복 값을 한 번만 표기

-- 주의사항 1) DISTINCT 구문은 SELECT 마다 딱 한번씩만 작성 가능
-- 주의사항 2) DISTINCT 구문은 SELECT 제일 앞에 작성되어야 한다.
-- 

SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;

-------------------------------------------------------------------------

-- SELECT 컬럼명 FROM 테이블명 WHERE 조건절;

-- 3. SELECT절 : SELECT 컬럼명
-- 1. FROM절 : FROM 테이블명
-- 2. WHERE절 : WHERE 컬럼명 연산자 값;
-- SELECT * FROM EMPLOYEE WHERE EMP_ID = 300;

-- EMPLOYEE 테이블에서 급여가 3백만원 초과인 사원의
-- 사번, 이름, 급여, 부서코드를 조회해라
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE 
FROM EMPLOYEE 
WHERE SALARY > 3000000;

-- EMPLOYEE 테이블에서 부서코드가 'D9'인 사원의
-- 사번, 이름, 부서코드, 직급코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; -- 비교연산자 ( = ) / 대입연산자 ( := ) --

-- 비교연산자 : >, <, >=, <=, =(같다), !=, <> (같지 않다)

--------------------------------------------------------------------------

-- 논리연산자(AND, OR)
-- EMPLOYEE 테이블에서 급여가 300만 미만 또는 500만 이상인 사원의
-- 사번, 이름, 급여, 전화번호 조회
SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY < 3000000 OR SALARY >= 5000000;

-- EMPLOYEE 테이블에서 급여가 300만 이상 또는 500만 미만인 사원의
-- 사번, 이름, 급여, 전화번호 조회
SELECT EMP_ID, EMP_NAME, SALARY,PHONE
FROM EMPLOYEE
WHERE SALARY >= 3000000 AND SALARY < 5000000;

---------------------------------------------------------------------------

-- BETWEEN A AND B : A 이상 B 이하
-- 300만 이상, 600만 이하
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000;

-- NOT BETWEEN A AND B : A 이상 B 이하가 아닌 경우 --> A 미만, B 초과
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3000000 AND 6000000; --> 300만 미만 OR 600만 초과

-- 날짜(DATE)에 BETWEEN 사용하기
-- EMPLOYEE 테이블에서 입사일이 1990-01-01 ~ 1999-12-31 사이인 직원
-- 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '1990-01-01' AND '1999-12-31';
-- 오라클은 데이터 타입이 달라도 형태가 일치하면 자동으로 타입을 변환시킴

-- ex) 1 = '1'
SELECT '같음'
FROM DUAL
WHERE 1 = '1';

----------------------------------------------------------------------------

-- LIKE --
-- 비교하려는 값이 특정한 패턴을 만족시키면 조회하는 연산자

-- [작성법] --
-- WHERE 컬럼명 LIKE '패턴이 적용될 값'

-- LIKE의 패턴을 나타내는 문자
--> '%' : 포함
--> '_'(언더바) : 글자 수

-- '%' 예시 --
-- 'A%' : A로 시작하는 문자열
-- '%A' : A로 끝나는 문자열
-- '%A%' : A를 포함하는 문자열

-- '_' 예시 --
-- 'A_' : A로 시작하는 두 글자 문자열
-- '___A' : A로 끝나는 네 글자 문자열
-- '__A__' : 세 번째 문자가 A인 다섯 글자 문자열
-- '_____' : 다섯글자 문자열

-- EMPLOYEE 테이블에서 성이 '전'씨인 사원의
-- 사번, 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
-- WHERE EMP_NAME LIKE '전__';













