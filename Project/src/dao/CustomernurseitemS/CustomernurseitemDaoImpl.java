package dao.CustomernurseitemS;


import entity.CustomernurseitemS.Customernurseitem;
import utils.JdbcUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomernurseitemDaoImpl implements CustomernurseitemDao {
    @Override
    public boolean save(Customernurseitem obj) throws SQLException {
        String sql = "insert into Customernurseitem(id,item_id,customer_id,level_id,nurse_number,is_deleted,buy_time,maturity_time ) values(?,?,?,?,?,?,?,?)";
        Connection conn = JdbcUtils.getConnection();
        PreparedStatement stat = conn.prepareStatement(sql);
        stat.setInt(1,obj.getId());
        stat.setInt(2,obj.getItem_id());
        stat.setInt(3,obj.getCustomer_id());
        stat.setInt(4,obj.getLevel_id());
        stat.setInt(5,obj.getNurse_number());
        stat.setInt(6,obj.getIs_deleted());
        stat.setDate(7, (Date) obj.getBuy_time());
        stat.setDate(8, (Date) obj.getMaturity_time());
        int row = stat.executeUpdate();
        return row>0?true:false;
    }

    @Override
    public boolean update(Customernurseitem obj) throws SQLException {
        String sql="update Customrnurseitem set item_id=?,customer_id=?,level_id=?,nurse_number=?,is_deleted=?,buy_time=?,maturity_time=? where id=?";
        Connection conn = JdbcUtils.getConnection();
        PreparedStatement stat = conn.prepareStatement(sql);
        stat.setInt(1,obj.getItem_id());
        stat.setInt(2,obj.getCustomer_id());
        stat.setInt(3,obj.getLevel_id());
        stat.setInt(4,obj.getNurse_number());
        stat.setInt(5,obj.getIs_deleted());
        stat.setDate(6, (Date) obj.getBuy_time());
        stat.setDate(7, (Date) obj.getMaturity_time());
        stat.setInt(8,obj.getId());
        int row = stat.executeUpdate();
        return row>0?true:false;
    }

    @Override
    public boolean delete(Integer id) throws SQLException {
        String sql = "delete from Customernurseitem where id=?";
        Connection conn = JdbcUtils.getConnection();
        PreparedStatement stat = conn.prepareStatement(sql);
        stat.setInt(1,id);
        int row = stat.executeUpdate();
        return row>0?true:false;
    }

    @Override
    public Customernurseitem findOne(Integer id) throws SQLException {
        String sql = "select * from Customernurseitem where id=?";
        Connection conn = JdbcUtils.getConnection();
        PreparedStatement stat = conn.prepareStatement(sql);
        stat.setInt(1,id);
        ResultSet rs = stat.executeQuery();
        if(rs.next()){
            Customernurseitem obj = new Customernurseitem();
            obj.setId(rs.getInt("id"));
            obj.setItem_id(rs.getInt("item_id"));
            obj.setCustomer_id(rs.getInt("customer_id"));
            obj.setLevel_id(rs.getInt("level_id"));
            obj.setNurse_number(rs.getInt("nurse_number"));
            obj.setIs_deleted(rs.getInt("is_deleted"));
            obj.setBuy_time(rs.getDate("buy_time"));
            obj.setMaturity_time(rs.getDate("maturity_time"));
            return obj;
        }
        return null;
    }

    @Override
    public List<Customernurseitem> findAll() throws SQLException {
        String sql = "select * from Customernurseitem";
        Connection conn = JdbcUtils.getConnection();
        PreparedStatement stat = conn.prepareStatement(sql);
        ResultSet rs = stat.executeQuery();
        List<Customernurseitem> list = new ArrayList<>();
       while(rs.next()){
           Customernurseitem obj = new Customernurseitem();
           obj.setId(rs.getInt("id"));
           obj.setItem_id(rs.getInt("item_id"));
           obj.setCustomer_id(rs.getInt("customer_id"));
           obj.setLevel_id(rs.getInt("level_id"));
           obj.setNurse_number(rs.getInt("nurse_number"));
           obj.setIs_deleted(rs.getInt("is_deleted"));
           obj.setBuy_time(rs.getDate("buy_time"));
           obj.setMaturity_time(rs.getDate("maturity_time"));
           list.add(obj);
       }

        return findAll();
    }}

