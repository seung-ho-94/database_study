--서브쿼리(부속질의, SUB QUERY)
--SQL문(SELECT, INSERT, UPDATE, DELETE) 내에 있는 쿼리문
------------------------------
--박지성이 구입한 내역을 검색
SELECT * FROM ORDERS;
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID : 1
SELECT * FROM ORDERS
 WHERE CUSTID = 1;
---------
--서브쿼리 사용
SELECT * FROM ORDERS
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성')
;
--조인문으로 처리
SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME = '박지성'
;
-----------------
-- WHERE 절에서 서브쿼리 사용시 조회결과가 2건 이상인 경우 IN 사용
-- 박지성, 김연아 구입내역(서브쿼리)
SELECT * FROM ORDERS
 WHERE CUSTID IN (SELECT CUSTID
                   FROM CUSTOMER
                  WHERE NAME IN ('박지성', '김연아') )
;
-------------
--책중 정가가 가장 비싼 도서의 이름을 구하시오
SELECT MAX(PRICE) FROM BOOK; --가장 비싼 책 가격 : 35000
SELECT * FROM BOOK WHERE PRICE = 35000;
---
SELECT * FROM BOOK 
 WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);
--------------------
--서브쿼리를 FROM 절에 사용하는 경우
SELECT *
  FROM BOOK B,
       (SELECT MAX(PRICE) MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE  
;
------
--박지성, 김연아 구입내역(서브쿼리)
SELECT *
  FROM ORDERS O,
       (SELECT * FROM CUSTOMER WHERE NAME IN ('박지성','김연아')) C
 WHERE O.CUSTID = C.CUSTID
;
--SELECT 절에 서브쿼리 사용예
SELECT * FROM ORDERS;
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME,
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME,
       O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O
;  
---------------
--박지성이 구매한 책 목록(책제목)
--맨 안쪽SQL --> 중간SQL --> 바깥쪽 SQL문 실행
SELECT *
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID IN (SELECT CUSTID
                                      FROM CUSTOMER
                                     WHERE NAME = '박지성')
                 )
;
----------------------------
--(실습) 서브쿼리 이용(서브쿼리, 조인문)
--1. 한 번이라도 구매한 내역이 있는 사람
----(또는 한 번도 구매하지 않은 사람)
SELECT * FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS)
;
----(또는 한 번도 구매하지 않은 사람)
SELECT * FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--JOIN 문 : 한 번도 구매하지 않은 사람
SELECT C.*
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;
--2. 20000원 이상 되는 책을 구입한 고객 명단 조회
SELECT *
  FROM CUSTOMER 
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS WHERE SALEPRICE >= 20000)
;
--조인문으로 
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND SALEPRICE >= 20000
; 
--3. '대한미디어' 출판사의 책을 구매한 고객이름 조회
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID 
                    FROM ORDERS
                   WHERE BOOKID IN (SELECT BOOKID
                                      FROM BOOK
                                     WHERE PUBLISHER = '대한미디어') )
;
--JOIN 문으로
SELECT C.*, B.BOOKNAME, B.PUBLISHER, O.SALEPRICE, O.ORDERDATE
  FROM CUSTOMER C, ORDERS O, BOOK B
 WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID
   AND B.PUBLISHER = '대한미디어'
;
--4. 전체 책가격 평균보다 비싼 책의 목록 조회
----------------
SELECT *
  FROM BOOK
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK) -- 14450
 ORDER BY PRICE
;
--조인문
SELECT *
  FROM BOOK B,
       (SELECT AVG(PRICE) AVG_PRICE FROM BOOK) AVG
 WHERE PRICE > AVG_PRICE
;








