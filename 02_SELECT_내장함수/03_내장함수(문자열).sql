/******************************* 
오라클의 내장함수 - 문자열, 숫자, 날짜 관련 함수
<문자열 관련 내장함수>
UPPER : 대문자로 변경
LOWER : 소문자로 변경
INITCAP : 첫 글자만 대문자로 나머지는 소문자
LENGTH : 문자열의 길이(문자단위)
LENGTHB : 문자열의 길이(BYTE 단위)
SUBSTR(대상, 시작위치, 길이) : 문자열의 일부 추출
   (시작위치는 1부터 시작, 오른쪽에서 시작하는 경우 마이너스(-)값 사용)
INSTR(대상, 찾는문자) : 대상문자열에 찾는문자 위치값 리턴
INSTR(대상, 찾는문자, 시작위치)
INSTR(대상, 찾는문자, 시작위치, nth) : nth 찾은값의 순서값(3 : 3번째 찾은 값)
TRIM('문자열') : 양쪽 공백 제거
LTRIM('문자열') : 왼쪽에 있는 공백 제거
RTRIM('문자열') : 오른쪽에 있는 공백 제거
CONCAT(문자열1, 문자열2) : 문자열 연결 - 문자열1 || 문자열2
LPAD(대상문자열, 전체글자수, 삽입될문자) : 왼쪽에 삽입
RPAD(대상문자열, 전체글자수, 삽입될문자) : 오른쪽에 삽입
REPLACE(대상문자열, 찾을문자, 변경문자) : 문자열에서 찾은문자를 변경
********************************/
select * from dual;
select 1000 * 1234 from dual;

--UPPER : 대문자로 변경
--LOWER : 소문자로 변경
--INITCAP : 첫 글자만 대문자로 나머지는 소문자
select bookname, upper(bookname) from book where bookid = 10;
select upper('Olympic Champions') from dual;
select lower('Olympic Champions') from dual;
select initcap('OLYMPIC CHAMPIONS') from dual;

select * from book where bookname = 'Olympic Champions';
-- 테이블 명이나 컬럼명은 대소문자 구분이 없지만 데이터는 구분함!
select * from book where bookname like 'OLYMPIC%';
select * from book where bookname like 'olympic%';
select * from book where bookname like 'Olympic%';

-- 표준화가 되어있지 않은(대소문자가 섞여있는 등) 데이터를 찾을때
-- 부득이하게 upper, lower 함수로 변형을 시킨 후 찾아야한다.
select bookid, bookname, upper(bookname) from book
where upper(bookname) like 'OLYMPIC%';

--LENGTH : 문자열의 길이(문자단위)
--LENGTHB : 문자열의 길이(BYTE 단위)
SELECT LENGTH('ABCDE123#$') FROM DUAL; --문자단위 : 10 글자
SELECT LENGTHB('ABCDE123#$') FROM DUAL; --바이트단위 : 10 바이트

SELECT LENGTH('홍길동123') FROM DUAL;  --문자단위 : 6 글자
SELECT LENGTHB('홍길동123') FROM DUAL; --바이트단위 : 12(9+3) 바이트

--SUBSTR(대상, 시작위치, 길이) : 문자열의 일부 추출
---- (시작위치는 1부터 시작, 오른쪽에서 시작하는 경우 마이너스(-)값 사용)
SELECT SUBSTR('홍길동123', 1, 3) FROM DUAL; --홍길동
SELECT SUBSTR('홍길동123', -3, 3) FROM DUAL; --123
SELECT SUBSTR('홍길동12345', 4) FROM DUAL; --12345
SELECT SUBSTR('홍길동12345', -3) FROM DUAL; --345
SELECT SUBSTR('홍길동12345', 2, 4) FROM DUAL; --길동12

--INSTR(대상, 찾는문자) : 대상문자열에 찾는문자 위치값 리턴
--INSTR(대상, 찾는문자, 시작위치)
--INSTR(대상, 찾는문자, 시작위치, nth) : nth 찾은값의 순서값(3 : 3번째 찾은 값)
SELECT INSTR('900101-1234567', '-') FROM DUAL; --7 번째 위치
SELECT INSTR('900101-1234567', '*') FROM DUAL; --0 없음의미
SELECT INSTR('900101-1234567', '34') FROM DUAL; --10 위치값

SELECT INSTR('900101-1234567', '1') FROM DUAL; --4
SELECT INSTR('900101-1234567', '1', 7) FROM DUAL; -- 8 : 7번째 위치부터 찾기
SELECT INSTR('900101-1234567', '1', 1, 2) FROM DUAL; --6 : 처음부터 2번째 위치

--TRIM('문자열') : 양쪽 공백 제거
--LTRIM('문자열') : 왼쪽에 있는 공백 제거
--RTRIM('문자열') : 오른쪽에 있는 공백 제거
SELECT '  TEST  ', '-'||TRIM('  TEST  ')||'-' FROM DUAL;
SELECT '  TEST  ', '-'||LTRIM('  TEST  ')||'-' FROM DUAL;
SELECT '  TEST  ', '-'||RTRIM('  TEST  ')||'-' FROM DUAL;

--CONCAT(문자열1, 문자열2) : 문자열 연결 - 문자열1 || 문자열2
SELECT CONCAT('HELLO ', 'WORLD') FROM DUAL;
SELECT 'HELLO ' || 'WORLD' FROM DUAL;

--LPAD(대상문자열, 전체글자수, 삽입될문자) : 왼쪽에 삽입
--RPAD(대상문자열, 전체글자수, 삽입될문자) : 오른쪽에 삽입
SELECT LPAD('HELLO', 10) FROM DUAL;
SELECT LPAD('HELLO', 10, '*') FROM DUAL;

SELECT RPAD('HELLO', 10) FROM DUAL;
SELECT RPAD('HELLO', 10, '*') FROM DUAL;
SELECT RPAD('HELLO', 10, '*$') FROM DUAL;

--REPLACE(대상문자열, 찾을문자, 변경문자) : 문자열에서 찾은문자를 변경
SELECT 'HELLO JAVA', REPLACE('HELLO JAVA', 'A', 'O') FROM DUAL;
SELECT 'HELLO JAVA', REPLACE('HELLO JAVA', 'JAVA', 'WORLD') FROM DUAL;






