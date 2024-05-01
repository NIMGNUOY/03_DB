SELECT MEMBER_NO, MEMBER_EMAIL, MEMBER_PASSWORD, MEMBER_NICKNAME, MEMBER_NAME, MEMBER_TEL, MEMBER_ADDR, 
			TO_CHAR( ENROLL_DATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"' ) ENROLL_DATE, CODE_NO
FROM "MEMBER"
WHERE MEMBER_DEL_FL = 'N'
AND MEMBER_EMAIL = 'petnolza@kh.or.kr';

UPDATE "MEMBER" SET MEMBER_PASSWORD = '$2a$10$bT3UxxgQElFzZAlqsq6JGehCUSRTQIolBKh/QNhk62sMpFAjWP692'
WHERE MEMBER_NO = '1';

ALTER TABLE "MEMBER" MODIFY (MEMBER_PASSWORD NVARCHAR2(100));

COMMIT;