package kms.com.management.service.impl;

import java.util.List;

import kms.com.app.service.AccountVO;
import kms.com.management.service.ExpenseDetail;
import kms.com.management.service.ExpenseVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsExpenseDAO")
public class ExpenseDAO extends EgovAbstractDAO {

	public List<ExpenseVO> selectExpenceList(ExpenseVO expenseVO) {
		return list("ExpenseDAO.selectExpenseStatistic", expenseVO);
	}

	public List<ExpenseDetail> selectExpenseDetailList(ExpenseVO expenseVO) {
		return list("ExpenseDAO.selectExpenseDetailList", expenseVO);
	}
	
	public JSONObject selectExpenseDetail(ExpenseVO expenseVO) {		
		return (JSONObject) selectByPk("ExpenseDAO.selectExpenseDetail", expenseVO);
		//JSONArray expenseArray = new JSONArray();
		//List expenseListJ =  (List<JSONObject>) list("ApprovalDAO.selectExpenseList", searchVO);
		//expenseArray.addAll(expenseListJ);
		//return expenseArray;
	}
	
	public void updateExpenseDetail(ExpenseVO expenseVO) {		
		update("ExpenseDAO.updateExpenseDetail", expenseVO);
	}

}
