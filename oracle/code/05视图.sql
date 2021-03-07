/*
CREATE [OR REPLACE] VIEW view
[(alias[, alias]...)]
AS subquery
[WITH READ ONLY];
*/

--�����ͨ�û���һ�δ�����ͼ����ʾû��Ȩ�ޣ�Ҫʹ�ù���Աȥ�޸�Ȩ�ޡ�
grant create view to scott;
--������ͼ
create view v_emp as select * from emp where deptno=30;
--ʹ����ͼ
select * from v_emp;
--����ͼ���������,ִ�гɹ�����Ҫ�ύ������ɫ��ʾ�ύ���񣬺�ɫ��ʾ�ع����������ݻָ�ԭ״̬
insert into v_emp(empno,ename) values(1111,'zhangsan');
--��ǰ��ѯ��ʱ��ֻ�ڵ�ǰ�Ự����Ч�����������һ���Ự��ѯ�Ļ���������鲻��
--�����õ�����cmd�е�¼sql�����в�ѯ�鲻��
select * from emp;
--����������ͼ�Ƿ�ֻ����ͼ�Ļ�������ͨ����ͼ����в������ݣ������ֻ����ͼ���򲻿��Բ�������
create view v_emp2 as select * from emp with read only;
select * from v_emp2;
--ֻ����ͼֻ�ṩ��ѯ�������޷�������ɾ�Ĳ���
insert into v_emp2(EMPNO,ename) values(1234,'lisi');--ʧ��

--ɾ����ͼ
drop view v_emp2;
--��ɾ����ͼ�����ݵ�ʱ�����������Դ�ڶ���������ʱ����ȫ������ɾ����ֻ��ɾ��һ�����е����ݡ�
--����Ҫ��ƽ��нˮ�ĵȼ���͵Ĳ��ţ����Ĳ���������ʲô��������ȫʹ���Ӳ�ѯ
--1.��ƽ��нˮ
select e.deptno,avg(sal) from emp e group by e.deptno;
--2.��ƽ��нˮ�ĵȼ�
select t.deptno, sg.grade gd
  from salgrade sg
  join (select e.deptno, avg(sal) vsal from emp e group by e.deptno) t
    on t.vsal between sg.losal and sg.hisal;
--3.��ƽ��нˮ�ĵȼ���͵Ĳ���
select min(t.gd) 
  from (select t.deptno, sg.grade gd
          from salgrade sg
          join (select e.deptno, avg(sal) vsal from emp e group by e.deptno) t
            on t.vsal between sg.losal and sg.hisal) t
    
--4.��ƽ��нˮ�ĵȼ���͵Ĳ��ŵĲ�������
select d.dname, d.deptno
  from dept d
  join (select t.deptno, sg.grade gd
          from salgrade sg
          join (select e.deptno, avg(sal) vsal from emp e group by e.deptno) t
            on t.vsal between sg.losal and sg.hisal) t
    on t.deptno = d.deptno
 where t.gd =
       (select min(t.gd)
          from (select t.deptno, sg.grade gd
                  from salgrade sg
                  join (select e.deptno, avg(sal) vsal
                         from emp e
                        group by e.deptno) t
                    on t.vsal between sg.losal and sg.hisal) t)
--�鿴sql�ܹ����֣�sql���кܶ��ظ���sql�Ӳ�ѯ������ͨ����ͼ���ظ��������������
--������ͼ
create view v_deptno_grade as select t.deptno, sg.grade gd
          from salgrade sg
          join (select e.deptno, avg(sal) vsal from emp e group by e.deptno) t
            on t.vsal between sg.losal and sg.hisal;
--ʹ����ͼ�滻
select d.dname, d.deptno
  from dept d
  join v_deptno_grade t
    on t.deptno = d.deptno
 where t.gd = (select min(t.gd) from v_deptno_grade t)










