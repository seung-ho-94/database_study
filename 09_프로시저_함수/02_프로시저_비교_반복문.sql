/* �񱳱���(�б�ó��) IF��
IF (���ǽ�) THEN ~ END IF;
IF (���ǽ�) THEN ~ ELSE ~ END IF;
IF (���ǽ�) THEN ~ ELSIF ~...~ ELSIF ~ ELSE ~ END IF;
***************************/
--Ȧ��, ¦�� �Ǻ�
CREATE OR REPLACE PROCEDURE PRC_IF (
  IN_NUM IN NUMBER 
) AS 
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>�Է°� : ' || IN_NUM);
    --Ȧ,¦ �Ǻ�
    IF (MOD(IN_NUM, 2) = 0) THEN
        DBMS_OUTPUT.PUT_LINE(IN_NUM || ' - ¦��');
    ELSE 
        DBMS_OUTPUT.PUT_LINE(IN_NUM || ' - Ȧ��');
    END IF;
END PRC_IF;
----------------------------------
-- 4�� ���� ������ �� Ȯ��
CREATE OR REPLACE PROCEDURE PRC_IF2 (
  IN_NUM IN NUMBER 
) AS 
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>�Է°� : ' || IN_NUM);
    --4�� ���� ������ �� Ȯ��
    IF (MOD(IN_NUM,4) = 0) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4�� ���� ������ 0');
    ELSIF (MOD(IN_NUM,4) = 1) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4�� ���� ������ 1');
    ELSIF (MOD(IN_NUM,4) = 2) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4�� ���� ������ 2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('>> 4�� ���� ������ 3');
    END IF;
END PRC_IF2;

--==================================================
-- �ݺ��� : FOR, WHILE
-- FOR��
---- FOR ���� IN �ʱⰪ .. ������ LOOP ~ END LOOP;

-- ����(N) �ϳ��� �Է� �޾Ƽ� 1~N ���� ���
CREATE OR REPLACE PROCEDURE PRC_FOR_N (
  IN_NUM IN NUMBER 
) AS 
BEGIN
    -- 1���� 1�� �����ϸ鼭 ���޹��� ���ڱ��� ���
    DBMS_OUTPUT.PUT_LINE('>>�Է°� : '|| IN_NUM);
    
    --FOR ������ �ݺ� ó��
    --FOR ���� IN �ʱⰪ .. ������ LOOP ~ END LOOP;
    FOR I IN 1 .. IN_NUM LOOP
        DBMS_OUTPUT.PUT_LINE('> I : ' || I);
    END LOOP;
END PRC_FOR_N;
------------------------------------
--(�ǽ�) ����(N) �ϳ��� �Է¹޾Ƽ� �հ� ���(1~N ������ �հ�)
CREATE OR REPLACE PROCEDURE PRC_FOR_SUM (
    IN_NUM IN NUMBER 
) AS --���� �����
    V_SUM NUMBER := 0;
BEGIN --���๮ �ۼ� ����
    --�Է� ���� �� Ȯ��
    DBMS_OUTPUT.PUT_LINE('>>�Է°� : ' || IN_NUM);
    
    --1 ���� ���޹��� ������ �հ豸�ϱ�
    FOR I IN 1 .. IN_NUM LOOP
        --DBMS_OUTPUT.PUT_LINE('I : ' || I);
        V_SUM := V_SUM + I;
        --DBMS_OUTPUT.PUT_LINE('V_SUM : ' || V_SUM);
    END LOOP;
    DBMS_OUTPUT.PUT('1���� '|| IN_NUM || '������ �հ� : ');
    DBMS_OUTPUT.PUT_LINE(V_SUM);  
END PRC_FOR_SUM;
--===========================
/* LOOP ~ END LOOP;
LOOP
    EXIT WHEN (�������ǽ�);
END LOOP;
***********************/
CREATE OR REPLACE PROCEDURE LOOP1
AS
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
        EXIT WHEN (I >= 10);
        I := I + 1;
    END LOOP;
END;
--===========================
--WHILE ��
-- WHILE (���ǽ�) LOOP ~ END LOOP;
------
-- ����(N) �ϳ��� ���޹޾� �հ� ���(1~N ������ �հ�)
create or replace PROCEDURE PRC_WHILE_SUM (
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    I NUMBER := 1;
BEGIN
    -- �Է� �� Ȯ��
    DBMS_OUTPUT.PUT_LINE('�Է°� : ' || IN_NUM);
    
    -- 1���� �Է°������� �հ� ���ϱ�
    WHILE (I <= IN_NUM) LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
        V_SUM := V_SUM + I;
        I := I + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('�հ� : ' || V_SUM);
END;
--==============================
/* (�ǽ�) ���ڸ� �ϳ� �Է¹޾� 1~���ڱ����� �հ� ���ϱ�
���ν����� : PRC_SUM_EVENODD
-- �Է°��� Ȧ���� Ȧ�� ���� ���ϰ�
-- �Է°��� ¦���� ¦�� ���� ���ؼ�
���� �հ谪�� ȭ�鿡 ���
<�������>
-- �Է¼���: �Է°�, Ȧ��/¦��, �հ�: �հ���
   ��¿�) �Է¼���: 4, ¦��, �հ�: 6
   ��¿�) �Է¼���: 5, Ȧ��, �հ�: 9
********************************/
CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD (
    IN_NUM IN NUMBER 
) AS 
    V_SUM NUMBER := 0;
    I NUMBER := 0;
    V_EVEN_ODD VARCHAR2(10); --Ȧ��, ¦��
BEGIN
    --�Է°� Ȧ/¦ ���� Ȯ��
    IF (MOD(IN_NUM, 2) = 0) THEN 
        V_EVEN_ODD := '¦��';
    ELSE
        V_EVEN_ODD := 'Ȧ��';
    END IF;
    
    --1���� �Էµ� ���ڰ����� ���ڸ� Ȧ/¦ �Ǻ��ϰ� �Էµ� ���ڿ� ���� ����(Ȧ/¦)�� �ջ�
    FOR I IN 1 .. IN_NUM LOOP
        IF (MOD(I,2) = 0 AND V_EVEN_ODD = '¦��') THEN
            V_SUM := V_SUM + I;
            DBMS_OUTPUT.PUT_LINE('¦���� ó���� - ' || I);
        END IF;
        IF (MOD(I,2) <> 0 AND V_EVEN_ODD = 'Ȧ��') THEN
            V_SUM := V_SUM + I;
            DBMS_OUTPUT.PUT_LINE('Ȧ���� ó���� - ' || I);
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('�Է¼���: '|| IN_NUM ||', '|| V_EVEN_ODD
        ||', �հ�: '|| V_SUM);   
END PRC_SUM_EVENODD;
-----------------------------
create or replace PROCEDURE PRC_SUM_EVENODD2 (
    IN_NUM IN NUMBER 
) AS 
    V_SUM NUMBER := 0;
    I NUMBER := 0;
    V_EVEN_ODD VARCHAR2(10); --Ȧ��, ¦��
    V_MOD NUMBER(1) := 0;
BEGIN
    --�Է°� Ȧ/¦ ���� Ȯ��
    V_MOD := MOD(IN_NUM, 2); -- 0 / 1
    IF (V_MOD = 0) THEN 
        V_EVEN_ODD := '¦��';
    ELSE
        V_EVEN_ODD := 'Ȧ��';
    END IF;
    
    --1���� �Էµ� ���ڰ����� ���ڸ� Ȧ/¦ �Ǻ��ϰ� �Էµ� ���ڿ� ���� ����(Ȧ/¦)�� �ջ�
    FOR I IN 1 .. IN_NUM LOOP
        IF (MOD(I,2) = V_MOD) THEN
            V_SUM := V_SUM + I;
            DBMS_OUTPUT.PUT_LINE('Ȧ/¦ ó���� - ' || I);
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('�Է¼���: '|| IN_NUM ||', '|| V_EVEN_ODD
        ||', �հ�: '|| V_SUM);   
END;















