package reflect;

import entity.Dept;
import entity.Emp;
import javafx.scene.DepthTest;
import util.DButil;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * @Author : LiuYan
 * @create 2021/2/15 11:00
 *
 * 要查询N张表的数据，但是不想写N多个方法，能否写一个方法完成所有表的查询操作 增删改查
 *   实现对象和表之间的一个关系对接。
 */
public class BaseDaoImpl {

    /**
     * 统一的查询表的方法
     * @param sql     不同的sql语句
     * @param params  sql语句的参数
     * @param clazz   查询返回的对象
     * @return
     */
    public List getRows(String sql,Object[] params,Class clazz) {
        List list = new ArrayList();
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
            //建立连接
            connection = DButil.getConnection();
            //创建pstmt对象
            pstmt = connection.prepareStatement(sql);
            //给sql语句填充参数
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i+1, params[i]);
                }
            }
            //开始执行查询操作，resultset中有返回的结果，需要将返回的结果放置到不同的对象中
            resultSet = pstmt.executeQuery();
            //获取结果集合的元数据对象
            ResultSetMetaData metaData = resultSet.getMetaData();
            //判断查询到的每一行记录中包含多少个列
            int columnCount = metaData.getColumnCount();
            //循环遍历resultset
            while (resultSet.next()) {
                //提前创建一个放置结果属性的对象
                Object obj = clazz.newInstance();
                for (int i = 0; i < columnCount; i++) {
                    //从结果集合中获取单一列的值
                    Object objValue = resultSet.getObject(i + 1);
                    //获取列的名称
                    String columName = metaData.getColumnName(i+1).toLowerCase();
                    //获取类中的属性
                    Field declaredField = clazz.getDeclaredField(columName);
                    //获取类中属性对应的set方法
                    Method method = clazz.getMethod(getSetName(columName),declaredField.getType());
                    if (objValue instanceof Number) {
                        Number number = (Number) objValue;
                        String fname = declaredField.getType().getName();
                        if ("int".equals(fname) || "java.lang.Integer".equals(fname)) {
                            method.invoke(obj,number.intValue());
                        } else if ("byte".equals(fname) || "java.lang.Byte".equals(fname)) {
                            method.invoke(obj,number.byteValue());
                        } else if ("short".equals(fname) || "java.lang.Short".equals(fname)) {
                            method.invoke(obj,number.shortValue());
                        } else if ("long".equals(fname) || "java.lang.Long".equals(fname)) {
                            method.invoke(obj,number.longValue());
                        } else if ("float".equals(fname) || "java.lang.Float".equals(fname)) {
                            method.invoke(obj,number.floatValue());
                        } else if ("double".equals(fname) || "java.lang.Double".equals(fname)) {
                            method.invoke(obj,number.doubleValue());
                        }
                    } else {
                        method.invoke(obj,objValue);
                    }
                }
                list.add(obj);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DButil.closeConnection(connection,pstmt,resultSet);
        }

        return list;
    }

    /**
     * 将字符串转换成首字母大写的形式
     * @param name
     * @return
     */
    public String getSetName(String name) {
        return "set"+name.substring(0,1).toUpperCase()+name.substring(1);
    }

    /**
     * 统一的增加记录的方法
     * @param sql
     * @param params
     * @param clazz
     * @return
     */
    public void insertRows(String sql, Object[] params, Class clazz) {
        Connection connection = DButil.getConnection();
        PreparedStatement pstmt = null;
        try {
            pstmt = connection.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i+1,params[i]);
                }
            }
            //返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数："+i);
        } catch (Exception throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.closeConnection(connection,pstmt);
        }
    }
    /**
     * 统一的删除表的方法
     * @param sql
     * @param params
     * @param clazz
     */
    public void deleteRows(String sql, Object[] params, Class clazz) {
        Connection connection = DButil.getConnection();
        PreparedStatement pstmt = null;
        try {
            pstmt = connection.prepareStatement(sql);
            //给sql语句填充参数
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i+1,params[i]);
                }
            }
            //返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数："+i);

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            DButil.closeConnection(connection,pstmt);
        }
    }

    /**
     * 统一的更改记录方法
     * @param sql
     * @param params
     * @param clazz
     */
    public void update(String sql, Object[] params, Class clazz) {
        Connection connection = DButil.getConnection();
        PreparedStatement pstmt = null;
        try {
            pstmt = connection.prepareStatement(sql);
            //给sql语句填充参数
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i+1,params[i]);
                }
            }
            //返回值表示受影响的行数
            int i = pstmt.executeUpdate();
            System.out.println("受影响的行数："+i);

        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            DButil.closeConnection(connection,pstmt);
        }
    }


    public static void main(String[] args) {
//        System.out.println(new BaseDaoImpl().getSetName("name"));
        BaseDaoImpl baseDao = new BaseDaoImpl();
        // 查询表测试1
        List rows = baseDao.getRows("select empno,ename,sal,deptno from emp where deptno=?",new Object[]{10}, Emp.class);
        for (Iterator it = rows.iterator();it.hasNext();) {
            Emp emp = (Emp) it.next();
            System.out.println(emp);
        }
        // 查询表测试2
//        List rows = baseDao.getRows("select loc,dname,deptno from dept",new Object[]{}, Dept.class);
//        for (Iterator it = rows.iterator();it.hasNext();) {
//            Dept dept = (Dept) it.next();
//            System.out.println(dept);
//        }
        // 删除表记录测试1
//        baseDao.deleteRows("delete from emp where empno=?",new Object[]{7369}, Emp.class);
        // 删除表记录测试2
//        baseDao.deleteRows("delete from dept where deptno=1",new Object[]{}, Dept.class);
        // 增加记录测试
//        baseDao.insertRows("insert into emp values(?,?,?,?,to_date(?,'yyyy-mm-dd'),?,?,?)",
//                new Object[]{4444,"sisi","SALES",1111,"2021-2-14",1500.0,500.0,10},
//                Emp.class);
        // 统一的更改记录方法
//        baseDao.update("update emp set job = ? where empno= ?",new Object[]{"BOSS",4444},Emp.class);
    }
}
