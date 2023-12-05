package kms.com.cooperation.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import kms.com.cooperation.service.Customer;
import kms.com.cooperation.service.CustomerComment;
import kms.com.cooperation.service.CustomerPerson;
import kms.com.cooperation.service.CustomerService;
import kms.com.cooperation.service.CustomerVO;

@Service("KmsCustomerService")
public class CustomerServiceImpl implements CustomerService {

	@Resource(name="KmsCustomerDAO")
	private CustomerDAO custDAO;
	
	@Resource(name="kmsCustomerIdGnrService")
	private EgovIdGnrService idgnrService;

	@Override
	public List<CustomerVO> selectCustomerListAll(CustomerVO customerVO)
	throws Exception {
		return custDAO.selectCustomerListAll(customerVO);
	}
	
	@Override
	public List<CustomerVO> selectCustomerList(CustomerVO customerVO)
			throws Exception {
		return custDAO.selectCustomerList(customerVO);
	}
	
	@Override
	public int selectCustomerListTotCnt(CustomerVO customerVO) throws Exception {
		return custDAO.selectCustomerListTotCnt(customerVO);
	}

	@Override
	public CustomerVO selectCustomer(CustomerVO customerVO) throws Exception {
		CustomerVO result = custDAO.selectCustomer(customerVO);
		List<CustomerPerson> custPersonList = custDAO.selectCustomerPersonList(customerVO);
		
		result.setPersonList(custPersonList);
		
		return result;
	}

	@Override
	public void insertCustomer(Customer customer,
			List<CustomerPerson> custPersonList) throws Exception {
		String custId = idgnrService.getNextStringId();
		customer.setCustId(custId);
		
		if (customer != null)
			custDAO.insertCustomer(customer);
		
		if (custPersonList != null) {
			for(int i=0; i<custPersonList.size(); i++) {
				CustomerPerson cp = custPersonList.get(i);
				cp.setCustId(custId);
				
				custDAO.insertCustomerPerson(cp);
			}
		}
	}

	@Override
	public void updateCustomer(Customer customer,
			List<CustomerPerson> custPersonList) throws Exception {
		custDAO.updateCustomer(customer);
		custDAO.deleteCustomerPerson(customer);
		
		for(int i=0; i<custPersonList.size(); i++) {
			CustomerPerson cp = custPersonList.get(i);
			
			custDAO.insertCustomerPerson(cp);
		}
	} 

	@Override
	public void deleteCustomer(Customer customer) throws Exception {
		custDAO.deleteCustomer(customer);
	}

	@Override
	public List<CustomerComment> selectCustomerCommentList(CustomerComment customerComment) throws Exception {
		return custDAO.selectCustomerCommentList(customerComment);
	}

	@Override
	public CustomerComment selectCustomerComment(CustomerComment customerComment)
			throws Exception {
		return custDAO.selectCustomerComment(customerComment);
	}

	@Override
	public void insertCustomerComment(CustomerComment customerComment) throws Exception {
		custDAO.insertCustomerComment(customerComment);
	}

	@Override
	public void updateCustomerComment(CustomerComment customerComment) throws Exception {
		custDAO.updateCustomerComment(customerComment);
	}

	@Override
	public void deleteCustomerComment(CustomerComment customerComment) throws Exception {
		custDAO.deleteCustomerComment(customerComment);
	}
	
}
