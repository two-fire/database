--��ת�� ����������
--1.�й��ƶ�sql�����⣺
create table test(
   id number(10) primary key,
   type number(10) ,
   t_id number(10),
   value varchar2(5)
);
insert into test values(100,1,1,'����');
insert into test values(200,2,1,'��');
insert into test values(300,3,1,'50');

insert into test values(101,1,2,'����');
insert into test values(201,2,2,'��');
insert into test values(301,3,2,'30');

insert into test values(102,1,3,'����');
insert into test values(202,2,3,'Ů');
insert into test values(302,3,3,'10');

select * from test;
/*
���󣺽������ʾת��Ϊ

����      �Ա�     ����
--------- -------- ----
����       ��        50
*/
select decode(type, 1, value) ����,
       decode(type, 2, value) �Ա�,
       decode(type, 3, value) ����
  from test;
--���кϲ�Ϊһ��
select max(decode(type, 1, value)) ����,
       max(decode(type, 2, value)) �Ա�,
       max(decode(type, 3, value)) ����
  from test group by t_id;
  
  
--2.һ��SQL��������⣬����group by
/*
�����ݣ�
2005-05-09 ʤ
2005-05-09 ʤ
2005-05-09 ��
2005-05-09 ��
2005-05-10 ʤ
2005-05-10 ��
2005-05-10 ��

���Ҫ�������н��, �����дsql���?

          ʤ ��
2005-05-09 2 2
2005-05-10 1 2
*/
create table tmp(rq varchar2(10),shengfu varchar2(5));

insert into tmp values('2005-05-09','ʤ');
insert into tmp values('2005-05-09','ʤ');
insert into tmp values('2005-05-09','��');
insert into tmp values('2005-05-09','��');
insert into tmp values('2005-05-10','ʤ');
insert into tmp values('2005-05-10','��');
insert into tmp values('2005-05-10','��');

select * from tmp;
-- decodeȱʡֵnull���Բ�д��Ĭ��null
select rq,
       count(decode(shengfu, 'ʤ', 1, null)) "ʤ",
       count(decode(shengfu, '��', 1, null)) "��"
  from tmp
 group by rq order by rq;


--3.
create table STUDENT_SCORE
(
  name    VARCHAR2(20),
  subject VARCHAR2(20),
  score   NUMBER(4,1)
);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', '����', 78.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', '��ѧ', 88.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', 'Ӣ��', 98.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', '����', 89.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', '��ѧ', 76.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', 'Ӣ��', 90.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', '����', 99.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', '��ѧ', 66.0);
insert into student_score (NAME, SUBJECT, SCORE) values ('����', 'Ӣ��', 91.0);

/*
�õ���������Ľ��
����   ����  ��ѧ  Ӣ��

����    89    56    89
*/
--����ʹ�����ַ�ʽд��
select * from student_score;

--decode
select ss.name,
       max(decode(subject, '����', score)) ����,
       max(decode(subject, '��ѧ', score)) ��ѧ,
       max(decode(subject, 'Ӣ��', score)) Ӣ��
  from student_score ss
 group by name;
 
--case when
select ss.name,
       max(case subject
             when '����' then
              score
           end) ����,
       max(case subject
             when '��ѧ' then
              score
           end) ��ѧ,
       max(case subject
             when 'Ӣ��' then
              score
           end) Ӣ��
  from student_score ss
 group by name;
 
--join
--t1.name����
select name, t1.����, t2.��ѧ, t3.Ӣ��
  from (select ss.name, ss.score ����
          from student_score ss
         where ss.subject = '����') t1 natural
  join (select ss.name, ss.score ��ѧ
          from student_score ss
         where ss.subject = '��ѧ') t2 natural
  join (select ss.name, ss.score Ӣ��
          from student_score ss
         where ss.subject = 'Ӣ��') t3
--name����ָ�������ű�� 
select t1.name, t1.score ����, t2.score ��ѧ, t3.score Ӣ��
  from (select ss.name, ss.score 
          from student_score ss
         where ss.subject = '����') t1
  join (select ss.name, ss.score 
          from student_score ss
         where ss.subject = '��ѧ') t2
    on t1.name = t2.name
  join (select ss.name, ss.score
          from student_score ss
         where ss.subject = 'Ӣ��') t3
    on t1.name = t3.name

--union all 

select ss1.name, ss1.score ����,null ��ѧ,null Ӣ�� from student_score ss1 where ss1.subject = '����' union all 
select ss2.name,null ���� ,ss2.score ��ѧ,null Ӣ�� from student_score ss2 where ss2.subject = '��ѧ' union all
select ss3.name,null ��ѧ,null Ӣ�� , ss3.score Ӣ�� from student_score ss3 where ss3.subject = 'Ӣ��'

select name, max(����) ����, max(��ѧ) ��ѧ, max(Ӣ��) Ӣ��
  from (select ss1.name, ss1.score ����, null ��ѧ, null Ӣ��
          from student_score ss1
         where ss1.subject = '����'
        union all
        select ss2.name, null ����, ss2.score ��ѧ, null Ӣ��
          from student_score ss2
         where ss2.subject = '��ѧ'
        union all
        select ss3.name, null ��ѧ, null Ӣ��, ss3.score Ӣ��
          from student_score ss3
         where ss3.subject = 'Ӣ��')
 group by name;

/* 
   ���ڻ����80��ʾ���㣬���ڻ����60��ʾ����С��60�ֱ�ʾ������  
       ��ʾ��ʽ��  
       ����              ��ѧ                Ӣ��  
 ����  ����              ����               ����    
*/
select name,
       case
         when ���� >= 80 then
          to_char('����')
         when ���� >= 60 then
          to_char('����')
         else
          to_char('������')
       END ����,
       case
         when ��ѧ >= 80 then
          to_char('����')
         when ��ѧ >= 60 then
          to_char('����')
         else
          to_char('������')
       END ��ѧ,
       case
         when Ӣ�� >= 80 then
          to_char('����')
         when Ӣ�� >= 60 then
          to_char('����')
         else
          to_char('������')
       END Ӣ��
  from (select ss.name,
               max(decode(subject, '����', score)) ����,
               max(decode(subject, '��ѧ', score)) ��ѧ,
               max(decode(subject, 'Ӣ��', score)) Ӣ��
          from student_score ss
         group by name);


/*
����һ��sql���ó����
��table1,table2��ȡ����table3���и�ʽ���ݣ�ע���ṩ�����ݼ������׼ȷ��
ֻ����Ϊһ����ʽ������̡�
 

table1

�·�mon ����dep ҵ��yj
-------------------------------
һ�·�      01      10
һ�·�      02      10
һ�·�      03      5
���·�      02      8
���·�      04      9
���·�      03      8

table2

����dep      ��������dname
--------------------------------
      01      ����ҵ��һ��
      02      ����ҵ�����
      03      ����ҵ������
      04      ����ҵ��

table3 ��result��

����dep һ�·�      ���·�      ���·�
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

insert into yj01(month,deptno,yj) values('һ�·�',01,10);
insert into yj01(month,deptno,yj) values('���·�',02,10);
insert into yj01(month,deptno,yj) values('���·�',03,5);
insert into yj01(month,deptno,yj) values('���·�',02,8);
insert into yj01(month,deptno,yj) values('���·�',04,9);
insert into yj01(month,deptno,yj) values('���·�',03,8);

create table yjdept(
       deptno number(10),
       dname varchar2(20)
);

insert into yjdept(deptno,dname) values(01,'����ҵ��һ��');
insert into yjdept(deptno,dname) values(02,'����ҵ�����');
insert into yjdept(deptno,dname) values(03,'����ҵ������');
insert into yjdept(deptno,dname) values(04,'����ҵ��');

--ʵ��
select * from yj01; --table1
select * from yjdept; --table2

--�����У�table2û���õ�
select t1.deptno "����dep",
       max(decode(month, 'һ�·�', yj)) һ�·�,
       max(decode(month, '���·�', yj)) ���·�,
       max(decode(month, '���·�', yj)) ���·�
  from yj01 t1
 group by deptno
 order by deptno;












