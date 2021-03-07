package Demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * @Author : LiuYan
 * @create 2021/2/14 11:07
 */
public class CreateSeq {
    public static void main(String[] args) throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@192.168.12.1:1521:orcl", "scott", "tiger");
        String sql = "create sequence seq_1 increment by 1 start with 1";
        Statement statement = connection.createStatement();
        boolean execute = statement.execute(sql);
        System.out.println(execute);
        statement.close();
        connection.close();
    }
}
