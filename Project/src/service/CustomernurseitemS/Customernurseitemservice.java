package service.CustomernurseitemS;

import entity.CustomernurseitemS.Customernurseitem;

import java.sql.SQLException;
import java.util.List;

public interface Customernurseitemservice {
    boolean addCustomernurseitem(Customernurseitem customernurseitem);
    boolean updateCustomernurseitem(Customernurseitem customernurseitem);
    boolean deleteCustomernurseitem(Integer id);
    Customernurseitem findCustomernurseitemById(Integer id) throws SQLException;
    List<Customernurseitem> findAllCustomernurseitem() throws SQLException;
}
