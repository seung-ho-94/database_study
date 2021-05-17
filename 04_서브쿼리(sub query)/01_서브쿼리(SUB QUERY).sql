--��������(�μ�����, SUB QUERY)
--SQL��(SELECT, INSERT, UPDATE, DELETE) ���� �ִ� ������
------------------------------
--�������� ������ ������ �˻�
SELECT * FROM ORDERS;
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID : 1
SELECT * FROM ORDERS
 WHERE CUSTID = 1;
---------
--�������� ���
SELECT * FROM ORDERS
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������')
;
--���ι����� ó��
SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME = '������'
;
-----------------
-- WHERE ������ �������� ���� ��ȸ����� 2�� �̻��� ��� IN ���
-- ������, �迬�� ���Գ���(��������)
SELECT * FROM ORDERS
 WHERE CUSTID IN (SELECT CUSTID
                   FROM CUSTOMER
                  WHERE NAME IN ('������', '�迬��') )
;
-------------
--å�� ������ ���� ��� ������ �̸��� ���Ͻÿ�
SELECT MAX(PRICE) FROM BOOK; --���� ��� å ���� : 35000
SELECT * FROM BOOK WHERE PRICE = 35000;
---
SELECT * FROM BOOK 
 WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);
--------------------
--���������� FROM ���� ����ϴ� ���
SELECT *
  FROM BOOK B,
       (SELECT MAX(PRICE) MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE  
;
------
--������, �迬�� ���Գ���(��������)
SELECT *
  FROM ORDERS O,
       (SELECT * FROM CUSTOMER WHERE NAME IN ('������','�迬��')) C
 WHERE O.CUSTID = C.CUSTID
;
--SELECT ���� �������� ��뿹
SELECT * FROM ORDERS;
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME,
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME,
       O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O
;  
---------------
--�������� ������ å ���(å����)
--�� ����SQL --> �߰�SQL --> �ٱ��� SQL�� ����
SELECT *
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID IN (SELECT CUSTID
                                      FROM CUSTOMER
                                     WHERE NAME = '������')
                 )
;
----------------------------
--(�ǽ�) �������� �̿�(��������, ���ι�)
--1. �� ���̶� ������ ������ �ִ� ���
----(�Ǵ� �� ���� �������� ���� ���)
SELECT * FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS)
;
----(�Ǵ� �� ���� �������� ���� ���)
SELECT * FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--JOIN �� : �� ���� �������� ���� ���
SELECT C.*
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;
--2. 20000�� �̻� �Ǵ� å�� ������ �� ��� ��ȸ
SELECT *
  FROM CUSTOMER 
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS WHERE SALEPRICE >= 20000)
;
--���ι����� 
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND SALEPRICE >= 20000
; 
--3. '���ѹ̵��' ���ǻ��� å�� ������ ���̸� ��ȸ
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID 
                    FROM ORDERS
                   WHERE BOOKID IN (SELECT BOOKID
                                      FROM BOOK
                                     WHERE PUBLISHER = '���ѹ̵��') )
;
--JOIN ������
SELECT C.*, B.BOOKNAME, B.PUBLISHER, O.SALEPRICE, O.ORDERDATE
  FROM CUSTOMER C, ORDERS O, BOOK B
 WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID
   AND B.PUBLISHER = '���ѹ̵��'
;
--4. ��ü å���� ��պ��� ��� å�� ��� ��ȸ
----------------
SELECT *
  FROM BOOK
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK) -- 14450
 ORDER BY PRICE
;
--���ι�
SELECT *
  FROM BOOK B,
       (SELECT AVG(PRICE) AVG_PRICE FROM BOOK) AVG
 WHERE PRICE > AVG_PRICE
;








