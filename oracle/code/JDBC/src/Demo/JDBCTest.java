package Demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @Author : LiuYan
 * @create 2021/2/13 17:25
 *
 * 如果需要建立连接，java中提供了一套标准，数据库厂商进行实现，包含实现子类，实现子类的jar文件在哪？
 * 一般存放在安装目录下
 */
public class JDBCTest {
    public static void main(String[] args) throws Exception {

        //1. 加载驱动
        /**
         * 当执行了当前代码后，会返回一个Class对象，在此对象的创建过程中，会调用具体类(OracleDriver)的静态代码块，
         * 里面会将当前对象注册进DriverManager
         */
        Class.forName("oracle.jdbc.driver.OracleDriver");
        //2. 建立连接
        // 第一步中已经将driver对象注册到了driverManager中，所以此时可以直接通过drivermanager来获取数据库的连接了
        /**
         * 需要输入连接数据库的参数：
         *  url: 数据库的地址
         *  username：用户名
         *  password：密码
         */
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@192.168.12.1:1521:orcl",
                "scott", "tiger");
        //3. 测试是否成功
        System.out.println(connection);
        //4. 定义sql语句
        //只要填写正常sql语句即可
        String sql = "select * from emp";
        //5. 准备静态处理块对象，将sql语句放置到静态处理块中，理解为sql语句放置对象
        /**
         * 在执行sql语句的过程中，需要一个对象来存放sql语句，将对象进行执行的时候，调用的是数据库的服务，数据库会从当前对象中
         * 拿到对应的sql语句进行执行
         */
        Statement statement = connection.createStatement();
        //6. 执行sql语句，返回值对象是结果集合
        /**
         * 将结果放到resultset中，是返回结果的一个集合
         * 需要经过循环迭代才能获取得到其中的每一条记录
         *
         * statement在执行的时候可以选择三种方式：
         *  1.execute：任何sql语句都可以执行
         *  2.executeQuery：只能执行查询语句
         *  3.executeUpdate：只能执行DML语句 增删改查
         */
        ResultSet resultSet = statement.executeQuery(sql);
        //7. 循环处理
        /**
         * 使用while循环，有两种获取具体值的方式：
         *  1.通过下标索引编号来获取 从1开始
         *  2.通过列名来获取
         *  推荐使用列名，列名一般不会发生修改。
         */
        while (resultSet.next()) {
            int anInt = resultSet.getInt(1);
            System.out.println(anInt);
            String ename = resultSet.getString("ename");
            System.out.println(ename);
            System.out.println("---------------");
        }
        // 8. 关闭连接
        statement.close();
        connection.close();
    }
}
