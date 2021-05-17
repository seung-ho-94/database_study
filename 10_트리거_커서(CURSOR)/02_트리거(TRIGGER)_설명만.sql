/********** Ʈ����(TRIGGER) ******************
Ʈ����(TRIGGER) : Ư�� �̺�Ʈ�� DDL, DML ������ ����Ǿ��� ��,
   �ڵ������� � �Ϸ��� ����(Operation)�̳� ó���� �����ϵ��� �ϴ�
   ����Ÿ���̽� ��ü�� �ϳ�
  -�Ϲ������� ������ ���̺� ����Ÿ�� �߰�(NSERT), ����(DELETE), ����(UPDATE) �� ��,
    �ٸ� ���� ���迡 �ִ� ���̺��� ����Ÿ�� �ڵ������� ������ ��쿡 ���

CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
  BEFORE [OR AFTER]
  UPDATE [OR DELETE OR INSERT] ON ���̺��
  [FOR EACH ROW]
DECLARE
  ���������;
BEGIN
  ���α׷� ���� ������;
END;  
-------------------------------
<Ʈ���� ����ñ� ����>
BEFORE : ������ ó���� ����Ǳ� �� ����(INSERT, UPDATE, DELETE �� ������)
AFTER : ������ ó���� ����� �� ����(INSERT, UPDATE, DELETE �� ������)

�̺�Ʈ ���� ���� : INSERT, UPDATE, DELETE
�̺�Ʈ �߻� ���̺� ���� : ON ���̺��

<ó������ ����>
FOR EACH ROW : ����Ÿ ó���� �ǰ��� Ʈ���� ����. �� �ɼ��� ������ 
  �⺻���� ���� ���� Ʈ���ŷ� ����Ǹ� ������, �Ŀ� �ѹ����� Ʈ���� ����

DECLARE : ���� ���� �� ��� Ű����
--------------------
<�÷��� ���>
:OLD.�÷��� : SQL �ݿ� ���� �÷� ����Ÿ�� �ǹ�
:NEW.�÷��� : SQL �ݿ� ���� �÷� ����Ÿ�� �ǹ�
---------------------
<Ʈ���� ����, Ȱ��, ��Ȱ��>
- ���� : DROP TRIGGER Ʈ���Ÿ�;
- Ȱ�� : ALTER TRIGGER Ʈ���Ÿ� enable;
- ��Ȱ�� : ALTER TRIGGER Ʈ���Ÿ� disable;
*****************************************/
--BOOK ���̺� ���� �α�(LOG �̷�)�� ���� ���̺� ����
CREATE TABLE BOOK_LOG (
    BOOKID NUMBER(5),
    BOOKNAME VARCHAR(200),
    PUBLISHER VARCHAR(200),
    PRICE VARCHAR(200),
    LOGDATE DATE DEFAULT SYSDATE,
    JOB_GUBUN VARCHAR(10)
);
--Ʈ���� ����
--BOOK ���̺� �����Ͱ� �Է�(INSERT)�Ǹ� BOOK_LOG�� �̷� �����
--Ʈ���Ÿ� : AFTER_INSERT_BOOK
CREATE OR REPLACE TRIGGER AFTER_INSERT_BOOK 
AFTER INSERT ON BOOK 
FOR EACH ROW
BEGIN
  --�Է¿� ���� �̷� �����
  INSERT INTO BOOK_LOG
        (BOOKID, BOOKNAME, PUBLISHER, PRICE, LOGDATE, JOB_GUBUN)
  VALUES(:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER, :NEW.PRICE,
         SYSDATE, 'INSERT');
END;
----------------------------------------------------------------
--INSERT Ʈ���� ���� ���� Ȯ��
SELECT * FROM BOOK_LOG;
SELECT * FROM BOOK ORDER BY BOOKID DESC;

INSERT INTO BOOK VALUES (30, '�����ͺ��̽��� ����', 'IT_BOOK', 25000);
ROLLBACK; --�Է��۾� ���(Ʈ���ſ� ���� �Էµ� �����͵� �Է���ҵ�)
COMMIT;

INSERT INTO BOOK VALUES (30, '�����ͺ��̽��� ����', 'IT_BOOK', 25000);
INSERT INTO BOOK VALUES (31, '�����ͺ��̽��� ����2', 'IT_BOOK', 30000);

------------------------------------------
--UPDATE Ʈ���� �ۼ� : AFTER_UPDATE_BOOK
CREATE OR REPLACE TRIGGER AFTER_UPDATE_BOOK 
AFTER UPDATE ON BOOK 
FOR EACH ROW
BEGIN
  --������ ���� �̷� �����
  INSERT INTO BOOK_LOG
        (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
  VALUES(:OLD.BOOKID, 
         :OLD.BOOKNAME || '->' || :NEW.BOOKNAME,
         :OLD.PUBLISHER || '->' || :NEW.PUBLISHER, 
         :OLD.PRICE || '->' || :NEW.PRICE,
         'UPDATE');
END;
----------------------------------------------------------------
--UPDATE Ʈ���� ���� Ȯ��
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT * FROM BOOK_LOG;
UPDATE BOOK 
    SET BOOKNAME = '����Ŭ�����ͺ��̽��� ����2'
     , PRICE = 32000
    WHERE BOOKID = 31;

------------------------- 
--(�ǽ�) delete Ʈ���� �ۼ��ϰ� ���� �׽�Ʈ ����
--Ʈ���Ÿ� : AFTER_DELETE_BOOK
--������ BOOK ���̺� �����Ͱ� �����Ǹ�, BOOK_LOG ���̺� �̷� �����


























