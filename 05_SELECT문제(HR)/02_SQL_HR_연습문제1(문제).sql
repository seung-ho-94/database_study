/* ***** HR DB ������ ��ȸ �ǽ� *****************
��1 HR �μ����� ���� �� ������ �޿� ���� ������ �ۼ��Ϸ��� �Ѵ�. 
  �������(Employees) ���̺��� �޿��� $7,000~$10,000 ���� �̿��� ����� 
  �̸��� ��(Name���� ��Ī) �� �޿��� �޿��� ���� ������ ����Ͻÿ�
*/
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY < 7000 OR SALARY > 10000
 ORDER BY SALARY ASC;
 ---
 SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY NOT BETWEEN 7000 AND 10000
 ORDER BY SALARY;
---
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, SALARY
  FROM EMPLOYEES
 WHERE NOT SALARY BETWEEN 7000 AND 10000
 ORDER BY SALARY;
/*
��2 HR �μ������� �޿�(salary)�� ������(commission_pct)�� ���� ���� ������ �ۼ��Ϸ��� �Ѵ�. 
  ������ �޴� ��� ����� �̸��� ��(Name���� ��Ī), �޿�, ����, �������� ����Ͻÿ�. 
  �̶� �޿��� ū ������� �����ϵ�, �޿��� ������ �������� ū ������� �����Ͻÿ�
*/
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, SALARY,
       JOB_ID, COMMISSION_PCT
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL
 ORDER BY SALARY DESC, COMMISSION_PCT DESC
;
/*  
��3 �̹� �б⿡ 60�� IT �μ������� �ű� ���α׷��� �����ϰ� �����Ͽ� ȸ�翡 �����Ͽ���. 
  �̿� �ش� �μ��� ��� �޿��� 12.3% �λ��ϱ�� �Ͽ���. 
  60�� IT �μ� ����� �޿��� 12.3% �λ��Ͽ� ������(�ݿø�) ǥ���ϴ� ������ �ۼ��Ͻÿ�. 
  ������ �����ȣ, ���� �̸�(Name���� ��Ī), �޿�, �λ�� �޿�(Increase Salary�� ��Ī)������ ����Ͻÿ�
*/  
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, SALARY,
       DEPARTMENT_ID,
       ROUND(SALARY * 0.123) AS "�λ�ݾ�",
       ROUND(SALARY * 1.123) AS "Increase Salary"
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 60
;
/*
��4 �� ����� ��(last_name)�� 's'�� ������ ����� �̸��� ������ �Ʒ��� ���� ���� ����ϰ��� �Ѵ�. 
  ��� �� �̸�(first_name)�� ��(last_name)�� ù ���ڰ� �빮��, ������ ��� �빮�ڷ� ����ϰ� 
  �Ӹ���(��ȸ�÷���)�� Employee JOBs.�� ǥ���Ͻÿ�
  ��) FIRST_NAME  LAST_NAME  Employee JOBs.
      Shelley     Higgins    AC_MGR
*/
SELECT INITCAP(FIRST_NAME) AS FIRST_NAME, 
       INITCAP(LAST_NAME) LAST_NAME, 
       UPPER(JOB_ID) AS "Employee JOBs."
  FROM EMPLOYEES
 WHERE LOWER(LAST_NAME) LIKE '%s' --LOWER ó���� ����������
; 

/*
��5 ��� ����� ������ ǥ���ϴ� ������ �ۼ��Ϸ��� �Ѵ�. 
  ������ ����� �̸��� ��(Name���� ��Ī), �޿�, ���翩�ο� ���� ������ �����Ͽ� ����Ͻÿ�. 
  ���翩�δ� ������ ������ "Salary + Commission", ������ ������ "Salary only"��� ǥ���ϰ�, 
  ��Ī�� ������ ���̽ÿ�. ���� ��� �� ������ ���� ������ �����Ͻÿ�
*/
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, 
       SALARY, COMMISSION_PCT,
       SALARY * 12 AS SALARY12,
       'Salary only' AS COMMISSION_YN
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NULL
UNION
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, 
       SALARY, COMMISSION_PCT,
       SALARY * (1+COMMISSION_PCT) * 12 AS SALARY12,
       'Salary + Commission' AS COMMISSION_YN
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL
;
-- DECODE : ����񱳸� ���� �б� ó��
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, 
       SALARY, COMMISSION_PCT,
       DECODE(COMMISSION_PCT, NULL, 'Salary only', 'Salary + Commission') AS COMMISSTION_YN,
       SALARY * (1 + NVL(COMMISSION_PCT, 0) ) * 12 AS SALARY12
  FROM EMPLOYEES
 --ORDER BY 6 DESC
 ORDER BY SALARY12 DESC
;

--======================================
/*
��6 �� ����� �Ҽӵ� �μ����� �޿� �հ�, �޿� ���, �޿� �ִ�, �޿� �ּڰ��� �����ϰ��� �Ѵ�. 
  ���� ��°��� ���� �ڸ��� �� �ڸ� ���б�ȣ, $ǥ�ÿ� �Բ� ���($123,456) 
  ��, �μ��� �Ҽӵ��� ���� ����� ���� ������ �����ϰ�, ��� �� �Ӹ����� ��Ī(alias) ó���Ͻÿ�
*/    
SELECT DEPARTMENT_ID, 
       COUNT(*) AS CNT, --�ο���
       TO_CHAR(SUM(SALARY), '$999,999') AS SUM_SALARY, --�޿��հ�
       TO_CHAR(ROUND(AVG(SALARY),2), '$999,999.99') AS AVG_SALARY, --�޿����
       TO_CHAR(MAX(SALARY), '$999,999') AS MAX_SALARY, --�޿��ִ밪
       TO_CHAR(MIN(SALARY), '$999,999') AS MIN_SALARY --�޿��ּҰ�
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NOT NULL
 GROUP BY DEPARTMENT_ID
;
/*
��7 ������� ������(JOB_ID) ��ü �޿� ����� $10,000���� ū ��츦 ��ȸ�Ͽ� 
    ������ �޿� ����� ����Ͻÿ�. 
  �� ������ CLERK�� ���Ե� ���� �����ϰ� ��ü �޿� ����� ���� ������� ����Ͻÿ�
*/
--����(JOB_ID)�� CLERK�� ���Ե� ���� Ȯ��
SELECT DISTINCT JOB_ID --DISTINCT �ߺ��� �����ϰ� �ϳ����� ǥ��
  FROM EMPLOYEES
 WHERE UPPER(JOB_ID) LIKE '%CLERK%'
;
SELECT JOB_ID
  FROM EMPLOYEES
 WHERE UPPER(JOB_ID) LIKE '%CLERK%'
 GROUP BY JOB_ID
;
SELECT JOB_ID, AVG(SALARY)
  FROM EMPLOYEES
 WHERE UPPER(JOB_ID) NOT LIKE '%CLERK%'
 GROUP BY JOB_ID
 HAVING AVG(SALARY) > 10000
 ORDER BY AVG(SALARY) DESC
;
/*
��8 HR ��Ű���� �����ϴ� Employees, Departments, Locations ���̺��� ������ �ľ��� �� 
  Oxford�� �ٹ��ϴ� ����� �̸��� ��(Name���� ��Ī), ����, �μ��̸�, �����̸��� ����Ͻÿ�. 
  �̶� ù ��° ���� ȸ���̸��� 'HR-Company'�̶�� ������� ��µǵ��� �Ͻÿ�
*/
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
SELECT 'HR-Company' AS COMPANY_NAME,
       E.EMPLOYEE_ID, E.FIRST_NAME||' '||E.LAST_NAME AS NAME, E.JOB_ID,
       D.DEPARTMENT_NAME, L.CITY 
  FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
   AND D.LOCATION_ID = L.LOCATION_ID
   AND L.CITY = 'Oxford'
   --AND UPPER(L.CITY) = 'OXFORD'
;
--(�ǽ�) EMP_DETAILS_VIEW ����ؼ� ������ ��ȸ

/*
��9 HR ��Ű���� �ִ� Employees, Departments ���̺��� ������ �ľ��� �� 
  ������� �ټ� �� �̻��� �μ��� �μ��̸��� ��� ���� ����Ͻÿ�. 
  �̶� ��� ���� ���� ������ �����Ͻÿ�
*/
SELECT E.DEPARTMENT_ID, d.department_name, COUNT(*) CNT
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = d.department_id
 GROUP BY E.DEPARTMENT_ID, d.department_name
 HAVING COUNT(*) >= 5
 ORDER BY CNT DESC
;
--(�ǽ�) EMP_DETAILS_VIEW ����ؼ� ������ ��ȸ

/*
��10 �� ����� �޿��� ���� �޿� ����� �����Ϸ��� �Ѵ�. 
  �޿� ����� Job_Grades ���̺� ǥ�õȴ�. �ش� ���̺��� ������ ���캻 �� 
  ����� �̸��� ��(Name���� ��Ī), ����, �μ��̸�, �Ի���, �޿�, �޿������ ����Ͻÿ�.
  
CREATE TABLE JOB_GRADES (
    GRADE_LEVEL VARCHAR2(3),
    LOWEST_SAL NUMBER,
    HIGHEST_SAL NUMBER
);
INSERT INTO JOB_GRADES VALUES ('A', 1000, 2999);
INSERT INTO JOB_GRADES VALUES ('B', 3000, 5999);
INSERT INTO JOB_GRADES VALUES ('C', 6000, 9999);
INSERT INTO JOB_GRADES VALUES ('D', 10000, 14999);
INSERT INTO JOB_GRADES VALUES ('E', 15000, 24999);
INSERT INTO JOB_GRADES VALUES ('F', 25000, 40000);
COMMIT;
********************************/
SELECT * FROM JOB_GRADES
 WHERE 24000 BETWEEN LOWEST_SAL AND HIGHEST_SAL;

SELECT E.EMPLOYEE_ID, E.FIRST_NAME||' '||E.LAST_NAME AS NAME,
       E.SALARY, E.JOB_ID,
       d.department_name,
       j.grade_level
       --, j.lowest_sal, j.highest_sal
  FROM EMPLOYEES E, JOB_GRADES J, DEPARTMENTS D 
 WHERE E.DEPARTMENT_ID = d.department_id
   AND E.SALARY BETWEEN j.lowest_sal AND j.highest_sal
   --AND E.EMPLOYEE_ID = 100
;
--(�ǽ�) EMP_DETAILS_VIEW ����ؼ� ������ ��ȸ
