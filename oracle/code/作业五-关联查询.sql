/*
��ҵ�� ������ѯ 2021/2/7
 1����ƽ��нˮ��ߵĲ��ŵĲ��ű��
 2������ƽ��нˮ�ĵȼ�
 3������ƽ����нˮ�ȼ�
 4����нˮ��ߵ�ǰ5����Ա
 5����нˮ��ߵĵ�6��10����Ա
*/
--��ƽ��нˮ��ߵĲ��ŵĲ��ű��
--1.����ƽ��нˮ(t1)
select e.deptno, avg(e.sal) vsal from emp e group by e.deptno;
--2.���1��ƽ��нˮ��ߵĲ���нˮ
select max(t1.vsal)
  from (select deptno, avg(e.sal) vsal from emp e group by e.deptno) t1;
--3.��ƽ��нˮ��ߵĲ��ű��
select t1.deptno, t1.vsal
  from (select e.deptno, avg(e.sal) vsal from emp e group by e.deptno) t1
 where t1.vsal =
       (select max(t1.vsal)
          from (select deptno, avg(e.sal) vsal from emp e group by e.deptno) t1);

--����ƽ��нˮ�ĵȼ�
--1.����ƽ��нˮ(��1)
select e.deptno,avg(e.sal) vsal from emp e group by e.deptno;
--2.��1��salgrade�����
select t1.deptno, sg.grade
  from salgrade sg
  join (select e.deptno, avg(e.sal) vsal from emp e group by e.deptno) t1
    on t1.vsal between sg.losal and sg.hisal;

--����ƽ����нˮ�ȼ�
--1.ÿ���˵�нˮ�ȼ���t1��
select e.deptno, sg.grade
  from emp e
  join salgrade sg
    on e.sal between sg.losal and sg.hisal;
--2.��t1�еĹ�Ա�ֲ��ţ����ƽ���ȼ�
select t1.deptno, avg(t1.grade)
  from (select e.deptno, sg.grade
          from emp e
          join salgrade sg
            on e.sal between sg.losal and sg.hisal) t1
 group by deptno;

--���������limit��mysql����������������ģ�����Oracle�в���
--��Oracle�У������Ҫʹ����������ͷ�ҳ�Ĺ��ܣ�����ʹ��rownum��
--����rownum����ֱ��ʹ�ã���ҪǶ��ʹ��
--��нˮ��ߵ�ǰ5����Ա
select *
  from (select * from emp e order by e.sal desc) t1
 where rownum <= 5;

--��нˮ��ߵĵ�6��10����Ա
--ʹ��rownum��ʱ�����Ҫ��������Ƕ�ף���ʱ���ܽ�rownum��Ϊ
--���е�һ���У�Ȼ���ٽ������������
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
