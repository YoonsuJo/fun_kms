package kms.com.support.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalVO;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarVO;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.CardVO;
import kms.com.support.service.TaxPublishVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsRuleDAO")
public class RuleDAO extends EgovAbstractDAO{

	public List searchTitleList(Map<String, Object> param) {
		return list("KmsRuleDAO.searchTitleList", param);
	}
	
	public List selectTitleList(Map<String, Object> param) {
		return list("KmsRuleDAO.selectTitleList", param);
	}
	
	public Map<String, Object> selectContent(Map<String, Object> param) {
		return (Map<String, Object>) selectByPk("KmsRuleDAO.selectContent", param);
	}

	public List selectHistoryList(Map<String, Object> param) {
		return list("KmsRuleDAO.selectHistoryList", param);
	}
	
	public int selectMaxTitleNo(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsRuleDAO.selectMaxTitleNo", param);
	}
	
	public int selectMaxContentNo(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsRuleDAO.selectMaxContentNo", param);
	}
	
	public int selectMaxTitleOrd(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsRuleDAO.selectMaxTitleOrd", param);
	}

	public void insertTitle(Map<String, Object> param) {
		insert("KmsRuleDAO.insertTitle", param);
	}
	
	public void insertContent(Map<String, Object> param) {
		insert("KmsRuleDAO.insertContent", param);
	}
	
	public void insertHistory(Map<String, Object> param) {
		insert("KmsRuleDAO.insertHistory", param);
	}
	
	public void updateTitle(Map<String, Object> param) {
		update("KmsRuleDAO.updateTitle", param);
	}
	
	public void updateContent(Map<String, Object> param) {
		update("KmsRuleDAO.updateContent", param);
	}
	
}