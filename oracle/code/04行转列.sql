--行转列 经典面试题
--1.中国移动sql面试题：
create table test(
   id number(10) primary key,
   type number(10) ,
   t_id number(10),
   value varchar2(5)
);
insert into test values(100,1,1,'张三');
insert into test values(200,2,1,'男');
insert into test values(300,3,1,'50');

insert into test values(101,1,2,'刘二');
insert into test values(201,2,2,'男');
insert into test values(301,3,2,'30');

insert into test values(102,1,3,'刘三');
insert into test values(202,2,3,'女');
insert into test values(302,3,3,'10');

select * from test;
/*
需求：将表的显示转换为

姓名      性别     年龄
--------- -------- ----
张三       男        50
*/
select decode(type, 1, value) 姓名,
       decode(type, 2, value) 性别,
       decode(type, 3, value) 年龄
  from test;
--多行合并为一行
select max(decode(type, 1, value)) 姓名,
       max(decode(type, 2, value)) 性别,
       max(decode(type, 3, value)) 年龄
  from test group by t_id;
  
  
--2.一道SQL语句面试题，关于group by
/*
表内容：
2005-05-09 胜
2005-05-09 胜
2005-05-09 负
2005-05-09 负
2005-05-10 胜
2005-05-10 负
2005-05-10 负

如果要生成下列结果, 该如何写sql语句?

          胜 负
2005-05-09 2 2
2005-05-10 1 2
*/
create table tmp(rq varchar2(10),shengfu varchar2(5));

insert into tmp values('2005-05-09','胜');
insert into tmp values('2005-05-09','胜');
insert into tmp values('2005-05-09','负');
insert into tmp values('2005-05-09','负');
insert into tmp values('2005-05-10','胜');
insert into tmp values('2005-05-10','负');
insert into tmp values('2005-05-10','负');

select * from tmp;
-- decode缺省值null可以不写，默认null
select rq,
       count(decode(shengfu, '胜', 1, null)) "胜",
       count(decode(shengfu, '负', 1, null)) "负"
  from tmp
 group by rq order by rq;


--3.
create table STUDENT_SCORE
(
  name    VARCHAR2(20),
  subject VARCHAR2(20),
  score   NUMBER(4,1)
);
insert into student_score (NAME, SUBJECT, SCORE) values ('张三', '语文', 78.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('张三', '数学', 88.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('张三', '英语', 98.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('李四', '语文', 89.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('李四', '数学', 76.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('李四', '英语', 90.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('王五', '语文', 99.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('王五', '数学', 66.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('王五', '英语', 91.0);

/*
得到类似下面的结果
姓名   语文  数学  英语

王五    89    56    89
*/
--至少使用四种方式写出
select * from student_score;

--decode
select ss.name,
       max(decode(subject, '语文', score)) 语文,
       max(decode(subject, '数学', score)) 数学,
       max(decode(subject, '英语', score)) 英语
  from student_score ss
 group by name;
 
--case when
select ss.name,
       max(case subject
             when '语文' then
              score
           end) 语文,
       max(case subject
             when '数学' then
              score
           end) 数学,
       max(case subject
             when '英语' then
              score
           end) 英语
  from student_score ss
 group by name;
 
--join
--t1.name错误
select name, t1.语文, t2.数学, t3.英语
  from (select ss.name, ss.score 语文
          from student_score ss
         where ss.subject = '语文') t1 natural
  join (select ss.name, ss.score 数学
          from student_score ss
         where ss.subject = '数学') t2 natural
  join (select ss.name, ss.score 英语
          from student_score ss
         where ss.subject = '英语') t3
--name必须指定是哪张表的 
select t1.name, t1.score 语文, t2.score 数学, t3.score 英语
  from (select ss.name, ss.score 
          from student_score ss
         where ss.subject = '语文') t1
  join (select ss.name, ss.score 
          from student_score ss
         where ss.subject = '数学') t2
    on t1.name = t2.name
  join (select ss.name, ss.score
          from student_score ss
         where ss.subject = '英语') t3
    on t1.name = t3.name

--union all 

select ss1.name, ss1.score 语文,null 数学,null 英语 from student_score ss1 where ss1.subject = '语文' union all 
select ss2.name,null 语文 ,ss2.score 数学,null 英语 from student_score ss2 where ss2.subject = '数学' union all
select ss3.name,null 数学,null 英语 , ss3.score 英语 from student_score ss3 where ss3.subject = '英语'

select name, max(语文) 语文, max(数学) 数学, max(英语) 英语
  from (select ss1.name, ss1.score 语文, null 数学, null 英语
          from student_score ss1
         where ss1.subject = '语文'
        union all
        select ss2.name, null 语文, ss2.score 数学, null 英语
          from student_score ss2
         where ss2.subject = '数学'
        union all
        select ss3.name, null 数学, null 英语, ss3.score 英语
          from student_score ss3
         where ss3.subject = '英语')
 group by name;

/* 
   大于或等于80表示优秀，大于或等于60表示及格，小于60分表示不及格。  
       显示格式：  
       语文              数学                英语  
 王五  优秀              及格               优秀    
*/
select name,
       case
         when 语文 >= 80 then
          to_char('优秀')
         when 语文 >= 60 then
          to_char('及格')
         else
          to_char('不及格')
       END 语文,
       case
         when 数学 >= 80 then
          to_char('优秀')
         when 数学 >= 60 then
          to_char('及格')
         else
          to_char('不及格')
       END 数学,
       case
         when 英语 >= 80 then
          to_char('优秀')
         when 英语 >= 60 then
          to_char('及格')
         else
          to_char('不及格')
       END 英语
  from (select ss.name,
               max(decode(subject, '语文', score)) 语文,
               max(decode(subject, '数学', score)) 数学,
               max(decode(subject, '英语', score)) 英语
          from student_score ss
         group by name);


/*
请用一个sql语句得出结果
从table1,table2中取出如table3所列格式数据，注意提供的数据及结果不准确，
只是作为一个格式向大家请教。
 

table1

月份mon 部门dep 业绩yj
-------------------------------
一月份      01      10
一月份      02      10
一月份      03      5
二月份      02      8
二月份      04      9
三月份      03      8

table2

部门dep      部门名称dname
--------------------------------
      01      国内业务一部
      02      国内业务二部
      03      国内业务三部
      04      国际业务部

table3 （result）

部门dep 一月份      二月份      三月份
--------------------------------------
      01      10                  
      02                 10       8         
      03                 5        8
      04                          9

*/
create table yj01(
       month varchar2(10),
       deptno number(10),
       yj number(10)
);

insert into yj01(month,deptno,yj) values('一月份',01,10);
insert into yj01(month,deptno,yj) values('二月份',02,10);
insert into yj01(month,deptno,yj) values('二月份',03,5);
insert into yj01(month,deptno,yj) values('三月份',02,8);
insert into yj01(month,deptno,yj) values('三月份',04,9);
insert into yj01(month,deptno,yj) values('三月份',03,8);

create table yjdept(
       deptno number(10),
       dname varchar2(20)
);

insert into yjdept(deptno,dname) values(01,'国内业务一部');
insert into yjdept(deptno,dname) values(02,'国内业务二部');
insert into yjdept(deptno,dname) values(03,'国内业务三部');
insert into yjdept(deptno,dname) values(04,'国际业务部');

--实现
select * from yj01; --table1
select * from yjdept; --table2

--这题中，table2没有用到
select t1.deptno "部门dep",
       max(decode(month, '一月份', yj)) 一月份,
       max(decode(month, '二月份', yj)) 二月份,
       max(decode(month, '三月份', yj)) 三月份
  from yj01 t1
 group by deptno
 order by deptno;












