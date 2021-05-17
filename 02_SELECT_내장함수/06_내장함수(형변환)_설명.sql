/************************************************
����ȯ �����Լ�
TO_CHAR : ����Ÿ������ ��ȯ(��¥ -> ����, ���� -> ����)
TO_NUMBER : ����Ÿ������ ��ȯ(���� -> ����)
TO_DATE : ��¥Ÿ������ ��ȯ(���� -> ��¥)

      <- TO_NUMBER(����)  -> TO_DATE(����)
������   ----    ������   ----     ��¥��
      -> TO_CHAR(����)   <- TO_CHAR(��¥)
************************************************
--��¥ -> ����
TO_CHAR(��¥������, '�������')
<�������>
�⵵(YYYY, YY), ��(MM), ��(DD)
�ð� : HH, HH12(12 �ð���), HH24(24 �ð���)
��(MI), ��(SS)
����, ����: AM, PM
����Ͻú��� �ۼ���) YYYY-MM-DD HH24:MI:SS
************************************************/
--TO_CHAR(��¥������, '�������')
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM  DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM  DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM  DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD DY') FROM  DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD (DY)') FROM  DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM  DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS') FROM  DUAL;

--==============================
/* TO_CHAR(����, '�������') : ���� -> ����Ÿ��
<��������>
0(��) : �ڸ����� ��Ÿ����, �ڸ����� ���� �ʴ� ��� 0�� ǥ��
9(��) : �ڸ����� ��Ÿ����, �ڸ����� ���� �ʴ� ��� ǥ������ ����
L : ���� ��ȭ ���� ǥ��
.(��) : �Ҽ���
,(�޸�) : 1000���� ���� ǥ�� ����
**************************************/
SELECT 123000, TO_CHAR(123000) FROM DUAL;
SELECT PRICE, TO_CHAR(PRICE) FROM BOOK;
SELECT '123000', TO_NUMBER('123000') FROM DUAL;

SELECT 123000 + 10, TO_CHAR(123000) + 10,
        '123000' + 10, TO_NUMBER('123000') +10
FROM DUAL;
------------------------------------------------------------------------
SELECT  TO_CHAR(123456, 'L999,999,999'), TO_CHAR(123456, 'L000,000,000')
FROM DUAL;

SELECT  TO_CHAR(123.5, 'L999,999,999'), TO_CHAR(1230.5, 'L000,000,000')
FROM DUAL;

SELECT  TO_CHAR(1230, 'L999,999,999'), TO_CHAR(1230, 'L000,000,000')
FROM DUAL;

SELECT  TO_CHAR(1230.5544, 'L999,999,999'), TO_CHAR(1230.5544, 'L000,000,000')
FROM DUAL;
-------------------------------------
--TO_DATE(���ڿ�, ���Ĺ���) : ���� -> ��¥Ÿ��
SELECT '2021-04-16', SYSDATE FROM DUAL;
SELECT '2021-04-16', TO_DATE('2021-04-16', 'YYYY-MM-DD') FROM DUAL;
SELECT '2021-04-16' + 1 FROM DUAL; --ORA-01722: invalid number
SELECT '2021-04-16' || 1 FROM DUAL;

SELECT TO_DATE('2021-04-16', 'YYYY-MM-DD') + 1 FROM DUAL;
SELECT '2021-04-16 17:57:16',
        TO_DATE('2021-04-16 17:57:16', 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;
--------------------------
SELECT '���糯¥�ð�', SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYY-MM-DD HH24:MI:SS') FROM DUAL; --����ð�
SELECT TO_CHAR(SYSDATE+1, 'YYY-MM-DD HH24:MI:SS') FROM DUAL; --�Ϸ��
SELECT TO_CHAR(SYSDATE +(1/24), 'YYY-MM-DD HH24:MI:SS') FROM DUAL; --1�ð���
SELECT TO_CHAR(SYSDATE +(1/24)*3, 'YYY-MM-DD HH24:MI:SS') FROM DUAL;--3�ð� ��
SELECT TO_CHAR(SYSDATE +1 / 24 / 60, 'YYY-MM-DD HH24:MI:SS') FROM DUAL;--1�� ��
SELECT TO_CHAR(SYSDATE +1 / 24 / 60 /60, 'YYY-MM-DD HH24:MI:SS') FROM DUAL;--1�� ��
















