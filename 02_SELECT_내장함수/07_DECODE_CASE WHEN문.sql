/* DECODE, CASE WHEN : SQL�� ������ IF�� ����(CASE : ǥ��SQL)
DECODE : ����񱳸� ����(���� ������ Ȯ��)
DECODE(���, �񱳰�, ������ ó����, �ٸ��� ó����);
DECODE(���, �񱳰�, DECODE(), DECODE());
DECODE(���, �񱳰�1, ó����1
          , �񱳰�2, ó����2
          , ...
          , �񱳰�n, ó����n
          , ó����n+1)
**************************************/
SELECT * FROM CUSTOMER ORDER BY NAME;
SELECT NAME, DECODE(NAME, '�迬��', '��~�迬�ƴ�!!!', '�������')
--     NAME�÷�����  NAME��  �迬�Ƹ�  �̰Ÿ���     �ƴϸ� �̰Ÿ���
FROM CUSTOMER ORDER BY NAME;

--�̸��� �������̸� '�౸����' �ƴϸ� '�����'
SELECT NAME, DECODE(NAME, '������', '�౸����', '�����')
FROM CUSTOMER ORDER BY NAME;

--�̸��� �迬�Ƹ� '�ǰܽ�������', �ڼ����� '����', �������̸� '�౸'
SELECT NAME, DECODE(NAME, '�迬��', '�ǰܽ�������',
                          '������', '�౸',
                          '�ڼ���', '����',
                          '�����') AS NAME_DECODE
FROM CUSTOMER ORDER BY NAME;

--DECODE(���, �񱳰�, DECODE(), DECODE())
--DECODE���� �ȿ� DECODE�� ���
SELECT NAME,
       DECODE(NAME, '�迬��', '�ǰܽ�������',
                    DECODE(NAME, '�ڼ���', '����',
                             DECODE(NAME, '������', '�౸', '�����')
                             )
            ) AS "�"
FROM CUSTOMER ORDER BY NAME;


--===============================================
/***** CASE WHEN �� ************
����1 : SWITCH CASEó��(DECODE�� ó��)
CASE �÷�(���ذ�)
     WHEN �񱳰�1 THEN ��ġ�ϸ� ó���� ����
     WHEN �񱳰�2 THEN ��ġ�ϸ� ó���� ����
     ...
     WHEN �񱳰�n THEN ��ġ�ϸ� ó���� ����
     ELSE ���� ��ġ�ϴ� ��찡 ������ ������ ����
END
--------
����2 : IF THEN ELSE ó�� ���(�ε�� ó�� ����)
--CASE�� ���� ó�����忡�� CASE�ߺ� ��� ����
--�񱳱��� : =, <>, !=, >, <, >=, <=, AND, OR, NOT ��밡��
CASE WHEN �񱳱���
     THEN �񱳱��� ��� TRUE�� ��� ó������
     ELSE �񱳱��� ��� FALSE�� ��� ó������
END   
------
CASE WHEN �񱳱���(��: KOR > 90)
     THEN (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
     ELSE (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
END   
-----
CASE WHEN �񱳱��� THEN ó������
     WHEN �񱳱��� THEN ó������
     ....
     ELSE ���� �񱳱����� �ش���� �ʴ� ��� ó������
END 
***************************/
SELECT * FROM CUSTOMER ORDER BY NAME;
--�̸��� �������̸� '�౸����' �ƴϸ� '�����'
SELECT NAME, DECODE(NAME, '������', '�౸����', '�����')
FROM CUSTOMER ORDER BY NAME;

SELECT NAME, 
    CASE NAME
        WHEN '������' 
        THEN '�౸����' 
        ELSE '�����' 
    END AS NAME_CASE
FROM CUSTOMER ORDER BY NAME; 

 --�̸��� �迬��->�ǰܽ�������, �ڼ���->����, ������->�౸, ������ ->�����
SELECT NAME,
    CASE NAME
        WHEN '�迬��' THEN '�ǰܽ�������'
        WHEN '�ڼ���' THEN '����'
        WHEN '������' THEN '�౸'
        ELSE '�����'
    END AS NAME_CASE
FROM CUSTOMER ORDER BY NAME;

--BOOK ���̺��� ������ �̿��� ��
SELECT * FROM BOOK ORDER BY PRICE;

--����(PRICE)�� 10000 �̸��̸� '�δ�'/ 10000~20000:�����ϴ�
--20000 ���� ũ�� : ��δ� / 30000���� ũ�� : �ʹ���δ�
SELECT B.*,
       CASE WHEN PRICE < 10000 THEN '�δ�'
            WHEN PRICE >= 10000 AND PRICE < 20000  THEN '�����ϴ�'
            WHEN PRICE >= 20000 AND PRICE < 30000 THEN '��δ�'
            ELSE '�ʹ� ��δ�'
       END AS "������"
FROM BOOK B
ORDER BY PRICE;
        





































