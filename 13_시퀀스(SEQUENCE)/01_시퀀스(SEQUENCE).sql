/****������******
SEQUENCE : DB���� �����ϴ� �ڵ�ä�� ��ü
���� : CREATE SEQUENCE ��������;
���� : DROP SEQUENCE ��������;

��������.NEXVAL : ������ ��ȣ(��) ����
��������.CURRVAL : ���� �������� Ȯ�� (NEXVAL �ѹ��̻� ���� ��)


******************/
CREATE SEQUENCE "MADANG"."SEQUENCE1"
MINVALUE 1 MAXVALUE 9999999999999999999999999
INCREMENT BY 1
START WITH 1 CACHE 20 NOORDER NOCYCLE;
---------------------------------------
SELECT SEQUENCE1.NEXTVAL FROM DUAL; --���ο� ��ȣ ����
SELECT SEQUENCE1.CURRVAL FROM DUAL; --���� ������ ��ȣ(������ ��ȣ)

SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT MAX(BOOKID), NVL(MAX(BOOKID),0) + 1 FROM BOOK;

--�������� ����ϴ� ���
CREATE SEQUENCE SEQ_BOOK
START WITH 50 
INCREMENT BY 1
NOCACHE;

--BOOK���̺� INSERT �۾�, BOOKID �ִ밪 +1 ���
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES ((SELECT NVL(MAX(BOOKID),0) +1 FROM BOOK),
        'MAX(BOOKID)+1', 'IT_BOOK', 20000);

INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (SEQ_BOOK.NEXTVAL,
        '���������', 'IT_BOOK', 20000);

SELECT * FROM BOOK ORDER BY BOOKID DESC;












