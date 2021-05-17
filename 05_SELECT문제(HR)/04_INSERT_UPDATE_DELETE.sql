--INSERT, UPDATE, DELETE
/* *********************
�� INSERT ��
INSERT INTO ���̺��
       (�÷���1, �÷���2, ..., �÷���n)
VALUES (��1, ��2, ..., ��n);

�� UPDATE ��
UPDATE ���̺��
   SET �÷���1 = ��1, �÷���2 = ��2, ..., �÷���n = ��n
[WHERE �������]

�� DELETE ��
DELETE FROM ���̺��
[WHERE �������]  
**************************/

/*  INSERT : �÷����� �������� �ʰ� �Է�
----���̺� ������ �ۼ��� �÷��� ���� ��� �Է�(������ ����)
----���̺� ������ �ۼ��� �÷��� ������ ���� ������ �Է����� �ʴ� ���
    (�Է¼���) ���� ���� - �߸��� ��ġ�� ������ �Է�
    (�Է½���) ������ Ÿ�� ����ġ, ������ ũ�� ����ġ ����
    
**********************************/
/* �� INSERT ��
INSERT INTO ���̺��
       (�÷���1, �÷���2, ..., �÷���n)
VALUES (��1, ��2, ..., ��n);
********************************/
INSERT INTO BOOK
VALUES (32, '�ڹٶ� �����ΰ�3?', 'ITBOOK', 30000);
COMMIT;
-----------
INSERT INTO BOOK
VALUES (33, '�ڹٶ� �����ΰ�4?', '', 30000); --���ǻ� : NULL
-----------
INSERT INTO BOOK
VALUES(34, '�ڹٶ� �����ΰ�5?', 'ITBOOK'); --SQL ����: ORA-00947: not enough values
-----------
-- �ϰ��Է� : ���̺� �����͸� �̿��ؼ� ���� �����͸� �ѹ��� �Է�ó��
------IMPORTED_BOOK --> BOOK : �ϰ��Է�
INSERT INTO BOOK
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
  FROM IMPORTED_BOOK
;

/* �� UPDATE ��
UPDATE ���̺��
   SET �÷���1 = ��1, �÷���2 = ��2, ..., �÷���n = ��n
[WHERE �������]
********************************/
SELECT * FROM CUSTOMER;
--�ڼ��� �ּ� ���� : ���ѹα� ���� -> ���ѹα� �λ�
UPDATE CUSTOMER
   SET ADDRESS = '���ѹα� �λ�'
 WHERE NAME = '�ڼ���'
;
COMMIT;
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';
--�ڼ����� �ּ�, ��ȭ��ȣ ���� : '���ѹα� ����', '010-1111-1111'
UPDATE CUSTOMER
   SET ADDRESS = '���ѹα� ����',
       PHONE = '010-1111-1111'
 WHERE NAME = '�ڼ���'       
;      
COMMIT;
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';
----------------------
-- �ڼ��� �ּ� ���� : �迬���� �ּҿ� �����ϰ� ����
SELECT ADDRESS FROM CUSTOMER WHERE NAME = '�迬��';
----UPDATE ���� �������� �������� ������ ������ ã�� ����
----���������� ��� �����Ͱ� 1�� ���Ͽ��� ��(2�� �̻��� ��� ����)
UPDATE CUSTOMER
   SET ADDRESS = '���ѹα� ����'
 WHERE NAME = '�ڼ���'
; 
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER WHERE NAME = '�迬��')
 WHERE NAME = '�ڼ���'
; 
COMMIT;
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';
----------------------------------
--�ڼ��� �ּ�, ��ȭ��ȣ ���� : �߽ż��� �����ϰ�
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER WHERE NAME = '�߽ż�'),
       PHONE = (SELECT PHONE FROM CUSTOMER WHERE NAME = '�߽ż�')
 WHERE NAME = '�ڼ���';
 
--================================
/*�� DELETE ��
DELETE FROM ���̺��
[WHERE �������]  
***********************/
SELECT * FROM TEST_LIKE;
--DELETE FROM TEST_LIKE WHERE NAME = 'ȫ�浿';
--DELETE FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿2';
--DELETE FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿%';


SELECT * FROM BOOK ORDER BY BOOKID DESC;
--å ������ '�ڹ�'�� �����ϰ� ���ǻ簡 ITBOOK�� ������ ����
DELETE FROM BOOK 
WHERE BOOKNAME LIKE '�ڹ�%' AND PUBLISHER = 'ITBOOK';
COMMIT;

SELECT * FROM ORDERS;





