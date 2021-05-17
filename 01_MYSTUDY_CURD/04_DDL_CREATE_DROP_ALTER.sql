/*(�ǽ�) ���̺�(TABLE) ����� (���̺�� : TEST2)
    NO : ����Ÿ�� 5�ڸ�, PRIMARY KEY ����
    ID : ����Ÿ�� 10�ڸ�(���� 10�ڸ�), ���� �ݵ�� ���� (NULL��� ����)
    NAME : �ѱ� 10�ڸ� ���尡���ϰ� ����, ���� �ݵ�� ����
    EMAIL : ����, ����, Ư������ ���� 30�ڸ�
    ADDRESS : �ѱ� 100��
    IDNUM : ����Ÿ�� ������ 7�ڸ�, �Ҽ��� 3�ڸ�
    REGDATE : ��¥Ÿ��
****************************/
CREATE TABLE TEST2 (
    NO NUMBER(5) PRIMARY KEY, 
    ID VARCHAR2(10) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30),
    ADDRESS VARCHAR2(300),
    IDNUM NUMBER(7,3),
    REGDATE DATE 
);
SELECT * FROM TEST2;

INSERT INTO TEST2 (NO, ID, NAME, EMAIL, ADDRESS, IDNUM)
VALUES (1, '1111', '�ӽ�ȣ', 'xlqmdl@nate.com', '���ֽ�', 13.543);

INSERT INTO TEST2 (NO, ID, NAME, EMAIL, ADDRESS, IDNUM, REGDATE)
VALUES (2, '2222', '������', '�ٺ�@nate.com', '����', 14.543, SYSDATE);

INSERT INTO TEST2 (NO, ID, NAME, EMAIL, ADDRESS, IDNUM, REGDATE)
VALUES (3, '3333', '������', '�𸣴��̸���', '�����', 1244.45, SYSDATE);

UPDATE TEST2
SET REGDATE = SYSDATE
WHERE NO = 1;

SELECT * FROM TEST2 WHERE NO = 1;
COMMIT;

-- Ư�� ���̺�l �����Ϳ� �Բ� ���̺� ������ �Բ� ����
CREATE TABLE TEST3
AS SELECT * FROM TEST2;

SELECT * FROM TEST3;

SELECT * FROM TEST4;
--Ư�� ���̺��� Ư���÷��� Ư�� �����͸� �����ϸ鼭 ���̺� ����
CREATE TABLE TEST4
AS 
SELECT NO, ID, NAME, EMAIL FROM TEST2 WHERE ID = '1111';

--=======================
--Ư�� ���̺��� ������ ����(�����ʹ� �������� ����)
CREATE TABLE TEST5
AS
SELECT *FROM TEST2 WHERE 1 = 2;

SELECT * FROM TEST5;
--===============================
SELECT *FROM TEST2;
DELETE FROM TEST2 WHERE ID = '3333';
DELETE FROM TEST2;
ROLLBACK;

--======================���̺� ����==========================
--TRUNCATE ��ɹ� : ���̺� ��ü ������ ����(ROLLBACK ���� �ȵ�)
TRUNCATE TABLE TEST2;
SELECT * FROM TEST2;

--DROP ��ɹ� : �����Ϳ� �Բ� ���̺� ���� ��� ����ó��
-- cascade constraints : ���������Ͱ� �־ ����
-- PURGE : �����뿡 ������� ������ ����
DROP TABLE TEST4;


--======================���̺� ����==========================
-- DDL : ALTER TABLE
--  ADD : �߰�
--  MODIFY : ���� -> ������ ���¿� ���� ���� ���ɿ��� ����
--      
--  DROP COLUMN : ����

SELECT * FROM TEST3;

--�÷��߰� TEST3 ���̺� ADDCOL �÷� �߰�
ALTER TABLE TEST3 ADD ADDCOL VARCHAR2(10);

--�÷����� TEST3 ���̺��� ADDCOL ũ�� -> VARCHAR(20)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(20);
UPDATE TEST3 SET ADDCOL = '123456789012345';

ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR(10); --�����߻�
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR(15); --����ó����

--�÷����� : DROP COLUMN
ALTER TABLE TEST3 DROP COLUMN ADDCOL;
SELECT * FROM TEST3;
ALTER TABLE "MYSTUDY"."TEST3" RENAME TO AAAA;
ALTER TABLE AAAA RENAME TO TEST3;



