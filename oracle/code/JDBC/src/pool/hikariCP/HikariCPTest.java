package pool.hikariCP;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * @Author : LiuYan
 * @create 2021/2/17 12:33
 */
public class HikariCPTest {
    public static void main(String[] args) throws SQLException {
        //initialize方式一
//        HikariConfig config = new HikariConfig();
//        config.setJdbcUrl("jdbc:mysql://localhost:3306/demo");
//        config.setUsername("root");
//        config.setPassword("512");
//        HikariDataSource ds = new HikariDataSource(config);

        //方式二
//        HikariDataSource ds = new HikariDataSource();
//        ds.setJdbcUrl("jdbc:mysql://localhost:3306/demo");
//        ds.setUsername("root");
//        ds.setPassword("512");

        //方式三 配置文件
        HikariConfig config = new HikariConfig("src/pool/hikariCP/hikariCP.properties");
        HikariDataSource ds = new HikariDataSource(config);
        Connection connection = ds.getConnection();
        System.out.println(connection);
        connection.close();
    }
}
