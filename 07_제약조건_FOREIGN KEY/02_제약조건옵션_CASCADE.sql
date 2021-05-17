/* �������� �ɼ�
CASCADE : �θ����̺�(parent)�� ���������� ��Ȱ��ȭ(����) ��Ű�鼭
    �����ϰ� �ִ� �ڳ�(child) ���̺��� �������Ǳ��� ��Ȱ��ȭ(����)
**************************/
--ORA-02297: cannot disable constraint (MADANG.SYS_C007024) - dependencies exist
ALTER TABLE DEPT DISABLE PRIMARY KEY;

--���1 : �ڳ����̺� ����Ű ��� ���� �Ǵ� ��Ȱ��ȭ
ALTER TABLE EMP01 DISABLE CONSTRAINT SYS_C007032;
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 DISABLE CONSTRAINT EMP03_DEPTNO_FK;
ALTER TABLE DEPT DISABLE PRIMARY KEY; --�������̺��� ������ ���� ó����

--DEPT ���̺� PK, �ڳ����̺� FK Ȱ��ȭ
ALTER TABLE DEPT ENABLE PRIMARY KEY; 
ALTER TABLE EMP01 ENABLE CONSTRAINT SYS_C007032;
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 ENABLE CONSTRAINT EMP03_DEPTNO_FK;

--���2 : DEPT ���̺��� PK ��Ȱ��ȭ ��Ű�鼭
---- �����ϰ� �ִ� ���̺�(EMP01, EMP02, EMP03) �Բ� ��Ȱ��ȭ ó��
---- CASCADE �ɼǻ�� : �θ����̺� PK + �ڳ����̺�FK ���ÿ� ��Ȱ��ȭ ó��
ALTER TABLE DEPT DISABLE PRIMARY KEY CASCADE; 

--==========================
/* �������� �ɼ� : ON DELETE CASCADE
���̺��� ���迡�� �θ����̺� ������ ������
�ڳ����̺� �����͵� �Բ� ���� ó��
*******************************/
CREATE TABLE C_TEST_MAIN (
    MAIN_PK NUMBER PRIMARY KEY,
    MAIN_DATA VARCHAR2(30)
);
CREATE TABLE C_TEST_SUB (
    SUB_PK NUMBER PRIMARY KEY,
    SUB_DATA VARCHAR2(30),
    SUB_FK NUMBER,
    CONSTRAINT C_TEST_SUB_FK FOREIGN KEY (SUB_FK)
    REFERENCES C_TEST_MAIN (MAIN_PK) ON DELETE CASCADE
);
------
INSERT INTO C_TEST_MAIN VALUES (1111, '1�� ���� ������');
INSERT INTO C_TEST_MAIN VALUES (2222, '2�� ���� ������');
INSERT INTO C_TEST_MAIN VALUES (3333, '3�� ���� ������');
COMMIT;
--
INSERT INTO C_TEST_SUB VALUES (1, '1�� SUB ������', 1111);
INSERT INTO C_TEST_SUB VALUES (2, '2�� SUB ������', 2222);
INSERT INTO C_TEST_SUB VALUES (3, '3�� SUB ������', 3333);
INSERT INTO C_TEST_SUB VALUES (4, '4�� SUB ������', 3333);
COMMIT;
-------------
--���� ���̺� ������ ����
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 1111;
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 3333;

--===========================
--���̺� ���� : �θ�-�ڳ� ���� ������
DROP TABLE C_TEST_MAIN; --ORA-02449: unique/primary keys in table referenced by foreign keys

--���1 : �������̺� ��� ���� �� �θ����̺� ����
DROP TABLE C_TEST_SUB;
DROP TABLE C_TEST_MAIN;

--���2 : �������̺� �ִ� FK ������ ��� ���� �� �θ����̺� ����
----FK ��Ȱ��ȭ(DISABLE) �������δ� �ȵ�. FK �����ؾ� ��
ALTER TABLE C_TEST_SUB DROP CONSTRAINT C_TEST_SUB_FK;
DROP TABLE C_TEST_MAIN;

--���3 : �θ����̺� ������ CASCADE CONSTRAINTS �ɼ� ���
---- �������̺��� ��������(FK) ������ �θ����̺�(MAIN) ���� ó��
DROP TABLE C_TEST_MAIN CASCADE CONSTRAINTS;
--===================






