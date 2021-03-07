/*
��ҵ�� 2021/2/6
1����ѯ82��Ա��
2����ѯ40�깤�����Ա
3����ʾԱ����Ӷ�� 6 ���º���һ������һ������
4����û���ϼ���Ա������mgr���ֶ���Ϣ���Ϊ "boss"
5��Ϊ�����˳����ʣ���׼�ǣ�10���ų�10%��20���ų�15%��30���ų�20%�������ų�18%
*/
select * from emp;
--��ѯ82��Ա��
select ename,hiredate from emp where extract(year from hiredate) = 1982;
--��ѯ40�깤�����Ա
select ename, hiredate
  from emp
 where trunc(months_between(sysdate,hiredate) / 12) = 40;
--��ʾԱ����Ӷ�� 6 ���º���һ������һ������
select next_day(add_months(hiredate,6),'����һ') from emp;
--��û���ϼ���Ա������mgr���ֶ���Ϣ���Ϊ "boss"
select ename, nvl(to_char(mgr), 'boss') from emp where mgr is null;
--Ϊ�����˳����ʣ���׼�ǣ�10���ų�10%��20���ų�15%��30���ų�20%�������ų�18%
--decode()
select ename,
       sal,
       decode(deptno,
              10,
              sal * 1.1,
              20,
              sal * 1.15,
              30,
              sal * 1.2,
              sal * 1.18)
  from emp;
--case when then
select ename,
       sal,
       case deptno
         when 10 then
          sal * 1.1
         when 20 then
          sal * 1.15
         when 30 then
          sal * 1.2
         else
          sal * 1.18
       end
  from emp;
