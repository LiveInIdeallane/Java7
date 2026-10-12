package dao.CustomerS;

import dao.CustomerS.CustomerDAO;
import entity.CustomerS.Customer;
import utils.CRUDUtils;
import utils.JdbcUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAOImpl implements CustomerDAO {

    @Override
    public boolean saveCustomer(Customer customer) throws SQLException {
        String sql = "insert into customer(is_deleted,customer_name,customer_age,customer_sex,idcard,room_no,building_no,checkin_date,expiration_date,contact_tel,bed_id,psychosomatic_state,attention,birthday,height,weight,blood_type,filepath,user_id,level_id,family_number) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        Object[] object = {customer.getIs_deleted(),customer.getCustomer_name(),customer.getCustomer_age(),customer.getCustomer_sex(),customer.getIdcard(),customer.getRoom_no(),customer.getBuilding_no(), (Date) customer.getCheckin_date(),(Date) customer.getExpiration_date(),customer.getContact_tel(), customer.getBed_id(),customer.getPsychosomatic_state(),customer.getAttention(),(Date) customer.getBirthday(),customer.getHeight(),customer.getWeight(),customer.getBlood_type(),customer.getFilepath(),customer.getUser_id(),customer.getLevel_id(),customer.getFamily_number()};
        return CRUDUtils.update(sql, object);
    }

    @Override
    public boolean updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE customer SET is_deleted = ?, customer_name = ?, customer_age = ?, customer_sex = ?, idcard = ?, room_no = ?, building_no = ?, checkin_date = ?, expiration_date = ?, contact_tel = ?, bed_id = ?, psychosomatic_state = ?, attention = ?, birthday = ?, height = ?, weight = ?, blood_type = ?, filepath = ?, user_id = ?, level_id = ?, family_member = ? where id = ?";

        Object[] object = {customer.getIs_deleted(),customer.getCustomer_name(),customer.getCustomer_age(),customer.getCustomer_sex(),customer.getIdcard(),customer.getRoom_no(),customer.getBuilding_no(), (Date) customer.getCheckin_date(),(Date) customer.getExpiration_date(),customer.getContact_tel(), customer.getBed_id(),customer.getPsychosomatic_state(),customer.getAttention(),(Date) customer.getBirthday(),customer.getHeight(),customer.getWeight(),customer.getBlood_type(),customer.getFilepath(),customer.getUser_id(),customer.getLevel_id(),customer.getFamily_number(),customer.getId()};
        return CRUDUtils.update(sql, object);
    }



    @Override
    public boolean deleteCustomer(Integer id) throws SQLException {
        String sql = "DELETE FROM customer WHERE id = ?";

        Object[] object = {id};
        return CRUDUtils.update(sql, object);
    }

    @Override
    public Customer findCustomer(Integer id) throws SQLException {
        String sql = "SELECT * FROM customer WHERE id = ?";
        Object[] object = {id};
        List<Customer> customers = CRUDUtils.select(sql,object, Customer.class);
        return customers.size() > 0 ? customers.get(0) : null;
    }

    @Override
    public List<Customer> findAllCustomers() throws SQLException {
        String sql = "SELECT * FROM customer";
        Object[] object = {};
        List<Customer> customers = CRUDUtils.select(sql, object, Customer.class);
        return customers;
    }

    @Override
    public List<Customer> search(String customerName, String contact_tel, String idcard, String building_no) throws SQLException, InstantiationException, IllegalAccessException {
        String sql = "SELECT * FROM customer WHERE 1=1 ";

        List<Object> list = new ArrayList<>();

        //sql语句拼接
        if(customerName!=null&&!"".equals(customerName)){
            sql+=" AND customer_name like ? ";
            list.add("%"+customerName+"%");
        }if(contact_tel!=null&&!"".equals(contact_tel)){
            sql+=" AND contact_tel like ? ";
            list.add("%"+contact_tel+"%");
        }if(idcard!=null&&!"".equals(idcard)){
            sql+=" AND idcard like ? ";
            list.add("%"+idcard+"%");
        }if(building_no!=null&&!"".equals(building_no)){
            sql+=" AND building_no like ? ";
            list.add("%"+building_no+"%");
        }
        Object[] params = list.toArray();

        return CRUDUtils.select(sql,params,Customer.class);
    }
}
