/*5�� HR ��Ű���� �ִ� Job_history ���̺��� ������� ���� ���� �̷��� ��Ÿ���� ���̺��̴�. 
  �� ������ �̿��Ͽ� ��� ����� ���� �� ������ ���� �̷� ������ ����ϰ��� �Ѵ�. 
  �ߺ��� ��������� ������ �� ���� ǥ���Ͽ� ����Ͻÿ�
  (�����ȣ, ����)
*********************************************************************/
-- UNION --�ߺ������� �ϳ��� ǥ��
SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES
UNION --�ߺ������� �ϳ��� ǥ��
SELECT EMPLOYEE_ID, JOB_ID FROM Job_history
ORDER BY EMPLOYEE_ID; --UNION ���� ORDER BY�� �� �������� �ѹ��� �ۼ�

--UNION ALL --�ߺ������͵� ��� ǥ��
SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES
UNION ALL --�ߺ������͵� ��� ǥ��
SELECT EMPLOYEE_ID, JOB_ID FROM Job_history
ORDER BY EMPLOYEE_ID;

/*6�� �� �������� �� ����� ���� �̷� ������ Ȯ���Ͽ���. ������ '��� �����
  ���� �̷� ��ü'�� ������ ���ߴ�. ���⿡���� ��� ����� 
  ���� �̷� ���� ����(JOB_HISTORY) �� �������濡 ���� �μ������� 
  �����ȣ�� ���� ������� ����Ͻÿ�(���տ����� UNION)
  (�����ȣ, �μ�����, ����)
**********************************************************************/
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID FROM EMPLOYEES
UNION --�ߺ������� �ϳ��� ǥ��
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID FROM Job_history
ORDER BY EMPLOYEE_ID; 

/*7�� HR �μ������� �ű� ������Ʈ�� �������� �̲� �ش� �����ڵ��� 
  �޿��� �λ� �ϱ�� �����Ͽ���. 
  ����� ���� 107���̸� 19���� ������ �ҼӵǾ� �ٹ� ���̴�. 
  �޿� �λ� ����ڴ� ȸ���� ����(Distinct job_id) �� ���� 5�� �������� 
  ���ϴ� ����� �ش�ȴ�. ������ ������ ���ؼ��� �޿��� ����ȴ�. 
  5�� ������ �޿� �λ���� ������ ����.
  HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)
**********************************************************************/
--DECODE �Լ� ���(����񱳸� ����)
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID, SALARY,
       DECODE(JOB_ID, 
              'HR_REP', SALARY * 1.10, --SALARY + (SALARY * 0.1)
              'MK_REP', SALARY * 1.12,
              'PR_REP', SALARY * 1.15,
              'SA_REP', SALARY * 1.18,
              'IT_PROG', SALARY * 1.20,
              SALARY --���� 5�� ������ �ƴѻ��
       ) AS NEW_SALARY,
       DECODE(JOB_ID, 
              'HR_REP', SALARY * 0.10, --SALARY + (SALARY * 0.1)
              'MK_REP', SALARY * 0.12,
              'PR_REP', SALARY * 0.15,
              'SA_REP', SALARY * 0.18,
              'IT_PROG', SALARY * 0.20,
              0 --���� 5�� ������ �ƴѻ��
       ) AS "���� �λ� �ݾ�"
  FROM EMPLOYEES
-- WHERE JOB_ID = 'HR_REP'
;
-- CASE �����
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID, SALARY,
       CASE JOB_ID 
            WHEN 'HR_REP' THEN SALARY * 1.10  --SALARY + (SALARY * 0.1)
            WHEN 'MK_REP' THEN SALARY * 1.12
            WHEN 'PR_REP' THEN SALARY * 1.15
            WHEN 'SA_REP' THEN SALARY * 1.18
            WHEN 'IT_PROG' THEN SALARY * 1.20
            ELSE SALARY --���� 5�� ������ �ƴѻ��
       END AS NEW_SALARY,
       CASE JOB_ID 
            WHEN 'HR_REP' THEN SALARY * 0.10  --SALARY + (SALARY * 0.1)
            WHEN 'MK_REP' THEN SALARY * 0.12
            WHEN 'PR_REP' THEN SALARY * 0.15
            WHEN 'SA_REP' THEN SALARY * 0.18
            WHEN 'IT_PROG' THEN SALARY * 0.20
            ELSE 0 --���� 5�� ������ �ƴѻ��
       END AS "���� �λ� �ݾ�"
  FROM EMPLOYEES
;

/*8�� HR �μ������� �ֻ��� �Ի��Ͽ� �ش��ϴ� 2001����� 2003����� �Ի��ڵ��� �޿��� 
  ���� 5%, 3%, 1% �λ��Ͽ� ���п� ���� �������� �����ϰ��� �Ѵ�. 
  ��ü ����� �� �ش� �⵵�� �ش��ϴ� ������� �޿��� �˻��Ͽ� �����ϰ�, 
  �Ի����ڿ� ���� �������� ������ �����Ͻÿ�
**********************************************************************/
SELECT MIN(HIRE_DATE) FROM EMPLOYEES; --2001/01/13
SELECT EMPLOYEE_ID, HIRE_DATE FROM EMPLOYEES  ORDER BY HIRE_DATE;
--2001�� �Ի��ڰ� ���ٴ� �����Ͽ� 2001�� �Ի��� Ȯ��
SELECT EMPLOYEE_ID, HIRE_DATE FROM EMPLOYEES 
WHERE HIRE_DATE < TO_DATE('2002/01/01', 'YYYY/MM/DD');
--��¥ Ÿ�� �����Ϳ��� �⵵ 4�ڸ��� �����ؼ� ��
SELECT EMPLOYEE_ID, HIRE_DATE FROM EMPLOYEES 
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2001';
-------------
--CASE WHEN �̿��ؼ� ��ȸ
----��, 2001�� ���� �Ի��� ���� ���
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID, HIRE_DATE, SALARY,
       CASE WHEN HIRE_DATE < TO_DATE('2002/01/01', 'YYYY/MM/DD') --2001�� �Ի���
            THEN SALARY * 1.05
            WHEN HIRE_DATE < TO_DATE('2003-01-01', 'YYYY-MM-DD') --2002�� �Ի���
            THEN SALARY * 1.03
            WHEN HIRE_DATE < TO_DATE('20040101', 'YYYYMMDD') --2003�� �Ի���
            THEN SALARY * 1.01
            ELSE 0
       END AS "����"
  FROM EMPLOYEES
-- WHERE HIRE_DATE >= TO_DATE('2001/01/01', 'YYYY/MM/DD')
--   AND HIRE_DATE < TO_DATE('2004/01/01', 'YYYY/MM/DD')
 ORDER BY HIRE_DATE
;
------------------
--�Ի����� �⵵ 4�ڸ�(YYYY) �������� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID, HIRE_DATE, SALARY,
       CASE WHEN TO_CHAR(HIRE_DATE, 'YYYY') = '2001' --2001�� �Ի���
            THEN SALARY * 1.05
            WHEN TO_CHAR(HIRE_DATE, 'YYYY') = '2002' --2002�� �Ի���
            THEN SALARY * 1.03
            WHEN TO_CHAR(HIRE_DATE, 'YYYY') = '2003' --2003�� �Ի���
            THEN SALARY * 1.01
            ELSE 0
       END AS "����"
  FROM EMPLOYEES
-- WHERE TO_CHAR(HIRE_DATE, 'YYYY') IN ('2001', '2002', '2003')
 ORDER BY HIRE_DATE
;
------------------
--DECODE ó�� : �Ի����� �⵵ 4�ڸ�(YYYY) �������� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID, HIRE_DATE, SALARY,
       DECODE(TO_CHAR(HIRE_DATE, 'YYYY'),
              '2001', ROUND(SALARY * 1.05),
              '2002', ROUND(SALARY * 1.03),
              '2003', ROUND(SALARY * 1.01),
              0
       ) AS "����"
  FROM EMPLOYEES
 WHERE TO_CHAR(HIRE_DATE, 'YYYY') >= '2001' AND TO_CHAR(HIRE_DATE, 'YYYY') <= '2003'
 ORDER BY HIRE_DATE  
;  


/*9�� �μ��� �޿� �հ踦 ���ϰ�, �� ����� ������ ���� ǥ���Ͻÿ�.
  Sum Salary > 100000 �̸�, "Excellent"
  Sum Salary > 50000 �̸�, "Good"
  Sum Salary > 10000 �̸�, "Medium"
  Sum Salary <= 10000 �̸�, "Well"
**********************************************************************/
--�μ��� �޿��հ� 
SELECT DEPARTMENT_ID, SUM(SALARY) DEPT_SUM_SALARY
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY DEPARTMENT_ID
;
--------------------
--CASE WHEN ==> IF ~ ELSIF ~ ELSIF ~ ELSE ~
SELECT DEPARTMENT_ID, SUM(SALARY) DEPT_SUM_SALARY,
       CASE WHEN SUM(SALARY) > 100000 THEN 'Excellent'
            WHEN SUM(SALARY) > 50000 THEN 'Good'
            WHEN SUM(SALARY) > 10000 THEN 'Medium'
            --WHEN SUM(SALARY) <= 10000 THEN 'Well'
            ELSE 'Well'
       END AS "�򰡰��"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY DEPT_SUM_SALARY DESC
;

/*10�� 2005�� ������ �Ի��� ��� �� ������ "MGR"�� ���Ե� ����� 15%, 
  "MAN"�� ���Ե� ����� 20% �޿��� �λ��Ѵ�. 
  ���� 2005����� �ٹ��� ������ ��� �� "MGR"�� ���Ե� ����� 25% �޿��� �λ��Ѵ�. 
  �̸� �����ϴ� ������ �ۼ��Ͻÿ�
**********************************************************************/
SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'MGR' OR JOB_ID = 'MAN'; --������ ����
SELECT DISTINCT JOB_ID FROM EMPLOYEES;
SELECT DISTINCT JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MGR' OR JOB_ID LIKE '%MAN';
SELECT DISTINCT JOB_ID, SUBSTR(JOB_ID, -3) FROM EMPLOYEES 
WHERE JOB_ID LIKE '%MGR' OR JOB_ID LIKE '%MAN';

SELECT DISTINCT JOB_ID FROM EMPLOYEES 
WHERE SUBSTR(JOB_ID, -3) = 'MGR' OR SUBSTR(JOB_ID, -3) = 'MAN';
---------
--CASE WHEN �̿��ؼ� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID, HIRE_DATE, SALARY,
       --'2005'�� ���� �Ի� ���� Ȯ��
       CASE WHEN TO_CHAR(HIRE_DATE, 'YYYY') < '2005'
            THEN CASE WHEN JOB_ID LIKE '%MGR' THEN SALARY * 1.15
                      WHEN JOB_ID LIKE '%MAN' THEN SALARY * 1.20
                      ELSE SALARY
                 END
            --2005����� �ٹ��� ���� 'MGR' �̸� 25% �λ�    
            ELSE CASE WHEN JOB_ID LIKE '%MGR' THEN SALARY * 1.25
                      ELSE SALARY
                 END
       END AS "����� �޿�"
  FROM EMPLOYEES
 ORDER BY HIRE_DATE  
;
-----------------
-- DECODE ������ ����
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME,
       JOB_ID, HIRE_DATE, SALARY,
       --'2005'�� ���� �Ի� ���� Ȯ��
       CASE WHEN TO_CHAR(HIRE_DATE, 'YYYY') < '2005'
            THEN DECODE(SUBSTR(JOB_ID, -3) 
                      , 'MGR', SALARY * 1.15
                      , 'MAN', SALARY * 1.20
                      , SALARY)
            --2005����� �ٹ��� ���� 'MGR' �̸� 25% �λ�    
            ELSE DECODE(SUBSTR(JOB_ID, -3), 'MGR', SALARY * 1.25
                      , SALARY)
       END AS "����� �޿�"
  FROM EMPLOYEES
 ORDER BY HIRE_DATE  
;

/*11�� ������ �Ի��� ��� �� ���
  (���1) ������ �Ի��� ��� ���� �Ʒ��� ���� �� �ະ�� ��µǵ��� �Ͻÿ�(12��).
  1�� xx
  2�� xx
  3�� xx
  ..
  12�� xx
  �հ� XXX
**********************************************************************/ 
SELECT HIRE_DATE, TO_CHAR(HIRE_DATE, 'MM') FROM EMPLOYEES;
SELECT TO_CHAR(HIRE_DATE, 'MM'), COUNT(*)
  FROM EMPLOYEES
 GROUP BY TO_CHAR(HIRE_DATE, 'MM')
; 
--
SELECT COUNT(*) FROM EMPLOYEES;
---------------------
SELECT DECODE(MM, 99, '�հ�', MM||'��') AS "�Ի��", CNT AS "������"
  FROM (SELECT TO_NUMBER(TO_CHAR(HIRE_DATE, 'MM')) AS MM, COUNT(*) CNT
          FROM EMPLOYEES
         GROUP BY TO_CHAR(HIRE_DATE, 'MM')
        UNION
        SELECT 99, COUNT(*) FROM EMPLOYEES
       );
---------------------------------------------------------
/* (���2) ù �࿡ ��� ���� �Ի� ��� ���� ��µǵ��� �Ͻÿ�
  1�� 2�� 3�� 4�� .... 11�� 12��
  xx  xx  xx xx  .... xx   xx
**********************************************************************/
SELECT TO_CHAR(HIRE_DATE, 'MM'),
       DECODE(TO_CHAR(HIRE_DATE, 'MM'), '01', COUNT(*),0) AS "1��",
       DECODE(TO_CHAR(HIRE_DATE, 'MM'), '02', COUNT(*),0) AS "2��",
       DECODE(TO_CHAR(HIRE_DATE, 'MM'), '03', COUNT(*),0) AS "3��",
       COUNT(*)
  FROM EMPLOYEES
 GROUP BY TO_CHAR(HIRE_DATE, 'MM')
;
SELECT SUM(DECODE(TO_CHAR(HIRE_DATE, 'MM'), '01', COUNT(*))) AS "1��",
       SUM(DECODE(TO_CHAR(HIRE_DATE, 'MM'), '02', COUNT(*))) AS "2��",
       SUM(DECODE(TO_CHAR(HIRE_DATE, 'MM'), '03', COUNT(*))) AS "3��",
       SUM(COUNT(*)) AS "�հ�"
  FROM EMPLOYEES
 GROUP BY TO_CHAR(HIRE_DATE, 'MM')
;





