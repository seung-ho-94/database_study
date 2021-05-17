--PL/SQL 프로시저(PROCEDURE)
SET SERVEROUTPUT ON; -- 출력결과 볼수 있게 설정
--=================================
--PROCEDURE 
BEGIN
    DBMS_OUTPUT.PUT_LINE('테스트~~!!!');
END;
---------------------------
DECLARE --변수선언부
    V_EMPID NUMBER;
    V_NAME VARCHAR2(30);
BEGIN --실행문 시작
    V_EMPID := 100; --치환문(대입문) 부호 :=
    V_NAME := '홍길동';
    DBMS_OUTPUT.PUT_LINE('V_EMPID : ' || V_EMPID);
    DBMS_OUTPUT.PUT_LINE('V_NAME : ' || V_NAME);
END; --실행문 끝

------------------------------
--BOOK 테이블 데이터 중 1개를 선택해서 화면 출력
DECLARE
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    --SELECT ~ INTO ~ FROM 형태로 DB데이터 선택하고 INTO절의 변수에 저장
    --1개의 데이터만 처리 가능
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
      INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
      FROM BOOK 
     WHERE BOOKID = 2;
    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||', '|| V_BOOKNAME ||', '|| 
            V_PUBLISHER ||', '|| V_PRICE); 
END;

--============================
/* 저장프로시저(Stored PROCEDURE)
매개변수(파라미터, parameter) 유형
- IN : 입력을 받기만 하는 변수(기본값)
- OUT : 출력만 하는 변수
       (값을 받을 수 없고, 프로시저 실행 후 호출한 곳으로 변수를 통해 값 전달)
- IN OUT : 입력도 받고, 값을 변수를 통해 전달(출력)도 한다
*****************************/
CREATE OR REPLACE PROCEDURE BOOK_DISP --프로시저 선언부
(
    IN_BOOKID IN NUMBER
)
AS --변수 선언부(AS 또는 IS ~ BEGIN 문 사이
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
      INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
      FROM BOOK 
     WHERE BOOKID = IN_BOOKID;
     
    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||', '|| V_BOOKNAME ||', '|| 
            V_PUBLISHER ||', '|| V_PRICE); 
END;
---------------------
--프로시저 실행 : EXECUTE 프로시저명
EXECUTE BOOK_DISP(1);
EXEC BOOK_DISP(2);

--프로시저 삭제 
DROP PROCEDURE BOOK_DISP;

--========================================
--프로시저 파라미터 유형 : IN, OUT
create or replace PROCEDURE GET_BOOKINFO (
    IN_BOOKID IN NUMBER, --매개변수 선언시 타입만 지정
    OUT_BOOKNAME OUT VARCHAR2,
    OUT_PUBLISHER OUT VARCHAR2,
    OUT_PRICE OUT NUMBER
) AS
    -- %TYPE 사용 : 테이블명.컬럼명%TYPE
    -- 테이블 컬럼과 동일한 타입으로 선언(변경시에도 자동 적용)
    V_BOOKID BOOK.BOOKID%TYPE;
    V_BOOKNAME BOOK.bookname%TYPE;
    V_PUBLISHER BOOK.publisher%TYPE;
    V_PRICE BOOK.PRICE%TYPE;
BEGIN
    --IN, OUT 매개변수값 출력
    DBMS_OUTPUT.PUT_LINE('매개변수값 : '||IN_BOOKID ||','|| OUT_BOOKNAME||','||
            OUT_PUBLISHER  ||','|| OUT_PRICE);
    
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK 
    WHERE BOOKID = IN_BOOKID; 
    
    --데이터를 호출한 곳으로 전달하기 위해 OUT 유형의 매개변수에 저장
    OUT_BOOKNAME := V_BOOKNAME;
    OUT_PUBLISHER := V_PUBLISHER;
    OUT_PRICE := V_PRICE;
    DBMS_OUTPUT.PUT_LINE('매개변수값 : '||IN_BOOKID ||','|| OUT_BOOKNAME||','||
            OUT_PUBLISHER  ||','|| OUT_PRICE);
    
    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||', '|| V_BOOKNAME ||', '|| 
            V_PUBLISHER ||', '|| V_PRICE);     
END;

--=============================
-- 프로시저 OUT 매개변수 값 확인용 프로시저
CREATE OR REPLACE PROCEDURE GET_BOOKINFO_TEST (
  IN_BOOKID IN NUMBER 
) AS 
    V_BOOKNAME book.bookname%TYPE;
    V_PUBLISHER book.publisher%TYPE;
    V_PRICE book.price%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>GET_BOOKINFO_TEST - '|| IN_BOOKID);
    
    --GET_BOOKINFO 프로시저 호출(실행)
    GET_BOOKINFO(IN_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE);
    
    --GET_BOOKINFO 프로시저로 부터 전달받은 값 확인(화면 출력)
    DBMS_OUTPUT.PUT_LINE('>>GET_BOOKINFO OUT값 - '|| IN_BOOKID
        ||'/'|| V_BOOKNAME ||'/'|| V_PUBLISHER ||'/'|| V_PRICE); 
END GET_BOOKINFO_TEST;
--============================
/* (실습)프로시저 작성하고 실행하기
고객테이블(CUSTOMER)에 있는 데이터 조회 프로시저 작성
- 프로시저명 : GET_CUSTINFO
- 입력받는 값 : 고객ID
- 처리 : 입력받은 고객ID에 해당하는 데이터를 찾아서 화면출력
- 출력항목 : 고객ID, 고객명, 주소, 전화번호
**************************/
create or replace PROCEDURE GET_CUSTINFO (
    IN_CUSTID IN NUMBER
) AS
    V_CUSTID CUSTOMER.CUSTID%TYPE;
    V_NAME CUSTOMER.NAME%TYPE;
    V_ADDRESS customer.address%TYPE;
    V_PHONE customer.phone%TYPE;
BEGIN
    SELECT CUSTID, NAME, ADDRESS, PHONE
    INTO V_CUSTID, V_NAME, V_ADDRESS, V_PHONE
    FROM CUSTOMER
    WHERE CUSTID = IN_CUSTID;
    
    DBMS_OUTPUT.PUT_LINE('>>결과 : '|| V_CUSTID||','|| V_NAME||','|| 
        V_ADDRESS||','|| V_PHONE);
END;







