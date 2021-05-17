/* STUDENT ���̺� ����
�������� ���� �÷��� �߰�
*/
CREATE TABLE STUDENT (
    ID VARCHAR2(20),
    NAME VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3),
    TOT NUMBER(3),
    AVG NUMBER(5,2)
);
----------------------------
-- CRUD : INSERT, SELECT, UPDATE, DELETE
SELECT * FROM STUDENT;
SELECT ID, NAME FROM STUDENT;

--����Ÿ �߰�(�Է�) : INSERT INTO 
INSERT INTO STUDENT 
       (ID, NAME, KOR, ENG, MATH)
VALUES ('1111', 'ȫ�浿', 100, 90, 80);
COMMIT; --�۾���� DB�ݿ�
ROLLBACK; -- �۾����(INSERT,UPDATE,DELETE �۾�)

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2222', '������', 90, 80, 70);
COMMIT;
----------------------
--���� : ������ ���� - UPDATE
UPDATE STUDENT
SET ENG = 88, MATH = 77
WHERE NAME = '������';
COMMIT;

SELECT * FROM STUDENT WHERE NAME = '������';
SELECT * FROM STUDENT WHERE NAME = 'ȫ�浿';
--------------------------------
--����Ÿ ���� : DELETE FROM
SELECT * FROM STUDENT WHERE ID = '2222';
DELETE FROM STUDENT WHERE ID = '2222';
DELETE FROM STUDENT WHERE NAME = '������';
SELECT * FROM STUDENT WHERE NAME = '������';
COMMIT;
-- =======================
INSERT INTO STUDENT (ID) VALUES ('3333');

