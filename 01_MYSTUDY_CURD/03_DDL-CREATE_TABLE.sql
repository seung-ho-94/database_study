/* *************************
데이타 정의어
- DDL(Data Definition Language) : 데이타를 정의하는 언어
- CREATE(생성), DROP(삭제), ALTER(수정)
- {}반복가능, []생략가능, | 또는(선택)
CREATE TABLE 테이블명 (
{컬럼명 데이타타입
    [NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]
}
    [PRIMARY KEY]
    {[FOREIGN KEY 컬럼명 REFERENCES 테이블명(컬럼명)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
--------
컬럼의 기본 데이타 타입
VARCHAR2(n) : 문자열 가변길이
CHAR(n) : 문자열 고정길이
NUMBER(p, s) : 숫자타입 p:전체길이, s:소수점이하 자리수
  예) (5,2) : 정수부 3자리, 소수부 2자리 - 전체 5자리
DATE : 날짜형 년,월,일 시간 값 저장

문자열 처리 : UTF-8 형태로 저장
- 숫자, 알파벳 문자, 특수문자 : 1 byte 처리(키보드 자판 글자들)
- 한글 : 3 byte 처리
***************************/
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, --NOT NULL + UNIQUE
    NAME VARCHAR2(30) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(300)
);
-------------------------
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG', '홍길동', '1234');

INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG2', '홍길동', '1234');

--unique 설정컬럼 중복 데이타 입력시 오류 발생
--ORA-00001: unique constraint (MYSTUDY.SYS_C006999) violated
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG2', '홍길동', '1234');
------------------------------------------
SELECT * FROM MEMBER;

--입력 : 컬럼명을 명시적으로 작성하지 않은 경우 모든 컬럼값 입력 필수
-- 테이블에 있는 컬럼의 순서에 맞게 데이터 입력
INSERT INTO MEMBER
VALUES ('HONG5', '홍길동5', '1234', '010-1111-1111', '서울시');

--실수 : 전화번호 위치에 잘못해서 주소값 입력한 경우 
INSERT INTO MEMBER
VALUES ('HONG6', '홍길동6', '1234', '서울시', '010-1111-1111');
-----------------------------------------
INSERT INTO MEMBER (ID, NAME, PASSWORD, PHONE, ADDRESS)
VALUES ('HONG7', '홍길동7', '7777', '010-7777-7777', '부산시');
COMMIT;

SELECT * FROM MEMBER WHERE ID = 'HONG6';
--------------------------
--수정 : HONG6 전화번호 - 010-6666-6666 변경
--수정 : HONG6 주소 '서울시'로 변경
UPDATE MEMBER SET PHONE = '010-6666-6666' WHERE ID = 'HONG6';
UPDATE MEMBER SET ADDRESS = '서울시' WHERE ID = 'HONG6';
UPDATE MEMBER 
   SET PHONE = '010-6666-6666',
       ADDRESS = '서울시'
 WHERE ID = 'HONG6';
----------------------------
--삭제 : HONG7 데이터 삭제
--삭제 : 이름이 홍길동인 사람 삭제
DELETE FROM MEMBER WHERE ID = 'HONG7';
SELECT * FROM MEMBER;
SELECT * FROM MEMBER WHERE NAME = '홍길동';
SELECT COUNT(*) FROM MEMBER WHERE NAME = '홍길동';
DELETE FROM MEMBER WHERE NAME = '홍길동';
-----------------------
/* (실습) CRUD - 입력,조회,수정,삭제
입력 : 아이디-hong8, 이름-홍길동8, 암호-1111, 주소-서울시 서초구
조회(검색) : 이름이 '홍길동8'인 사람의 아이디, 이름, 주소 데이터만 조회
수정 : 아이디 hong8 사람의 
    전화번호 : 010-8888-8888
    암호 : 8888
    주소 : 서울시 강남구
삭제 : 아이디 hong8 인 사람
******************************/
INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS)
VALUES ('hong8', '홍길동8', '1111', '서울시 서초구');
SELECT * FROM MEMBER WHERE ID = 'hong8';
SELECT ID, NAME, ADDRESS FROM MEMBER WHERE ID = 'hong8';

UPDATE MEMBER
SET PHONE = '010-8888-8888',
    PASSWORD = '8888',
    ADDRESS = '서울시 강남구'
WHERE ID = 'hong8';

DELETE FROM MEMBER WHERE ID = 'hong8';
commit;

--=============================
--컬럼 특성을 확인하기 위한 테이블
CREATE TABLE TEST (
    NUM NUMBER(5,2), --전체자리수 5, 정수부 3, 소수부 2자리
    STR1 CHAR(10), --고정길이
    STR2 VARCHAR2(10), --가변길이
    DATE1 DATE --날짜데이타 : 년월일시분초
);
INSERT INTO TEST VALUES (100.454, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.455, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.456, 'ABC', 'ABC', SYSDATE);
SELECT * FROM TEST;
SELECT '-' || STR1 || '-', '-' ||STR2|| '-' FROM TEST;
INSERT INTO TEST VALUES (100.456, 'DEF', 'DEF ', SYSDATE);
SELECT LENGTHB(STR1), LENGTHB(STR2) FROM TEST;
-----------------------------------------------
SELECT * FROM TEST WHERE NUM = 100.45; --당연히 조회됨
SELECT * FROM TEST WHERE NUM = '100.45'; --조회됨
SELECT * FROM TEST WHERE NUM = '100.45A'; --ORA-01722: invalid number
--==============================================
--날짜타입 DATE는 내부에 년월일시분초 데이터 저장
SELECT DATE1, TO_CHAR(DATE1, 'YYYY-MM-DD HH24') FROM TEST;

--한글데이터 : 3byte, ASCII코드 : 
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', 'ABCDEFGHIJ');
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', '홍길동');
--==============================================
--NULL(널) : 데이터가 없는 상태
--NULL은 비교처리가 안됨 : =, <>, !=, <, >, >=, <= 비교처리 의미없음
--NULL과의 연산 결과는 항상 NULL(연산의미 없음)
--NULL 값에 대한 조회는 IS NULL, IS NOT NULL 키워드로 처리
----
SELECT * FROM TEST WHERE NUM = NULL; --조회안됨 
SELECT * FROM TEST WHERE NUM IS NULL;
SELECT * FROM TEST WHERE NUM <> NULL; --<>, != : 같지않다(다르다)
SELECT * FROM TEST WHERE NUM IS NOT NULL;

--NULL과의 연산처리 결과
SELECT * FROM DUAL; --DUAL : DUMMY 테이블 컬럼 1개, 데이터 1개
SELECT 100+200, 111+222 FROM DUAL;
SELECT NUM, NUM+100 FROM TEST; --NULL 과의 연산결과느 항상 NULL

--정렬 NULL
SELECT * FROM TEST ORDER BY STR2; --기본 오름차순 정렬, ASC 키워드 생략 가능
SELECT * FROM TEST ORDER BY STR2 DESC; --DESC : 내림차순 정렬

--정렬시 오라클에서는 NULL 값을 가장 큰 값으로 처리
SELECT * FROM TEST ORDER BY NUM;

INSERT INTO TEST (NUM, STR1, STR2) VALUES (200, '', NULL);
SELECT * FROM TEST WHERE STR1 = ''; --데이터 조회 안됨

















