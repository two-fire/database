select * from emp;

--��1����ѯ20�Ų��ŵ�����Ա����Ϣ
select * from emp where deptno=20;
--��2����ѯ���й���ΪCLERK��Ա���Ĺ��š�Ա�����Ͳ�����
select empno, ename, dname
  from emp e
  join dept d
    on e.deptno = d.deptno
 where e.job = 'CLERK';
--��3����ѯ����COMM�����ڹ��ʣ�SAL����Ա����Ϣ
select * from emp e where e.comm > e.sal;
--��4����ѯ������ڹ��ʵ�20%��Ա����Ϣ
select * from emp where comm > sal * 1.2;
--��5����ѯ10�Ų����й���ΪMANAGER��20�Ų����й���ΪCLERK��Ա������Ϣ
select * from emp e where e.job='MANAGER' and e.deptno=10 or e.job='CLERK' and e.deptno=20;
--��6����ѯ���й��ֲ���MANAGER��CLERK���ҹ��ʴ��ڻ����2000��Ա������ϸ��Ϣ
select * from emp e where e.sal >= 2000 and e.job != 'MANAGER' and e.job != 'CLERK'; 
--��7����ѯ�н����Ա���Ĳ�ͬ����
select ename,job from emp where comm is not null; 
-- (8) ��ѯ����Ա�����ʺͽ���ĺ�
select sum(sal+nvl(comm,0)) from emp;
--��9����ѯû�н���򽱽����100��Ա����Ϣ
select * from emp where nvl(comm,0)<100 or comm is null;
--��10����ѯ���µ�����2����ְ��Ա����Ϣ
select * from emp where hiredate = last_day(hiredate)-1;
--��11����ѯԱ��������ڻ����10���Ա����Ϣ
select * from emp where sysdate-hiredate>=10; 
--��12����ѯԱ����Ϣ��Ҫ��������ĸ��д�ķ�ʽ��ʾ����Ա��������
select initcap(ename) from emp;
--��13����ѯԱ��������Ϊ6���ַ���Ա������Ϣ
select * from emp where length(ename)=6;
--��14����ѯԱ�������в�������ĸ��S��Ա��
select * from emp where ename not like '%S%';
--��15����ѯԱ�������ĵ�2����ĸΪ��M����Ա����Ϣ
select * from emp where ename like '_M%';
--��16����ѯ����Ա��������ǰ3���ַ�
select substr(ename,1,3) from emp;
--��17����ѯ����Ա�������������������ĸ��s�������á�S���滻
select replace(ename,'s','S') from emp;
--��18����ѯԱ������������ְ���ڣ�������ְ���ڴ��ȵ����������
select ename, hiredate from emp order by hiredate;
--��19����ʾ���е����������֡����ʺͽ��𣬰����ֽ������У���������ͬ�򰴹�����������
select ename,job,sal,comm from emp order by job desc,sal;
--��20����ʾ����Ա������������ְ����ݺ��·ݣ�����ְ�������ڵ��·��������·���ͬ����ְ���������
select ename,extract(year from hiredate) yh,extract(month from hiredate) mh from emp order by mh, yh;
select ename,to_char(hiredate,'YYYY'��year,to_char(hiredate,'MM')month from emp order by month, year;
--��21����ѯ��2�·���ְ������Ա����Ϣ
select * from emp where extract(month from hiredate) = 2;
--��22����ѯ����Ա����ְ�����Ĺ������ޣ��á�**��**��**�ա�����ʽ��ʾ
select ename,
       floor((sysdate - hiredate) / 365) || '��' ||
       floor(mod((sysdate - hiredate), 365) / 30) || '��' ||
       floor(mod(mod((sysdate - hiredate), 365),30)) || '��'
  from emp;
--��23����ѯ������һ��Ա���Ĳ�����Ϣ
select * from dept d join (select deptno from emp group by deptno having count(1)>=1) t on t.deptno=d.deptno; 
--��24����ѯ���ʱ�SMITHԱ�����ʸߵ�����Ա����Ϣ
select * from emp e where e.sal>(select sal from emp where ename='SMITH');
--��25����ѯ����Ա������������ֱ���ϼ�������
select e.ename,m.ename from emp e join emp m on e.mgr=m.empno;
--��26����ѯ��ְ����������ֱ���ϼ��쵼������Ա����Ϣ
select * from 
--��27����ѯ���в��ż���Ա����Ϣ��������Щû��Ա���Ĳ���
--��28����ѯ����Ա�����䲿����Ϣ��������Щ���������κβ��ŵ�Ա��
