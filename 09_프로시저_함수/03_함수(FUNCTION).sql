/* **** 함수(FUNCTION) ******
실행 후 값을 리턴(RETURN)하는 프로그램
CREATE OR REPLACE FUNCTION FUNCTION1 (
  PARAM1 IN VARCHAR2 --파라미터(매개변수) 
) RETURN VARCHAR2 --리턴 타입 지정
AS 
BEGIN
  RETURN NULL;  --리턴값 설정
END FUNCTION1;
-----------------------
--리턴할 데이터에 대한 선언 필요
RETURN 데이터유형;
--프로그램 마지막에 값 리턴하는 문장 필요
RETURN 리턴값;
************************/
--BOOK 테이블에서 BOOKID로 책제목 확인하는 함수
----(입력파라미터값 : BOOKID,  RETURN값 : BOOKNAME)
CREATE OR REPLACE FUNCTION GET_BOOKNAME (
    IN_ID IN NUMBER 
) RETURN VARCHAR2 -- 리턴할 데이터 타입(유형)
AS 
    V_BOOKNAME book.bookname%TYPE;
BEGIN
    SELECT BOOKNAME INTO V_BOOKNAME
    FROM BOOK
    WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME; --리턴값
END;
-------------------
--함수의 사용
--SELECT 절에서 사용
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID)
  FROM BOOK;
--
SELECT O.*, GET_BOOKNAME(BOOKID)
  FROM ORDERS O
;
----
--WHERE 절에서 함수 사용
SELECT O.*, GET_BOOKNAME(BOOKID)
  FROM ORDERS O
 WHERE GET_BOOKNAME(BOOKID) = '야구를 부탁해'
;
--========================
/*(실습)고객ID를 받아서 고객명을 돌려주는 함수 작성(CUSTOMER 테이블 사용)
--함수명 : GET_CUSTNAME
-- 함수를 사용해서 ORDERS 테이블 데이터 조회
-- GET_BOOKNAME, GET_CUSTNAME 함수사용 주문(판매)정보와 책제목, 고객명 조회
**************************/
CREATE OR REPLACE FUNCTION GET_CUSTNAME (
    IN_ID IN NUMBER
) RETURN VARCHAR2
AS
    V_CUSTNAME customer.name%TYPE;
BEGIN
    SELECT NAME INTO V_CUSTNAME
    FROM CUSTOMER
    WHERE CUSTID = IN_ID;
    
    RETURN V_CUSTNAME;
END;
--------------
SELECT O.*, GET_BOOKNAME(BOOKID), GET_CUSTNAME(CUSTID)
  FROM ORDERS O
;
--
SELECT O.*, 
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) CUST_NAME,
       GET_BOOKNAME(BOOKID),
       GET_CUSTNAME(CUSTID)
  FROM ORDERS O
;











