package kms.com.management.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalVO;
import kms.com.management.service.BondVO;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.PlanCostVO;
import kms.com.management.service.SalesVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsConractDAO")
public class ContractDAO extends EgovAbstractDAO{

	public List selectContractList(Map<String, Object> param) {
		return list("KmsContractDAO.selectContractList", param);
	}
	
	public int selectContractListCnt(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsContractDAO.selectContractListCnt", param);
	}
	
	public Map<String, Object> selectContract(Map<String, Object> param) {
		return (Map<String, Object>) selectByPk("KmsContractDAO.selectContract", param);
	}
	
	void insertContract(Map<String, Object> param) {
		insert("KmsContractDAO.insertContract", param);
	}
	
	void deleteContract(Map<String, Object> param) {
		update("KmsContractDAO.deleteContract", param);
	}
	
	void updateContract(Map<String, Object> param) {
		update("KmsContractDAO.updateContract", param);
	}
	
	void updateContractResultRegister(Map<String, Object> param) {
		update("KmsContractDAO.updateContractResultRegister", param);
	}
	
	public List selectAuthList(Map<String, Object> param) {
		return list("KmsContractDAO.selectAuthList", param);
	}
	
	void insertAuthList(Map<String, Object> param) {
		insert("KmsContractDAO.insertAuthList", param);
	}
	
	void deleteAuthList(Map<String, Object> param) {
		delete("KmsContractDAO.deleteAuthList", param);
	}
}
