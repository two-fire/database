--��Oracle�У������Ҫ���һ���е���������������Ҫʹ������
/*
create sequence seq_name
increment by n ÿ������n
start with n ���ĸ�ֵ��ʼ����
maxvalue n|nomaxvalue 10^27 or -1 ���ֵ
minvalue n|no minvalue ��Сֵ
cycle|nocycle �Ƿ���ѭ��
cache n|nocache �Ƿ��л���
*/
create sequence my_sequence
increment by 2
start with 1;

--���ʹ�ã�
--ע�⣺�������������֮��û�о����κε�ʹ�ã���ô���ܻ�ȡ��ǰ��ֵ��������ִ��nextval���ܻ�ȡ��ǰ��ֵ
--�鿴��ǰ���е�ֵ
select my_sequence.currval from dual;
--��ȡ���е���һ��ֵ
select my_sequence.nextval from dual;

insert into emp(empno,ename) values(my_sequence.nextval,'hehe');
select * from emp;
--ɾ������
drop sequence my_sequence;
