package kms.com.management.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kms.com.management.service.ExpenseDetail;
import kms.com.management.service.ExpenseService;
import kms.com.management.service.ExpenseVO;
import kms.com.management.service.BusinessPlanService;
import kms.com.management.service.PlanCostVO;

@Service("KmsBusinessPlanService")
public class BusinessPlanImpl implements BusinessPlanService {

	@Resource(name="KmsBusinessPlanDAO")
	private BusinessPlanDAO businessPlanDAO;
	
	@Override
	public List prjPlanCostList(PlanCostVO searchVO) {
		return businessPlanDAO.prjPlanCostList(searchVO);
		
	}

	@Override
	public List prjPlanCostDetailList(PlanCostVO searchVO) {
		return businessPlanDAO.prjPlanCostDetailList(searchVO);
	}

	@Override
	public List annualBusinessPlan(PlanCostVO searchVO) {
		return businessPlanDAO.annualBusinessPlan(searchVO);
	}

	@Override
	public PlanCostVO annualBusinessPlanSum(PlanCostVO searchVO) {
		return businessPlanDAO.annualBusinessPlanSum(searchVO);
	}

	@Override
	public List selectBusinessPlanApp(PlanCostVO searchVO) {
		return businessPlanDAO.selectBusinessPlanApp(searchVO);
	}

	@Override
	public PlanCostVO prjPlanCostSum(PlanCostVO searchVO) {
		return businessPlanDAO.prjPlanCostSum(searchVO);
	}
	
	

}
