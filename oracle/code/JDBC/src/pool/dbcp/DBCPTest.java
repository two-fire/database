package pool.dbcp;

import org.apache.commons.dbcp2.BasicDataSource;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @Author : LiuYan
 * @create 2021/2/16 9:15
 *
 * BasicDataSource
 */
public class DBCPTest {
    public static void main(String[] args) {
        // 数据库的连接池资源，在之后操作的时候，只需要从池中获取即可
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/demo");
        dataSource.setUsername("root");
        dataSource.setPassword("512");

        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        try {
            connection=dataSource.getConnection();
            String sql = "select * from emp";
            pstmt = connection.prepareStatement(sql);
            resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                System.out.println(resultSet.getString("ename"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                connection.close();  // 并不是关闭连接，而是放回池中去
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
//        dataSource.close(); //很少去关闭
    }
}
