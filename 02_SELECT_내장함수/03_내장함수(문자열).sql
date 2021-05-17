/******************************* 
����Ŭ�� �����Լ� - ���ڿ�, ����, ��¥ ���� �Լ�
<���ڿ� ���� �����Լ�>
UPPER : �빮�ڷ� ����
LOWER : �ҹ��ڷ� ����
INITCAP : ù ���ڸ� �빮�ڷ� �������� �ҹ���
LENGTH : ���ڿ��� ����(���ڴ���)
LENGTHB : ���ڿ��� ����(BYTE ����)
SUBSTR(���, ������ġ, ����) : ���ڿ��� �Ϻ� ����
   (������ġ�� 1���� ����, �����ʿ��� �����ϴ� ��� ���̳ʽ�(-)�� ���)
INSTR(���, ã�¹���) : ����ڿ��� ã�¹��� ��ġ�� ����
INSTR(���, ã�¹���, ������ġ)
INSTR(���, ã�¹���, ������ġ, nth) : nth ã������ ������(3 : 3��° ã�� ��)
TRIM('���ڿ�') : ���� ���� ����
LTRIM('���ڿ�') : ���ʿ� �ִ� ���� ����
RTRIM('���ڿ�') : �����ʿ� �ִ� ���� ����
CONCAT(���ڿ�1, ���ڿ�2) : ���ڿ� ���� - ���ڿ�1 || ���ڿ�2
LPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : ���ʿ� ����
RPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : �����ʿ� ����
REPLACE(����ڿ�, ã������, ���湮��) : ���ڿ����� ã�����ڸ� ����
********************************/
select * from dual;
select 1000 * 1234 from dual;

--UPPER : �빮�ڷ� ����
--LOWER : �ҹ��ڷ� ����
--INITCAP : ù ���ڸ� �빮�ڷ� �������� �ҹ���
select bookname, upper(bookname) from book where bookid = 10;
select upper('Olympic Champions') from dual;
select lower('Olympic Champions') from dual;
select initcap('OLYMPIC CHAMPIONS') from dual;

select * from book where bookname = 'Olympic Champions';
-- ���̺� ���̳� �÷����� ��ҹ��� ������ ������ �����ʹ� ������!
select * from book where bookname like 'OLYMPIC%';
select * from book where bookname like 'olympic%';
select * from book where bookname like 'Olympic%';

-- ǥ��ȭ�� �Ǿ����� ����(��ҹ��ڰ� �����ִ� ��) �����͸� ã����
-- �ε����ϰ� upper, lower �Լ��� ������ ��Ų �� ã�ƾ��Ѵ�.
select bookid, bookname, upper(bookname) from book
where upper(bookname) like 'OLYMPIC%';

--LENGTH : ���ڿ��� ����(���ڴ���)
--LENGTHB : ���ڿ��� ����(BYTE ����)
SELECT LENGTH('ABCDE123#$') FROM DUAL; --���ڴ��� : 10 ����
SELECT LENGTHB('ABCDE123#$') FROM DUAL; --����Ʈ���� : 10 ����Ʈ

SELECT LENGTH('ȫ�浿123') FROM DUAL;  --���ڴ��� : 6 ����
SELECT LENGTHB('ȫ�浿123') FROM DUAL; --����Ʈ���� : 12(9+3) ����Ʈ

--SUBSTR(���, ������ġ, ����) : ���ڿ��� �Ϻ� ����
---- (������ġ�� 1���� ����, �����ʿ��� �����ϴ� ��� ���̳ʽ�(-)�� ���)
SELECT SUBSTR('ȫ�浿123', 1, 3) FROM DUAL; --ȫ�浿
SELECT SUBSTR('ȫ�浿123', -3, 3) FROM DUAL; --123
SELECT SUBSTR('ȫ�浿12345', 4) FROM DUAL; --12345
SELECT SUBSTR('ȫ�浿12345', -3) FROM DUAL; --345
SELECT SUBSTR('ȫ�浿12345', 2, 4) FROM DUAL; --�浿12

--INSTR(���, ã�¹���) : ����ڿ��� ã�¹��� ��ġ�� ����
--INSTR(���, ã�¹���, ������ġ)
--INSTR(���, ã�¹���, ������ġ, nth) : nth ã������ ������(3 : 3��° ã�� ��)
SELECT INSTR('900101-1234567', '-') FROM DUAL; --7 ��° ��ġ
SELECT INSTR('900101-1234567', '*') FROM DUAL; --0 �����ǹ�
SELECT INSTR('900101-1234567', '34') FROM DUAL; --10 ��ġ��

SELECT INSTR('900101-1234567', '1') FROM DUAL; --4
SELECT INSTR('900101-1234567', '1', 7) FROM DUAL; -- 8 : 7��° ��ġ���� ã��
SELECT INSTR('900101-1234567', '1', 1, 2) FROM DUAL; --6 : ó������ 2��° ��ġ

--TRIM('���ڿ�') : ���� ���� ����
--LTRIM('���ڿ�') : ���ʿ� �ִ� ���� ����
--RTRIM('���ڿ�') : �����ʿ� �ִ� ���� ����
SELECT '  TEST  ', '-'||TRIM('  TEST  ')||'-' FROM DUAL;
SELECT '  TEST  ', '-'||LTRIM('  TEST  ')||'-' FROM DUAL;
SELECT '  TEST  ', '-'||RTRIM('  TEST  ')||'-' FROM DUAL;

--CONCAT(���ڿ�1, ���ڿ�2) : ���ڿ� ���� - ���ڿ�1 || ���ڿ�2
SELECT CONCAT('HELLO ', 'WORLD') FROM DUAL;
SELECT 'HELLO ' || 'WORLD' FROM DUAL;

--LPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : ���ʿ� ����
--RPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : �����ʿ� ����
SELECT LPAD('HELLO', 10) FROM DUAL;
SELECT LPAD('HELLO', 10, '*') FROM DUAL;

SELECT RPAD('HELLO', 10) FROM DUAL;
SELECT RPAD('HELLO', 10, '*') FROM DUAL;
SELECT RPAD('HELLO', 10, '*$') FROM DUAL;

--REPLACE(����ڿ�, ã������, ���湮��) : ���ڿ����� ã�����ڸ� ����
SELECT 'HELLO JAVA', REPLACE('HELLO JAVA', 'A', 'O') FROM DUAL;
SELECT 'HELLO JAVA', REPLACE('HELLO JAVA', 'JAVA', 'WORLD') FROM DUAL;






