/* ******** CURSOR(Ŀ��) **************
�����ͺ��̽� Ŀ��(Cursor)�� �Ϸ��� �����Ϳ� ���������� �׼����� �� 
�˻� �� "���� ��ġ"�� �����ϴ� ������ ���

������Ŀ�� : SELECT, INSERT, UPDATE, DELETE ������ ����� ��
     DBMS�� CURSOR(Ŀ��)�� Open, Fetch, Close �ڵ� ó��
�����Ŀ�� : ���α׷������� ��������� Ŀ��(CURSOR)�� ������ ���

<Ŀ��(CURSOR) ��� ����>
1. ����(CURSOR Ŀ���� IS SELECT��)
2. Ŀ������(OPEN Ŀ����)
3. ����Ÿ����(FETCH Ŀ���� INTO)
4. Ŀ���ݱ�(CLOSE Ŀ����)
------------------------------------------
- SQL%ROWCOUNT : ���� ��
- SQL%FOUND : 1�� �̻��� ��� (������� ������ true)
- SQL%NOTFOUND : ������� �ϳ��� ������ true
- SQL%ISOPEN : �׻� false, �Ͻ��� Ŀ���� ���� ������ true
**************************************/
CREATE OR REPLACE PROCEDURE DISP_ORDERS
AS
    --1. Ŀ������(CURSOR Ŀ���� IS SELECT��)
    CURSOR C_ORDERS IS
    SELECT ORDERID
         , GET_CUSTNAME(CUSTID) AS CUSTNAME
         , GET_BOOKNAME(BOOKID) AS BOOKNAME
         , SALEPRICE, ORDERDATE
    FROM ORDERS;
    --����� ���� ����
    V_ORDERID orders.orderid%TYPE;
    V_CUSTNAME customer.name%TYPE;
    V_BOOKNAME book.bookname%TYPE;
    V_SALEPRICE orders.saleprice%TYPE;
    V_ORDERDATE orders.orderdate%TYPE;
BEGIN
    --����� Ŀ�� ����ϱ�
    --2. Ŀ������(OPEN Ŀ����)
    OPEN C_ORDERS;
    
    LOOP
        --3. ����Ÿ����(FETCH Ŀ���� INTO)
        FETCH C_ORDERS
        INTO V_ORDERID, V_CUSTNAME, V_BOOKNAME, V_SALEPRICE, V_ORDERDATE;
        
        EXIT WHEN C_ORDERS%NOTFOUND; --Ŀ���� �����Ͱ� ������ �ݺ� ����
        
        --Ŀ������ ������ ������ ȭ�� ���
        DBMS_OUTPUT.PUT_LINE(V_ORDERID||', '||V_CUSTNAME||', '||V_BOOKNAME
            ||', '||V_SALEPRICE||', '||V_ORDERDATE);
    END LOOP;
    
    --4. Ŀ���ݱ�(CLOSE Ŀ����)
    CLOSE C_ORDERS;
END;
--====================







