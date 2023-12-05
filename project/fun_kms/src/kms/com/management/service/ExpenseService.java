package kms.com.management.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

public interface ExpenseService {

	Map<String, Object> selectExpenseList(ExpenseVO expenseVO) throws Exception;
	
	List<ExpenseDetail> selectExpenseDetailList(ExpenseVO expenseVO) throws Exception;
	
	JSONObject selectExpenseDetail(ExpenseVO expenseVO) throws Exception;
	
	void updateExpenseDetailt(ExpenseVO expenseVO) throws Exception;
}
