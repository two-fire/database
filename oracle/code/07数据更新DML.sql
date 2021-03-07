--DML:数据操作语言
--增
--删
--改

--在实际项目中，使用最多的是读取操作，但是插入数据和删除数据同等重要，而修改操作相对较少
    
/*
插入操作：
  元组值的插入，最基本的插入方式 
  查询结果的插入
*/
--元组，一组里面多个值
--insert into tablename values(val1,val2,...)如果表名后没有列，那么只能将所有的列都插入
--insert into tablename(col1,col2,...) values(val1,val2,...)可以指定向哪些列中插入数据

insert into emp values(2222,'haha','clerk',7902,to_date('2019-11-2','yyyy-mm-dd'),1000,500,10);

--向部分列插入数据的时候，不是想向哪个列插入就插入的，要遵循创建表的时候定义的规范
insert into emp(empno,ename) values(3333,'wangwu');

--创建表的其他方式
--复制表同时复制表数据，不会复制约束
create table emp2 as select * from emp; --有数据
--复制表结构但是不复制表数据，不会复制约束
create table emp3 as select * from emp where 1=2;--无数据
--如果有一个集合的数据，把集合中的所有数据都挨条插入的话，效率很低。所以一般实际操作中，很少一条插入，一般批量插入。

/*
删除操作：
delete from tablename where condition

*/
--删除满足条件的数据
delete from emp2 where deptno=10;
--把整张表的数据全部清空
delete from emp2;
--truncate,跟delete不同，delete在进行删除的时候经过事务，而truncate不经过事务，一旦删除就是永久删除，不会回滚。
--效率高，但易发生误操作，不建议使用
truncate table emp2;

/*
修改操作：
    update tablename set co1 = val1, col2 = val2 where condition;
    可以修改满足条件的一个列或者是多个列
*/
--可以更新单列
update emp set ename ename='heihei' where ename='hehe';
--可以更新多列的值
update emp set job='teacher',mgr=7902 where empo=15;

/*
总结：
     增删改是数据库常用操作，在进行操作的时候都需要（事务）的保证，也就是说每次在plsql中执行sql语句之后都需要完成commit操作，所以事务变得非常关键。
     最主要的目的是：最终为了保证数据一致性。
     如果同一份数据，在同一时刻只能有一个人访问，就不会出现数据错乱的问题，但是在现在的项目中，更多的是并发访问，并发访问的同时带来的就是数据不安全，也就是不一致。
     如果要保证数据的安全，最主要的方式就是加锁的方式，MVCC
     
     事务的延伸：
       最基本的数据库事务
       声明式事务
       分布式事务
     为了提高效率，有可能多个操作会在同一个事务中执行，那么就有可能部分成功，部分失败，基于这样的情况就需要事务的控制。
     select * from emp where id=7902 for update 
     select * from emp where id=7902 lock in share mode
     
     如果不保证事务的话，会造成脏读，不可重复读，幻读。
*/



















