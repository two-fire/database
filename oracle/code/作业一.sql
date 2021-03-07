/*
作业一 2021/2/5
1、查询部门编号为10的员工信息
2、查询年薪大于3万的人员的姓名与部门编号
3、查询佣金为null的人员姓名与工资
4、查询工资大于1500 且 and 含有佣金的人员姓名
5、查询工资大于1500 或 or含有佣金的人员姓名
6、查询姓名里面含有 S 员工信息 工资、名称
7、求姓名以J开头第二个字符O的员工姓名的与工资
8、求包含%的雇员姓名
9、使用in查询部门名称为 SALES 和 RESEARCH 的雇员姓名、工资、部门编号
10、使用exists查询部门名称为SALES和RESEARCH 的雇员姓名、工资、部门编号
*/
--查询部门编号为10的员工信息
select * from emp where emp.deptno = 20;
--查询年薪大于3万的人员的姓名与部门编号
select ename, deptno from emp e where e.sal * 12 > 30000 ;
--查询佣金为null的人员姓名与工资
select ename, sal from emp where comm is not null;
--查询工资大于1500 且 and 含有佣金的人员姓名
select ename from emp where sal>1500 and comm is not null;
--查询工资大于1500 或 or含有佣金的人员姓名
select ename from emp where sal>1500 or comm is not null;
--查询姓名里面含有 S 员工信息 工资、名称
select sal,ename from emp where ename like('%S%');
--求姓名以J开头第二个字符O的员工姓名的与工资
select ename,sal from emp where ename like('JO%');
--求包含%的雇员姓名
select ename from emp where ename like('%\%%') escape('\');
--使用in查询部门名称为 SALES 和 RESEARCH 的雇员姓名、工资、部门编号
select e.ename, e.sal, e.deptno
  from emp e
 where e.deptno in
       (select d.deptno from dept d where d.dname in ('SALES', 'RESEARCH'));
--使用exists查询部门名称为SALES和RESEARCH 的雇员姓名、工资、部门编号
select e.ename, e.sal, e.deptno
  from emp e
 where exists (select d.deptno
          from dept d
         where (d.dname = 'SALES' or d.dname = 'RESEARCH')
           and e.deptno = d.deptno);
--综合使用in和exists
select e.ename, e.sal, e.deptno
  from emp e
 where exists (select d.deptno
          from dept d
         where d.dname in ('SALES', 'RESEARCH')
           and e.deptno = d.deptno);
