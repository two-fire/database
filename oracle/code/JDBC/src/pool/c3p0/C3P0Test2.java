package pool.c3p0;

import com.mchange.v2.c3p0.DataSources;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author : LiuYan
 * @create 2021/2/16 11:04
 *
 * 2、通过工厂方法来完成操作
 * 静态工厂类DataSources，这个类可以创建未池化的数据源对象，也可以将未池化的数据源池化，
 * 当然，这种方式也会去自动加载配置文件
 */
public class C3P0Test2 {
    public static void main(String[] args) throws SQLException {
        // 1.获取未池化数据源对象
        DataSource ds_unpooled = DataSources.unpooledDataSource("jdbc:mysql://localhost:3306/demo",
                "root",
                "512");
        // 2.将未池化数据源对象进行池化
        //不能搭参数
//        DataSource ds_pooled = DataSources.pooledDataSource(ds_unpooled);
        // 用map可以写入参数
        Map overrides = new HashMap();
        overrides.put("maxStatements","200");
        overrides.put("maxPoolSize",new Integer(50));
        DataSource ds_pooled = DataSources.pooledDataSource(ds_unpooled,overrides);
        // 3.获取连接
        Connection connection = ds_pooled.getConnection();
        System.out.println(connection);
        connection.close();
    }

}
