package kms.com.cooperation.service;

import java.util.List;

public interface CustomerService {

	List<CustomerVO> selectCustomerListAll(CustomerVO customerVO) throws Exception;
	List<CustomerVO> selectCustomerList(CustomerVO customerVO) throws Exception;
	int selectCustomerListTotCnt(CustomerVO customerVO) throws Exception;
	CustomerVO selectCustomer(CustomerVO customerVO) throws Exception;
	
	void insertCustomer(Customer customer, List<CustomerPerson> custPersonList) throws Exception;
	void updateCustomer(Customer customer, List<CustomerPerson> custPersonList) throws Exception;
	void deleteCustomer(Customer customer) throws Exception;

	List<CustomerComment> selectCustomerCommentList(CustomerComment customerComment) throws Exception;
	CustomerComment selectCustomerComment(CustomerComment customerComment) throws Exception;
	void insertCustomerComment(CustomerComment customerComment) throws Exception;
	void updateCustomerComment(CustomerComment customerComment) throws Exception;
	void deleteCustomerComment(CustomerComment customerComment) throws Exception;
}
