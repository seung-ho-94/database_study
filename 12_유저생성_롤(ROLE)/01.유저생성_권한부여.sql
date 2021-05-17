/* ********* ����� ����, ���� *********
-- ����� ���� : CREATE USER
CREATE USER ����ڸ�(������) --"MDGUEST" 
IDENTIFIED BY ��й�ȣ --"mdguest"  
DEFAULT TABLESPACE ���̺����̽� --"USERS"
TEMPORARY TABLESPACE �ӽ��۾����̺����̽� --"TEMP";

-- ����� �뷮 ����(����)
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";

-- ����� ���� : ALTER USER 
ALTER USER ����ڸ�(������) IDENTIFIED BY ��й�ȣ;

-- ���Ѻο�(�� ��� ���� �ο�, �� �ο�)
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
GRANT CREATE VIEW TO "MDGUEST" ;

--�������� �뷮����
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";

-- ����� ���� : DROP USER
DROP USER ������ [CASCADE];
--CASCADE : ���������� �����(����)�� ������ ��� ����Ÿ ����
*************************************/
--(SYSTEM) CONNECT, RESOURCE ��(ROLE)�� ���� ���� Ȯ��
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
GRANT CREATE VIEW TO "MDGUEST" ;


SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
ORDER BY GRANTEE, privilege
;
--
GRANT CONNECT, RESOURCE TO MDGUEST;


--���Ѻο� : MADANG ������ BOOK ���̺� ���� SELECT ������ MDGUEST���� �ο�
SELECT  * FROM MADANG.BOOK;
GRANT SELECT ON MADANG.BOOK TO MDGUEST; --���Ѻο�

--(MDGUEST) ������ ��뿩�� Ȯ��
SELECT * FROM MADANG.BOOK;      --���� ������ ��ȸ
DELETE FROM MADANG.BOOK WHERE BOOKID  = 1; --���Ѿ���
SELECT * FROM MADANG.CUSTOMER; --ORA-00942: table or view does not exist

--(MADANG) ����ȸ�� 
REVOKE SELECT ON MADANG.BOOK FROM MDGUEST;

--(������ MADANG) ���Ѻο�, ����ȸ��(���)
GRANT SELECT ON BOOK TO MDGUEST;
REVOKE SELECT ON BOOK FROM MDGUEST;

GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST;
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST;

--WITH GRANT OPTION : �ٸ� �������� ���� �ο��� �� �ֵ��� ���
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST WITH GRANT OPTION;

--HR�������� SELECT ���� �ο�
GRANT SELECT ON MADANG.CUSTOMER TO HR;

--(MADANG) ����ȸ��(���)
--�ο��� ���� ��� ȸ�� ó�� -MDGUEST ���� �ο��� ���� ȸ��ó��
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST;

--(������ ���� - SYSTEM) ��������
DROP USER MDGUEST CASCADE;























--=============================
/****** ���� �ο�(GRANT), ���� ���(REVOKE) **********************
GRANT ���� [ON ��ü] TO {�����|ROLE|PUBLIC,.., n} [WITH GRANT OPTION]
--PUBLIC�� ��� ����ڿ��� ������ �ǹ�

GRANT ���� TO �����; --������ ����ڿ��� �ο�
GRANT ���� ON ��ü TO �����; -��ü�� ���� ������ ����ڿ��� �ο�
-->> WITH GRANT OPTION :��ü�� ���� ������ ����ڿ��� �ο� 
-- ������ ���� ����ڰ� �ٸ� ����ڿ��� ���Ѻο��� �Ǹ� ����
GRANT ���� ON ��ü TO ����� WITH GRANT OPTION;
--------------------
-->>>���� ���(REVOKE)
REVOKE ���� [ON ��ü] FROM {�����|ROLE|PUBLIC,.., n} CASCADE
--CASCADE�� ����ڰ� �ٸ� ����ڿ��� �ο��� ���ѱ��� ��ҽ�Ŵ
  (Ȯ�� �� ���� �� �۾�)

REVOKE ���� FROM �����; --������ ����ڿ��� �ο�
REVOKE ���� ON ��ü FROM �����; -��ü�� ���� ������ ����ڿ��� �ο�
*************************************************/












