--������ѯ
/*
select t1.c1,t2.c2 from t1,t2 where t1.c3 = t2.c4
�ڽ������ӵ�ʱ�򣬿���ʹ�õ�ֵ���ӣ�����ʹ�÷ǵ�ֵ����

*/
--��ѯ��Ա�����ƺͲ��ŵ�����
select ename,dname from emp,dept where emp.deptno = dept.deptno;
--��ѯ��Ա�����Լ��Լ���нˮ�ȼ�
select e.ename,e.sal,sg.grade from emp e,salgrade sg where e.sal between sg.losal and sg.hisal;

--��ֵ���ӣ��������а�����ͬ������
--�ǵ�ֵ���ӣ���������û����ͬ������������ĳһ��������һ�ű���еķ�Χ֮��
--������
select * from emp;
select * from dept;
--��Ҫ����Ա���е��������ݶ�������ʾ,���õ�ֵ���ӵĻ�ֻ��ѹ�������������ʾ��
--û�й����������ݲ�����ʾ����ʱ��Ҫ������
--���ࣺ�������ӣ�������ȫ��������ʾ�����������ӣ����ұ��ȫ��������ʾ��
select * from emp e,dept d where e.deptno = d.deptno��--��ֵ����
select * from emp e,dept d where e.deptno = d.deptno(+);--��������
select * from emp e,dept d where e.deptno(+) = d.deptno;--��������
--������,��һ�ű��ɲ�ͬ�ı����������Լ������Լ�
--����Ա������������Ʋ����
select e.ename,m.ename from emp e,emp m where e.mgr = m.empno;
--�ѿ�����,���������ű����ǲ�ָ������������ʱ�򣬻���еѿ�������
--��������ܼ�¼����ΪM*n��һ�㲻Ҫʹ��
select * from emp e,dept d;

--92�ı������﷨��ʲô���⣿����
--��92�﷨�У����ű�����������᷽��where�Ӿ��У�ͬʱwhere��Ҫ�Ա������������
--��ˣ��൱�ڽ��������������������ൽһ��̫���ˣ���˳�����99�﷨

/*
99�﷨
�C CROSS JOIN ��������
�C NATURAL JOIN��Ȼ����
�C USING�Ӿ�
�C ON�Ӿ�
�C LEFT OUTER JOIN
�C RIGHT OUTER JOIN
�C FULL OUTER JOIN
�C Inner outer join
�ܽ�:�����﷨��SQL���û���κ����ƣ��ٹ�˾�п�������ʹ�ã�
���ǽ���ʹ��99�﷨����Ҫʹ��92�﷨��SQL�Ե��������
*/
--cross join ��ͬ��92�﷨�еĵѿ�������������
select * from emp cross join dept;
select * from emp ,dept;
--natural join  �൱���ǵ�ֵ���ӣ�����ע�⣬����Ҫд����������������ű����ҵ���ͬ����������
--�����ű��в�������ͬ��������ʱ�򣬻���еѿ���������
--��Ȼ���Ӹ�92�﷨��������û���κι�ϵ
select * from emp e natural join dept d ;--��Ȼ���ӵĽ���������ظ�������
select * from emp e,dept d where e.deptno=d.deptno;--����
select * from emp e natural join salgrade sg;
--on�Ӿ䣬����������������������
--����������� �൱��92�﷨�еĵ�ֵ����
select * from emp e join dept d on e.deptno = d.deptno;
--�൱��92�﷨�еķǵ�ֵ���ӣ�
select * from emp e join salgrade sg on e.sal between sg.losal and sg.hisal;
--left (outer) join����������ȫ������������ʾ���ұ�û�ж�Ӧ������ֱ����ʾ�ռ���
select * from emp e left outer join dept d on e.deptno = d.deptno;
select * from emp e,dept d where e.deptno = d.deptno(+);
--right (outer) join���������ӣ������������෴��outer��ʡ��
select * from emp e right outer join dept d on e.deptno = d.deptno;
select * from emp e,dept d where e.deptno(+) = d.deptno;
--full (outer) join���൱���������Ӻ��������ӵĺϼ�
select * from emp e full outer join dept d on e.deptno=d.deptno;
--inner join�����ű�����Ӳ�ѯ��ֻ���ѯ����ƥ���¼�����ݡ�
--Ҳ����˵������Ҫ�ж�Ӧ���ܲ����
select * from emp e inner join dept d on e.deptno=d.deptno;
select * from emp e join dept d on e.deptno=d.deptno;
--using�����˿���ʹ��on��ʾ��������֮�⣬Ҳ����ʹ��using��Ϊ��������,���Ǵ�ʱ
--�����������в��ٹ���������һ�ű�
--using�Ӿ����õ�����sql�κεط�����ʹ�ñ������߱�����ǰ׺,
select * from emp e join dept d using(deptno); --deptnoֻ��ʾһ�У��������ظ�������
select * from emp e join dept d on e.deptno=d.deptno;--deptno��ʾ����
select deptno from emp e join dept d using(deptno); --û����
select e.deptno from emp e join dept d using(deptno); --����
select e.deptno from emp e join dept d on e.deptno=d.deptno��--û����

--������Ա���֡����ڵ�λ��нˮ�ȼ�����������Ϣ�����������棬����ֻ���ö������
select e.ename, d.loc, sg.grade
  from emp e
  join dept d
    on e.deptno = d.deptno
  join salgrade sg
    on e.sal between sg.losal and sg.hisal;

/*
�Ӳ�ѯ��
    Ƕ��������sql����е�����sql��䣬���Գ�֮Ϊ�Ӳ�ѯ��
  ���ࣺ
    1.�����Ӳ�ѯ
    2.�����Ӳ�ѯ
*/
--���ӵ�sql�����Բ�������
--��ѯ����Щ�˵�нˮ����������Ա��ƽ��нˮ֮�ϵģ�
--1.���������й�Ա��ƽ��нˮ
select avg(e.sal) from emp e;
--2.�������˵�нˮ��ƽ��нˮ���Ƚ�
select * from emp e where e.sal > (select avg(e.sal) from emp e);
--����Ҫ���ڹ�Ա������Щ���Ǿ����ˣ�
--1.��ѯ���о����˱��(ȥ�ز���)
select distinct e.mgr from emp e;
--2.�ڹ�Ա���й�����Щ��ż���
select * from emp e where e.empno in (select distinct e.mgr from emp e);
--�ҳ����ű��Ϊ20������Ա����������ߵ�ְԱ?
--1.�ҳ����ű��Ϊ20������Ա��������
select e.sal from emp e where e.deptno = 20;
--2.��С��1���������Ĺ�Ա���Ҳ��ű����20
select *
  from emp e
 where sal >= all (select e.sal from emp e where e.deptno = 20)
   and e.deptno = 20;
--��ÿ������ƽ��нˮ�ĵȼ�
--1.���Ƚ�ÿ�����ŵ�ƽ��нˮ�����������Ե���һ�������
select e.deptno,avg(e.sal) from emp e group by e.deptno;
--2.����ı��нˮ�ȼ��������������нˮ�ȼ�
select t.deptno, sg.grade
  from salgrade sg
  join (select e.deptno, avg(e.sal) vsal from emp e group by e.deptno) t
    on t.vsal between sg.losal and sg.hisal;








