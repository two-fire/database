package reflect;

import entity.Emp;

/**
 * @Author : LiuYan
 * @create 2021/2/14 16:40
 *
 * 获取Class对象
 *  推荐使用第一种和第二种。
 */
public class CreateClassObject {
    public static void main(String[] args) throws Exception {
        //1、通过Class.forName方法来获取对象
//        Class clazz = Class.forName("entity.Emp");
        //2、通过类名.class来获取
//        Class<Emp> clazz = Emp.class;
        //3、通过对象的getClass()来获取
        /**
         * 每次在加载我们对象的时候，只要类加载器一旦加载我们class文件了，自然而然就会创建好一个Class对象。
         *  面new了一个新对象，而我已经有了一个Class对象了，相当于充分利用过程。所以不太推荐。
         */
        Class clazz = new Emp().getClass();
        System.out.println(clazz.getPackage());
        System.out.println(clazz.getName());//获取完整名称包名+类名entity.Emp
        System.out.println(clazz.getSimpleName()); // Emp
        System.out.println(clazz.getCanonicalName());// entity.Emp
// 4、如果是一个基本数据类型，那么可以通过Type的方式来获取Class对象
//        Class<Integer> type1 = Integer.TYPE;

        Class type = args.getClass();
        System.out.println(type.getName()); // [Ljava.lang.String;
        System.out.println(type.getCanonicalName()); // java.lang.String[]

//        Class type1 = Integer[].class;
//        System.out.println(type1.getName());// [Ljava.lang.Integer;
//        System.out.println(type1.getCanonicalName());// java.lang.Integer[]

    }
}

