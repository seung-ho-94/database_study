/* **** �Լ�(FUNCTION) ******
���� �� ���� ����(RETURN)�ϴ� ���α׷�
CREATE OR REPLACE FUNCTION FUNCTION1 (
  PARAM1 IN VARCHAR2 --�Ķ����(�Ű�����) 
) RETURN VARCHAR2 --���� Ÿ�� ����
AS 
BEGIN
  RETURN NULL;  --���ϰ� ����
END FUNCTION1;
-----------------------
--������ �����Ϳ� ���� ���� �ʿ�
RETURN ����������;
--���α׷� �������� �� �����ϴ� ���� �ʿ�
RETURN ���ϰ�;
************************/
--BOOK ���̺��� BOOKID�� å���� Ȯ���ϴ� �Լ�
----(�Է��Ķ���Ͱ� : BOOKID,  RETURN�� : BOOKNAME)
CREATE OR REPLACE FUNCTION GET_BOOKNAME (
    IN_ID IN NUMBER 
) RETURN VARCHAR2 -- ������ ������ Ÿ��(����)
AS 
    V_BOOKNAME book.bookname%TYPE;
BEGIN
    SELECT BOOKNAME INTO V_BOOKNAME
    FROM BOOK
    WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME; --���ϰ�
END;
-------------------
--�Լ��� ���
--SELECT ������ ���
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID)
  FROM BOOK;
--
SELECT O.*, GET_BOOKNAME(BOOKID)
  FROM ORDERS O
;
----
--WHERE ������ �Լ� ���
SELECT O.*, GET_BOOKNAME(BOOKID)
  FROM ORDERS O
 WHERE GET_BOOKNAME(BOOKID) = '�߱��� ��Ź��'
;
--========================
/*(�ǽ�)��ID�� �޾Ƽ� ������ �����ִ� �Լ� �ۼ�(CUSTOMER ���̺� ���)
--�Լ��� : GET_CUSTNAME
-- �Լ��� ����ؼ� ORDERS ���̺� ������ ��ȸ
-- GET_BOOKNAME, GET_CUSTNAME �Լ���� �ֹ�(�Ǹ�)������ å����, ���� ��ȸ
**************************/
CREATE OR REPLACE FUNCTION GET_CUSTNAME (
    IN_ID IN NUMBER
) RETURN VARCHAR2
AS
    V_CUSTNAME customer.name%TYPE;
BEGIN
    SELECT NAME INTO V_CUSTNAME
    FROM CUSTOMER
    WHERE CUSTID = IN_ID;
    
    RETURN V_CUSTNAME;
END;
--------------
SELECT O.*, GET_BOOKNAME(BOOKID), GET_CUSTNAME(CUSTID)
  FROM ORDERS O
;
--
SELECT O.*, 
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) CUST_NAME,
       GET_BOOKNAME(BOOKID),
       GET_CUSTNAME(CUSTID)
  FROM ORDERS O
;











