package kms.com.management.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kms.com.management.service.BusinessResultService;
import kms.com.management.service.MonthResultVO;
import kms.com.management.service.PlanResultVO;
import kms.com.management.service.ProjectResultVO;
import kms.com.management.service.StepResultVO;

@Service("KmsBusinessResultService")
public class BusinessResultServiceImpl implements BusinessResultService {
	
	@Resource(name = "KmsBusinessResultDAO")
	BusinessResultDAO brDAO;

	@Override
	public List<StepResultVO> selectStepResultStatistic(StepResultVO brVO, boolean reCalc) throws Exception {
		return brDAO.selectStepResultStatistic(brVO, reCalc);
	}
	@Override
	public StepResultVO selectStepResultStatisticRow(StepResultVO brVO) throws Exception {
		return brDAO.selectStepResultStatisticRow(brVO);
	}

	@Override
	public Map<String, Object> selectPlanResultStatisticPreview(PlanResultVO prVO) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<PlanResultVO> resultList = brDAO.selectPlanResultStatisticPreview(prVO);
		
		PlanResultVO sum = new PlanResultVO();
		
		for (int i=0; i<resultList.size(); i++) {
			PlanResultVO tmp = resultList.get(i);
			if (tmp.isHavingLeaf() == false) {
				sum.setSalaryPlan(sum.getSalaryPlan() + tmp.getSalaryPlan());
				sum.setExpensePlan(sum.getExpensePlan() + tmp.getExpensePlan());
				sum.setExpense(sum.getExpense() + tmp.getExpense());
				sum.setSalaryPlanAcc(sum.getSalaryPlanAcc() + tmp.getSalaryPlanAcc());
				sum.setExpensePlanAcc(sum.getExpensePlanAcc() + tmp.getExpensePlanAcc());
				sum.setExpenseAcc(sum.getExpenseAcc() + tmp.getExpenseAcc());
			}
		}
		
		result.put("resultList", resultList);
		result.put("sum", sum);
		
		return result;
	}
	@Override
	public PlanResultVO selectPlanResultStatistic(PlanResultVO prVO) throws Exception {
		return brDAO.selectPlanResultStatistic(prVO);
	}
	@Override
	public PlanResultVO selectPlanResultOrgSumStatistic(PlanResultVO prVO) throws Exception {
		return brDAO.selectPlanResultOrgSumStatistic(prVO);
	}
	

	@Override
	public Map<String, Object> selectProjectResultStatistic(ProjectResultVO prVO, boolean reCalc) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<ProjectResultVO> resultList = brDAO.selectProjectResultStatistic(prVO, reCalc);
		
		ProjectResultVO sum = new ProjectResultVO();		
		for (int i=0; i<resultList.size(); i++) {
			ProjectResultVO tmp = resultList.get(i);
			if (tmp.isHavingLeaf() == false) {
				
				sum.setSalesOut(sum.getSalesOut() + tmp.getSalesOut());
				sum.setSalesIn(sum.getSalesIn() + tmp.getSalesIn());
				sum.setPurchaseOut(sum.getPurchaseOut() + tmp.getPurchaseOut());
				sum.setPurchaseIn(sum.getPurchaseIn() + tmp.getPurchaseIn());
				sum.setSalary(sum.getSalary() + tmp.getSalary());
				sum.setExpense(sum.getExpense() + tmp.getExpense());
				
				sum.setSalesOutAcc(sum.getSalesOutAcc() + tmp.getSalesOutAcc());
				sum.setSalesInAcc(sum.getSalesInAcc() + tmp.getSalesInAcc());
				sum.setPurchaseOutAcc(sum.getPurchaseOutAcc() + tmp.getPurchaseOutAcc());
				sum.setPurchaseInAcc(sum.getPurchaseInAcc() + tmp.getPurchaseInAcc());
				sum.setSalaryAcc(sum.getSalaryAcc() + tmp.getSalaryAcc());
				sum.setExpenseAcc(sum.getExpenseAcc() + tmp.getExpenseAcc());
			}
		}		
		result.put("resultList", resultList);
		result.put("sum", sum);
		
		return result;
	}

	@Override
	public ProjectResultVO selectProjectResultStatisticRow(ProjectResultVO prVO) throws Exception {
		return brDAO.selectProjectResultStatisticRow(prVO);
	}
	@Override
	public ProjectResultVO selectProjectResultOrgSumStatistic(ProjectResultVO prVO) throws Exception {
		return brDAO.selectProjectResultOrgSumStatistic(prVO);
	}

	@Override
	public MonthResultVO selectMonthResultStatistic(MonthResultVO mrVO, boolean reCalc) throws Exception {
		return brDAO.selectMonthResultStatistic(mrVO, reCalc);
	}
	
	@Override
	public List<ProjectResultVO> selectSaleResultStatistic(ProjectResultVO prVO, boolean reCalc) throws Exception {
		return brDAO.selectSaleResultStatistic(prVO, reCalc);
	}
	@Override
	public List<ProjectResultVO> selectPerfResultStatistic(ProjectResultVO prVO, boolean reCalc) throws Exception {
		return brDAO.selectPerfResultStatistic(prVO, reCalc);
	}
	@Override
	public List<ProjectResultVO> selectCommResultStatistic(ProjectResultVO prVO, boolean reCalc) throws Exception {
		return brDAO.selectCommResultStatistic(prVO, reCalc);
	}
	
	@Override
	public ProjectResultVO selectLaborResultStatistic(ProjectResultVO prVO) throws Exception {
		return brDAO.selectLaborResultStatistic(prVO);
	}
	@Override
	public ProjectResultVO selectCommLaborResultStatistic(ProjectResultVO prVO)
			throws Exception {
		return brDAO.selectCommLaborResultStatistic(prVO);
	}

	@Override
	public String updateStatistic(String updateYear, String updateMonth) throws Exception {
		return brDAO.updateStatistic(updateYear, updateMonth);
	}
	
	@Override
	public String updateStatisticDate(String updateYear, String updateMonth) throws Exception {
		return brDAO.updateStatisticDate(updateYear, updateMonth);
	}
	@Override
	public String updateStatisticDate(String prjId) throws Exception {
		return brDAO.updateStatisticDate(prjId);

	}

}
