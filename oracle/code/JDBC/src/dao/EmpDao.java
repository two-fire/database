package dao;

import entity.Emp;

/**
 * @Author : LiuYan
 * @create 2021/2/14 11:21
 */
public interface EmpDao {
    // 插入数据
    public void insert(Emp emp);
    // 删除数据
    public void delete(Emp emp);
    // 修改数据
    public void update(Emp emp);
    // 查找数据
    public Emp getEmpByEmpno(Integer empno);

    Emp getEmpByEname(String ename);
}
