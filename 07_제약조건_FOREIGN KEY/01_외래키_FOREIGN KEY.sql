/* ���̺� ������ �������� ����
�÷��� �����ϸ鼭 �÷��������� �������� ����
- �ܷ�Ű(FORIGN KEY) �������� ���� ����
- ���� : �÷��� REFERENCES ������̺� (�÷���)
**************************/
SELECT * FROM DEPT;
CREATE TABLE EMP01 (
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT (ID) --�ܷ�Ű ����(�÷�����)
);
-----
SELECT * FROM EMP01;
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10');

--ORA-02291: integrity constraint (MADANG.SYS_C007032) violated - parent key not found
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40');--DEPT ���̺��� ID�÷��� ���� ������(40) �Է¸���

--============================
--���̺� �������� �������� ����
CREATE TABLE EMP02 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), --�⺻Ű(PRIMARY KEY) ����
    FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID)
);
SELECT * FROM EMP02;
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10');
--ORA-02291: integrity constraint (MADANG.SYS_C007035) violated - parent key not found
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40');--DEPT ���̺��� ID�÷��� ���� ������(40) �Է¸���

--================================
-- �������Ǹ��� ��������� �����ؼ� ���
-- ���� : CONSTRAINT �������Ǹ� ��������������
CREATE TABLE EMP03 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO), --�⺻Ű(PRIMARY KEY) ����
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID)
);
SELECT * FROM EMP03;
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10');
--ORA-02291: integrity constraint (MADANG.SYS_C007035) violated - parent key not found
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40');--DEPT ���̺��� ID�÷��� ���� ������(40) �Է¸���

--==============================
--�⺻Ű(PRIMARY KEY) ������ ����Ű ���
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), --�г�
    BAN NUMBER(2), --��
    BUN NUMBER(2), --��ȣ
    NAME VARCHAR2(30),
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN)
);
SELECT * FROM HSCHOOL;
INSERT INTO HSCHOOL VALUES (1, 1, 1, 'ȫ�浿1');
--INSERT INTO HSCHOOL VALUES (1, 1, 1, 'ȫ�浿~~'); --�����߻� �ߺ�������
INSERT INTO HSCHOOL VALUES (1, 1, 2, 'ȫ�浿2');
INSERT INTO HSCHOOL VALUES (1, 2, 1, 'ȫ�浿3');
INSERT INTO HSCHOOL VALUES (3, 1, 1, 'ȫ�浿4');

--=====================================
/* *** ���̺� �������� �߰�, ���� ****
--�������� �߰�
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������������(����);
--�������� ����
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
*******************************/
--EMP01 ���̺��� PRIMARY KEY ���� : SYS_C007031
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007031;

--EMP01 ���̺� PRIMARY KEY �߰�
--ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������������(����);
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
-----------------
--PK �����ϴ� ���
INSERT INTO EMP01 VALUES (1111, 'ȫ�浿2', '����2', '10'); --unique constraint �����߻�
--PK ���� ��
ALTER TABLE EMP01 DROP CONSTRAINT EMP01_EMPNO_PK;
INSERT INTO EMP01 VALUES (1111, 'ȫ�浿2', '����2', '10');

--�ߺ������Ͱ� �ִ� ��� PK ������ ���� �߻� : �ߺ������͸� ���� �� ����
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);

--(�ǽ�) EMP02, EMP03 �ܷ�Ű(FORIGN KEY) �̸� ���� ó��
----EMP02: EMP02_DEPTNO_FK, EMP03: EMP03_FK_DEPTNO

ALTER TABLE EMP02 DROP CONSTRAINT SYS_C007031;
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

--------------------------------
/* �������� Ȱ��ȭ �Ǵ� ��Ȱ��ȭ
--�������� �����Ǿ� �ִ� ���� ���� �Ǵ� ��������
ALTER TABLE ���̺�� DISABLE CONSTRAINT
********************************/
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;

--�ܷ�Ű DISABLED ������ ���

INSERT INTO EMP02 VALUES(3333, 'ȫ�浿2', '����2', '40');
COMMIT;

--�������� Ȱ��ȭ(�������)
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
--<< ���� �����Ͱ� �θ����̺� ������ ����
----------------------------------------
--������ ���� ���̺� ��� �������� ����
SELECT * FROM USER_CONS_COLUMNS;
SELECT * FROM USER_CONSTRAINTS;

SELECT a.owner, a.table_name, a.column_name, a.constraint_name
    , b.constraint_type
    , DECODE(B.CONSTRAINT_TYPE,
            'P', 'PRIMARY KEY',
            'U', 'UNIQUE',
            'C', 'CHECK OR NOT NULL',
            'R', 'FORIGN KEY') CONSTRAINT_TYPE_DESC
FROM USER_CONS_COLUMNS A, USER_CONSTRAINTS B
WHERE A.TABLE_NAME = B.TABLE_NAME
AND a.constraint_name = b.constraint_name
AND a.constraint_name LIKE 'EMP%';



