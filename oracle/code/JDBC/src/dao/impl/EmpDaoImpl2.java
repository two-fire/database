package dao.impl;

import dao.EmpDao;
import entity.Emp;
import util.DButil;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * @Author : LiuYan
 * @create 2021/2/14 11:28
 *
 * 防止sql注入问题
 */
public class EmpDaoImpl2 implements EmpDao {
    @Override
    public void insert(Emp emp) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            // 设置事务是否自动提交，true表示自动提交，false表示不是自动提交
           connection = DButil.getConnection();
           connection.setAutoCommit(true);
           //拼接sql语句
            String sql = "insert into emp values(?,?,?,?,?,?,?,?)";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1,emp.getEmpno());
            pstmt.setString(2,emp.getEname());
            pstmt.setString(3,emp.getJob());
            pstmt.setInt(4,emp.getMrg());
            // parse后是util里面的Date -> 时间 -> sql里面的Date
            pstmt.setDate(5,
                    new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(emp.getHiredate()).getTime()));
            pstmt.setDouble(6,emp.getSal());
            pstmt.setDouble(7,emp.getComm());
            pstmt.setInt(8,emp.getDeptno());

            System.out.println(sql);
            // 返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数是："+i);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        } finally {
            DButil.closeConnection(connection,pstmt);
        }
    }

    @Override
    public void delete(Emp emp) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            // 设置事务是否自动提交，true表示自动提交，false表示不是自动提交
            connection = DButil.getConnection();
            connection.setAutoCommit(true);
            //拼接sql语句
            String sql = "delete from emp where empno = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1,emp.getEmpno());
            System.out.println(sql);
            // 返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数是："+i);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,pstmt);
        }
    }

    @Override
    public void update(Emp emp) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        try {
            // 设置事务是否自动提交，true表示自动提交，false表示不是自动提交
            connection = DButil.getConnection();
            connection.setAutoCommit(true);
            //拼接sql语句
            String sql = "update emp set job = ? where empno= ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1,emp.getJob());
            pstmt.setInt(2,emp.getEmpno());
            System.out.println(sql);
            // 返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数是："+i);

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,pstmt);
        }
    }

    @Override
    public Emp getEmpByEmpno(Integer empno) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        Emp emp = null;
        try {
            connection = DButil.getConnection();
            String sql = "select * from emp where empno = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1,empno);
            System.out.println(sql);
            // 返回结果
            resultSet = pstmt.executeQuery();
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
            DButil.closeConnection(connection,pstmt,resultSet);
        }
        return emp;
    }
    @Override
    public Emp getEmpByEname(String ename) {
        Connection connection = null;
        PreparedStatement pstmt = null; // 预处理块
        ResultSet resultSet = null;
        Emp emp = null;
        try {
            connection = DButil.getConnection();
            String sql = "select * from emp where ename = ?";
            pstmt = connection.prepareStatement(sql);
            pstmt.setString(1,ename);
            System.out.println(sql);
            // 返回结果
            resultSet = pstmt.executeQuery();
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
            DButil.closeConnection(connection,pstmt,resultSet);
        }
        return emp;
    }

    public static void main(String [] args) {
        EmpDao empDao = new EmpDaoImpl2();
        Emp emp = new Emp(4444,"sisi","SALES",1111,"2021-2-14",1500.0,500.0,10);
//        empDao.insert(emp);
        empDao.delete(emp);
//        empDao.update(emp);
//        Emp empByEmpno = empDao.getEmpByEmpno(7369);
//        System.out.println(empByEmpno);
//        Emp emp1 = empDao.getEmpByEname("'SMITH' or 1 = 1");
//        System.out.println(emp1);
    }

}
