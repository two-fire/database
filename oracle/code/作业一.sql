/*
��ҵһ 2021/2/5
1����ѯ���ű��Ϊ10��Ա����Ϣ
2����ѯ��н����3�����Ա�������벿�ű��
3����ѯӶ��Ϊnull����Ա�����빤��
4����ѯ���ʴ���1500 �� and ����Ӷ�����Ա����
5����ѯ���ʴ���1500 �� or����Ӷ�����Ա����
6����ѯ�������溬�� S Ա����Ϣ ���ʡ�����
7����������J��ͷ�ڶ����ַ�O��Ա���������빤��
8�������%�Ĺ�Ա����
9��ʹ��in��ѯ��������Ϊ SALES �� RESEARCH �Ĺ�Ա���������ʡ����ű��
10��ʹ��exists��ѯ��������ΪSALES��RESEARCH �Ĺ�Ա���������ʡ����ű��
*/
--��ѯ���ű��Ϊ10��Ա����Ϣ
select * from emp where emp.deptno = 20;
--��ѯ��н����3�����Ա�������벿�ű��
select ename, deptno from emp e where e.sal * 12 > 30000 ;
--��ѯӶ��Ϊnull����Ա�����빤��
select ename, sal from emp where comm is not null;
--��ѯ���ʴ���1500 �� and ����Ӷ�����Ա����
select ename from emp where sal>1500 and comm is not null;
--��ѯ���ʴ���1500 �� or����Ӷ�����Ա����
select ename from emp where sal>1500 or comm is not null;
--��ѯ�������溬�� S Ա����Ϣ ���ʡ�����
select sal,ename from emp where ename like('%S%');
--��������J��ͷ�ڶ����ַ�O��Ա���������빤��
select ename,sal from emp where ename like('JO%');
--�����%�Ĺ�Ա����
select ename from emp where ename like('%\%%') escape('\');
--ʹ��in��ѯ��������Ϊ SALES �� RESEARCH �Ĺ�Ա���������ʡ����ű��
select e.ename, e.sal, e.deptno
  from emp e
 where e.deptno in
       (select d.deptno from dept d where d.dname in ('SALES', 'RESEARCH'));
--ʹ��exists��ѯ��������ΪSALES��RESEARCH �Ĺ�Ա���������ʡ����ű��
select e.ename, e.sal, e.deptno
  from emp e
 where exists (select d.deptno
          from dept d
         where (d.dname = 'SALES' or d.dname = 'RESEARCH')
           and e.deptno = d.deptno);
--�ۺ�ʹ��in��exists
select e.ename, e.sal, e.deptno
  from emp e
 where exists (select d.deptno
          from dept d
         where d.dname in ('SALES', 'RESEARCH')
           and e.deptno = d.deptno);
