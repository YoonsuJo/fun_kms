package kms.com.management.service;

import java.util.List;

public interface BusinessPlanService {

	List prjPlanCostList(PlanCostVO searchVO);

	List prjPlanCostDetailList(PlanCostVO searchVO);

	List annualBusinessPlan(PlanCostVO searchVO);

	PlanCostVO annualBusinessPlanSum(PlanCostVO searchVO);

	List selectBusinessPlanApp(PlanCostVO searchVO);

	PlanCostVO prjPlanCostSum(PlanCostVO searchVO);

}
