/* ��¥���� ���� �Լ�
��¥�� ���� ����
DATEŸ�� + ����(����) : ���ڸ�ŭ ���� ����
DATEŸ�� - ����(����) : ���ڸ�ŭ ���� ����

ADD_MONTHS(��¥, ������) : ������ ��ŭ ���� ���� �Ǵ� ����
LAST_DAY(��¥) : ��¥�� ���� ���� ������ ��¥ ���ϱ�
NEXT_DAY(��¥, ����) : ���� ��¥ ���ϱ�, ��¥ ������ ���� ù��° ���� ���� ���ϱ�
MONTHS_BETWEEN(��¥1, ��¥2) : �Ⱓ ���ϱ�(����) ������(��¥1 - ��¥2)
*************************/
SELECT SYSDATE, SYSDATE + 1, SYSDATE - 1 FROM DUAL;

--ADD_MONTHS(��¥, ������) : ������ ��ŭ ���� ���� �Ǵ� ����
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 2) FROM DUAL;
SELECT SYSDATE, ADD_MONTHS(SYSDATE, -2) FROM DUAL;

--LAST_DAY(��¥) : ��¥�� ���� ���� ������ ��¥ ���ϱ�
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
SELECT SYSDATE, ADD_MONTHS(SYSDATE, -1),
        LAST_DAY(ADD_MONTHS(SYSDATE, -1)),
        LAST_DAY(ADD_MONTHS(SYSDATE, -1)) + 1
FROM DUAL;

--NEXT_DAY(��¥, ����) : ���� ��¥ ���ϱ�, ��¥ ������ ���� ù��° ���� ���� ���ϱ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;

--MONTHS_BETWEEN(��¥1, ��¥2) : �Ⱓ ���ϱ�(����) ������(��¥1 - ��¥2)
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 2) FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 2)) FROM DUAL;
SELECT MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 2), SYSDATE) FROM DUAL;

SELECT SYSDATE, ADD_MONTHS(SYSDATE -10, 2) FROM DUAL;
SELECT MONTHS_BETWEEN(ADD_MONTHS(SYSDATE -10, 2), SYSDATE) FROM DUAL;

--==================================
--��¥ ���� ���� ����
-- 1�� : 1���� 24�ð� - 1 / 24 --> 1�ð�
-- 1�ð� : 60�� ---> 1 / 24 / 60 ==> 1��
-- 1�� : 60�� -----> 1 / 24 / 60 / 60 ==> 1��
SELECT 1/24, 1/24 * 5 FROM DUAL;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
     , TO_CHAR(SYSDATE + 1, 'YYYY-MM-DD HH24:MI:SS') --1����
     , TO_CHAR(SYSDATE + (1/24), 'YYYY-MM-DD HH24:MI:SS') --1�ð� ��
     , TO_CHAR(SYSDATE + (1/24)*10, 'YYYY-MM-DD HH24:MI:SS') --10�ð� ��
FROM DUAL;

SELECT 1*60 AS "1��(��)", 60*60 "1�ð�(��)"
     , 60*60*24 "1��(��)", 24*60 "1��(��)" 
FROM DUAL;
--1��(��), 1�ð�(��), 1��(��), 1��(��)
--60	  3600	     86400	 1440

--1��, 1�ð�, 1��, 1��
SELECT 1, 1/24, 1/24/60, 1/24/60/60 FROM DUAL;

