/* ********* ����(�� ROLE) ***********
����(��, ROLE) : DB ��ü �� �ý��ۿ� ���� ������ ��Ƶ� ������ �ǹ�
���� ���� : CREATE ROLE �����̸�
���� ���� : DROP ROLE �����̸�
���ҿ� ���� �ο� : GRANT ���� [ON ��ü] TO �����̸�
������ ���� ȸ�� : REVOKE ���� [ON ��ü] FROM �����̸�
����ڿ��� ���� �ο� : GRANT �����̸� TO �����

<���� �������� ����� �߰������� �ܰ�>
CREATE ROLE - ���һ���
GRANT - ������� ���ҿ� ���� �ο�
GRANT - ����ڿ��� ���� �ο�
-->>���� ������ ��� �ݴ�� ����
DROP ROLE - ���� ����(����ڿ��� �ο��� ���ҿ� ���� ���� ���� ���ŵ�)
***************************************/

--(DBA���� -SYSTEM) ����� ����
GRANT CREATE VIEW TO "MDGUEST";

--(MADANG) �ο��� �� Ȯ��
SELECT * FROM USER_ROLE_PRIVS; --CONNECT, RESOURCE
--(SYSTEM)
SELECT * FROM USER_ROLE_PRIVS; -- DBA, AQ_ADMINISTRATOR_ROLE
--(SYSTEM) CONNECT, RESOURCE �ѿ� ������ ���� Ȯ��
SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
ORDER BY GRANTEE;

--(SYSTEM) ��(ROLE) ���� : PROGRAMMER(������) ��� ���� ����
CREATE ROLE PROGRAMMER;

----(SYSTEM) PROGRAMMER �ѿ� ���Ѻο� ���̺�, �� �������� ���
GRANT CREATE ANY TABLE, CREATE ANY VIEW TO PROGRAMMER;

----(SYSTEM) MDGUEST �������� PROGRAMMER ��(����) �ο�
grant programmer to mdguest;






