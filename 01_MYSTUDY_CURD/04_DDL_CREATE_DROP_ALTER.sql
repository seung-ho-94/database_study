/*(실습) 테이블(TABLE) 만들기 (테이블명 : TEST2)
    NO : 숫자타입 5자리, PRIMARY KEY 선언
    ID : 문자타입 10자리(영문 10자리), 값이 반드시 존재 (NULL허용 안함)
    NAME : 한글 10자리 저장가능하게 설정, 값이 반드시 존재
    EMAIL : 영문, 숫자, 특수문자 포함 30자리
    ADDRESS : 한글 100자
    IDNUM : 숫자타입 정수부 7자리, 소수부 3자리
    REGDATE : 날짜타입
****************************/
CREATE TABLE TEST2 (
    NO NUMBER(5) PRIMARY KEY, 
    ID VARCHAR2(10) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30),
    ADDRESS VARCHAR2(300),
    IDNUM NUMBER(7,3),
    REGDATE DATE 
);
SELECT * FROM TEST2;

INSERT INTO TEST2 (NO, ID, NAME, EMAIL, ADDRESS, IDNUM)
VALUES (1, '1111', '임승호', 'xlqmdl@nate.com', '파주시', 13.543);

INSERT INTO TEST2 (NO, ID, NAME, EMAIL, ADDRESS, IDNUM, REGDATE)
VALUES (2, '2222', '남윤아', '바보@nate.com', '고양시', 14.543, SYSDATE);

INSERT INTO TEST2 (NO, ID, NAME, EMAIL, ADDRESS, IDNUM, REGDATE)
VALUES (3, '3333', '김유신', '모르는이메일', '서울시', 1244.45, SYSDATE);

UPDATE TEST2
SET REGDATE = SYSDATE
WHERE NO = 1;

SELECT * FROM TEST2 WHERE NO = 1;
COMMIT;

-- 특정 테이블릐 데이터와 함께 테이블 구조를 함께 복사
CREATE TABLE TEST3
AS SELECT * FROM TEST2;

SELECT * FROM TEST3;

SELECT * FROM TEST4;
--특정 테이블의 특정컬럼과 특정 데이터만 복사하면서 테이블 생성
CREATE TABLE TEST4
AS 
SELECT NO, ID, NAME, EMAIL FROM TEST2 WHERE ID = '1111';

--=======================
--특정 테이블의 구조만 복사(데이터는 복사하지 않음)
CREATE TABLE TEST5
AS
SELECT *FROM TEST2 WHERE 1 = 2;

SELECT * FROM TEST5;
--===============================
SELECT *FROM TEST2;
DELETE FROM TEST2 WHERE ID = '3333';
DELETE FROM TEST2;
ROLLBACK;

--======================테이블 삭제==========================
--TRUNCATE 명령문 : 테이블 전체 데이터 삭제(ROLLBACK 복구 안됨)
TRUNCATE TABLE TEST2;
SELECT * FROM TEST2;

--DROP 명령문 : 데이터와 함께 테이블 구조 모두 삭제처리
-- cascade constraints : 참조데이터가 있어도 삭제
-- PURGE : 휴지통에 백업없이 완전히 삭제
DROP TABLE TEST4;


--======================테이블 수정==========================
-- DDL : ALTER TABLE
--  ADD : 추가
--  MODIFY : 수정 -> 데이터 상태에 따라 적용 가능여부 결정
--      
--  DROP COLUMN : 삭제

SELECT * FROM TEST3;

--컬럼추가 TEST3 테이블에 ADDCOL 컬럼 추가
ALTER TABLE TEST3 ADD ADDCOL VARCHAR2(10);

--컬럼수정 TEST3 테이블의 ADDCOL 크기 -> VARCHAR(20)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(20);
UPDATE TEST3 SET ADDCOL = '123456789012345';

ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR(10); --오류발생
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR(15); --수정처리됨

--컬럼삭제 : DROP COLUMN
ALTER TABLE TEST3 DROP COLUMN ADDCOL;
SELECT * FROM TEST3;
ALTER TABLE "MYSTUDY"."TEST3" RENAME TO AAAA;
ALTER TABLE AAAA RENAME TO TEST3;



