/* *************************
SELECT [* | DISTINCT] {�÷���, �÷���, ...}
  FROM ���̺��
[WHERE ������]
[GROUP BY {�÷���, ....}
    [HAVING ����] ] --GROUP BY ���� ���� ����
[ORDER BY {�÷��� [ASC | DESC], ....}] --ASC : ��������(�⺻/��������)
                                      --DESC : ��������
***************************/
--GROUP BY : �����͸� �׷����ؼ� ó���� ��� ���
--GROUP BY ���� ����ϸ� SELECT �׸��� GROUP BY ���� ���� �÷�
---- �Ǵ� �׷��Լ�(COUNT, SUM, AVG, MAX, MIN)�� ����� �� �ִ�
--===============================
--���� ������ ���űݾ��� �հ踦 ���Ͻÿ�
SELECT CUSTID, SUM(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
-----
SELECT C.NAME, SUM(SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID -- ��������
 GROUP BY C.NAME
 ORDER BY C.NAME
;
---
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID -- ��������
 GROUP BY C.NAME
 ORDER BY SUM(O.SALEPRICE) DESC
;
---
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID -- ��������
 GROUP BY C.NAME
 ORDER BY 2 DESC --SELECT ���� �÷����� ������ ����
;
-----------------------------
--�ֹ�(�Ǹ�) ���̺��� ���� ������ ��ȸ(�Ǽ�,�հ�,���,�ִ�,�ּ�)
SELECT CUSTID, COUNT(*), SUM(SALEPRICE),
       TRUNC(AVG(SALEPRICE)),
       MAX(SALEPRICE), MIN(SALEPRICE)
  FROM ORDERS 
 GROUP BY CUSTID
;
--�߽ż�, ������ ���� ������ ��ȸ(�Ǽ�,�հ�,���,�ִ�,�ּ�)
SELECT C.NAME,
       COUNT(*), SUM(SALEPRICE),
       TRUNC(AVG(SALEPRICE)),
       MAX(SALEPRICE), MIN(SALEPRICE)
--SELECT *       
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME IN ('�߽ż�', '������')
 GROUP BY C.NAME
;
---------------------------
--(�ǽ�)���� �������� ���� ������ ��ȸ(���ŰǼ�,�հ�,���,�ִ�,�ּ�)
---- �߽ż�, ��̶� �� 2�� ��ȸ
SELECT C.NAME, 
       COUNT(*) AS CNT,
       SUM(O.SALEPRICE) SUM_PRICE,
       TRUNC(AVG(O.SALEPRICE)) AVG_PRICE,
       MAX(O.SALEPRICE) MAX_PRICE,
       MIN(O.SALEPRICE) MIN_PRICE
--SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID --��������
   AND C.NAME IN ('�߽ż�','��̶�')
 GROUP BY C.NAME
;
--ǥ�� SQL ���
SELECT C.NAME, 
       COUNT(*) AS CNT,
       SUM(O.SALEPRICE) SUM_PRICE,
       TRUNC(AVG(O.SALEPRICE)) AVG_PRICE,
       MAX(O.SALEPRICE) MAX_PRICE,
       MIN(O.SALEPRICE) MIN_PRICE
--SELECT *
  FROM ORDERS O JOIN CUSTOMER C
       ON O.CUSTID = C.CUSTID --��������
 WHERE C.NAME IN ('�߽ż�','��̶�')
 GROUP BY C.NAME
;
-----
SELECT C.NAME, 
       COUNT(*) AS CNT,
       SUM(O.SALEPRICE) SUM_PRICE,
       TRUNC(AVG(O.SALEPRICE)) AVG_PRICE,
       MAX(O.SALEPRICE) MAX_PRICE,
       MIN(O.SALEPRICE) MIN_PRICE
--SELECT *
  FROM ORDERS O JOIN CUSTOMER C
       ON O.CUSTID = C.CUSTID --��������
 GROUP BY C.NAME
 HAVING C.NAME IN ('�߽ż�', '��̶�')
;
-----------------------
--HAVING �� : GROUP BY ���� ���� ������� �����Ϳ��� �˻����� �ο�
--HAVING ���� �ܵ����� ����� �� ����, GROUP BY ���� �Բ� ���Ǿ�� �Ѵ�
-------------------
-- 3�� �̻� ������ �� ��ȸ
SELECT C.NAME, COUNT(*) AS CNT
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID 
 GROUP BY C.NAME
 HAVING COUNT(*) >= 3 --�׷��ε� �����Ϳ��� ���ϴ� ������ �˻�
;
----------
-- ������ å�߿��� 20000�� �̻��� å�� ������ ����� ��赥���� 
---- (�Ǽ�, �հ�, ���, �ּ�, �ִ�)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--SELECT *       
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING MAX(O.SALEPRICE) >= 20000 --��赥���� ���� �� 2�����̻� å ���� ��� ã��
;
-----------------------------
--���� : WHERE ���� ���Ǵ� ã������(���̺� ������ ����)
----HAVING  ������ ���Ǵ� ������ �׷��ε� ������ �������� �˻�
----(������� �ٸ��� ó���ǹǷ� ã�� �����Ͱ� �������� ��Ȯ�� �ϴ°��� �߿�)
-----------------------------
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--SELECT *    
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND O.SALEPRICE >= 20000 --20000�� �̻��� �����͸� ������� ó��
 GROUP BY C.NAME
;
--==========================
--(�ǽ�)�ʿ�� ���ΰ� GROUP BY ~ HAVING  ������ ����ؼ� ó��
--1.���� �ֹ��� ������ ���ǸŰǼ�, �Ǹž�, ��հ�, �ְ�, ������ ���ϱ�
SELECT COUNT(*) AS "TOTAL COUNT"
     , SUM(SALEPRICE) AS  "�Ǹž� �հ�"  --�ѱ� ����� �� ������ ������� ����
     , AVG(SALEPRICE) ��հ�AVG
     , MIN(SALEPRICE) MIN_PRICE --�����(_) ��밡��
     , MAX(SALEPRICE) "�ְ�(MAX)"
  FROM ORDERS
;
--2.������ �ֹ��� ������ �Ѽ���, ���Ǹž� ���ϱ�
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE) AS SUM_PRICE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 --ORDER BY C.NAME
 --ORDER BY SUM(O.SALEPRICE) DESC --����� �׷��Լ��� ����
 --ORDER BY 3 DESC --�÷� ��ġ������ ����
 ORDER BY SUM_PRICE DESC --�÷� ��Ī(alias)���� ����
;
--3.���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
SELECT C.NAME, O.SALEPRICE, B.PRICE, B.BOOKNAME
  FROM CUSTOMER C, ORDERS O, BOOK B
 WHERE C.CUSTID = O.CUSTID
   AND O.BOOKID = B.BOOKID
;
--4.������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, �������� ����
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
; 
--5.������ �ֹ��� �Ǽ�, �հ�ݾ�, ��ձݾ��� ���ϱ�(3�Ǻ��� ���� ������ ���)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), ROUND(AVG(O.SALEPRICE))
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) < 3
; 
--(����) �� �� �� �ǵ� ���� �� �� ����� ����??
------------------------------












