package kms.com.management.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import kms.com.management.service.MonthResultVO;
import kms.com.management.service.PlanResultVO;
import kms.com.management.service.ProjectResultVO;
import kms.com.management.service.StepResultVO;
import kms.com.common.utils.CommonUtil;
import kms.com.daily.vo.DailyPlanVO;
import kms.com.management.vo.BizStatisticVO;


@Repository("KmsBusinessResultDAO")
public class BusinessResultDAO extends EgovAbstractDAO {
	Logger logT = Logger.getLogger("TENY");

	public List<StepResultVO> selectStepResultStatistic(StepResultVO brVO, boolean reCalc) {
		if (reCalc) {
			return list("BusiResultDAO.selectStepResultStatisticPreview_reCalc", brVO);
		}
		else {
			return list("BusiResultDAO.selectStepResultStatistic", brVO);
		}
	}
	public StepResultVO selectStepResultStatisticRow(StepResultVO brVO) {
		return (StepResultVO)getSqlMapClientTemplate().queryForObject("BusiResultDAO.selectStepResultStatisticRow_reCalc", brVO);
	}
	public List<PlanResultVO> selectPlanResultStatisticPreview(PlanResultVO prVO) {
		return list("BusiResultDAO.selectPlanResultStatisticPreview", prVO);
	}
	public PlanResultVO selectPlanResultStatistic(PlanResultVO prVO) {
		return (PlanResultVO)getSqlMapClientTemplate().queryForObject("BusiResultDAO.selectPlanResultStatistic", prVO);
	}
	public PlanResultVO selectPlanResultOrgSumStatistic(PlanResultVO prVO) {
		return (PlanResultVO)getSqlMapClientTemplate().queryForObject("BusiResultDAO.selectPlanResultOrgSumStatistic", prVO);
	}
	public List<ProjectResultVO> selectProjectResultStatistic(ProjectResultVO prVO, boolean reCalc) {
		if (reCalc) {
			return list("BusiResultDAO.selectProjectResultStatisticPreview_reCalc", prVO);
		}
		else {
			return list("BusiResultDAO.selectProjectResultStatistic", prVO);
		}
	}
	public ProjectResultVO selectProjectResultStatisticRow(ProjectResultVO prVO) {
		return (ProjectResultVO)getSqlMapClientTemplate().queryForObject("BusiResultDAO.selectProjectResultStatisticRow_reCalc", prVO);
	}
	public ProjectResultVO selectProjectResultOrgSumStatistic(ProjectResultVO prVO) {
		return (ProjectResultVO)getSqlMapClientTemplate().queryForObject("BusiResultDAO.selectProjectResultOrgSumStatistic_reCalc", prVO);
	}
	public MonthResultVO selectMonthResultStatistic(MonthResultVO mrVO, boolean reCalc) {
		if (reCalc) {
			return (MonthResultVO)selectByPk("BusiResultDAO.selectMonthResultStatistic_reCalc", mrVO);
		}
		else {
			return (MonthResultVO)selectByPk("BusiResultDAO.selectMonthResultStatistic", mrVO);
		}
	}
	public List<ProjectResultVO> selectSaleResultStatistic(ProjectResultVO prVO, boolean reCalc) {
		if (reCalc) {
			return list("BusiResultDAO.selectSaleResultStatistic_reCalc", prVO);
		}
		else {
			return list("BusiResultDAO.selectSaleResultStatistic", prVO);
		}
	}
	public List<ProjectResultVO> selectPerfResultStatistic(ProjectResultVO prVO, boolean reCalc) {
		if (reCalc) {
			return list("BusiResultDAO.selectPerfResultStatistic_reCalc", prVO);
		}
		else {
			return list("BusiResultDAO.selectPerfResultStatistic", prVO);
		}
	}
	public List<ProjectResultVO> selectCommResultStatistic(ProjectResultVO prVO, boolean reCalc) {
		if (reCalc) {
			return list("BusiResultDAO.selectCommResultStatistic_reCalc", prVO);
		}
		else {
			return list("BusiResultDAO.selectCommResultStatistic", prVO);
		}
	}
	public ProjectResultVO selectLaborResultStatistic(ProjectResultVO prVO) {
		return (ProjectResultVO)getSqlMapClientTemplate().queryForObject("BusiResultDAO.selectLaborResultStatistic_reCalc", prVO);
	}
	public ProjectResultVO selectCommLaborResultStatistic(ProjectResultVO prVO) {
		return (ProjectResultVO)getSqlMapClientTemplate().queryForObject("BusiResultDAO.selectCommLaborResultStatistic_reCalc", prVO);
	}
	
	
	public String updateStatistic(String updateYear, String updateMonth) {
		java.util.Map<String, Object> paramMap = new java.util.HashMap<String, Object>();
		paramMap.put("updateYear", updateYear);
		paramMap.put("updateMonth", updateMonth);
		
		getSqlMapClientTemplate().insert("BusiResultDAO.updateRestotalAll", paramMap);
		getSqlMapClientTemplate().insert("BusiResultDAO.updateRestotalAll2", paramMap);
		
		return "success";
	}
	
	public String updateStatisticDate(String updateYear, String updateMonth) {
		java.util.Map<String, Object> paramMap = new java.util.HashMap<String, Object>();
		paramMap.put("updateYear", updateYear);
		paramMap.put("updateMonth", updateMonth);
		
		getSqlMapClientTemplate().insert("BusiResultDAO.updateStatisticDate", paramMap);
		getSqlMapClientTemplate().insert("BusiResultDAO.updateStatisticDate2", paramMap);
		
		return "success";
	}
	
	public String updateStatisticDate(String prjId) {
		java.util.Map<String, Object> paramMap = new java.util.HashMap<String, Object>();
		paramMap.put("prjId", prjId);
		
		getSqlMapClientTemplate().insert("BusiResultDAO.updateStatisticDatePrj", paramMap);
		getSqlMapClientTemplate().insert("BusiResultDAO.updateStatisticDatePrj2", paramMap);
		
		return "success";
	}

	public BizStatisticVO selectBizStatisticPlan(String searchYM, String searchOrgnztIdList, String operationOrgnztId) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		map.put("searchOperationOrgnztId", operationOrgnztId);
		
		BizStatisticVO vo = (BizStatisticVO)selectByPk("BusiResultDAO.selectBizStatisticPlan", map);
		if(vo == null){
			logT.debug("fail to find row");
		}
		return vo;
	}
	
	public BizStatisticVO selectBizStatisticPlanSum(String searchYM, String searchOrgnztIdList, String operationOrgnztId) throws Exception {
		String searchYMFrom = searchYM.substring(0, 4) + "00";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYMFrom", searchYMFrom);
		map.put("searchYMTo", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		map.put("searchOperationOrgnztId", operationOrgnztId);

		BizStatisticVO vo = (BizStatisticVO)selectByPk("BusiResultDAO.selectBizStatisticPlan", map);
		if(vo == null){
			logT.debug("fail to find row");
		}
		return vo;
	}

	public BizStatisticVO selectBizStatisticResult(String searchYM, String searchOrgnztIdList, String operationOrgnztId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		map.put("searchOperationOrgnztId", operationOrgnztId);

		BizStatisticVO vo = (BizStatisticVO)selectByPk("BusiResultDAO.selectBizStatisticResult", map);
		if(vo == null){
			logT.debug("fail to find row");
		}
		return vo;
	}
	
	public BizStatisticVO selectBizStatisticResultSum(String searchYM, String searchOrgnztIdList, String operationOrgnztId) throws Exception {
		String searchYMFrom = searchYM.substring(0, 4) + "00";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYMFrom", searchYMFrom);
		map.put("searchYMTo", searchYM);
		map.put("searchYMSum", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));
		map.put("searchOperationOrgnztId", operationOrgnztId);

		BizStatisticVO vo = (BizStatisticVO)selectByPk("BusiResultDAO.selectBizStatisticResult", map);
		if(vo == null){
			logT.debug("fail to find row");
		}
		return vo;
	}

	public BizStatisticVO selectBizStatisticResultExp(String searchYM, String searchOrgnztIdList) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchYM", searchYM);
		map.put("searchOrgnztIdList", CommonUtil.makeValidIdList(searchOrgnztIdList));

		BizStatisticVO vo = (BizStatisticVO)selectByPk("BusiResultDAO.selectBizStatisticResult", map);
		if(vo == null){
			logT.debug("fail to find row");
		}
		return vo;
	}
}
