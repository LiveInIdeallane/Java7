package service.CustomerS;

import entity.CustomerS.Customer;

import java.util.List;

public interface CustomerService {

    //基础的服务接口
    boolean createCustomer(Customer customer);
    boolean updateCustomer(Customer customer);
    boolean deleteCustomer(Customer customer);
    Customer findCustomerById(Integer id);
    List<Customer> findAllCustomers();


    //进行模糊查询
    List<Customer> search(String customerName,String contact_tel,String idcard,String building_no);
}
