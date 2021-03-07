--给表添加注释
comment on table emp is '雇员表';
--给列添加注释
comment on column emp.empno is '雇员工号';
/* sql语句学习

SELECT [DISTINCT] {*,column alias..}
FROM table alias
Where 条件表达式

*/

--查询雇员表中部门编号是10的员工
select empno,ename,job from emp where deptno = 10;
--distinct去重 查询雇员表中拥有的部门编号
select distinct deptno from emp;
--去重也可以针对多个字段，多个字段值只要有一个不匹配就算是不同的记录
select distinct deptno,Sal from emp;

--在查询过程中可以给列添加别名，同时也可以给表添加别名
select e.empno 雇员编号，e.ename 雇员名称, e.job 雇员工作 from emp e where e.deptno = 10;
--给列起别名可以加as也可以不加
select e.empno as 雇员编号，e.ename as 雇员名称, e.job as 雇员工作 from emp e where e.deptno = 10;
--给列起别名，如果别名中包含空格，那么要将别名整体用“”包含起来
select e.empno "雇员 编号"，e.ename "雇员 名称", e.job "雇员 工作" from emp e where e.deptno = 10;
--查询表中所有字段,可以使用*，但是在项目中千万不要随便使用*！
select * from emp;

/*
▪ 条件比较
– ＝，！＝,<>，<,>,<=,>=,any,some,all
– is null,is not null
– between x and y
– in（list），not in（list）
– exists（sub－query）
– like _ ,%,escape ‘\‘ _\% escape ‘\’
*/
-- =
select * from emp where deptno = 20;
-- !=
select * from emp where deptno != 20;
-- <> 不等于
select * from emp where deptno <> 20;
-- <,
select sal from emp where sal < 1500;
-- >,
select sal from emp where sal > 1500;
-- <=,
select sal from emp where sal <= 1500;
-- >=,
select sal from emp where sal >= 1500;
--any,取其中任意一个
select sal from emp where sal > any(1000,1500,3000);
--some,跟any效果一样
select sal from emp where sal > some(1000,1500,3000);
--all,所有的值满足才会成立
select sal from emp where sal > all(1000,1500,3000);
--is null,在sql语句中，null表示一个特殊含义，null != null，必须使用is null或者is not null 判断
select * from emp where comm = null; --运行结果为空
select * from emp where comm is null;
--is not null
select * from emp where comm is not null;
select * from emp where null = null; --运行结果为空
select * from emp where null is null; --可以显示emp所有值
--between x and y, [x,y]
select * from emp where sal between 1500 and 3000;
select * from emp where sal >= 1500 and sal <=3000 --等价
--需要进行某些值的等值判断的时候，可以使用in和not in
--in(list),
select * from emp where deptno in(10,20);
--可以使用and 和 or这样的关键字，and相当于与，or相当于或操作
--一个语句中，要注意优先级。and的优先级高于or，所以一定要将or的相关操作用括号括起来
select * from emp where deptno = 10 or deptno = 20; --等价
--not in(list)
select * from emp where deptno not in(10,20);
select * from emp where deptno != 10 and deptno != 20;--等价
/*exists(sub-query),当exists中的子查询语句能查到对应结果的时候，
意味着条件满足，相当于双重for循环。
现在要查询部门编号为10和20的员工，要求使用exists实现
*/
--正确
select * from emp where deptno = 10 or deptno = 20;
--错误,会查到所有的结果.因为子查询不管怎么查都会出现10和20这两个值
--既然能查到结果，意味着条件满足，所以每一条记录都会被查出结果。
select *
  from emp
 where exists (select deptno
          from dept
         where deptno = 10
            or deptno = 20);
--通过外层循环来规范内层循环
--错误,依旧查出全部结果。因为and优先级高
select *
  from emp e
 where exists (select deptno d
          from dept d
         where d.deptno = 10
            or d.deptno = 20
           and e.deptno = d.deptno);
--正确
select *
  from emp e
 where exists (select deptno d
          from dept d
         where (d.deptno = 10 or d.deptno = 20)
           and e.deptno = d.deptno);
/*
模糊查询
like _ ,%,escape '\' _\% escape '\'

在like语句中，需要使用占位符或者通配符
_，某个字符或者数字只出现一次
%，任意字符出现任意次数
escape，使用转义字符，可以自己规定转义字符

使用like的时候要慎重，因为like的效率比较低
使用like可以参考使用索引，但是要求不能以%开头
涉及到大文本的检索的时候，可以使用某些框架 luence，solr，elastic search
*/
--查询名字以S开头的用户
select * from emp where ename like('S%');
--查询名字以S开头且倒数第二个字符为T的用户
select * from emp where ename like ('S%T_');
--查询名字中带%的人的用户
select * from emp where ename like ('%a%%') escape('a');

/*
order by进行排序操作
默认升序操作
asc：默认的排序方式，升序
desc：降序
按照自然顺序进行排序的。数值从大到小；字符串按照字典序（ASCII码）
A~Z在a~z前

在进行排序的时候，可以指定多个字段，而且多个字段可以采用不同的排序方式
每次在执行order by的时候，相当于是做了全排序，思考全排序的效率。
所以这些耗费内存的操作最好放到业务不太繁忙的时候进行，使用的时候一定要慎重。
*/
select * from emp order by sal;
select * from emp order by sal desc; 
select * from emp order by ename;
select * from emp order by sal desc, ename asc;
/*  使用字符字段*/
--字符串连接符
select 'my name is '||ename||'!' from emp;
select concat('my name is ',ename) from emp;
-- 计算所有员工的年薪
select ename,(e.sal+e.comm)*12 from emp e;
--null是比较特殊的存在，null做任何运算都还是为空，因此要将空做转换
--引入函数nvl，nvl(arg1,arg2)，如果arg1是空，那么返回arg2；如果不为空，则返回原来的值
select ename,(e.sal+nvl(e.comm,0))*12 from emp e;
--dual是oracle数据库中的一张虚拟表，没有实际的数据，可以拿来做测试
select 100+null from dual; -- 结果为空

--A  6条
select * from emp where deptno = 30;
--B  12条
select * from emp where sal > 1000;
--并集，将2个集合中所有数据都进行显示，但是不包含重复的数据
select * from emp where deptno = 30 union
select * from emp where sal > 1000; -- 13条
--全集，将2个集合的数据全显示，不去重
select * from emp where deptno = 30 union all
select * from emp where sal > 1000; -- 18条
--交集，两个集合中重复的数据集，只显示一次
select * from emp where deptno = 30 intersect
select * from emp where sal > 1000; -- 5条
--差集，包含在A集合而不包含在B集合中的数据，跟A,B顺序相关
select * from emp where deptno = 30 minus
select * from emp where sal > 1000;  -- 1条





















