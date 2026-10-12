package dao.CustomerS;

import entity.CustomerS.Customer;

import java.sql.SQLException;
import java.util.List;

public interface CustomerDAO {

    boolean saveCustomer(Customer customer) throws SQLException;
    boolean updateCustomer(Customer customer) throws SQLException;
    boolean deleteCustomer(Integer id) throws SQLException;
    Customer findCustomer(Integer id) throws SQLException;
    List<Customer> findAllCustomers() throws SQLException;

    List<Customer> search(String customerName,String contact_tel,String idcard,String building_no) throws SQLException, InstantiationException, IllegalAccessException;
}
