/*
作业四 2021/2/6
1、查询10号部门中编号最新入职的员工，工龄最长的员工的个人信息。
2、从software‛找到‘f’的位置，用‘*’左或右填充到15位，去除其中的‘a’
3、查询员工的奖金，如果奖金不为NULL显示‘有奖金’，为null则显示无奖金
4、写一个查询显示当前日期，列标题显示为Date。再显示六个月后的日期，下一个星期日的日期，该
月最后一天的日期。
5、查询EMP表按管理者编号升序排列，如果管理者编号为空则把为空的在最前显示
6、求部门平均薪水
7、按部门求出工资大于1300人员的部门编号、平均工资、最小佣金、最大佣金,且最大佣金大于100
8、找出每个部门的平均、最小、最大薪水
9、查询出雇员名，雇员所在部门名称，工资等级
*/
--查询10号部门中编号最新入职的员工，工龄最长的员工的个人信息
select *
  from emp
 where deptno = 10
   and (empno in (select max(empno) from emp where deptno = 10) or
       hiredate in (select min(hiredate) from emp where deptno = 10));
--从software‛找到‘f’的位置，用‘*’左填充到15位
select lpad(substr('software',1,instr('software','f')),15,'*') from dual;
--查询员工的奖金，如果奖金不为NULL显示‘有奖金’，为null则显示无奖金
select ename,
       decode(nvl(to_char(comm), '无奖金'),
              to_char(comm),
              '有奖金',
              '无奖金')
  from emp;
--写一个查询显示当前日期，列标题显示为Date。再显示六个月后的日期，下一个星期日的日期，该月最后一天的日期
select sysdate "Date",
       add_months(sysdate, 6),
       next_day(sysdate, '星期日'),
       last_day(sysdate)
  from dual;      
--查询EMP表按管理者编号升序排列，如果管理者编号为空则把为空的在最前显示
select * from emp order by mgr nulls first;
--求部门平均薪水
select avg(sal) from emp group by deptno;
--按部门求出工资大于1300人员的 部门编号、平均工资、最小佣金、最大佣金,且最大佣金大于100
select deptno, avg(nvl(sal, 0)), min(comm), max(comm)
  from emp
 where sal > 1300
 group by deptno
having max(nvl(comm, 0)) > 100;
--找出每个部门的平均、最小、最大薪水
select avg(nvl(sal,0)),min(sal),max(sal) from emp group by deptno;
--查询出雇员名，雇员所在部门名称，工资等级
select e.ename, d.dname, s.grade
  from emp e, dept d, salgrade s
 where e.deptno = d.deptno
   and e.sal between s.losal and s.hisal;




















