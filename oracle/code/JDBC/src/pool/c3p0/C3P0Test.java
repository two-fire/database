package pool.c3p0;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @Author : LiuYan
 * @create 2021/2/16 10:01
 *
 * 获取连接池和获取连接
 *      1、使用ComboPooledDataSource
 *      2、通过静态工厂方法DataSources来完成操作
 *      3、通过JNDI获取数据源
 *
 * 第一种 使用ComboPooledDataSource
 */
public class C3P0Test {

    public static Connection connection;
    public static ComboPooledDataSource dataSource;

    public static void getConnection() {
        dataSource = new ComboPooledDataSource();
    }

    public static void queryData() {
        try {
            connection=dataSource.getConnection();
            String sql = "select * from emp";
            PreparedStatement pstmt = connection.prepareStatement(sql);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                System.out.println(resultSet.getString("ename"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    public static void main(String[] args) throws Exception {
        /**
         * 方式一 直接在**类的方法中**设置连接参数，一般没人使用，最好使用配置文件
         */
//        ComboPooledDataSource cpds = new ComboPooledDataSource();
//        cpds.setDriverClass("com.mysql.cj.jdbc.Driver"); // load the jdbc driver
//        cpds.setJdbcUrl("jdbc:mysql://localhost:3306/demo");
//        cpds.setUser("root");
//        cpds.setPassword("512");
//        Connection connection = cpds.getConnection();
//        System.out.println(connection);
//        connection.close();
        getConnection();
        queryData();
    }
}
