package utils;

import java.lang.reflect.Field;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


//用于简化dao层对sql处理的重复语句
public class CRUDUtils {


    //对多数据重复处理的简化
    public static boolean update(String sql,Object[] objects) throws SQLException {

        Connection conn = JdbcUtils.getConnection();
        PreparedStatement stat = conn.prepareStatement(sql);
        for (int i = 0; i <objects.length ; i++) {
            stat.setObject(i+1,objects[i]);
        }
        int row = stat.executeUpdate();
        return row>0;

    }



    //通用的查询语句，返回的是查询到结果集
    public static List select(String sql, Object[] objects, Class clazz) throws SQLException {


        Connection conn = JdbcUtils.getConnection();
        PreparedStatement stat = conn.prepareStatement(sql);
        List list = new ArrayList();
        for (int i = 0; i <objects.length ; i++) {
            stat.setObject(i+1,objects[i]);
        }
        //获得结果集
        ResultSet rs = stat.executeQuery();
        ResultSetMetaData rsmd = rs.getMetaData();
        //获得不同实体的模版
        Class c = clazz;
        try {
            while(rs.next()){
                //通过模板手动生成对象
                Object obj = c.newInstance();
                Field[] fields = c.getDeclaredFields();
                //将当前行的数据输出
                for (int i = 1; i <=rsmd.getColumnCount() ; i++) {
                    fields[i-1].setAccessible(true);
                    fields[i-1].set(obj,rs.getObject(rsmd.getColumnName(i)));
                }
                list.add(obj);
            }
        } catch (InstantiationException e) {
            throw new RuntimeException(e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }

        return list;
    }


}
