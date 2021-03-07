/*
作业二 2021/2/5
1、使用基本查询语句
 (1)查询DEPT表显示所有部门名称
 (2)查询EMP表显示所有雇员名及其全年收入(月收入=工资+补助)),处理NULL行,并指定列别名为"年收入"
 (3)查询显示不存在补助的雇员的所有部门号。
2、限制查询数据
 (1)查询EMP表显示工资超过2850的雇员姓名和工资。
 (2)查询EMP表显示工资不在1500～2850的所有雇员及工资。
 (3)查询EMP表显示代码为7566的雇员姓名及所在部门代码。
 (4)查询EMP表显示部门10和30中工资超过1500的雇员名及工资。
 (5)查询EMP表显示第2个字符为"A"的所有雇员名其工资。
 (6)查询EMP表显示补助非空的所有雇员名及其补助。
3、排序数据
 (1)查询EMP表显示所有雇员名、工资、雇佣日期，并以雇员名的升序进行排序。
 (2)查询EMP表显示在1981年2月1日到1981年5月1日之间雇佣的雇员名、岗位及雇佣日期，并以雇佣日期进行排序。
 (3)查询EMP表显示获得补助的所有雇员名、工资及补助，幵以工资升序和补助降序排序。
*/
--查询DEPT表显示所有部门名称
select dname from DEPT; 
--查询EMP表显示所有雇员名及其全年收入(月收入=工资+补助),处理NULL行,并指定列别名为"年收入"
select ename,(sal+nvl(0,comm))*12 年收入 from emp;
--查询显示不存在补助的雇员的所有部门号
select e.deptno from emp e where e.comm is null;
--查询EMP表显示工资超过2850的雇员姓名和工资
select ename,sal from emp where sal>2850;
--查询EMP表显示工资不在1500～2850的所有雇员及工资
select ename,sal from emp where sal not between 1500 and 2850;
--查询EMP表显示代码为7566的雇员姓名及所在部门代码
select ename,deptno from emp where empno = 7566;
--查询EMP表显示部门10和30中工资超过1500的雇员名及工资
select ename,sal from emp where deptno in (10,30) and sal>1500;
--查询EMP表显示第2个字符为"A"的所有雇员名其工资
select ename,sal from emp where ename like ('_A%');
--查询EMP表显示补助非空的所有雇员名及其补助
select ename,comm from emp where comm is not null;
--查询EMP表显示所有雇员名、工资、雇佣日期，并以雇员名的升序进行排序
select ename,sal,hiredate from emp order by ename;
--查询EMP表显示在1981年2月1日到1981年5月1日之间雇佣的雇员名、岗位及雇佣日期，并以雇佣日期进行排序
select ename, job, hiredate
  from emp
 where hiredate between to_date('1981/2/1', 'yyyy/mm/dd') and
       to_date('1981/5/1', 'yyyy/mm/dd')
 order by hiredate;
--查询EMP表显示获得补助的所有雇员名、工资及补助，并以工资升序和补助降序排序
select ename,sal,comm from emp where comm is not null order by sal,comm desc;













