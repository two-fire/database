package apacheDBUtil;

import entity.Emp;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.*;
import sun.plugin2.main.server.ResultHandler;
import util.MySQLDButil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @Author : LiuYan
 * @create 2021/2/15 15:48
 */
public class DBUtilTest {

    public static Connection connection;

    /**
     * BeanHandler 查看一条记录
     * @throws SQLException
     */
    public static void testQuery() throws SQLException {
        connection = MySQLDButil.getConnection();
        String sql = "select * from emp where empno=?";
        QueryRunner runner = new QueryRunner();
        Emp query = runner.query(connection, sql, new BeanHandler<Emp>(Emp.class), 7369);
        System.out.println(query);
        connection.close();
    }

    /**
     * BeanListHandler 查看集合
     * @throws SQLException
     */
    public static void testList() throws SQLException {
        connection = MySQLDButil.getConnection();
        String sql = "select * from emp";
        QueryRunner runner = new QueryRunner();
        List<Emp> query = runner.query(connection, sql, new BeanListHandler<Emp>(Emp.class));
        for (Emp emp : query) {
            System.out.println(emp);
        }
        connection.close();
    }

    /**
     *  ArrayHandler 查看一条记录
     *  每一行的值会组成一个数组对象放进去
     * @throws SQLException
     */
    public static void testArray() throws SQLException {
        connection = MySQLDButil.getConnection();
        String sql = "select * from emp";
        QueryRunner runner = new QueryRunner();
        Object[] query = runner.query(connection, sql, new ArrayHandler());
        for (Object o: query) {
            System.out.println(o); //查看的是第一条记录
        }
        connection.close();
    }

    /**
     * ArrayListHandler 查看集合
     * 把表中的所有记录的值一条条放到List中，而每条具体值是放到Object[]中的
     * 7369--SMITH
     * 7499--ALLEN
     * ...
     * @throws SQLException
     */
    public static void testArrayList() throws SQLException {
        connection = MySQLDButil.getConnection();
        String sql = "select * from emp";
        QueryRunner runner = new QueryRunner();
        List<Object[]> query = runner.query(connection, sql, new ArrayListHandler());
        for (Object[] o: query) {
            System.out.println(o[0] +"--"+o[1]);
        }
        connection.close();
    }

    /**
     * MapHandler 查看一条记录
     * 将一条记录中列名和对应的值作为一整个键值对元素放到Map中
     * EMPNO----7369
     * ENAME----SMITH
     * ...
     * @throws SQLException
     */
    public static void tesMap() throws SQLException {
        connection = MySQLDButil.getConnection();
        String sql = "select * from emp";
        QueryRunner runner = new QueryRunner();
        Map<String, Object> query = runner.query(connection, sql, new MapHandler());
        Set<Map.Entry<String,Object>> entries = query.entrySet();
        for (Map.Entry<String ,Object> entry : entries) {
            System.out.println(entry.getKey()+"----"+entry.getValue());
        }
        connection.close();
    }

    /**
     * MapListHandler
     * @throws SQLException
     */
    public static void tesMapList() throws SQLException {
        connection = MySQLDButil.getConnection();
        String sql = "select * from emp";
        QueryRunner runner = new QueryRunner();
        List<Map<String, Object>> query = runner.query(connection, sql, new MapListHandler());
        for (Map<String, Object> q: query) {
            Set<Map.Entry<String,Object>> entries = q.entrySet();
            for (Map.Entry<String,Object> entry : entries) {
                System.out.println(entry.getKey()+"----"+entry.getValue());
            }
            System.out.println("----------");
        }
        connection.close();
    }

    /**
     * ScalarHandler 单值查询
     * @throws SQLException
     */
    public static void tesScalar() throws SQLException {
        connection = MySQLDButil.getConnection();
        String sql = "select count(*) from emp";
        QueryRunner runner = new QueryRunner();
        Object query = runner.query(connection, sql, new ScalarHandler<>());
        System.out.println(query);
        connection.close();
    }

    /**
     * 自定义handler对象
     * @throws SQLException
     */
    public static void tesMyHandler() throws SQLException {
        connection = MySQLDButil.getConnection();
        String sql = "select * from emp where empno=?";
        QueryRunner runner = new QueryRunner();
        Emp query = runner.query(connection, sql, new ResultSetHandler<Emp>() {
            @Override
            public Emp handle(ResultSet resultSet) throws SQLException {
                Emp e = null;
                if (resultSet.next()) {
                    e = new Emp();
                    e.setEmpno(resultSet.getInt("empno"));
                    e.setEname(resultSet.getString("ename"));
                    e.setJob(resultSet.getString("job"));
                    e.setMrg(resultSet.getInt("mgr"));
                    e.setHiredate(resultSet.getString("hiredate"));
                    e.setSal(resultSet.getDouble("sal"));
                    e.setComm(resultSet.getDouble("comm"));
                    e.setDeptno(resultSet.getInt("deptno"));
                }
                return e;
            }
        },7369);
        System.out.println(query);
        connection.close();
    }

    /**
     * 插入数据
     */
    public static void insert() throws SQLException {
        String sql = "insert into emp(empno,ename) values(?,?)";
        connection = MySQLDButil.getConnection();
        QueryRunner queryRunner = new QueryRunner();
        queryRunner.update(connection,sql,1234,"msb");
        connection.close();
    }

    /**
     * 修改数据
     */
    public static void update() throws SQLException {
        String sql = "update emp set ename=? where empno=?";
        connection = MySQLDButil.getConnection();
        QueryRunner queryRunner = new QueryRunner();
        queryRunner.update(connection,sql,"msb123",1234);
        connection.close();
    }

    /**
     * 删除数据
     */
    public static void delete() throws SQLException {
        String sql = "delete from emp where empno=?";
        connection = MySQLDButil.getConnection();
        QueryRunner queryRunner = new QueryRunner();
        queryRunner.update(connection,sql,1234);
        connection.close();
    }
    public static void main(String[] args) throws SQLException {
//        testQuery();
        testList();
//        testArray();
//        testArrayList();
//        tesMap();
//        tesMapList();
//        tesScalar();
//        tesMyHandler();
//        insert();
//        update();
        delete();
    }
}
