/* ** �ǽ����� : HR����(DB)���� �䱸���� �ذ� **********
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
-- ������ �ִ� ���޿� �˻�
-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
-- ������ ��ձ޿� �̻��� ���� ��ȸ
**********************************************************/
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
SELECT * FROM EMPLOYEES WHERE employee_id = 100;
SELECT * FROM EMPLOYEES WHERE employee_id > 100;

-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000;

-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY 
FROM EMPLOYEES 
WHERE SALARY >= 15000
ORDER BY SALARY DESC;

-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY 
FROM EMPLOYEES 
WHERE SALARY <= 10000
ORDER BY SALARY DESC;

-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
SELECT *
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = LOWER('john') --������ ǥ��ȭ �ȵ� ���
;
SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = INITCAP('john') --������ ǥ��ȭ�� ���
;

-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
SELECT COUNT(*)
FROM EMPLOYEES
WHERE FIRST_NAME = INITCAP('john') --������ ǥ��ȭ�� ���
;

-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
SELECT EMPLOYEE_ID, HIRE_DATE, 
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEES
;
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS FULLNAME, 
       SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2008'
ORDER BY HIRE_DATE
;
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS FULLNAME, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN TO_DATE('2008/01/01', 'YYYY/MM/DD')
                    AND TO_DATE('2008-12-31', 'YYYY-MM-DD')
;
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS FULLNAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 20000 AND SALARY <= 30000
;
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS FULLNAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 20000 AND 30000
;
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NULL;

-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
SELECT MAX(SALARY) 
FROM EMPLOYEES
WHERE job_id = 'IT_PROG'
;
SELECT 'IT_PROG', COUNT(*), SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEES
WHERE job_id = 'IT_PROG'
;

-- ������ �ִ� ���޿� �˻�
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
;

-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
 HAVING MAX(SALARY) >= 10000
;
-- ������ ��ձ޿� �̻��� ���� ��ȸ
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
;
SELECT EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
  AND SALARY >= 5760 ;

--����
SELECT E.EMPLOYEE_ID, E.JOB_ID, AVG.JOB_ID AVG_JOB, 
       E.SALARY, AVG_SALARY
  FROM EMPLOYEES E,
       (SELECT JOB_ID, AVG(SALARY) AVG_SALARY
        FROM EMPLOYEES
        GROUP BY JOB_ID
       ) AVG
 WHERE E.JOB_ID = AVG.JOB_ID
   AND E.SALARY >= AVG.AVG_SALARY
;  
--������ ��ձ޿� �̻��� ���� ��ȸ(�����������)
SELECT *
  FROM EMPLOYEES E
 WHERE 1=1
   --AND JOB_ID = 'IT_PROG'
   AND SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES 
                   WHERE JOB_ID = E.JOB_ID)  
;












  
  
  
  


