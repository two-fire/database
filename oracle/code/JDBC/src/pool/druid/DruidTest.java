package pool.druid;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.util.Properties;

/**
 * @Author : LiuYan
 * @create 2021/2/17 12:06
 */
public class DruidTest {
    public static void main(String[] args) throws Exception {
        // 可以直接创建，不过更多的是通过工厂方式进行创建
//        DruidDataSource dataSource = new DruidDataSource();
        Properties properties = new Properties();
        FileInputStream fileInputStream = new FileInputStream("src/pool/druid/druid.properties");
        properties.load(fileInputStream);

        DataSource dataSource = DruidDataSourceFactory.createDataSource(properties);
        Connection connection =dataSource.getConnection();
        System.out.println(connection);
        connection.close();
    }
}
