/****** HR 데이타 조회 문제2 ****************
/*1■ HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. 
  Tucker 사원 보다 급여를 많이 받고 있는 사원의 
  이름과 성(Name으로 별칭), 업무, 급여를 출력하시오
*****************************************************/
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Tucker' OR LAST_NAME = 'Tucker'; --10000
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, JOB_ID, SALARY 
  FROM EMPLOYEES 
 WHERE SALARY > (SELECT SALARY FROM EMPLOYEES 
                 WHERE LAST_NAME = 'Tucker')
 ORDER BY SALARY;

/*2■ 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 
  이름과 성(Name으로별칭), 업무, 급여, 입사일을 출력하시오
********************************************************/
--업무별 최소 급여
SELECT JOB_ID, MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
; 
----------
--조인문(JOIN)
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, E.HIRE_DATE,
       SALARY, M.MIN_SALARY 
  FROM EMPLOYEES E,
       (SELECT JOB_ID, MIN(SALARY) MIN_SALARY
          FROM EMPLOYEES
         GROUP BY JOB_ID) M
 WHERE E.JOB_ID = M.JOB_ID --조인조건
   AND E.SALARY = M.MIN_SALARY
 ORDER BY E.JOB_ID   
; 
----------------
--서브쿼리 방식으로 조회
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, E.HIRE_DATE,
       SALARY
  FROM EMPLOYEES E
 WHERE SALARY = (SELECT MIN(SALARY) 
                   FROM EMPLOYEES
                  WHERE JOB_ID = E.JOB_ID) --같은직무(직종)
 ORDER BY JOB_ID               
; 
/*3■ 소속 부서의 평균 급여보다 많은 급여를 받는 사원의 
  이름과 성(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오
***********************************************************/
--소속 부서의 평균 급여 -> 부서별 평균급여
SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;
--조인(JOIN)문으로 조회
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, E.DEPARTMENT_ID, 
       SALARY, TRUNC(AVG_SALARY) AVG_SALARY
  FROM EMPLOYEES E,
       (SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
       ) A
 WHERE E.DEPARTMENT_ID = A.DEPARTMENT_ID --조인조건
   AND E.SALARY > A.AVG_SALARY
 ORDER BY DEPARTMENT_ID, SALARY     
;
--상관서브 쿼리 방식으로 조회
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, E.DEPARTMENT_ID, SALARY
  FROM EMPLOYEES E
 WHERE SALARY > (SELECT AVG(SALARY) --평균급여
                 FROM EMPLOYEES 
                 WHERE DEPARTMENT_ID = E.DEPARTMENT_ID) --같은부서
 ORDER BY DEPARTMENT_ID, SALARY                
;
/*4■ 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 이름과 성(Name으로 별칭),
  업무, 급여, 부서번호, 부서평균연봉(Department Avg Salary로 별칭)을 출력하시오
***************************************************************/
--부서별 평균급여, 평균연봉
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY)),
       ROUND(AVG(SALARY * 12)), --연봉
       ROUND(AVG(SALARY * (1 + NVL(COMMISSION_PCT,0)))), --커미션적용된 월급여 평균
       ROUND(AVG(SALARY * (1 + NVL(COMMISSION_PCT,0)) * 12)) --커미션적용된 연봉 평균
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
--상관서브쿼리 - SELECT 절에 서브쿼리 사용
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, SALARY, E.DEPARTMENT_ID,
       ROUND(SALARY * 12) SALARY12,
       (SELECT ROUND(AVG(SALARY * 12))
          FROM EMPLOYEES
         WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
       ) AS "Department Avg Salary"
  FROM EMPLOYEES E
 ORDER BY DEPARTMENT_ID, SALARY12 
;  



