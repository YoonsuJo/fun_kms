package kms.com.management.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalVO;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.PlanCostVO;
import kms.com.management.service.SalesVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsFundDAO")
public class FundDAO extends EgovAbstractDAO{

	public Map<String, Object> selectFund(Map<String, Object> param) {
		return (Map<String, Object>) selectByPk("KmsFundDAO.selectFund", param);
	}
	
	public void insertFund(Map<String, Object> param) {
		insert("KmsFundDAO.insertFund", param);
	}
	
	public void updateFund(Map<String, Object> param) {
		insert("KmsFundDAO.updateFund", param);
	}
	
	public void deleteFund(Map<String, Object> param) {
		insert("KmsFundDAO.deleteFund", param);
	}
	
	public void deleteFundByDocId(Map<String, Object> param) {
		insert("KmsFundDAO.deleteFundByDocId", param);
	}

	public List selectFundWeeklyDetail(Map<String, Object> param) {
		return (List) list("KmsFundDAO.selectFundWeeklyDetail", param);
	}
	
	public List selectFundWeekly(Map<String, Object> param) {
		return (List) list("KmsFundDAO.selectFundWeekly", param);
	}
	
	public List selectFundMonthly(Map<String, Object> param) {
		return (List) list("KmsFundDAO.selectFundMonthly", param);
	}

	public List selectFundYearly(Map<String, Object> param) {
		return null;
		//return (List) list("KmsFundDAO.selectFundYearly", param);
	}
}
