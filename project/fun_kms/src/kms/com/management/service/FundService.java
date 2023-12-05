package kms.com.management.service;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalVO;

public interface FundService {

	Map<String, Object> selectFund(Map<String, Object> param) throws Exception;
	
	void insertFund(Map<String, Object> param) throws Exception;
	
	void updateFund(Map<String, Object> param) throws Exception;
	
	void deleteFund(Map<String, Object> param) throws Exception;
	
	void deleteFundByDocId(Map<String, Object> param) throws Exception;
	
	List selectFundListWeeklyDetail(Map<String, Object> param) throws Exception;
	
	List selectFundListWeekly(Map<String, Object> param) throws Exception;

	List selectFundListMonthly(Map<String, Object> param) throws Exception;
	
	List selectFundListYearly(Map<String, Object> param) throws Exception;
}
