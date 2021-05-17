/* *************************
SELECT [* | DISTINCT] {�÷���, �÷���, ...}
  FROM ���̺��
[WHERE ������]
[GROUP BY {�÷���, ....}
    [HAVING ����] ] --GROUP BY ���� ���� ����
[ORDER BY {�÷��� [ASC | DESC], ....}] --ASC : ��������(�⺻/��������)
                                      --DESC : ��������
***************************/
SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
------------------------------
SELECT * FROM BOOK ORDER BY BOOKNAME DESC;
-- ���ǻ� ���� ��������(�Ǵ� ��������)
-- å���� �������� ��������(�Ǵ� ��������)
SELECT * FROM BOOK ORDER BY PUBLISHER, BOOKNAME;
-- ���ǻ� ���� ��������, ���� �ݾ��� ū �ͺ���(��������)
SELECT * FROM BOOK ORDER BY PUBLISHER, PRICE DESC;
------------------------------
-- AND, OR, NOT (�ڹٿ����� &&, ||, !)
-- ���ǻ� ���ѹ̵��, �ݾ� 3���� �̻��� å ��ȸ{�˻�, ����)
SELECT *
FROM Book
where publisher = '���ѹ̵��'AND PRICE >= 30000;
-- OR : ���ǻ� ���ѹ̵�� �Ǵ� �̻�̵��� ������ å ����
SELECT * FROM BOOK
WHERE PUBLISHER = '���ѹ̵��' OR PUBLISHER = '�̻�̵��';
-- NOT : ���ǻ� �½������� �����ϰ� ������ ��ü
SELECT * FROM BOOK WHERE PUBLISHER <> '�½�����';
SELECT * FROM BOOK WHERE PUBLISHER != '�½�����';
-- �½�����, ���ѹ̵�� ���ǻ簡 �ƴ� å
SELECT * FROM BOOK
WHERE PUBLISHER <> '�½�����' AND PUBLISHER <> '���ѹ̵��';

SELECT * FROM BOOK
WHERE NOT(PUBLISHER = '�½�����' OR PUBLISHER = '���ѹ̵��');

------------------------------
-- IN : �ȿ� �ֳ�?
-- (�ǽ�) ���ǻ� ������, ���ѹ̵��, �Ｚ�翡�� ������ å ���
SELECT * FROM BOOK
WHERE PUBLISHER = '������' 
OR PUBLISHER = '���ѹ̵��' 
OR PUBLISHER = '�Ｚ��';

SELECT * FROM BOOK
WHERE PUBLISHER IN ('������', '���ѹ̵��', '�Ｚ��');
-- (�ǽ�) ������, ���ѹ̵��, �Ｚ���� ������ ���ǻ� å ���(AND)
SELECT * FROM BOOK
WHERE PUBLISHER <> '������' 
AND PUBLISHER <> '���ѹ̵��' 
AND PUBLISHER <> '�Ｚ��';

SELECT * FROM BOOK
WHERE PUBLISHER NOT IN ('������', '���ѹ̵��', '�Ｚ��');
------------------------------
-- ����(=), ũ��(>), �۴�(<), ũ�ų�����(<=), �۰ų�����(<=)
-- �����ʴ�/�ٸ��� : <>, !=
-- (�ǽ�) ���ǵ� å�߿� 8000���̻��̰� 22000�� ������ å(���ݼ� ����)
SELECT * FROM BOOK
WHERE (PRICE >= 8000) AND (PRICE <= 22000)
ORDER BY PRICE;
-- BETWEEN a AND b : a���� b����
SELECT * FROM BOOK
WHERE PRICE BETWEEN 8000 AND 22000 -- ��谪 ����
ORDER BY PRICE;

-- NOT BETWEEN a AND b : a���� �۰ų� b���� ū
SELECT * FROM BOOK
WHERE PRICE NOT BETWEEN 8000 AND 22000 -- PRICE < 8000 OR PRICE > 22000
ORDER BY PRICE;
------------------------------
-- å ������ '�߱�' ~ '�ø���'
SELECT * FROM BOOK ORDER BY BOOKNAME;
SELECT * FROM BOOK
WHERE BOOKNAME BETWEEN '�߱�' AND '�ø���'
ORDER BY BOOKNAME;
-- (�ǽ�) ���ǻ� ������-�Ｚ�� ������ å(���ǻ������ ����)(BETWEEN)
SELECT * FROM BOOK
WHERE PUBLISHER BETWEEN '������' AND '�Ｚ��'
ORDER BY PUBLISHER;
SELECT * FROM BOOK ORDER BY PUBLISHER;
-- (�ǽ�) ���ѹ̵��, �̻�̵��� ������ å(IN)
-- ���� : ���ǻ��, å���� ������
SELECT * FROM BOOK
WHERE PUBLISHER IN('���ѹ̵��', '�̻�̵��')
ORDER BY PUBLISHER, BOOKNAME;
------------------------------
-- LIKE : '%', '_' ��ȣ�� �Բ� ���
-- % : ��ü(����)�� �ǹ�
-- _(�����) : ���� �ϳ��� ���Ͽ� ��� ���� �ǹ�
SELECT * FROM BOOK
WHERE PUBLISHER LIKE '%�̵��'; -- ���ǻ���� '�̵��'�� ������ ��
-- '�߱�'�� �����ϴ� å ��ȸ
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '�߱�%'; -- '�߱�'�� �����ϴ� ��

-- å���� '�ܰ�' �ܾ �ִ� å ��ȸ
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '%�ܰ�%'; -- '�ܰ�' �ܾ �ִ� ��

-- (�ǽ�) å ���� '��' ���ڰ� �ִ� å�� ��ȸ
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '%��%'
ORDER BY BOOKNAME;
------------------------------
-- å ���� �߿� 2, 3��° ���ڰ� '����'�� å ���
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '_����%';

-- (�ǽ�) å ���� '��' ���ڰ� 2��°�� �ִ� å ��ȸ
SELECT * FROM BOOK
WHERE BOOKNAME LIKE '_��%';
------------------------------
-- LIKE ���� ���� ��� Ȯ��
CREATE TABLE TEST_LIKE(
    ID NUMBER(2) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO TEST_LIKE VALUES(1, 'ȫ�浿');
INSERT INTO TEST_LIKE VALUES(2, 'ȫ�浿2');
INSERT INTO TEST_LIKE VALUES(3, 'ȫ�浿��');
INSERT INTO TEST_LIKE VALUES(4, 'ȫ�浿�빮');
INSERT INTO TEST_LIKE VALUES(5, 'ȫ�浿2��');
INSERT INTO TEST_LIKE VALUES(6, '��ȫ�浿');
INSERT INTO TEST_LIKE VALUES(7, '��ȫ�浿��');
INSERT INTO TEST_LIKE VALUES(8, '�踸ȫ�浿');
INSERT INTO TEST_LIKE VALUES(9, '�踸ȫ�浿�̴�');
INSERT INTO TEST_LIKE VALUES(10, '�踸ȫ���̴�');
COMMIT;
SELECT * FROM TEST_LIKE;
SELECT * FROM TEST_LIKE WHERE NAME = 'ȫ�浿';
SELECT * FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿';
SELECT * FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿2%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '%ȫ�浿';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '%ȫ�浿%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_ȫ�浿_'; -- �ݵ�� �ټ����ڸ�
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_ȫ�浿_%'; -- �ּ� �ټ������̻�
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_ȫ�浿%'; -- �ּ� �ױ����̻�
SELECT * FROM TEST_LIKE WHERE NAME LIKE '__ȫ�浿%';
------------------------------













