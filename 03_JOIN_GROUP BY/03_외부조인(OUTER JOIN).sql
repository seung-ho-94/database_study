--(����) �� �� �� �ǵ� ���� �� �� ����� ����??
--CUSTOMOR ���̺��� �ְ�, ORDERS ���̺��� ���� ���
--(���1) minus : ������ ó��
select custid from customer -- 1,2,3,4,5
minus
select distinct custid from orders; -- 1,2,3,4
---------------
--(���2) �����������
select *
  from customer
 where custid not in (select distinct custid from orders)
;
------------
--(���3) �ܺ�����(OUTER JOIN)
select distinct c.custid, c.name
  from customer c, orders o
 where c.custid = o.custid --��������(��������-EQUIE JOIN)
;
-- �ܺ����� (��������)
select *
  from customer c, orders o
 where c.custid = o.custid(+) --��������(�������� �ܺ�����)
   and o.orderid is null
;
-- �ܺ����� (��������-ORACLE)
select *
  from orders o, customer c
 where c.custid = o.custid(+) --��������(�������� �ܺ�����)
   and o.orderid is null
;
--ANSI ǥ�� SQL(LEFT OUTER JOIN)
select *
  from customer c left outer join orders o
       on c.custid = o.custid
 where o.orderid is null
;
--ANSI ǥ�� SQL(LIGHT OUTER JOIN)
select *
  from orders o right outer join customer c
       on c.custid = o.custid
 where o.orderid is null
;

-------------------------------------
--��������(JOIN, INNER JOIN) : ���ε� ���̺� ��ο� �����ϴ� ������ �˻�
--�ܺ�����(OUTER JOIN) : ��� ���� ���̺� �ִ� �����Ͱ� �������� �ʴ� ������ �˻�
----�������̺� ��� ������ ǥ���ϰ�, ��ġ���� �ʴ� ������ ã�� �� ���
--------------------

CREATE TABLE DEPT(
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT VALUES ('10', '�ѹ���');    
INSERT INTO DEPT VALUES ('20', '�޿���');
INSERT INTO DEPT VALUES ('30', 'IT��');
COMMIT;

-----

CREATE TABLE DEPT_1(
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT_1 VALUES ('10', '�ѹ���');    
INSERT INTO DEPT_1 VALUES ('20', '�޿���');
COMMIT;

-----

CREATE TABLE DEPT_2(
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT_2 VALUES ('10', '�ѹ���');    
INSERT INTO DEPT_2 VALUES ('30', 'IT��');
COMMIT;

SELECT * FROM DEPT;
SELECT * FROM DEPT_1;
SELECT * FROM DEPT_2;

-----DEPT = DEPT_1
SELECT *
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID
;
SELECT *
FROM DEPT D, DEPT_2 D2
WHERE D.ID = D2.ID
;

--DEPT ���� �ְ�, DEPT_1���� ���� ������(�μ�) ��ȸ
--LEFT OUTER JOIN : ���� ���̺� ����
----DEPT ������ ��ü ǥ���ϰ�, ����(DEPT_1)�� ������ NULLǥ��
SELECT *
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID(+)   --��������(�������� �ܺ�����)
    AND D1.ID IS NULL
;

--ǥ�� SQL
SELECT * 
FROM DEPT D LEFT OUTER JOIN DEPT_1 D1
    ON D.ID = D1.ID
WHERE D1.ID IS NULL
;

--RIGHT OUTER JOIN : ���� ���̺� ����
SELECT *
FROM DEPT_1 D1, DEPT D
WHERE D1.ID(+) = D.ID
AND D1.ID IS NULL
;

--ǥ�� SQL
SELECT * 
FROM DEPT_1 D1 RIGHT OUTER JOIN DEPT D
    ON D1.ID = D.ID
WHERE D1.ID IS NULL
;

--FULL OUTER JOIN : ���� ���̺� ����
SELECT *
FROM DEPT_1 D1 FULL OUTER JOIN DEPT_2 D2
ON D1.ID = D2.ID 
;

--�ǽ�) DEPT_1, DEPT_2 ���̺��� �̿��ؼ�
--1.DEPT_1���� �ְ�, DEPT_2 ���̺��� ���� ������ ã��(LEFT OUTER JOIN)
SELECT *
FROM DEPT_1 D1 LEFT OUTER JOIN DEPT_2 D2
    ON D1.ID = D2.ID
WHERE D2.ID IS NULL
;

--2.DEPT_2���� �ְ�, DEPT_1 ���̺��� ���� ������ ã��(RIGHT OUTER JOIN)
SELECT *
FROM DEPT_1 D1 RIGHT OUTER JOIN DEPT_2 D2
    ON D1.ID = D2.ID
WHERE D1.ID IS NULL
;

--��������(�μ�����, SUB QUERY)










