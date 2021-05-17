/* 테이블 생성시 제약조건 설정
컬럼을 정의하면서 컬럼레벨에서 제약조건 지정
- 외래키(FORIGN KEY) 지정으로 관계 설정
- 형태 : 컬럼명 REFERENCES 대상테이블 (컬럼명)
**************************/
SELECT * FROM DEPT;
CREATE TABLE EMP01 (
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT (ID) --외래키 설정(컬럼레벨)
);
-----
SELECT * FROM EMP01;
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');

--ORA-02291: integrity constraint (MADANG.SYS_C007032) violated - parent key not found
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40');--DEPT 테이블의 ID컬럼에 없는 데이터(40) 입력못함

--============================
--테이블 레벨에서 제약조건 지정
CREATE TABLE EMP02 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), --기본키(PRIMARY KEY) 설정
    FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID)
);
SELECT * FROM EMP02;
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');
--ORA-02291: integrity constraint (MADANG.SYS_C007035) violated - parent key not found
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40');--DEPT 테이블의 ID컬럼에 없는 데이터(40) 입력못함

--================================
-- 제약조건명을 명시적으로 선언해서 사용
-- 형태 : CONSTRAINT 제약조건명 적용할제약조건
CREATE TABLE EMP03 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO), --기본키(PRIMARY KEY) 설정
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID)
);
SELECT * FROM EMP03;
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');
--ORA-02291: integrity constraint (MADANG.SYS_C007035) violated - parent key not found
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40');--DEPT 테이블의 ID컬럼에 없는 데이터(40) 입력못함

--==============================
--기본키(PRIMARY KEY) 설정시 복합키 사용
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), --학년
    BAN NUMBER(2), --반
    BUN NUMBER(2), --번호
    NAME VARCHAR2(30),
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN)
);
SELECT * FROM HSCHOOL;
INSERT INTO HSCHOOL VALUES (1, 1, 1, '홍길동1');
--INSERT INTO HSCHOOL VALUES (1, 1, 1, '홍길동~~'); --오류발생 중복데이터
INSERT INTO HSCHOOL VALUES (1, 1, 2, '홍길동2');
INSERT INTO HSCHOOL VALUES (1, 2, 1, '홍길동3');
INSERT INTO HSCHOOL VALUES (3, 1, 1, '홍길동4');

--=====================================
/* *** 테이블에 제약조건 추가, 삭제 ****
--제약조건 추가
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 적용할제약조건(형태);
--제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
*******************************/
--EMP01 테이블의 PRIMARY KEY 삭제 : SYS_C007031
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007031;

--EMP01 테이블에 PRIMARY KEY 추가
--ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 적용할제약조건(형태);
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
-----------------
--PK 존재하는 경우
INSERT INTO EMP01 VALUES (1111, '홍길동2', '직무2', '10'); --unique constraint 오류발생
--PK 삭제 후
ALTER TABLE EMP01 DROP CONSTRAINT EMP01_EMPNO_PK;
INSERT INTO EMP01 VALUES (1111, '홍길동2', '직무2', '10');

--중복데이터가 있는 경우 PK 설정시 오류 발생 : 중복데이터를 없앤 후 적용
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);

--(실습) EMP02, EMP03 외래키(FORIGN KEY) 이름 변경 처리
----EMP02: EMP02_DEPTNO_FK, EMP03: EMP03_FK_DEPTNO

ALTER TABLE EMP02 DROP CONSTRAINT SYS_C007031;
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

--------------------------------
/* 제약조건 활성화 또는 비활성화
--제약조건 설정되어 있는 것을 적용 또는 적용해제
ALTER TABLE 테이블명 DISABLE CONSTRAINT
********************************/
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;

--외래키 DISABLED 상태인 경우

INSERT INTO EMP02 VALUES(3333, '홍길동2', '직무2', '40');
COMMIT;

--제약조건 활성화(적용상태)
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
--<< 참조 데이터가 부모테이블에 없으면 오류
----------------------------------------
--데이터 사전 테이블 사용 제약조건 설정
SELECT * FROM USER_CONS_COLUMNS;
SELECT * FROM USER_CONSTRAINTS;

SELECT a.owner, a.table_name, a.column_name, a.constraint_name
    , b.constraint_type
    , DECODE(B.CONSTRAINT_TYPE,
            'P', 'PRIMARY KEY',
            'U', 'UNIQUE',
            'C', 'CHECK OR NOT NULL',
            'R', 'FORIGN KEY') CONSTRAINT_TYPE_DESC
FROM USER_CONS_COLUMNS A, USER_CONSTRAINTS B
WHERE A.TABLE_NAME = B.TABLE_NAME
AND a.constraint_name = b.constraint_name
AND a.constraint_name LIKE 'EMP%';



