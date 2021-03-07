package dao.impl;

import util.DButil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * @Author : LiuYan
 * @create 2021/2/14 15:32
 */
public class BatchDaoImpl {
    public static void main(String[] args) {
        long start = System.currentTimeMillis();
        insertBatch();
        System.out.println(System.currentTimeMillis()-start);
        System.out.println("---------------");
        long start2 = System.currentTimeMillis();
        // 程序的运行速度是非常快的，而我们数据库的连接是有上限的，并不是说我们能打开无数次连接
        // 所以要是插入数据过多，第二种方式最后会报拒绝连接的错误
        for (int i = 100; i < 200; i++) {
            insertBatch2(i,"msb"+i);
        }
        System.out.println(System.currentTimeMillis()-start2);
    }

    /**
     * 批量提交 时间比单条插入快
     * 中间省略了打开关闭连接过程
     */
    public static void insertBatch() {
        Connection connection = DButil.getConnection();
        String sql = "insert into emp(empno,ename) values(?,?)";
        PreparedStatement pstmt = null;
        // 准备预处理块对象
        try {
            pstmt = connection.prepareStatement(sql);
            for (int i = 0; i < 100; i++) {
                pstmt.setInt(1,i);
                pstmt.setString(2,"msb"+i);
                // 向批处理中添加sql语句
                pstmt.addBatch();
            }
            int[] ints = pstmt.executeBatch();
            for (int anInt : ints) {
                System.out.println(anInt);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,pstmt);
        }
    }
    /**
     * 批量提交效率演示
     */
    public static void insertBatch2(int i,String name) {
        Connection connection = DButil.getConnection();
        String sql = "insert into emp(empno,ename) values(?,?)";
        PreparedStatement pstmt = null;
        // 准备预处理块对象
        try {
            pstmt = connection.prepareStatement(sql);
                pstmt.setInt(1,i);
                pstmt.setString(2,name);
                // 向批处理中添加sql语句
                int t = pstmt.executeUpdate();
            System.out.println(t);
            int[] ints = pstmt.executeBatch();
            for (int anInt : ints) {
                System.out.println(anInt);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,pstmt);
        }
    }
}
