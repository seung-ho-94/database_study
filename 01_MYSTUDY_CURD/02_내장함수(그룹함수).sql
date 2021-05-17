/* �����Լ� : ����Ŭ DBMS���� �����ϴ� �Լ�(FUNCTION)
�׷��Լ� : �ϳ� �̻��� ���� �׷����� ��� ����
COUNT(*) : ������ ���� ��ȸ(��ü �÷��� ���Ͽ�)
COUNT(�÷���) : ������ ���� ��ȸ(������ �÷��� �������)
SUM(�÷���) : �հ谪 ���ϱ�
AVG(�÷���) : ��հ� ���ϱ�
MAX(�÷���) : �ִ밪 ���ϱ�
MIN(�÷���) : �ּҰ� ���ϱ�
******************************/
SELECT COUNT(*) FROM BOOK; -- ���̺� ������ �Ǽ� Ȯ��

SELECT * FROM CUSTOMER; -- �����ͰǼ� 5��
SELECT COUNT(*) FROM CUSTOMER; -- 5�� Ȯ��
SELECT COUNT(NAME) FROM CUSTOMER;
SELECT COUNT(PHONE) FROM CUSTOMER;


-- SUM(�÷���): �հ谪 ���ϱ�
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; --144500 �� Ȯ��
SELECT SUM(PRICE) FROM BOOK;
-- ���ѹ̵��, �̻�̵�� ���ǻ翡�� ������ å �ݾ� �հ�
SELECT SUM(PRICE) FROM BOOK
-- SELECT *
WHERE PUBLISHER IN('���ѹ̵��', '�̻�̵��');

--AVG(�÷���) : ��հ� ���ϱ�
SELECT AVG(PRICE) FROM BOOK; --14450
SELECT AVG(PRICE)
FROM BOOK
WHERE PUBLISHER IN ('���ѹ̵��', '�̻�̵��'); --22500

--MAX(�÷���) : �ִ밪 ���ϱ�
--MIN(�÷���) : �ּҰ� ���ϱ�
SELECT * FROM BOOK;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK;

--�½����� ������ å�� �ְ�, ������ ���ϱ�
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK
WHERE PUBLISHER = '�½�����';

--������ å�� ����, �հ�ݾ�, ��հ�, �ְ�, ������
SELECT COUNT(*), SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE) FROM BOOK;

--1. ���ǵ� å ��ü ��ȸ(���� : ���ǻ�, �ݾ׼�)
SELECT * FROM BOOK ORDER BY PUBLISHER, PRICE;

--2. �½��������� ������ å�� å��������� ��ȸ
SELECT * FROM BOOK
WHERE PUBLISHER = '�½�����'
ORDER BY BOOKNAME;

--3. ���ǵ� å �� 10000�� �̻��� å(���ݼ�-ū�ݾ׺���)
SELECT * FROM BOOK
WHERE PRICE >= 10000
ORDER BY PRICE DESC;

--4. �������� �� ���ž�(CUSTID=1)
SELECT SUM(SALEPRICE) FROM ORDERS
WHERE CUSTID = 1;

--5. �������� ������ ������ ��(COUNT)
SELECT COUNT(*) FROM ORDERS
WHERE custid = 1;

--6. ���� '��'���� ���� �̸� �ּ�
SELECT ADDRESS FROM CUSTOMER WHERE NAME LIKE '��%';

--7. ���� '��'���� �̸��� '��'���� ������ ���� �̸� �ּ�
SELECT NAME, ADDRESS FROM CUSTOMER WHERE NAME LIKE '��%��';

--8. å ������ '�߱�'���� '�౸'���� �� �˻� (�� '�������õ����� ����/ å�������� ����)
SELECT * FROM BOOK 
WHERE BOOKNAME BETWEEN '�߱�' AND '�౸' 
AND BOOKNAME Not Like '%����%'
ORDER BY BOOKNAME;
















