--事务：表示操作集合，不可分割。要么全成功，要么失败
--事务开始取决于一个DML语句
/*
事务的结束：
  1、正常commit（使数据修改生效）或者rollback（将数据恢复到上一个状态）
  2、自动提交，但是一般情况下要将自动提交自动关闭，效率太低
  3、用户关闭，会话后会自动提交事务。例如退出scott时候，会将执行的语句提交
  4、系统崩溃或断电时事务自动回滚事务，将数据恢复到上一个状态
*/
--可以sql命令提交/回滚，也可以按键提交/回滚
insert into emp(empno,ename) values(1111,'zhangsan');
--commit;
--rollback;
select * from emp;

--savepoint 保存点
--当一个操作集合中包含多条sql语句，但是只想让其中某部分成功，某部分失败，此时可以使用保存点。
--此时如果需要回滚到某一个状态的话，使用rollback to 保存点名称;
--前两条sql语句成功执行提交，回退到删除1234这一条语句前，也就是这一条语句执行失败。
delete from emp where empno=1111;
delete from emp where empno=2222;
savepoint sp1;
delete from emp where empno=1234;
rollback to sp1;
commit;

/*
事务的四个特性：ACID
    原子性（Atomicity）：不可分割，一个操作集合要么全部成功，要么全部失败，不可拆分。
    一致性（Consistency）：为了保证数据的一致性，当经过n多个操作之后，数据的状态不会改变。
                转账业务最终金额总数不会变化
                从一个一致性状态到另一个一致性状态，也就是数据不可以发生错乱
    隔离性（Isolation）：各个事务之间相关不会产生影响。（隔离级别）
                 严格的隔离性会导致效率降低，在某些情况下，为了提高程序的执行效率，需要降低隔离级别。
                 隔离级别：
                      读未提交
                      读已提交
                      可重复读
                      序列化
                  数据不一致的问题：
                      脏读
                      不可重复读
                      幻读
    持久性（Durability）：所有数据的修改都必须要持久化到达存储介质中，不会因为应用程序的关闭而导致数据丢失
    四个特性中，哪个是最关键的？
        四个特性都是为了保证数据的一致性，所以一致性是最终的追求。
        事务中的一致性是通过原子性、隔离性、持久性来保证的。
    锁的机制：
    为了解决并发访问的时候，数据不一致的问题，需要给数据加锁
    加锁的同时需要考虑《粒度》的问题：
        操作的对象
            数据库
            表
            行
        一般情况下，锁的粒度越细，效率越高；粒度越粗，效率越低
        在实际工作环境中，大部分操作都是行级锁
*/
