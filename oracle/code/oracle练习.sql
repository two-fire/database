select * from emp;

--（1）查询20号部门的所有员工信息
select * from emp where deptno=20;
--（2）查询所有工种为CLERK的员工的工号、员工名和部门名
select empno, ename, dname
  from emp e
  join dept d
    on e.deptno = d.deptno
 where e.job = 'CLERK';
--（3）查询奖金（COMM）高于工资（SAL）的员工信息
select * from emp e where e.comm > e.sal;
--（4）查询奖金高于工资的20%的员工信息
select * from emp where comm > sal * 1.2;
--（5）查询10号部门中工种为MANAGER和20号部门中工种为CLERK的员工的信息
select * from emp e where e.job='MANAGER' and e.deptno=10 or e.job='CLERK' and e.deptno=20;
--（6）查询所有工种不是MANAGER和CLERK，且工资大于或等于2000的员工的详细信息
select * from emp e where e.sal >= 2000 and e.job != 'MANAGER' and e.job != 'CLERK'; 
--（7）查询有奖金的员工的不同工种
select ename,job from emp where comm is not null; 
-- (8) 查询所有员工工资和奖金的和
select sum(sal+nvl(comm,0)) from emp;
--（9）查询没有奖金或奖金低于100的员工信息
select * from emp where nvl(comm,0)<100 or comm is null;
--（10）查询各月倒数第2天入职的员工信息
select * from emp where hiredate = last_day(hiredate)-1;
--（11）查询员工工龄大于或等于10年的员工信息
select * from emp where sysdate-hiredate>=10; 
--（12）查询员工信息，要求以首字母大写的方式显示所有员工的姓名
select initcap(ename) from emp;
--（13）查询员工名正好为6个字符的员工的信息
select * from emp where length(ename)=6;
--（14）查询员工名字中不包含字母“S”员工
select * from emp where ename not like '%S%';
--（15）查询员工姓名的第2个字母为“M”的员工信息
select * from emp where ename like '_M%';
--（16）查询所有员工姓名的前3个字符
select substr(ename,1,3) from emp;
--（17）查询所有员工的姓名，如果包含字母“s”，则用“S”替换
select replace(ename,'s','S') from emp;
--（18）查询员工的姓名和入职日期，并按入职日期从先到后进行排列
select ename, hiredate from emp order by hiredate;
--（19）显示所有的姓名、工种、工资和奖金，按工种降序排列，若工种相同则按工资升序排列
select ename,job,sal,comm from emp order by job desc,sal;
--（20）显示所有员工的姓名、入职的年份和月份，若入职日期所在的月份排序，若月份相同则按入职的年份排序
select ename,extract(year from hiredate) yh,extract(month from hiredate) mh from emp order by mh, yh;
select ename,to_char(hiredate,'YYYY'）year,to_char(hiredate,'MM')month from emp order by month, year;
--（21）查询在2月份入职的所有员工信息
select * from emp where extract(month from hiredate) = 2;
--（22）查询所有员工入职以来的工作期限，用“**年**月**日”的形式表示
select ename,
       floor((sysdate - hiredate) / 365) || '年' ||
       floor(mod((sysdate - hiredate), 365) / 30) || '月' ||
       floor(mod(mod((sysdate - hiredate), 365),30)) || '日'
  from emp;
--（23）查询至少有一个员工的部门信息
select * from dept d join (select deptno from emp group by deptno having count(1)>=1) t on t.deptno=d.deptno; 
--（24）查询工资比SMITH员工工资高的所有员工信息
select * from emp e where e.sal>(select sal from emp where ename='SMITH');
--（25）查询所有员工的姓名及其直接上级的姓名
select e.ename,m.ename from emp e join emp m on e.mgr=m.empno;
--（26）查询入职日期早于其直接上级领导的所有员工信息
select * from 
--（27）查询所有部门及其员工信息，包括那些没有员工的部门
--（28）查询所有员工及其部门信息，包括那些还不属于任何部门的员工
