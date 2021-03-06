/*
CREATE TABLE [schema.]table
(column datatype [DEFAULT expr] , …
);

*/
--设计要求：建立一张用来存储学生信息的表，表中的字段包含了学生的学号、姓名、年龄、入学日期、年级、班级、email等信息，
--并且为grade指定了默认值为1，如果在插入数据时不指定grade的值，就代表是一年级的学生

create table student
(
stu_id number(10),
name varchar2(20),
age number(3),
hiredate date,
grade varchar2(10) default 1,
classes varchar2(10),
email varchar2(50)
);
insert into student values(20191109,'zhangsan',22,to_date('2019-11-09','yyyy-mm-dd'),'2','1','123@qq.com');
insert into student(stu_id,name,age,hiredate,classes,email) values(20191109,'zhangsan',22,to_date('2019-11-09','yyyy-mm-dd'),'2','123@qq.com');
select * from student;

--正规的表结构设计需要使用第三方工具 powerdesigner
--在添加表的列的时候，不能允许设置成not null
alter  table student add address varchar(20);
alter table student drop column address;
alter table student modify(email varchar2(100));
--重新命名表
rename student to stu;
--删除表
/*
在删除表的时候，经常会遇到多个表关联的情况。多个表关联的时候，不能随意删除，需要使用级联删除。
cascade：如果A,B，A中的某个字段和B中的某一个字段做关联，那么删除A表的时候，需要将B表先删除
set null：在删除的时候，把表的关联字段设成空
*/
drop table stu;

--创建表的时候可以给表中的数据添加数据校验规则，这些规则称之为约束
/*
 Oracle 支持下面五类完整性约束:
1. NOT NULL非空： 插入数据的时候，某些列不能为空
2. UNIQUE 唯一键： 可以限定某一个列的值是唯一的，唯一键的列一般被用作索引列
3. PRIMARY KEY 主键：非空且唯一，任何一张表最好有主键，用来唯一标识一行记录
4. FOREIGN KEY 外键：当多个表之间有关联关系（一个表的某个列的值依赖于另一张表的某个值）的时候），需要使用外键
5. CHECK 自定义检查约束：可以根据用户自己的需求去限定某些列的值
*/
--执行失败，外键约束
insert into emp(empno,ename,deptno) values(9999,'hehe',50);

create table student
(
stu_id number(10) primary key,
name varchar2(20) not null,
age number(3) check(age>0 and age<126),
hiredate date,
grade varchar2(10) default 1,
classes varchar2(10),
email varchar2(50) unique,
deptno number(2),
FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);
select * from student;
--建议在创建表的时候直接将各个表的约束添加好，如果包含外键约束的话，最好把外键关联表的数据优先插入
--失败，非空约束
insert into student(stu_id,age,hiredate,classes,email) values(20191109,22,to_date('2019-11-09','yyyy-mm-dd'),'2','123@qq.com');
--失败，唯一约束
insert into student(stu_id,name,age,hiredate,classes,email) values(20191109,'zhangsan',22,to_date('2019-11-09','yyyy-mm-dd'),'2','123@qq.com');
insert into student(stu_id,name,age,hiredate,classes,email) values(20191109,'zhangsan',22,to_date('2019-11-09','yyyy-mm-dd'),'2','123@qq.com');
--失败，主键约束
insert into student(stu_id,name,age,hiredate,classes,email) values(20191109,'zhangsan',22,to_date('2019-11-09','yyyy-mm-dd'),'2','123@qq.com');
insert into student(name,age,hiredate,classes,email) values('lisi',22,to_date('2019-11-09''yyyy-mm-dd'),'2','124@qq.com');
--失败，检查约束
insert into student(stu_id,name,age,hiredate,classes,email) values(20191110,'zhangsan',144,to_date('2019-11-09','yyyy-mm-dd'),'2','124@qq.com');

--添加后，如果想删除dept表中的dept=10的那条记录，会失败。因为外键关联了.但是可以直接删除student中这条记录 
insert into student(stu_id,name,age,hiredate,classes,email,deptno) values(20191109,'zhangsan',22,to_date('2019-11-09','yyyy-mm-dd'),'2','123@qq.com',10);
--后续额外添加
alter table student add constraint fk_0001 foreign key(deptno) references dept(deptno);







