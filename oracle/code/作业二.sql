/*
��ҵ�� 2021/2/5
1��ʹ�û�����ѯ���
 (1)��ѯDEPT����ʾ���в�������
 (2)��ѯEMP����ʾ���й�Ա������ȫ������(������=����+����)),����NULL��,��ָ���б���Ϊ"������"
 (3)��ѯ��ʾ�����ڲ����Ĺ�Ա�����в��źš�
2�����Ʋ�ѯ����
 (1)��ѯEMP����ʾ���ʳ���2850�Ĺ�Ա�����͹��ʡ�
 (2)��ѯEMP����ʾ���ʲ���1500��2850�����й�Ա�����ʡ�
 (3)��ѯEMP����ʾ����Ϊ7566�Ĺ�Ա���������ڲ��Ŵ��롣
 (4)��ѯEMP����ʾ����10��30�й��ʳ���1500�Ĺ�Ա�������ʡ�
 (5)��ѯEMP����ʾ��2���ַ�Ϊ"A"�����й�Ա���乤�ʡ�
 (6)��ѯEMP����ʾ�����ǿյ����й�Ա�����䲹����
3����������
 (1)��ѯEMP����ʾ���й�Ա�������ʡ���Ӷ���ڣ����Թ�Ա���������������
 (2)��ѯEMP����ʾ��1981��2��1�յ�1981��5��1��֮���Ӷ�Ĺ�Ա������λ����Ӷ���ڣ����Թ�Ӷ���ڽ�������
 (3)��ѯEMP����ʾ��ò��������й�Ա�������ʼ����������Թ�������Ͳ�����������
*/
--��ѯDEPT����ʾ���в�������
select dname from DEPT; 
--��ѯEMP����ʾ���й�Ա������ȫ������(������=����+����),����NULL��,��ָ���б���Ϊ"������"
select ename,(sal+nvl(0,comm))*12 ������ from emp;
--��ѯ��ʾ�����ڲ����Ĺ�Ա�����в��ź�
select e.deptno from emp e where e.comm is null;
--��ѯEMP����ʾ���ʳ���2850�Ĺ�Ա�����͹���
select ename,sal from emp where sal>2850;
--��ѯEMP����ʾ���ʲ���1500��2850�����й�Ա������
select ename,sal from emp where sal not between 1500 and 2850;
--��ѯEMP����ʾ����Ϊ7566�Ĺ�Ա���������ڲ��Ŵ���
select ename,deptno from emp where empno = 7566;
--��ѯEMP����ʾ����10��30�й��ʳ���1500�Ĺ�Ա��������
select ename,sal from emp where deptno in (10,30) and sal>1500;
--��ѯEMP����ʾ��2���ַ�Ϊ"A"�����й�Ա���乤��
select ename,sal from emp where ename like ('_A%');
--��ѯEMP����ʾ�����ǿյ����й�Ա�����䲹��
select ename,comm from emp where comm is not null;
--��ѯEMP����ʾ���й�Ա�������ʡ���Ӷ���ڣ����Թ�Ա���������������
select ename,sal,hiredate from emp order by ename;
--��ѯEMP����ʾ��1981��2��1�յ�1981��5��1��֮���Ӷ�Ĺ�Ա������λ����Ӷ���ڣ����Թ�Ӷ���ڽ�������
select ename, job, hiredate
  from emp
 where hiredate between to_date('1981/2/1', 'yyyy/mm/dd') and
       to_date('1981/5/1', 'yyyy/mm/dd')
 order by hiredate;
--��ѯEMP����ʾ��ò��������й�Ա�������ʼ����������Թ�������Ͳ�����������
select ename,sal,comm from emp where comm is not null order by sal,comm desc;













