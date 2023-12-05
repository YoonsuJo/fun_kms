package kms.com.cooperation.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.admin.organ.service.Organ;
import kms.com.common.utils.CommonUtil;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.ProjectVO;
import kms.com.management.service.ProjectResultVO;
import kms.com.management.service.StepResultVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Service("projectService")
public class ProjectServiceImpl extends AbstractServiceImpl implements
	ProjectService {

    @Resource(name="KmsProjectDAO")
    private ProjectDAO projectDAO;

	@Override
	public List projectOrganTree(ProjectVO projectVO) {
		return projectDAO.projectOrganTree(projectVO);
		
	}

	@Override
	public int selectProjectCnt(ProjectVO searchVO) {
		return projectDAO.selectProjectCnt(searchVO);
	}

	@Override
	public List selectProjectList(ProjectVO searchVO) {
		searchVO.setSearchOrgnztIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgnztId()));
		return projectDAO.selectProjectList(searchVO);
	}
	
	@Override
	public List selectProjectListPaging(Map<String, Object> param) {
		return projectDAO.selectProjectListPaging(param);
	}
	
	@Override
	public int selectProjectListPagingCnt(Map<String, Object> param) {
		return projectDAO.selectProjectListPagingCnt(param);
	}

	@Override
	public ProjectVO selectProjectView(ProjectVO searchVO) {
		return projectDAO.selectProjectView(searchVO);
	}

	@Override
	public void insertProject(ProjectVO projectVO) {
		projectDAO.insertProject(projectVO);
		//상위 프로젝트의 CUR_MAX_PRJ_CD값을 상승
		//projCd값 생성
		if("M".equals(projectVO.getType()) )
			projectDAO.incrOrgnztCurMaxPrjCd(projectVO);
		else
			projectDAO.incrPrntPrjCurMaxPrjCd(projectVO);
		projectDAO.updatePrjCd(projectVO);		
	}

	@Override
	public int selectNextPrjLv(ProjectVO projectVO) {
		return projectDAO.selectNextPrjLv(projectVO);
	}

	@Override
	public void updateProject(ProjectVO projectVO) {
		ProjectVO beforePrjVO = projectDAO.selectProjectView(projectVO);
		if(!beforePrjVO.getStat().equals(projectVO.getStat()) ) {
			//진행중으로 바꿀경우 상위 프로젝트들을 모두 진행으로 교체
			if(projectVO.getStat().equals("P"))	{
				projectDAO.updatePrntPrjStatRecur(projectVO);
			}
			//중단, 종료로 변경시 하위 프로젝트 중 진행인 것들을 중단, 종료로 변경 
			else {
				projectDAO.updateChildPrjStatRecur(projectVO);
			}			
		}		
		projectDAO.updateProject(projectVO);		
	}

	
	//2013.07.30 김대현
	//update 후에 BUDGET_PRJ 예산관리 프로젝트 업데이트
	@Override
	public void updateBudgetPrj(ProjectVO projectVO) {
		projectDAO.updateBudgetPrj(projectVO);
	}
	
	@Override
	public void updateProjectEnd(ProjectVO projectVO) {
		ProjectVO beforePrjVO = projectDAO.selectProjectView(projectVO);
		if(!beforePrjVO.getStat().equals(projectVO.getStat()) ) {
			projectDAO.updateChildPrjStatRecur(projectVO);			
		}
		
		projectDAO.updateProjectEnd(projectVO);		
	}	
	
	@Override
	public void updatePrntPrjId(ProjectVO projectVO) {
		projectDAO.updatePrntPrjId(projectVO);		
	}

	@Override
	public List selectProjectInput(ProjectInputVO projectInputVO) {
		return projectDAO.selectProjectInput(projectInputVO);
	}

	@Override
	public List selectProjectInputForTransfer(ProjectVO projectVO) {
		return projectDAO.selectProjectInputForTransfer(projectVO);
	}

	
	
	@Override
	public int selectUserPrjInputCnt(ProjectInputVO projectInputVO) {
		return projectDAO.selectUserPrjInputCnt(projectInputVO);
	}

	@Override
	public void updateProjectInput(ProjectInputVO projectInputVO) {
		projectDAO.deleteProjectInputBatch(projectInputVO);
		for(int i=0; i< projectInputVO.getUserIdList().length;i++) {
			for(int j=0; j<12 ; j++) {
				if(projectInputVO.getMonthList()[i*12+j]==0)
					;
				else {
					ProjectInputVO vo = new ProjectInputVO();
					vo.setPrjId(projectInputVO.getPrjId());
					vo.setYear(projectInputVO.getYear());
					vo.setMonth(Integer.toString(j+1));
					vo.setUserId(projectInputVO.getUserIdList()[i]);
					vo.setWriterNo(projectInputVO.getWriterNo());	
					projectDAO.insertProjectInput(vo);
				}				
			}
		}		
	}

	@Override
	public void moveProjectU(ProjectVO projectVO) {
		
		//프로젝트 부서 및 상위프로젝트 변경
		ProjectVO bfProjectVO = projectDAO.selectProjectView(projectVO);
		if("M".equals(projectVO.getType()) ) {
			//변경되는 값이 없을 경우 아무 일도 일어나지 않음.
			if("M".equals(bfProjectVO.getType()) && projectVO.getOrgnztId().equals(bfProjectVO.getOrgnztId()) )
				return;
			else {
				//자신 및 하위 프로젝트 부서 정보 변경.
				projectDAO.updateOrgnztIdRecur(projectVO);
				//부모프로젝트코드값을 자기값으로 변경.
				projectVO.setPrntPrjId(projectVO.getPrjId());
				projectDAO.updatePrntPrjId(projectVO);
			}			
		} else  {
			if("S".equals(bfProjectVO.getType())&& projectVO.getPrntPrjId().equals(bfProjectVO.getPrntPrjId()))
				return;
			projectDAO.updatePrntPrjId(projectVO);
			//옮긴 프로젝트의 최상위 프로젝트가 속한 부서로 해당프로젝트 밑 하위프로젝트 부서값 변경.
			//즉 바로 상위 프로젝트의 부서값은 valid한 값이므로, 이 값으로 옮기는 프로젝트 및 하위 프로젝트의 부서 값을 변경한다.
			ProjectVO projectVO2 = new ProjectVO();
			projectVO2.setPrjId(projectVO.getPrntPrjId());
			//해당 프로젝트의 부서 값을 얻기 위해 정보를 얻어옴. 
			projectVO2 = projectDAO.selectProjectView(projectVO2);
			projectDAO.updateOrgnztIdRecur(projectVO2);
		}
		//기존 cd값 저장
		String beforePrjCd = bfProjectVO.getPrjCd();
		//프로젝트코드 및 하위프로젝트 코드 변경
		if("M".equals(projectVO.getType()) ) {
			projectDAO.incrOrgnztCurMaxPrjCd(projectVO);
		} else {
			projectDAO.incrPrntPrjCurMaxPrjCd(projectVO);
		}
		projectDAO.updatePrjCd(projectVO);
		//하위프로젝트의 cd의 기존 상위프로젝트의 cd와 일치하는 부분을 변경된 cd값으로 변경 
		//현재 변경된 cd값 저장
		String curPrjCd = projectDAO.selectProjectView(projectVO).getPrjCd();
		projectVO.setBeforePrjCd(beforePrjCd);
		projectVO.setCurPrjCd(curPrjCd);
		projectDAO.updatePrjCdRecur(projectVO);
	}
	
	
	
	@Override
	public int selectUnderPrjDataCnt(ProjectVO projectVO) {
		return projectDAO.selectUnderPrjDataCnt(projectVO);
	}

	
	@Override
	public void transferProjectU(ProjectVO projectVO) throws Exception {
		
		projectDAO.updateTransferPrj(projectVO);
	}
	

	@Override
	public int selectPrjInputCnt(ProjectInputVO projectInputVO) {
		return projectDAO.selectPrjInputCnt(projectInputVO);
	}

	@Override
	public int selectDefaultPrjCnt(ProjectVO searchVO) {
		return projectDAO.selectDefaultPrjCnt(searchVO);
	}

	@Override
	public int selectPresetPrjCnt(ProjectVO searchVO) {
		return projectDAO.selectPresetPrjCnt(searchVO);
	}

	@Override
	public void insertPrntPrjInput(ProjectVO projectVO) {
		projectDAO.insertPrntPrjInput(projectVO);
		
	}

	@Override
	public EgovMap selectPrjInputMaxUser(ProjectInputVO projectInputVO) {
		return projectDAO.selectPrjInputMaxUser(projectInputVO);
	}

	@Override
	public List<StepResultVO> selectProjectMonthlyReport(ProjectVO searchVO) {
		return projectDAO.selectProjectMonthlyReport(searchVO);
	}
	
	/**
	 * 전년도 실적 합계 가져오기
	 */
	@Override
	public StepResultVO selectProjectMonthlyReportPreSum(ProjectVO searchVO) {
		return projectDAO.selectProjectMonthlyReportPreSum(searchVO);
	}

	@Override
	public int selectPrjAuth(ProjectVO searchVO) {
		return projectDAO.selectPrjAuth(searchVO);
	}

	@Override
	public String selectPrjAuth2(ProjectVO searchVO) {
		return projectDAO.selectPrjAuth2(searchVO);
	}

	@Override
	public List selectProjectUserIncluded(ProjectVO searchVO) {
		return projectDAO.selectProjectUserIncluded(searchVO);
	}

	@Override
	public void updatePrjTree(ProjectVO projectVO) {
		projectDAO.updatePrjTree(projectVO);
	}

	@Override
	public void updatePrjTreeByOrg(Organ organ) {
		projectDAO.updatePrjTreeByOrg(organ);
	}

	@Override
	public List<EgovMap> selectProjectListForDelete(Map<String, Object> param) {
		return projectDAO.selectProjectListForDelete(param);
	}
	
	@Override
	public void deleteProject(Map<String, Object> param) {
		projectDAO.deleteProject(param);
	}
	
	@Override
	public void deleteProjectResTotal(Map<String, Object> param) {
		projectDAO.deleteProjectResTotal(param);
	}
	
	@Override
	public void switchPrjInterest(Map<String, Object> param) {
		// TODO Auto-generated method stub
		if (projectDAO.selectPrjInterestCnt(param) > 0) {
			projectDAO.deletePrjInterest(param);
		} else {
			projectDAO.insertPrjInterest(param);
		}
	}
	
	@Override
	public List selectProjectDetailList(ProjectVO searchVO) {
		searchVO.setSearchOrgnztIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgnztId()));
		return projectDAO.selectProjectDetailList(searchVO);
	}
	
	@Override
	public List selectProjectRowCnt(ProjectVO searchVO) {
		searchVO.setSearchOrgnztIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgnztId()));
		return projectDAO.selectProjectRowCnt(searchVO);
	}

	/**
	 * 상,하위 프로젝트 시작일, 종료일 가져오기
	 */
	@Override
	public HashMap<String, String> selectStartCompDate(ProjectVO projectVO) {
		HashMap<String, String> mapDate = new HashMap<String, String>();
	
		// 상위 프로젝트
		ProjectVO searchVO = new ProjectVO();
		
		searchVO.setPrjId(projectVO.getPrntPrjId());
		ProjectVO projectVO2 = selectProjectView(searchVO);
		
		if (projectVO2 != null) { 
			mapDate.put("prntStDt", projectVO2.getStDt());
			mapDate.put("prntCompDueDt", projectVO2.getCompDueDt());
		}
		
		// 하위 프로젝트
		HashMap<String, String> childMap = selectChildDate(projectVO.getPrjId());
		
		if (childMap.get("childStDt") != "") {
			//HashMap<String, String> tmpMap = projectService.selectChildDate(resultList);
			
			mapDate.put("childStDt", childMap.get("childStDt"));
			mapDate.put("childCompDueDt", childMap.get("childCompDueDt"));
		}
		return mapDate;
	}
	
	/**
	 * 하위 프로젝트 시작일, 종료일 가져오기
	 */
	@Override
	public HashMap<String, String> selectChildDate(String prjId) {
		return projectDAO.selectChildDate(prjId);
	}
	
	/**
	 * ajax로 프로젝트 정보(타입 및 PL정보) 가져오기
	 */
	@Override
	public JSONObject selectProjectInfo(String prjId) {
		List<JSONObject> resultList = projectDAO.selectProjectInfo(prjId);
		JSONObject result = resultList.get(0);
		return result;
	}
	
	/**
	 * ajax로 프로젝트 정보(현재 매출이관 보고서 결재 진행중인지) 가져오기
	 */
	@Override
	public JSONObject selectProjectInfoProgress(String prjId) {
		List<JSONObject> resultList = projectDAO.selectProjectInfoProgress(prjId);
		JSONObject result = resultList.get(0);
		return result;
	}

	/**
	 * ajax로 프로젝트 정보(매출이관보고서 최종 전결승인일과 오늘과의 차이값) 가져오기
	 */
	@Override
	public JSONObject getTransApprovalDateDiff(String prjId) {
		List<JSONObject> resultList = projectDAO.getTransApprovalDateDiff(prjId);
		JSONObject result = resultList.get(0);
		return result;
	}

	@Override
	public int selectReceivablePrjCnt(ProjectVO searchVO) {
		return projectDAO.selectReceivablePrjCnt(searchVO);
	}
	
	@Override
	public List<ProjectVO> selectSalesProjectList(ProjectVO projectVO) {
		return projectDAO.selectSalesProjectList(projectVO);
	}
	@Override
	public int selectSalesProjectCnt(ProjectVO projectVO) {
		return projectDAO.selectSalesProjectCnt(projectVO);
	}

	@Override
	public List<EgovMap> selectPrntPrjList(ProjectVO searchVO) {
		return projectDAO.selectPrntPrjList(searchVO);
	}

	@Override
	public String selectPrntPrjListCnt(ProjectVO searchVO) {
		return projectDAO.selectPrntPrjListCnt(searchVO);
	}
	
	@Override
	public JSONObject selectPrntPrj(ProjectVO searchVO) {
		List<JSONObject> resultList = projectDAO.selectPrntPrj(searchVO);
		JSONObject result = new JSONObject();
		if (resultList.size() > 0) {
			result = resultList.get(0);
			result.put("auth", "Y");
		} else {
			result.put("auth", "N");
		}
		return result;
	}
}
