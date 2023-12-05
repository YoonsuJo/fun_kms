package kms.com.management.service;

import java.util.List;
import java.util.Map;


public interface BusinessResultService {

	List<StepResultVO> selectStepResultStatistic(StepResultVO brVO, boolean reCalc) throws Exception;
	StepResultVO selectStepResultStatisticRow(StepResultVO brVO) throws Exception;
	
	Map<String, Object> selectPlanResultStatisticPreview(PlanResultVO prVO) throws Exception;
	PlanResultVO selectPlanResultStatistic(PlanResultVO prVO) throws Exception;
	PlanResultVO selectPlanResultOrgSumStatistic(PlanResultVO prVO) throws Exception;
	
	Map<String, Object> selectProjectResultStatistic(ProjectResultVO prVO, boolean reCalc) throws Exception;
	ProjectResultVO selectProjectResultStatisticRow(ProjectResultVO prVO) throws Exception;
	ProjectResultVO selectProjectResultOrgSumStatistic(ProjectResultVO prVO) throws Exception;
	
	MonthResultVO selectMonthResultStatistic(MonthResultVO mrVO, boolean reCalc) throws Exception;

	List<ProjectResultVO> selectSaleResultStatistic(ProjectResultVO prVO, boolean reCalc) throws Exception;
	List<ProjectResultVO> selectPerfResultStatistic(ProjectResultVO prVO, boolean reCalc) throws Exception;
	List<ProjectResultVO> selectCommResultStatistic(ProjectResultVO prVO, boolean reCalc) throws Exception;
	
	ProjectResultVO selectLaborResultStatistic(ProjectResultVO prVO) throws Exception;
	ProjectResultVO selectCommLaborResultStatistic(ProjectResultVO prVO) throws Exception;

	String updateStatistic(String updateYear, String updateMonth) throws Exception;
	/**
	 * 프로젝트 기간 변경시, 집계테이블에도 변경토록 적용하는 프로시져(전체 프로젝트 대상)
	 */
	String updateStatisticDate(String updateYear, String updateMonth) throws Exception;
	/**
	 * 프로젝트 기간 변경시, 집계테이블에도 변경토록 적용하는 프로시져(1개 프로젝트 대상)
	 */
	String updateStatisticDate(String prjId) throws Exception;
}
