package kms.com.cooperation.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

import kms.com.admin.organ.service.Organ;
import kms.com.management.service.StepResultVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface ProjectService {

	List projectOrganTree(ProjectVO projectVO);

	List selectProjectList(ProjectVO searchVO);

	List selectProjectListPaging(Map<String, Object> param);

	int selectProjectListPagingCnt(Map<String, Object> param);

	int selectProjectCnt(ProjectVO searchVO);

	ProjectVO selectProjectView(ProjectVO searchVO);

	void insertProject(ProjectVO projectVO);

	int selectNextPrjLv(ProjectVO projectVO);

	void updateProject(ProjectVO projectVO);

	//2013.07.30
	//update 후에 BUDGET_PRJ 예산관리 프로젝트 업데이트
	void updateBudgetPrj(ProjectVO projectVO);
	
	void updateProjectEnd(ProjectVO projectVO);

	void updatePrntPrjId(ProjectVO projectVO);

	List selectProjectInput(ProjectInputVO projectInputVO);

	int selectUserPrjInputCnt(ProjectInputVO projectInputVO);

	void updateProjectInput(ProjectInputVO projectInputVO);

	void moveProjectU(ProjectVO projectVO);
	
	int selectUnderPrjDataCnt(ProjectVO projectVO);
	void transferProjectU(ProjectVO projectVO) throws Exception;
	

	int selectPrjInputCnt(ProjectInputVO projectInputVO);

	int selectDefaultPrjCnt(ProjectVO searchVO);

	int selectPresetPrjCnt(ProjectVO searchVO);

	void insertPrntPrjInput(ProjectVO projectVO);

	EgovMap selectPrjInputMaxUser(ProjectInputVO projectInputVO);

	List<StepResultVO> selectProjectMonthlyReport(ProjectVO searchVO);
	
	/**
	 * 전년도 실적 합계 가져오기
	 */
	StepResultVO selectProjectMonthlyReportPreSum(ProjectVO searchVO);

	int selectPrjAuth(ProjectVO searchVO);
	
	String selectPrjAuth2(ProjectVO searchVO);

	List selectProjectUserIncluded(ProjectVO searchVO);

	void updatePrjTree(ProjectVO projectVO);

	void updatePrjTreeByOrg(Organ organ);

	List<EgovMap> selectProjectListForDelete(Map<String, Object> param);
	
	void deleteProject(Map<String, Object> param);
	
	void deleteProjectResTotal(Map<String, Object> param);
	
	void switchPrjInterest(Map<String, Object> param);
	
	List selectProjectDetailList(ProjectVO searchVO);

	List selectProjectRowCnt(ProjectVO searchVO);

	List selectProjectInputForTransfer(ProjectVO projectVO);

	/** 상,하위 프로젝트 시작일, 종료일 가져오기 */
	HashMap<String, String> selectStartCompDate(ProjectVO projectVO);
	
	/** 하위 프로젝트 시작일, 종료일 가져오기*/
	HashMap<String, String> selectChildDate(String prjId);
	
	/** ajax로 프로젝트 정보(타입 및 PL정보) 가져오기 */
	JSONObject selectProjectInfo(String prjId);
	
	/** ajax로 프로젝트 정보(현재 매출이관 보고서 결재 진행중인지) 가져오기 */
	JSONObject selectProjectInfoProgress(String prjId);
	
	/** ajax로 프로젝트 정보(매출이관보고서 최종 전결승인일과 오늘과의 차이값) 가져오기 */
	JSONObject getTransApprovalDateDiff(String prjId);

	/** 프로젝트에 걸려있는 미수금 정보 체크 */
	int selectReceivablePrjCnt(ProjectVO searchVO);
	
	/** 영업건 프로젝트 조회 */
	List<ProjectVO> selectSalesProjectList(ProjectVO searchVO);
	int selectSalesProjectCnt(ProjectVO searchVO);
	
	/** ajax로 상위 프로젝트 정보 가져오기 */
	List<EgovMap> selectPrntPrjList(ProjectVO searchVO);
	String selectPrntPrjListCnt(ProjectVO searchVO);
	JSONObject selectPrntPrj(ProjectVO searchVO);
 }
