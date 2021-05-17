/* ************************
��(VIEW) : �ϳ� �Ǵ� �� �̻��� ���̺�� ����
   �������� �κ������� ���̺��� ��ó�� ����ϴ� ��ü(�������̺�)
--��(VIEW) ������
CREATE [OR REPLACE] VIEW ���̸� [(�÷���Ī1, �÷���Ī2, ..., �÷���Īn)]
AS
SELECT ����
[�ɼ�];

--�б����� �ɼ� : WITH READ ONLY

--��(VIEW) ����
DROP VIEW ���̸�;
***************************/
SELECT * FROM BOOK;
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';
--VIEW �����
CREATE VIEW VW_BOOK
AS 
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%'
WITH READ ONLY; --�б�����

--�� ����ؼ� ������ �˻�
SELECT * FROM VW_BOOK WHERE PUBLISHER='�½�����';

-----------
--VIEW ���� - �÷���Ī(ALIAS) ���
CREATE VIEW VW_BOOK2(BID, BNAME, PUB, PRICE) --�÷���Ī
AS
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE 
FROM BOOK
WHERE BOOKNAME LIKE '%�౸%'
WITH READ ONLY;

-----------
CREATE OR REPLACE VIEW VW_ORDERS
AS
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
       B.BOOKNAME, B.PUBLISHER, B.PRICE,
       C.NAME, C.PHONE, C.ADDRESS,
       O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
WITH READ ONLY;

--VIEW ������, �迬�ư� ������ å ����, ���Աݾ�, �������� ������ ��ȸ
SELECT BOOKNAME, PRICE, ORDERDATE
FROM VW_ORDERS
WHERE NAME IN('������', '�迬��')
;
--���� ���� ���� (SQL����� �信 ��ϵ� SELECT ������ �����


--============================
--(�ǽ�) �並 ����, ��ȸ, ����
--1. ����� - ���Ī : VW_ORD_ALL
---- �ֹ�(�Ǹ�)����, å����, ������ ��� ��ȸ�� �� �ִ� ���� �� 
CREATE OR REPLACE VIEW VW_ORD_ALL
AS
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
       B.BOOKNAME, B.PUBLISHER, B.PRICE,
       C.NAME, C.PHONE, C.ADDRESS,
       O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.CUSTID = C.CUSTID AND O.BOOKID = B.BOOKID
WITH READ ONLY;

--2. �̻�̵��� ������ å�� �Ǹŵ� å����, �Ǹűݾ�, �Ǹ��� ��ȸ
SELECT BOOKNAME, SALEPRICE, ORDERDATE
FROM VW_ORD_ALL
WHERE PUBLISHER IN ('�̻�̵��');

--3. �̻�̵��� ������ å �߿��� �߽ż�, ��̶��� ������ å ���� ��ȸ
---- ����׸� : ������ ����̸�, å����, ���ǻ�, ����(����), �ǸŰ�, �Ǹ�����
---- ���� : ������ ����̸�, �������� �ֱټ�
SELECT NAME, BOOKNAME, PUBLISHER, SALEPRICE, SALEPRICE, ORDERDATE
FROM VW_ORD_ALL
WHERE NAME IN ('�߽ż�', '��̶�') ORDER BY NAME, ORDERDATE DESC
;

--4. �Ǹŵ� å�� ���Ͽ� �����ں� �Ǽ�, �հ�ݾ�, ��ձݾ�, �ְ�, ������ ��ȸ
SELECT COUNT(NAME), SUM(PRICE), 
        AVG(PRICE), MAX(PRICE), MIN(PRICE)
FROM VW_ORD_ALL
;

--(����) ����� : VW_ORD_ALL ���� ó��


--================================


