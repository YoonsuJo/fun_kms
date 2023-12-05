package kms.com.management.service.impl;

import java.util.List;

import kms.com.management.service.PlanCostVO;
import kms.com.management.service.PlanResultVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsBusinessPlanDAO")
public class BusinessPlanDAO extends EgovAbstractDAO {

	public List prjPlanCostList(PlanCostVO searchVO) {
		return list("BusinessPlanDAO.prjPlanCostList", searchVO);
		
	}

	public List prjPlanCostDetailList(PlanCostVO searchVO) {
		return list("BusinessPlanDAO.prjPlanCostDetailList", searchVO);
	}

	public List annualBusinessPlan(PlanCostVO searchVO) {
		return list("BusinessPlanDAO.annualBusinessPlan", searchVO);
	}

	public PlanCostVO annualBusinessPlanSum(PlanCostVO searchVO) {
		return (PlanCostVO)getSqlMapClientTemplate().queryForObject("BusinessPlanDAO.annualBusinessPlanSum", searchVO);
	}

	public List selectBusinessPlanApp(PlanCostVO searchVO) {
		return list("BusinessPlanDAO.selectBusinessPlanApp", searchVO);
	}

	public PlanCostVO prjPlanCostSum(PlanCostVO searchVO) {
		return (PlanCostVO)getSqlMapClientTemplate().queryForObject("BusinessPlanDAO.prjPlanCostSum", searchVO);
	}

}
