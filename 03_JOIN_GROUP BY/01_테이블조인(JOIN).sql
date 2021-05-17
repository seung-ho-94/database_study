--�������� ������ å�� �հ�ݾ�
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID:1
--���� ���� Ȯ��
SELECT * FROM ORDERS WHERE CUSTID = 1;

--��������(SUB QUERY) ���
SELECT * FROM ORDERS 
WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������');
---------------------

--���̺� ����(JOIN) ���
SELECT * FROM CUSTOMER WHERE CUSTID = 1;
SELECT * FROM ORDERS WHERE CUSTID = 1;

--CUSTOMER, ORDERS ���̺� ������ ���� ��ȸ
SELECT *
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --��������
AND CUSTOMER.NAME = '������' --ã������(WHERE)
;

--���̺� ��Ī ������� �����ϰ� ǥ���ϰ� ���
--WHERE�� �������� ��� - ����Ŭ �����
SELECT *
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID --��������
AND C.NAME = '������' --ã������(WHERE)
;
--ANSI ǥ�� ���� ����
SELECT *
FROM CUSTOMER C INNER JOIN ORDERS O --���ι�� ����
     ON C.CUSTID = O.CUSTID --�������� ����
WHERE C.NAME = '������' --�˻�����
;
-------------------
--�������� ������ å�� �հ�ݾ�
SELECT SUM(O.SALEPRICE) AS SUM_SALEPRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID

    AND C.NAME = '������';

--���ε� �����Ϳ��� �÷���ȸ�� : ���̺��(��Ī).�÷��� ���·� ���
SELECT C.CUSTID     --���� ���̺� ���� �÷��� �����ϴ� ��� ��ġ ���� �ʼ�
        ,C.NAME, C.ADDRESS, O.CUSTID AS ORD_CUSTID  --��ȸ�� �÷��� �ߺ��� ��Ī���� �ٸ��� ����
        ,O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O       --������ ���̺�
WHERE C.CUSTID = O.CUSTID       --��������
AND C.NAME = '������';           --�˻�����

--������ å�� �Ǹŵ� å���(�̵��� ������ ���ǻ�)
SELECT *
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID   --��������
--AND PUBLISHER LIKE '%�̵��'
--AND PUBLISHER = '�½�����'
ORDER BY B.PUBLISHER, B.BOOKNAME
;

--(�ǽ�)
--1.'�߱��� ��Ź��'��� å�� �ȸ� ���� Ȯ��(å ����, �Ǹűݾ�, �Ǹ�����)
SELECT B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID
AND B.BOOKNAME = '�߱��� ��Ź��';

--ǥ�� ���� ����
SELECT B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
FROM BOOK B INNER JOIN ORDERS O 
    ON B.BOOKID = O.BOOKID
WHERE B.BOOKNAME = '�߱��� ��Ź��';

--2.'�߱��� ��Ź��'��� å�� ����� �ȷȴ��� Ȯ��
SELECT COUNT(O.SALEPRICE) AS COUNT_SALE
FROM ORDERS O, BOOK B
WHERE B.BOOKID = O.BOOKID
AND B.BOOKNAME = '�߱��� ��Ź��';

--ǥ�� ���� ����
SELECT COUNT(O.SALEPRICE) AS COUNT_SALE
FROM ORDERS O INNER JOIN BOOK B
ON B.BOOKID = O.BOOKID
WHERE B.BOOKNAME = '�߱��� ��Ź��';

--3.'�߽ż�'�� ������ å���� �������ڸ� Ȯ��(å��, ��������)
SELECT O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, CUSTOMER C 
WHERE O.CUSTID = C.CUSTID
AND C.NAME = '�߽ż�';

--ǥ�� ���� ����
SELECT O.SALEPRICE, O.ORDERDATE
FROM ORDERS O INNER JOIN CUSTOMER C
ON O.CUSTID = C.CUSTID
WHERE C.NAME = '�߽ż�';

--4.'�߽ż�'�� ������ �հ�ݾ� Ȯ��
SELECT '�߽ż�' AS CUST_NAME, SUM(O.SALEPRICE) AS SUM_SALEPRICE
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID
AND C.NAME = '�߽ż�';

--ǥ�� ���� ����
SELECT SUM(O.SALEPRICE) AS SUM_SALEPRICE
FROM ORDERS O INNER JOIN CUSTOMER C
ON O.CUSTID = C.CUSTID
WHERE C.NAME = '�߽ż�';

--5.'������', '�߽ż�'�� ������ ����Ȯ��(�̸�, �Ǹűݾ�, �Ǹ�����)
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE O.CUSTID = C.CUSTID
AND C.NAME IN ('������', '�߽ż�');

--ǥ�� ���� ����
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C INNER JOIN ORDERS O
ON O.CUSTID = C.CUSTID
WHERE C.NAME IN ('������', '�߽ż�');

----------------------------------------
--CUSTOMER, BOOK, ORDERS ���̺� ����
--����, å����, �ǸŰ���, �Ǹ�����, ���ǻ��
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
    AND O.CUSTID = C.CUSTID;
--    AND C.NAME = '������';

--ANSI ǥ�� SQL
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O 
    INNER JOIN BOOK B
    ON O.BOOKID = B.BOOKID 
    INNER JOIN CUSTOMER C
    ON O.CUSTID = C.CUSTID;

--(�ǽ�) BOOK, CUSTOMER, ORDERS ���̺� ������ ��ȸ
--1.��̶��� ������ å����, ���԰���, ��������, ���ǻ�
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
FROM BOOK B, ORDERS O, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
    AND O.CUSTID = C.CUSTID
    AND C.NAME = '��̶�';
    
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
FROM ORDERS O 
    INNER JOIN BOOK B
    ON O.BOOKID = B.BOOKID 
    INNER JOIN CUSTOMER C
    ON O.CUSTID = C.CUSTID
where c.name = '��̶�';

--2.��̶��� ������ å �߿� 2014-01-01 ~ 2014-07-08���� ������ ����
SELECT C.NAME, B.BOOKNAME, O.ORDERDATE
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID
    AND O.BOOKID = B.BOOKID
    AND C.NAME = '��̶�'
    AND (O.ORDERDATE >= '2014-01-01' AND O.ORDERDATE <= '2014-07-08');
    
SELECT O.ORDERDATE, TO_CHAR(O.ORDERDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
  AND O.CUSTID = C.CUSTID
  AND C.NAME = '��̶�'
  AND O.ORDERDATE BETWEEN TO_DATE('2014-01-01', 'YYYY-MM-DD')
                      AND TO_DATE('2014-07-08', 'YYYY-MM-DD')
;
    
    
--3.'�߱��� ��Ź��'��� å�� ������ ����� �������ڸ� Ȯ��
SELECT C.NAME, O.ORDERDATE, B.BOOKNAME
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID
    AND O.BOOKID = B.BOOKID
    AND BOOKNAME = '�߱��� ��Ź��';

SELECT B.BOOKNAME, C.NAME, O.ORDERDATE
FROM ORDERS O INNER JOIN BOOK B
ON B.BOOKID = O.BOOKID
INNER JOIN CUSTOMER C
ON O.CUSTID = C.CUSTID
WHERE B.BOOKNAME = '�߱��� ��Ź��';

--4.�߽ż�, ��̶��� ������ å����, ���Աݾ�, �������� Ȯ��(����: ����, �������ڼ�)
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID
    AND O.BOOKID = B.BOOKID
    AND C.NAME IN('�߽ż�', '��̶�') ORDER BY C.NAME, O.ORDERDATE;

SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O INNER JOIN BOOK B
ON B.BOOKID = O.BOOKID
INNER JOIN CUSTOMER C
ON O.CUSTID = C.CUSTID
WHERE C.NAME IN ('�߽ż�', '��̶�')
ORDER BY C.NAME, O.ORDERDATE;

--5.�߽ż��� ������ å����, �հ�ݾ�, ��հ�, ������å�ݾ�, �����å�ݾ�
SELECT '�߽ż�' AS CUTOMER_NAME, COUNT(*), SUM(O.SALEPRICE), AVG(O.SALEPRICE),
        MAX(O.SALEPRICE), MIN(O.SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID AND C.NAME = '�߽ż�';













