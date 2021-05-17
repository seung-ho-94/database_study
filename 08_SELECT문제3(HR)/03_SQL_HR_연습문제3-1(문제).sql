/****** HR ����Ÿ ��ȸ ����2 ****************
/*1�� HR �μ��� � ����� �޿������� ��ȸ�ϴ� ������ �ð� �ִ�. 
  Tucker ��� ���� �޿��� ���� �ް� �ִ� ����� 
  �̸��� ��(Name���� ��Ī), ����, �޿��� ����Ͻÿ�
*****************************************************/
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Tucker' OR LAST_NAME = 'Tucker'; --10000
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, JOB_ID, SALARY 
  FROM EMPLOYEES 
 WHERE SALARY > (SELECT SALARY FROM EMPLOYEES 
                 WHERE LAST_NAME = 'Tucker')
 ORDER BY SALARY;

/*2�� ����� �޿� ���� �� ������ �ּ� �޿��� �ް� �ִ� ����� 
  �̸��� ��(Name���κ�Ī), ����, �޿�, �Ի����� ����Ͻÿ�
********************************************************/
--������ �ּ� �޿�
SELECT JOB_ID, MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
; 
----------
--���ι�(JOIN)
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, E.HIRE_DATE,
       SALARY, M.MIN_SALARY 
  FROM EMPLOYEES E,
       (SELECT JOB_ID, MIN(SALARY) MIN_SALARY
          FROM EMPLOYEES
         GROUP BY JOB_ID) M
 WHERE E.JOB_ID = M.JOB_ID --��������
   AND E.SALARY = M.MIN_SALARY
 ORDER BY E.JOB_ID   
; 
----------------
--�������� ������� ��ȸ
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, E.HIRE_DATE,
       SALARY
  FROM EMPLOYEES E
 WHERE SALARY = (SELECT MIN(SALARY) 
                   FROM EMPLOYEES
                  WHERE JOB_ID = E.JOB_ID) --��������(����)
 ORDER BY JOB_ID               
; 
/*3�� �Ҽ� �μ��� ��� �޿����� ���� �޿��� �޴� ����� 
  �̸��� ��(Name���� ��Ī), �޿�, �μ���ȣ, ������ ����Ͻÿ�
***********************************************************/
--�Ҽ� �μ��� ��� �޿� -> �μ��� ��ձ޿�
SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;
--����(JOIN)������ ��ȸ
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, E.DEPARTMENT_ID, 
       SALARY, TRUNC(AVG_SALARY) AVG_SALARY
  FROM EMPLOYEES E,
       (SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
       ) A
 WHERE E.DEPARTMENT_ID = A.DEPARTMENT_ID --��������
   AND E.SALARY > A.AVG_SALARY
 ORDER BY DEPARTMENT_ID, SALARY     
;
--������� ���� ������� ��ȸ
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, E.DEPARTMENT_ID, SALARY
  FROM EMPLOYEES E
 WHERE SALARY > (SELECT AVG(SALARY) --��ձ޿�
                 FROM EMPLOYEES 
                 WHERE DEPARTMENT_ID = E.DEPARTMENT_ID) --�����μ�
 ORDER BY DEPARTMENT_ID, SALARY                
;
/*4�� ��� ����� �ҼӺμ� ��տ����� ����Ͽ� ������� �̸��� ��(Name���� ��Ī),
  ����, �޿�, �μ���ȣ, �μ���տ���(Department Avg Salary�� ��Ī)�� ����Ͻÿ�
***************************************************************/
--�μ��� ��ձ޿�, ��տ���
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY)),
       ROUND(AVG(SALARY * 12)), --����
       ROUND(AVG(SALARY * (1 + NVL(COMMISSION_PCT,0)))), --Ŀ�̼������ ���޿� ���
       ROUND(AVG(SALARY * (1 + NVL(COMMISSION_PCT,0)) * 12)) --Ŀ�̼������ ���� ���
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;
-----
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, SALARY, E.DEPARTMENT_ID,
       ROUND(SALARY * 12) SALARY12,
       AVG_SALARY12 AS "Department Avg Salary"
  FROM EMPLOYEES E,
       (SELECT DEPARTMENT_ID, ROUND(AVG(SALARY * 12)) AVG_SALARY12
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID 
       ) A
 WHERE E.DEPARTMENT_ID = A.DEPARTMENT_ID  
 ORDER BY DEPARTMENT_ID, SALARY12 
;
--------------------
--����������� - SELECT ���� �������� ���
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, SALARY, E.DEPARTMENT_ID,
       ROUND(SALARY * 12) SALARY12,
       (SELECT ROUND(AVG(SALARY * 12))
          FROM EMPLOYEES
         WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
       ) AS "Department Avg Salary"
  FROM EMPLOYEES E
 ORDER BY DEPARTMENT_ID, SALARY12 
;  



