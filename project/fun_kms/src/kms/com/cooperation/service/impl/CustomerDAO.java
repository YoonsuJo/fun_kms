package kms.com.cooperation.service.impl;

import java.util.List;

import kms.com.cooperation.service.Customer;
import kms.com.cooperation.service.CustomerComment;
import kms.com.cooperation.service.CustomerPerson;
import kms.com.cooperation.service.CustomerVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsCustomerDAO")
public class CustomerDAO extends EgovAbstractDAO {

	public List<CustomerVO> selectCustomerListAll(CustomerVO customerVO) {
		return list("CustomerDAO.selectCustomerListAll", customerVO);
	}
	
	public List<CustomerVO> selectCustomerList(CustomerVO customerVO) {
		return list("CustomerDAO.selectCustomerList", customerVO);
	}

	public int selectCustomerListTotCnt(CustomerVO customerVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("CustomerDAO.selectCustomerListTotCnt", customerVO);
	}

	public CustomerVO selectCustomer(CustomerVO customerVO) {
		return (CustomerVO)selectByPk("CustomerDAO.selectCustomer", customerVO);
	}

	public void insertCustomer(Customer customer) {
		insert("CustomerDAO.insertCustomer", customer);
	}

	public void updateCustomer(Customer customer) {
		update("CustomerDAO.updateCustomer", customer);
	}

	public void deleteCustomer(Customer customer) {
		update("CustomerDAO.deleteCustomer", customer);
	}

	public List<CustomerPerson> selectCustomerPersonList(CustomerVO customerVO) {
		return list("CustomerDAO.selectCustomerPersonList", customerVO);
	}

	public void insertCustomerPerson(CustomerPerson customerPerson) {
		insert("CustomerDAO.insertCustomerPerson", customerPerson);
	}

	public void deleteCustomerPerson(Customer customer) {
		delete("CustomerDAO.deleteCustomerPerson", customer);
	}

	public List<CustomerComment> selectCustomerCommentList(CustomerComment customerComment) {
		return list("CustomerDAO.selectCustomerComment", customerComment);
	}

	public CustomerComment selectCustomerComment(CustomerComment customerComment) {
		return (CustomerComment)selectByPk("CustomerDAO.selectCustomerComment", customerComment);
	}

	public void insertCustomerComment(CustomerComment customerComment) {
		insert("CustomerDAO.insertCustomerComment", customerComment);
	}

	public void updateCustomerComment(CustomerComment customerComment) {
		update("CustomerDAO.updateCustomerComment", customerComment);
	}

	public void deleteCustomerComment(CustomerComment customerComment) {
		update("CustomerDAO.deleteCustomerComment", customerComment);
	}

}
