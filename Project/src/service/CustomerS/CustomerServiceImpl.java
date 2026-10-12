package service.CustomerS;

import dao.CustomerS.*;

import entity.CustomerS.Customer;
import service.CustomerS.*;
import utils.JdbcUtils;

import java.sql.SQLException;
import java.util.List;

public class CustomerServiceImpl implements CustomerService {

    private CustomerDAO  customerDAO = new CustomerDAOImpl();


    //写在service层面的相当于每个方法对应一个业务操作，一个业务操作需向下调用多个dao层的sql接口
    //而单个dao方法通常只对一条sql,单条sql由数据库自动保证原子性
    //所以在service层必须将dao层调用的接口全部包在一起，要么全成功，要么全回滚


    //基础档案管理
    @Override
    public boolean createCustomer(Customer customer) {
        //进行数据测试

        //进行事务处理，在service层
        try {
            JdbcUtils.getConnection().setAutoCommit(false);
            boolean b = customerDAO.saveCustomer(customer);
            JdbcUtils.getConnection().commit();
            return b;
        } catch (SQLException e) {
            try {
                JdbcUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }finally {
            JdbcUtils.close();
        }

    }

    @Override
    public boolean updateCustomer(Customer customer) {
        //同样进行数据测试



        //进行事务处理
        try {
            JdbcUtils.getConnection().setAutoCommit(false);
            boolean b = customerDAO.updateCustomer(customer);
            JdbcUtils.getConnection().commit();
            return b;
        } catch (SQLException e) {
            try {
                JdbcUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }finally {
            JdbcUtils.close();
        }

    }

    @Override
    public boolean deleteCustomer(Customer customer) {
        //同样进行数据测试


        //进行事务处理
        try {
            JdbcUtils.getConnection().setAutoCommit(false);
            boolean b =  customerDAO.deleteCustomer(customer.getId());
            JdbcUtils.getConnection().commit();
            return b;
        } catch (SQLException e) {
            try {
                JdbcUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }finally {
            JdbcUtils.close();
        }
    }

    @Override
    public Customer findCustomerById(Integer id) {
        //进行数据监测，对id进行检测


        //进行事务处理
        try {
            JdbcUtils.getConnection().setAutoCommit(false);
            Customer customer = customerDAO.findCustomer(id);
            JdbcUtils.getConnection().commit();
            return customer;
        } catch (SQLException e) {
            try {
                JdbcUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }finally {
            JdbcUtils.close();
        }

    }

    @Override
    public List<Customer> findAllCustomers() {

        //不需要进行数据检测，直接进行事务处理
        try {
            JdbcUtils.getConnection().setAutoCommit(false);
            List<Customer> customers = customerDAO.findAllCustomers();
            JdbcUtils.getConnection().commit();
            return customers;
        } catch (SQLException e) {
            try {
                JdbcUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }finally {
            JdbcUtils.close();
        }

    }

    @Override
    public List<Customer> search(String customerName, String contact_tel, String idcard, String building_no) {

        //需要对模糊的数据进行检测


        //进行事务处理
        try {
            JdbcUtils.getConnection().setAutoCommit(false);
            List<Customer> customers = customerDAO.search(customerName,contact_tel,idcard,building_no);
            JdbcUtils.getConnection().commit();
            return customers;
        } catch (SQLException | InstantiationException | IllegalAccessException e) {
            try {
                JdbcUtils.getConnection().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }finally {
            JdbcUtils.close();
        }

    }



}
