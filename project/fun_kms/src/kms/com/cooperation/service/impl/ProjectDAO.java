package kms.com.cooperation.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.admin.organ.service.Organ;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectVO;
import kms.com.fund.vo.BondCheckVO;
import kms.com.management.service.ProjectResultVO;
import kms.com.management.service.StepResultVO;




@Repository("KmsProjectDAO")
public class ProjectDAO extends EgovAbstractDAO {

	/** log */
	Logger logT = Logger.getLogger("TENY");


	public List projectOrganTree(ProjectVO projectVO) {		
		return list("KmsProjectDAO.projectOrganTree", projectVO);		
	}

	public int selectProjectCnt(ProjectVO searchVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectProjectCnt", searchVO);
	}

	public List selectProjectList(ProjectVO searchVO) {
		return list("KmsProjectDAO.selectProjectList",searchVO);
	}
	
	public List selectProjectListPaging(Map<String, Object> param) {
		return list("KmsProjectDAO.selectProjectListPaging",param);
	}
	
	public int selectProjectListPagingCnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectProjectListPagingCnt", param);
	}

	public ProjectVO selectProjectView(ProjectVO searchVO) {
		return (ProjectVO) selectByPk("KmsProjectDAO.selectProjectView",searchVO);
	}

	public void insertProject(ProjectVO projectVO) {
		insert("KmsProjectDAO.insertProject", projectVO);
		
	}

	public int selectNextPrjLv(ProjectVO projectVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectNextPrjLv",projectVO);
	}

	public void updateProject(ProjectVO projectVO) {
		update("KmsProjectDAO.updateProject", projectVO);
	}
	
	public void updateProjectEnd(ProjectVO projectVO) {
		update("KmsProjectDAO.updateProjectEnd", projectVO);
		
	}
	
	
	
	//2013.07.30
	//update 후에 BUDGET_PRJ 예산관리 프로젝트 업데이트
	public void updateBudgetPrj(ProjectVO projectVO) {
		update("KmsProjectDAO.updateBudgetPrj",projectVO);
	}
	
	//해당 프로젝트가 속한 최상위 프로젝트를 최상위 프로젝트로 하고 있는 모든 프로젝트의 orgnztId를 update시켜줌.
	public void updateOrgnztIdRecur(ProjectVO projectVO) {
		update("KmsProjectDAO.updateOrgnztIdRecur", projectVO);
		
	}

	public void updatePrntPrjId(ProjectVO projectVO) {
		update("KmsProjectDAO.updatePrntPrjId", projectVO);
		
	}

	public List selectProjectInput(ProjectInputVO projectInputVO) {
		return list("KmsProjectDAO.selectProjectInput", projectInputVO);
		
	}

	
	public List selectProjectInputForTransfer(ProjectVO projectVO) {
		return list("KmsProjectDAO.selectProjectInputForTransfer", projectVO);
		
	}
	
	public int selectUserPrjInputCnt(ProjectInputVO projectInputVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectUserPrjInputCnt",projectInputVO);
	}

	public void deleteProjectInputBatch(ProjectInputVO projectInputVO) {
		delete("KmsProjectDAO.deleteProjectInputBatch", projectInputVO);
		
	}

	public void insertProjectInput(ProjectInputVO vo) {
		insert("KmsProjectDAO.insertProjectInput",vo);
		
	}

	public void updatePrntPrjStatRecur(ProjectVO projectVO) {
		update("KmsProjectDAO.updatePrntPrjStatRecur",projectVO);
		
	}

	public void updateChildPrjStatRecur(ProjectVO projectVO) {
		update("KmsProjectDAO.updateChildPrjStatRecur",projectVO);
		
	}

	public void updatePrjCd(ProjectVO projectVO) {
		update("KmsProjectDAO.updatePrjCd",projectVO);
		
	}

	public void incrPrntPrjCurMaxPrjCd(ProjectVO projectVO) {
		update("KmsProjectDAO.incrPrntPrjCurMaxPrjCd",projectVO);
		
	}

	public void incrOrgnztCurMaxPrjCd(ProjectVO projectVO) {
		update("KmsProjectDAO.incrOrgnztCurMaxPrjCd",projectVO);
		
	}

	/**
	 * @param projectVO
	 * 해당 프로젝트 및 하위 프로젝트의 cd값 업데이트
	 */
	public void updatePrjCdRecur(ProjectVO projectVO) {
		update("KmsProjectDAO.updatePrjCdRecur",projectVO);
		
	}

	public int selectPrjInputCnt(ProjectInputVO projectInputVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectPrjInputCnt",projectInputVO);
	}

	public int selectDefaultPrjCnt(ProjectVO searchVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectDefaultPrjCnt", searchVO);
	}

	public int selectPresetPrjCnt(ProjectVO searchVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectPresetPrjCnt", searchVO);
	}

	public void insertPrntPrjInput(ProjectVO projectVO) {
		insert("KmsProjectDAO.insertPrntPrjInput", projectVO);
	}

	public EgovMap selectPrjInputMaxUser(ProjectInputVO projectInputVO) {
		return (EgovMap)selectByPk("KmsProjectDAO.selectPrjInputMaxUser", projectInputVO);
		
	}

	public List<StepResultVO> selectProjectMonthlyReport(ProjectVO searchVO) {
		return (List<StepResultVO>) list("KmsProjectDAO.selectProjectMonthlyReport", searchVO);
	}
	
	/**
	 * 전년도 실적 합계 가져오기
	 */
	public StepResultVO selectProjectMonthlyReportPreSum(ProjectVO searchVO) {
		return (StepResultVO) selectByPk("KmsProjectDAO.selectProjectMonthlyReportPreSum", searchVO);
	}

	public int selectPrjAuth(ProjectVO searchVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectPrjAuth", searchVO);
	}

	public String selectPrjAuth2(ProjectVO searchVO) {
		return (String)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectPrjAuth2", searchVO);
	}

	public List selectProjectUserIncluded(ProjectVO searchVO) {
		return list("KmsProjectDAO.selectProjectUserIncluded",searchVO);
	}

	public void updatePrjTree(ProjectVO projectVO) {
		update("KmsProjectDAO.updatePrjTree",projectVO);
		
	}

	public void updatePrjTreeByOrg(Organ organ) {
		update("KmsProjectDAO.updatePrjTreeByOrg",organ);
	}

	public List<EgovMap> selectProjectListForDelete(Map<String, Object> param) {
		return list("KmsProjectDAO.selectProjectListForDelete",param);
	}

	public void deleteProject(Map<String, Object> param) {
		delete("KmsProjectDAO.deleteProject",param);
	}
	
	public void deleteProjectResTotal(Map<String, Object> param) {
		delete("KmsProjectDAO.deleteProjectResTotal",param);
	}
	
	public int selectPrjInterestCnt(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectPrjInterestCnt", param);
	}
	
	public void insertPrjInterest(Map<String, Object> param) {
		insert("KmsProjectDAO.insertPrjInterest",param);
	}
	
	public void deletePrjInterest(Map<String, Object> param) {
		delete("KmsProjectDAO.deletePrjInterest",param);
	}

	public List selectProjectDetailList(ProjectVO searchVO) {
		return list("KmsProjectDAO.selectProjectDetailList",searchVO);
	}

	public List selectProjectRowCnt(ProjectVO searchVO) {
		return list("KmsProjectDAO.selectProjectRowCnt",searchVO);
	}
	
	
	
	
	
	public int selectUnderPrjDataCnt(ProjectVO projectVO) {
		// TODO Auto-generated method stub
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectUnderPrjDataCnt", projectVO);
	}
	
	

	
	//프로젝트 데이터 이동
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateTransferPrj(ProjectVO projectVO) throws Exception {
		update("KmsProjectDAO.update_comtnbbs", projectVO);
		update("KmsProjectDAO.update_tbl_bond_prj", projectVO);
		update("KmsProjectDAO.update_tbl_business_contact", projectVO);
		update("KmsProjectDAO.update_tbl_career", projectVO);
		update("KmsProjectDAO.update_tbl_contract", projectVO);
		update("KmsProjectDAO.update_tbl_eapp_budget_allocate2", projectVO);
		update("KmsProjectDAO.update_tbl_eapp_doc", projectVO);
		update("KmsProjectDAO.update_tbl_eapp_exp", projectVO);
		update("KmsProjectDAO.update_tbl_eapp_gen_sales", projectVO);	
		update("KmsProjectDAO.update_tbl_eapp_hol", projectVO);
		
		update("KmsProjectDAO.update_tbl_eapp_sales_in_sales_prj_id", projectVO);
		update("KmsProjectDAO.update_tbl_eapp_sales_in_purchase_prj_id", projectVO);
		
		update("KmsProjectDAO.update_tbl_eapp_preset", projectVO);
		
		update("KmsProjectDAO.update_tbl_eapp_tot_sales_sales_prj_id", projectVO);
		update("KmsProjectDAO.update_tbl_eapp_tot_sales_purchase_prj_id", projectVO);
		
		update("KmsProjectDAO.update_tbl_fund", projectVO);
		update("KmsProjectDAO.update_tbl_meeting_room", projectVO);
		update("KmsProjectDAO.update_tbl_plan_exp", projectVO);
		update("KmsProjectDAO.update_tbl_plan_labor", projectVO);
		if(projectVO.getPrjInputNoL() != null){
			if(projectVO.getPrjInputNoL().length > 0){
			delete("KmsProjectDAO.delete_tbl_prj_input", projectVO); //중복된 투입인력 삭제
			}
		}
		update("KmsProjectDAO.update_tbl_prj_input", projectVO);
		
		update("KmsProjectDAO.update_tbl_prj_input_plan", projectVO);
		update("KmsProjectDAO.update_tbl_prj_interest", projectVO);
		//update("KmsProjectDAO.update_tbl_prj_result_total", projectVO); // 2014-03-18 PK인 ID가 변경되지 않고 남아서 전일집계 할 때 중복 데이터 발생	
		delete("KmsProjectDAO.delete_tbl_prj_result_total", projectVO); // 전일집계 데이터는 삭제하도록 변경
		
		update("KmsProjectDAO.update_tbl_purchase_in_sales_prj_id", projectVO);
		update("KmsProjectDAO.update_tbl_purchase_in_purchase_prj_id", projectVO);
		
		update("KmsProjectDAO.update_tbl_purchase_in_labor_sales_prj_id", projectVO);
		update("KmsProjectDAO.update_tbl_purchase_in_labor_purchase_prj_id", projectVO);
		
		update("KmsProjectDAO.update_tbl_purchase_out", projectVO);
		update("KmsProjectDAO.update_tbl_sales", projectVO);
		update("KmsProjectDAO.update_tbl_stock", projectVO);
		update("KmsProjectDAO.update_tbl_stock_history", projectVO);
		update("KmsProjectDAO.update_tbl_task", projectVO);		
	}

	
	/**
	 * 하위 프로젝트 시작일, 종료일 가져오기
	 */
	public HashMap<String, String> selectChildDate(String prjId) {
		return (HashMap<String, String>)selectByPk("KmsProjectDAO.selectChildDate", prjId);
	}

	/**
	 * ajax로 프로젝트 정보(타입 및 PL정보) 가져오기
	 */
	public List<JSONObject> selectProjectInfo(String prjId) {
		return (List<JSONObject>) list("KmsProjectDAO.selectProjectInfo", prjId);
	}
	
	/**
	 * ajax로 프로젝트 정보(현재 매출이관 보고서 결재 진행중인지) 가져오기
	 */
	public List<JSONObject> selectProjectInfoProgress(String prjId) {
		return (List<JSONObject>) list("KmsProjectDAO.selectProjectInfoProgress", prjId);
	}
	
	/**
	 * ajax로 프로젝트 정보(매출이관보고서 최종 전결승인일과 오늘과의 차이값) 가져오기
	 */
	public List<JSONObject> getTransApprovalDateDiff(String prjId) {
		return (List<JSONObject>) list("KmsProjectDAO.getTransApprovalDateDiff", prjId);
	}
	
	/**
	 * 프로젝트에 걸려있는 미수금 정보 체크
	 */
	public int selectReceivablePrjCnt(ProjectVO searchVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectReceivablePrjCnt", searchVO);
	}
	
	public List selectSalesProjectList(ProjectVO searchVO) {
		return list("KmsProjectDAO.selectSalesProjectList",searchVO);
	}
	
	public int selectSalesProjectCnt(ProjectVO searchVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectSalesProjectCnt", searchVO);
	}
	
	public void updateProjectLastReport(ProjectVO projectVO) {
		update("KmsProjectDAO.updateProjectLastReport", projectVO);
	}
	
	public List selectPrntPrjList(ProjectVO searchVO) {
		return list("KmsProjectDAO.selectPrntPrjList",searchVO);
	}
	
	public String selectPrntPrjListCnt(ProjectVO searchVO) {
		return (String)getSqlMapClientTemplate().queryForObject("KmsProjectDAO.selectPrntPrjListCnt", searchVO);
	}
	
	public List<JSONObject> selectPrntPrj(ProjectVO searchVO) {
		return (List<JSONObject>) list("KmsProjectDAO.selectPrntPrj", searchVO);
	}
}
