package dao.OutwardS;

import entity.OutwardS.Outward;
import utils.CRUDUtils;
import utils.JdbcUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OutwardDAOImpl implements OutwardDAO {


    @Override
    public Boolean saveOutward(Outward outward) throws SQLException {
        String sql = "INSERT into outward values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        Object[] params = {outward.getId(),outward.getRemarks(),outward.getIs_delete(),outward.getCustomer_id(),outward.getOutgoingreason(),outward.getOutgoingtime(),outward.getExpectedreturntime(),outward.getActualreturntime(),outward.getEscortedtel(),outward.getAuditstatus(),outward.getAuditperson(),outward.getAudittime()};
        return CRUDUtils.update(sql,params);
    }

    @Override
    public Boolean deleteOutward(Integer id) throws SQLException {
        String sql = "DELETE from outward where id=?";
        Object[] params = {id};
        return CRUDUtils.update(sql,params);
    }

    @Override
    public Boolean updateOutward(Outward outward) throws SQLException {
        String sql = "UPDATE outward SET remarks = ?, is_deleted = ?, customer_id = ?, outgoingreason = ?, outgoingtime = ?, epectedreturntime = ?, actualreturntime = ?, escorted = ?, relation = ?, escortedtel = ?, auditstatus = ?, auditperson = ?, audittime = ? where id = ?";
        Object[] params = {outward.getRemarks(),outward.getIs_delete(),outward.getCustomer_id(),outward.getOutgoingreason(),outward.getOutgoingtime(),outward.getExpectedreturntime(),outward.getActualreturntime(),outward.getEscortedtel(),outward.getAuditstatus(),outward.getAuditperson(),outward.getAudittime(),outward.getId()};
        return CRUDUtils.update(sql,params);
    }

    @Override
    public Outward findOutwardById(Integer ID) throws SQLException {
        String sql = "select * from outward where id=?";
        Object[] params = {ID};
        List<Outward> outward = CRUDUtils.select(sql,params, Outward.class);
        return outward.size()>0?outward.get(0):null;
    }

    @Override
    public List<Outward> findAllOutward() throws SQLException {
        String sql = "select * from outward";
        Object[] params = {};
        List<Outward> outward = CRUDUtils.select(sql,params,Outward.class);

        return List.of();
    }
}
