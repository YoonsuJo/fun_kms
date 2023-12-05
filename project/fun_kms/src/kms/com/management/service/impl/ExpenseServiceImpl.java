package kms.com.management.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import kms.com.management.service.ExpenseDetail;
import kms.com.management.service.ExpenseService;
import kms.com.management.service.ExpenseVO;

@Service("KmsExpenseService")
public class ExpenseServiceImpl implements ExpenseService {
	
	@Resource(name="KmsExpenseDAO")
	private ExpenseDAO expDAO;

	@Override
	public Map<String, Object> selectExpenseList(ExpenseVO expenseVO)throws Exception {
		
		List<ExpenseVO> resultList = expDAO.selectExpenceList(expenseVO);
		
		ExpenseVO sumVO = new ExpenseVO();
		sumVO.setAccNm("합계");
		
		for (int i=0; i<resultList.size(); i++) {
			ExpenseVO tmp = resultList.get(i);
			
			sumVO.setExp01(sumVO.getExp01() + tmp.getExp01());
			sumVO.setExp02(sumVO.getExp02() + tmp.getExp02());
			sumVO.setExp03(sumVO.getExp03() + tmp.getExp03());
			sumVO.setExp04(sumVO.getExp04() + tmp.getExp04());
			sumVO.setExp05(sumVO.getExp05() + tmp.getExp05());
			sumVO.setExp06(sumVO.getExp06() + tmp.getExp06());
			sumVO.setExp07(sumVO.getExp07() + tmp.getExp07());
			sumVO.setExp08(sumVO.getExp08() + tmp.getExp08());
			sumVO.setExp09(sumVO.getExp09() + tmp.getExp09());
			sumVO.setExp10(sumVO.getExp10() + tmp.getExp10());
			sumVO.setExp11(sumVO.getExp11() + tmp.getExp11());
			sumVO.setExp12(sumVO.getExp12() + tmp.getExp12());
			sumVO.setSum(sumVO.getSum() + tmp.getSum());
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("resultList", resultList);
		result.put("sum", sumVO);
		
		return result;
	}

	@Override
	public List<ExpenseDetail> selectExpenseDetailList(ExpenseVO expenseVO) throws Exception {
		return expDAO.selectExpenseDetailList(expenseVO);
	}
	
	@Override
	public JSONObject selectExpenseDetail(ExpenseVO searchVO) throws Exception{
		//List<JSONObject> result = approvalDAO.selectExpenseList(searchVO);
		return expDAO.selectExpenseDetail(searchVO);
	}
	
	@Override
	public void updateExpenseDetailt(ExpenseVO expenseVO) throws Exception{
		expDAO.updateExpenseDetail(expenseVO);
	}

}
