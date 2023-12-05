package kms.com.support.service;

import java.util.List;
import java.util.Map;

public interface RuleService {
	List searchRuleList(Map<String, Object> param) throws Exception;
	List selectRuleList(Map<String, Object> param) throws Exception;
	Map<String, Object> selectRule(Map<String, Object> param) throws Exception;
	int insertRule(Map<String, Object> param) throws Exception;
	int updateRule(Map<String, Object> param) throws Exception;
	int updateRuleOrder(Map<String, Object> param) throws Exception;
	void updateRuleList(Map<String, Object> param) throws Exception;
	int deleteRule(Map<String, Object> param) throws Exception;
	int recoverRule(Map<String, Object> param) throws Exception;
	List selectRuleHistoryList(Map<String, Object> param) throws Exception;
	void sortRuleList() throws Exception;
}