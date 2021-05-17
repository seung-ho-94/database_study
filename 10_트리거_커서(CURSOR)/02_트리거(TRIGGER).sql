/********** Ʈ����(TRIGGER) ******************
Ʈ����(TRIGGER) : Ư�� �̺�Ʈ�� DDL, DML ������ ����Ǿ��� ��,
   �ڵ������� � �Ϸ��� ����(Operation)�̳� ó���� �����ϵ��� �ϴ�
   ����Ÿ���̽� ��ü�� �ϳ�
  -�Ϲ������� ������ ���̺� ����Ÿ�� �߰�(INSERT), ����(DELETE), ����(UPDATE) �� ��,
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
    BOOKNAME VARCHAR2(200),
    PUBLISHER VARCHAR2(200),
    PRICE VARCHAR2(200),
    LOGDATE DATE DEFAULT SYSDATE,
    JOB_GUBUN VARCHAR2(10)
);
--Ʈ���� ����
-- BOOK ���̺� �����Ͱ� �Է�(INSERT)�Ǹ� BOOK_LOG�� �̷� �����
-- Ʈ���Ÿ� : AFTER_INSERT_BOOK
CREATE OR REPLACE TRIGGER AFTER_INSERT_BOOK 
    AFTER INSERT ON BOOK
    FOR EACH ROW
BEGIN
    --�Է¿� ���� �̷� �����
    INSERT INTO BOOK_LOG
           (BOOKID, BOOKNAME, PUBLISHER, PRICE, 
            LOGDATE, JOB_GUBUN) 
    VALUES (:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER, :NEW.PRICE,
            SYSDATE, 'INSERT');
END;
---------------------
-- INSERT Ʈ���� ���� ���� Ȯ��
SELECT * FROM BOOK_LOG;
SELECT * FROM BOOK ORDER BY BOOKID DESC;
DELETE FROM BOOK WHERE BOOKID > 10;
INSERT INTO BOOK VALUES (30, '�����ͺ��̽��� ����', 'IT_BOOK', 25000);
ROLLBACK; --�Է��۾� ���(Ʈ���ſ� ���� �Էµ� �����͵� �Է���ҵ�)
COMMIT;
INSERT INTO BOOK VALUES (30, '�����ͺ��̽��� ����', 'IT_BOOK', 25000);
INSERT INTO BOOK VALUES (31, '�����ͺ��̽��� ����2', 'IT_BOOK', 30000);

--======================================
-- UPDATE Ʈ���� �ۼ� : AFTER_UPDATE_BOOK
create or replace TRIGGER AFTER_UPDATE_BOOK 
    AFTER UPDATE ON BOOK
    FOR EACH ROW
BEGIN
    --������ ���� �̷� �����
    INSERT INTO BOOK_LOG
           (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN) 
    VALUES (:OLD.BOOKID
         ,  :OLD.BOOKNAME ||' -> '|| :NEW.BOOKNAME
         ,  :OLD.PUBLISHER ||' -> '|| :NEW.PUBLISHER
         ,  :OLD.PRICE ||' -> '|| :NEW.PRICE,
            'UPDATE');
END;
-----------
-- UPDATE Ʈ���� ���� Ȯ��
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT * FROM BOOK_LOG;
UPDATE BOOK
   SET BOOKNAME = '����Ŭ�����ͺ��̽�������2'
     , PRICE = 32000
 WHERE BOOKID = 31; 
COMMIT; 
-----------------------
--(�ǽ�) DELETE Ʈ���� �ۼ��ϰ� ���� �׽�Ʈ ����
-- Ʈ���Ÿ� : AFTER_DELETE_BOOK
-- ������ BOOK ���̺� �����Ͱ� �����Ǹ�, BOOK_LOG ���̺� �̷� �����
--------------------------------
CREATE OR REPLACE TRIGGER AFTER_DELETE_BOOK 
    AFTER DELETE ON BOOK
    FOR EACH ROW
BEGIN
    --���� �α� �����
    INSERT INTO BOOK_LOG
           (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN) 
    VALUES (:OLD.BOOKID, :OLD.BOOKNAME, :OLD.PUBLISHER, :OLD.PRICE, 'DELETE');
           
END;
-------
-- DELETE Ʈ���� ���ۿ��� Ȯ��
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT * FROM BOOK_LOG ORDER BY LOGDATE DESC;
--BOOK ���̺� ������ DELETE �۾��ϰ� BOOK_LOG Ȯ��
DELETE FROM BOOK WHERE BOOKID > 10;
ROLLBACK;
COMMIT;
--==============================
--INSERT, UPDATE, DELETE �̺�Ʈ�� ���� Ʈ���� 
CREATE OR REPLACE TRIGGER TRIGGER_BOOK_IUD 
    AFTER INSERT OR UPDATE OR DELETE ON BOOK
    FOR EACH ROW
BEGIN
    --INSERT �̺�Ʈ �߻��� ��� �α� �����
    IF INSERTING THEN
        INSERT INTO BOOK_LOG
               (BOOKID, BOOKNAME, PUBLISHER, PRICE, LOGDATE, JOB_GUBUN) 
        VALUES (:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER, :NEW.PRICE, SYSDATE, 'INSERT');
    END IF;
    -- UPDATE �̺�Ʈ �߻��� ��� �α� �����
    IF UPDATING THEN
        INSERT INTO BOOK_LOG
               (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN) 
        VALUES (:OLD.BOOKID
             ,  :OLD.BOOKNAME ||' -> '|| :NEW.BOOKNAME
             ,  :OLD.PUBLISHER ||' -> '|| :NEW.PUBLISHER
             ,  :OLD.PRICE ||' -> '|| :NEW.PRICE,
                'UPDATE');
    END IF;
    -- DELETE �̺�Ʈ �߻��� ��� �α� �����
    IF DELETING THEN
        INSERT INTO BOOK_LOG
               (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN) 
        VALUES (:OLD.BOOKID, :OLD.BOOKNAME, :OLD.PUBLISHER, :OLD.PRICE, 'DELETE');
    END IF;
    
END;





