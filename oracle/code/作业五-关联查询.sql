/*
作业五 关联查询 2021/2/7
 1、求平均薪水最高的部门的部门编号
 2、求部门平均薪水的等级
 3、求部门平均的薪水等级
 4、求薪水最高的前5名雇员
 5、求薪水最高的第6到10名雇员
*/
--求平均薪水最高的部门的部门编号
--1.部门平均薪水(t1)
select e.deptno, avg(e.sal) vsal from emp e group by e.deptno;
--2.求表1中平均薪水最高的部门薪水
select max(t1.vsal)
  from (select deptno, avg(e.sal) vsal from emp e group by e.deptno) t1;
--3.求平均薪水最高的部门编号
select t1.deptno, t1.vsal
  from (select e.deptno, avg(e.sal) vsal from emp e group by e.deptno) t1
 where t1.vsal =
       (select max(t1.vsal)
          from (select deptno, avg(e.sal) vsal from emp e group by e.deptno) t1);

--求部门平均薪水的等级
--1.部门平均薪水(表1)
select e.deptno,avg(e.sal) vsal from emp e group by e.deptno;
--2.表1和salgrade表关联
select t1.deptno, sg.grade
  from salgrade sg
  join (select e.deptno, avg(e.sal) vsal from emp e group by e.deptno) t1
    on t1.vsal between sg.losal and sg.hisal;

--求部门平均的薪水等级
--1.每个人的薪水等级（t1）
select e.deptno, sg.grade
  from emp e
  join salgrade sg
    on e.sal between sg.losal and sg.hisal;
--2.把t1中的雇员分部门，求出平均等级
select t1.deptno, avg(t1.grade)
  from (select e.deptno, sg.grade
          from emp e
          join salgrade sg
            on e.sal between sg.losal and sg.hisal) t1
 group by deptno;

--限制输出，limit，mysql中用来做限制输出的，但是Oracle中不是
--在Oracle中，如果需要使用限制输出和分页的功能，必须使用rownum，
--但是rownum不能直接使用，需要嵌套使用
--求薪水最高的前5名雇员
select *
  from (select * from emp e order by e.sal desc) t1
 where rownum <= 5;

--求薪水最高的第6到10名雇员
--使用rownum的时候必须要在外层添加嵌套，此时才能将rownum作为
--其中的一个列，然后再进行限制输出。
select *
  from (select t1.*, rownum rn
          from (select * from emp e order by e.sal desc) t1
         where rownum <= 10) t
 where t.rn > 5
   and t.rn <= 10;

select *
  from (select t1.*, rownum rn
          from (select * from emp e order by e.sal desc) t1) t
 where t.rn > 5
   and t.rn <= 10;
