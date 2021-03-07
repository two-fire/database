--关联查询
/*
select t1.c1,t2.c2 from t1,t2 where t1.c3 = t2.c4
在进行连接的时候，可以使用等值连接，可以使用非等值连接

*/
--查询雇员的名称和部门的名称
select ename,dname from emp,dept where emp.deptno = dept.deptno;
--查询雇员名称以及自己的薪水等级
select e.ename,e.sal,sg.grade from emp e,salgrade sg where e.sal between sg.losal and sg.hisal;

--等值连接，两个表中包含相同的列名
--非等值连接，两个表中没有相同的列名，但是某一个列在另一张表的列的范围之中
--外连接
select * from emp;
select * from dept;
--需要将雇员表中的所有数据都进行显示,利用等值连接的话只会把关联到的数据显示，
--没有关联到的数据不会显示，此时需要外连接
--分类：左外连接（把左表的全部数据显示）和右外连接（把右表的全部数据显示）
select * from emp e,dept d where e.deptno = d.deptno；--等值连接
select * from emp e,dept d where e.deptno = d.deptno(+);--左外连接
select * from emp e,dept d where e.deptno(+) = d.deptno;--右外连接
--自连接,将一张表当成不同的表来看待，自己关联自己
--将雇员和他经理的名称查出来
select e.ename,m.ename from emp e,emp m where e.mgr = m.empno;
--笛卡尔积,当关联多张表，但是不指定连接条件的时候，会进行笛卡尔积，
--关联后的总记录条数为M*n，一般不要使用
select * from emp e,dept d;

--92的表连接语法有什么问题？？？
--在92语法中，多张表的连接条件会方法where子句中，同时where需要对表进行条件过滤
--因此，相当于将过滤条件和连接条件揉到一起，太乱了，因此出现了99语法

/*
99语法
– CROSS JOIN 交叉连接
– NATURAL JOIN自然连接
– USING子句
– ON子句
– LEFT OUTER JOIN
– RIGHT OUTER JOIN
– FULL OUTER JOIN
– Inner outer join
总结:两种语法的SQL语句没有任何限制，再公司中可以随意使用，
但是建议使用99语法，不要使用92语法，SQL显得清楚明了
*/
--cross join 等同于92语法中的笛卡尔积。少用它
select * from emp cross join dept;
select * from emp ,dept;
--natural join  相当于是等值连接，但是注意，不需要写连接条件，会从两张表中找到相同的列做连接
--当两张表中不具有相同的列名的时候，会进行笛卡儿积操作
--自然连接跟92语法的自连接没有任何关系
select * from emp e natural join dept d ;--自然连接的结果不保留重复的属性
select * from emp e,dept d where e.deptno=d.deptno;--保留
select * from emp e natural join salgrade sg;
--on子句，可以添加任意的连接条件，
--添加连接条件 相当于92语法中的等值连接
select * from emp e join dept d on e.deptno = d.deptno;
--相当于92语法中的非等值连接，
select * from emp e join salgrade sg on e.sal between sg.losal and sg.hisal;
--left (outer) join，会把左表中全部数据正常显示，右表没有对应的数据直接显示空即可
select * from emp e left outer join dept d on e.deptno = d.deptno;
select * from emp e,dept d where e.deptno = d.deptno(+);
--right (outer) join，右外连接，和左外连接相反。outer可省略
select * from emp e right outer join dept d on e.deptno = d.deptno;
select * from emp e,dept d where e.deptno(+) = d.deptno;
--full (outer) join，相当于左外连接和右外连接的合集
select * from emp e full outer join dept d on e.deptno=d.deptno;
--inner join，两张表的连接查询，只会查询出有匹配记录的数据。
--也就是说，必须要有对应才能查出来
select * from emp e inner join dept d on e.deptno=d.deptno;
select * from emp e join dept d on e.deptno=d.deptno;
--using，除了可以使用on表示连接条件之外，也可以使用using作为连接条件,但是此时
--连接条件的列不再归属于任意一张表。
--using子句引用的列在sql任何地方不能使用表名或者别名做前缀,
select * from emp e join dept d using(deptno); --deptno只显示一列，不保留重复的属性
select * from emp e join dept d on e.deptno=d.deptno;--deptno显示两列
select deptno from emp e join dept d using(deptno); --没问题
select e.deptno from emp e join dept d using(deptno); --报错
select e.deptno from emp e join dept d on e.deptno=d.deptno；--没问题

--检索雇员名字、所在单位、薪水等级：这三个信息在三个表里面，所以只能用多表联结
select e.ename, d.loc, sg.grade
  from emp e
  join dept d
    on e.deptno = d.deptno
  join salgrade sg
    on e.sal between sg.losal and sg.hisal;

/*
子查询：
    嵌套在其他sql语句中的完整sql语句，可以称之为子查询。
  分类：
    1.单行子查询
    2.多行子查询
*/
--复杂的sql语句可以拆开来做。
--查询有哪些人的薪水是在整个雇员的平均薪水之上的？
--1.首先求所有雇员的平均薪水
select avg(e.sal) from emp e;
--2.把所有人的薪水与平均薪水做比较
select * from emp e where e.sal > (select avg(e.sal) from emp e);
--我们要查在雇员中有哪些人是经理人？
--1.查询所有经理人编号(去重操作)
select distinct e.mgr from emp e;
--2.在雇员表中过滤这些编号即可
select * from emp e where e.empno in (select distinct e.mgr from emp e);
--找出部门编号为20的所有员工中收入最高的职员?
--1.找出部门编号为20的所有员工的收入
select e.sal from emp e where e.deptno = 20;
--2.求不小于1中求出收入的雇员，且部门编号是20
select *
  from emp e
 where sal >= all (select e.sal from emp e where e.deptno = 20)
   and e.deptno = 20;
--求每个部门平均薪水的等级
--1.首先将每个部门的平均薪水求出来结果可以当成一张虚拟表
select e.deptno,avg(e.sal) from emp e group by e.deptno;
--2.上面的表跟薪水等级表做关联，求得薪水等级
select t.deptno, sg.grade
  from salgrade sg
  join (select e.deptno, avg(e.sal) vsal from emp e group by e.deptno) t
    on t.vsal between sg.losal and sg.hisal;








