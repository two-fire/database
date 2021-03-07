package dao.impl;

import dao.EmpDao;
import entity.Emp;
import util.DButil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author : LiuYan
 * @create 2021/2/14 11:28
 *
 * 当插入数据的时候，要注意属性类型的匹配
 * 1、Date
 * 2、String类型在拼接sql语句时必须添加单引号
 */
public class EmpDaoImpl implements EmpDao {
    @Override
    public void insert(Emp emp) {
        Connection connection = null;
        Statement statement = null;
        try {
            // 设置事务是否自动提交，true表示自动提交，false表示不是自动提交
           connection = DButil.getConnection();
           connection.setAutoCommit(true);
           statement = connection.createStatement();
           //拼接sql语句
            String sql = "insert into emp values("+emp.getEmpno()+",'"+emp.getEname()+"','"+emp.getJob()+"',"+emp.getMrg()
                    +",to_date('" +emp.getHiredate()+"','YYYY-MM-DD'),"+emp.getSal()+","+emp.getComm()+","+emp.getDeptno()+")";
            System.out.println(sql);
            // 返回值表示受影响的行数
            int i = statement.executeUpdate(sql);
            System.out.println("受影响的行数是："+i);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,statement);
        }
    }

    @Override
    public void delete(Emp emp) {
        Connection connection = null;
        Statement statement = null;
        try {
            // 设置事务是否自动提交，true表示自动提交，false表示不是自动提交
            connection = DButil.getConnection();
            connection.setAutoCommit(true);
            statement = connection.createStatement();
            //拼接sql语句
            String sql = "delete from emp where empno="+emp.getEmpno();
            System.out.println(sql);
            // 返回值表示受影响的行数
            int i = statement.executeUpdate(sql);
            System.out.println("受影响的行数是："+i);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,statement);
        }
    }

    @Override
    public void update(Emp emp) {
        Connection connection = null;
        Statement statement = null;
        try {
            // 设置事务是否自动提交，true表示自动提交，false表示不是自动提交
            connection = DButil.getConnection();
            connection.setAutoCommit(true);
            statement = connection.createStatement();
            //拼接sql语句
            String sql = "update emp set job='" + emp.getJob()+"' where empno="+emp.getEmpno();
            System.out.println(sql);
            // 返回值表示受影响的行数
            int i = statement.executeUpdate(sql);
            System.out.println("受影响的行数是："+i);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,statement);
        }
    }

    @Override
    public Emp getEmpByEmpno(Integer empno) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        Emp emp = null;
        try {
            connection = DButil.getConnection();
            statement = connection.createStatement();
            String sql = "select * from emp where empno = "+ empno;
            System.out.println(sql);
            // 返回结果
            resultSet = statement.executeQuery(sql);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while (resultSet.next()) {
                emp = new Emp(resultSet.getInt("empno"),resultSet.getString("ename"),
                        resultSet.getString("job"),resultSet.getInt("mgr"),
                        sdf.format(resultSet.getDate("hiredate")), resultSet.getDouble("sal"),
                        resultSet.getDouble("comm"),resultSet.getInt("deptno"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,statement,resultSet);
        }
        return emp;
    }
    @Override
    public Emp getEmpByEname(String ename) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        Emp emp = null;
        try {
            connection = DButil.getConnection();
            statement = connection.createStatement();
            String sql = "select * from emp where ename = "+ ename;
            System.out.println(sql);
            // 返回结果
            resultSet = statement.executeQuery(sql);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while (resultSet.next()) {
                emp = new Emp(resultSet.getInt("empno"),resultSet.getString("ename"),
                        resultSet.getString("job"),resultSet.getInt("mgr"),
                        sdf.format(resultSet.getDate("hiredate")), resultSet.getDouble("sal"),
                        resultSet.getDouble("comm"),resultSet.getInt("deptno"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,statement,resultSet);
        }
        return emp;
    }

    public static void main(String [] args) {
        EmpDao empDao = new EmpDaoImpl();
        Emp emp = new Emp(4444,"sisi","SALES",1111,"2021-2-14",1500.0,500.0,10);
//        empDao.insert(emp);
//        empDao.delete(emp);
//        empDao.update(emp);
//        Emp empByEmpno = empDao.getEmpByEmpno(7369);
//        System.out.println(empByEmpno);
        // sql注入问题
        Emp emp1 = empDao.getEmpByEname("'SMITH' or 1 = 1");
        System.out.println(emp1);
    }

}
