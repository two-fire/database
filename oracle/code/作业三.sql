/*
作业三 2021/2/6
1、查询82年员工
2、查询40年工龄的人员
3、显示员工雇佣期 6 个月后下一个星期一的日期
4、找没有上级的员工，把mgr的字段信息输出为 "boss"
5、为所有人长工资，标准是：10部门长10%；20部门长15%；30部门长20%其他部门长18%
*/
select * from emp;
--查询82年员工
select ename,hiredate from emp where extract(year from hiredate) = 1982;
--查询40年工龄的人员
select ename, hiredate
  from emp
 where trunc(months_between(sysdate,hiredate) / 12) = 40;
--显示员工雇佣期 6 个月后下一个星期一的日期
select next_day(add_months(hiredate,6),'星期一') from emp;
--找没有上级的员工，把mgr的字段信息输出为 "boss"
select ename, nvl(to_char(mgr), 'boss') from emp where mgr is null;
--为所有人长工资，标准是：10部门长10%；20部门长15%；30部门长20%其他部门长18%
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
