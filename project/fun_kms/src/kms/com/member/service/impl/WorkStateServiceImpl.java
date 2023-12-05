package kms.com.member.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.common.service.LoginService;
import kms.com.common.service.impl.LoginDAO;
import kms.com.common.utils.CalendarUtil;
import kms.com.member.service.WorkState;
import kms.com.member.service.WorkStateDetail;
import kms.com.member.service.WorkStateService;
import kms.com.member.service.WorkStateStatistic;
import kms.com.member.service.WorkStateVO;

@Service("KmsWorkStateService")
public class WorkStateServiceImpl implements WorkStateService {
	
	@Resource(name="KmsWorkStateDAO")
	private WorkStateDAO workStateDAO;

	@Resource(name = "KmsLoginService")
    private LoginService loginService;
    
	@Resource(name="kmsWorkStateIdGnrService")
	EgovIdGnrService idGnrService;
	

	@Override
	public Map<String, Object> selectAbsenceState(WorkStateVO absenceVO) throws Exception {
		
		//부재현황조회 기능
		Map<String, Object> result = new HashMap<String, Object>();		
		//부재등록현황 통계
		List<EgovMap> sqlResult = workStateDAO.selectAbsenceState(absenceVO);
		//부재등록정보
		List<WorkStateVO> absList = workStateDAO.selectAbsenceList(absenceVO);		
		
		EgovMap state = new EgovMap();
		state.put("l", 0);
		state.put("n", 0);
		state.put("v", 0);
		state.put("o", 0);
		state.put("t", 0);
		state.put("s", 0);
		
		List<WorkStateVO> lateList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> nightList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> vacList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> outList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> tripList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> sendList = new ArrayList<WorkStateVO>();
		
		Integer sum = 0;
		for (int i=0; i<sqlResult.size(); i++) {
			EgovMap tmp = sqlResult.get(i);
			state.put(tmp.get("wsTyp"), tmp.get("wsTypCnt"));
			
			sum += Integer.parseInt(String.valueOf(tmp.get("wsTypCnt")));
		}
		state.put("sum", sum);
				
		for (int i=0; i<absList.size(); i++) {
			WorkStateVO tmp = absList.get(i);
			
			if (tmp.getWsTyp().equalsIgnoreCase("N")) {
				nightList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("L")) {
				lateList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("V")) {
				vacList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("O")) {
				outList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("T")) {
				tripList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("S")) {
				sendList.add(tmp);
			}
		}
		
		result.put("absList", absList);
		result.put("state", state);
		result.put("nightList", nightList);
		result.put("lateList", lateList);
		result.put("vacList", vacList);
		result.put("outList", outList);
		result.put("tripList", tripList);
		result.put("sendList", sendList);		
		
		return result;
	}
	
	@Override
	public List<WorkStateVO>  selectAbsenceStateMember(WorkStateVO absenceVO) throws Exception {
		//인사정보통합검색 사원 부재등록정보
		List<WorkStateVO> absList = workStateDAO.selectAbsenceListAll(absenceVO);	
		return absList;		
	}
	
	@Override
	public Map<String, Object> selectAbsenceStateAll(WorkStateVO absenceVO) throws Exception {
		
		//일일근태기록 부재등록현황
		Map<String, Object> result = new HashMap<String, Object>();		
		absenceVO.setUserNo(null);
		//부재등록현황 통계
		List<EgovMap> sqlResult = workStateDAO.selectAbsenceStateAll(absenceVO);
		//부재등록정보
		List<WorkStateVO> absList = workStateDAO.selectAbsenceListAll(absenceVO);
		
		EgovMap state = new EgovMap();
		state.put("v", 0);
		state.put("o", 0);
		state.put("t", 0);
		state.put("s", 0);
		state.put("n", 0);
		
		List<WorkStateVO> vacList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> outList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> tripList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> sendList = new ArrayList<WorkStateVO>();
		List<WorkStateVO> nightList = new ArrayList<WorkStateVO>();
		
		Integer sum = 0;
		for (int i=0; i<sqlResult.size(); i++) {
			EgovMap tmp = sqlResult.get(i);
			state.put(tmp.get("wsTyp"), tmp.get("wsTypCnt"));
			
			sum += Integer.parseInt(String.valueOf(tmp.get("wsTypCnt")));
		}
		state.put("sum", sum);
		
		
		for (int i=0; i<absList.size(); i++) {
			WorkStateVO tmp = absList.get(i);
			
			if (tmp.getWsTyp().equalsIgnoreCase("V")) {
				vacList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("O")) {
				outList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("T")) {
				tripList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("S")) {
				sendList.add(tmp);
			} else if (tmp.getWsTyp().equalsIgnoreCase("N")) {
				nightList.add(tmp);
			}
		}
		
		result.put("state", state);
		result.put("vacList", vacList);
		result.put("outList", outList);
		result.put("tripList", tripList);
		result.put("sendList", sendList);
		result.put("nightList", nightList);
				
		return result;
	}

	@Override
	public int checkExistAbsentData(WorkState absenceVO) throws Exception {
		return workStateDAO.checkExistAbsentData(absenceVO);
	}
	
	@Override
	public String selectExistAbsentDataWsId(WorkState absenceVO) throws Exception {
		return workStateDAO.selectExistAbsentDataWsId(absenceVO);
	}
	
	@Override
	public WorkStateVO selectWorkState(WorkStateVO absenceVO) throws Exception {
		return workStateDAO.selectWorkState(absenceVO);
	}
	
	@Override
	public WorkStateVO selectWorkStateByDocId(WorkStateVO absenceVO) throws Exception {
		return workStateDAO.selectWorkStateByDocId(absenceVO);
	}
	
	@Override
	public void insertWorkState(WorkState workState) throws Exception {
		String wsId = idGnrService.getNextStringId();
		workState.setWsId(wsId);	
		workStateDAO.insertWorkState(workState);
		
		String sDt = workState.getWsBgnDe();
		String eDt = workState.getWsEndDe();
		String wsTyp = workState.getWsTyp();
			
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userNo", workState.getUserNo());
		//외근 O, 면제 E, 야근 N
		if (eDt == null || eDt.equals("") 
				|| eDt.equals("99991231") || eDt.equals("99999999")) {
			param.put("attendDt", sDt);
			loginService.updatePastAttendCheck(param);
		} else if (wsTyp.equals("V")) { // 휴가 V
			String date = sDt;
			int stAmpm = workState.getStAmpm();
			if(stAmpm == 2) //오후부터 휴가 시작인 날은 수정 안함 
				date = CalendarUtil.getDate(date, 1);
						
			while(CalendarUtil.getDateDiff(eDt, date) >= 0) {
				param.put("attendDt", date);
				loginService.updatePastAttendCheck(param);				
				date = CalendarUtil.getDate(date, 1);
			}
		} else { // 출장 T 파견 S
			String date = sDt;
			while(CalendarUtil.getDateDiff(eDt, date) >= 0) {
				param.put("attendDt", date);
				// 해당 날짜의 attend_cd 등록상태 체크
				List<EgovMap> statusList = loginService.selectAttendCheck(param);
				if (statusList.size() > 0) {
					EgovMap status = statusList.get(0);
					// 휴가가 아닐 경우에만 업데이트
					if ( !"VC".equals(status.get("attendCd")) ) {
						loginService.updatePastAttendCheck(param);
					}
				}
				date = CalendarUtil.getDate(date, 1);
			}
		}
	}
	
	@Override
	public void updateWorkState(WorkState absence) throws Exception {
		WorkStateVO tmp = new WorkStateVO();
		tmp.setWsId(absence.getWsId());
		WorkStateVO workState = selectWorkState(tmp);
		
		workStateDAO.updateWorkState(absence);
		if (absence.getWsTyp().equals("V") || absence.getWsTyp().equals("S") 
				|| absence.getWsTyp().equals("T") || absence.getWsTyp().equals("E")) {
			String sDt = absence.getWsBgnDe();
			String eDt = absence.getWsEndDe();

			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userNo", absence.getUserNo());
			if (eDt == null || eDt.equals("") || eDt.equals("99991231")) {
				param.put("attendDt", sDt);
				loginService.updatePastAttendCheck(param);
			}
			else {
				String date = sDt;
				while(CalendarUtil.getDateDiff(eDt, date) >= 0) {
					param.put("attendDt", date);
					loginService.updatePastAttendCheck(param);
					
					date = CalendarUtil.getDate(date, 1);	
				}
			}
		}
	}
	
	@Override
	public void deleteWorkStateUpdatePastAttendCheck(WorkStateVO workState) throws Exception {
				
		if (workState.getWsTyp().equals("V") || workState.getWsTyp().equals("S") 
		 || workState.getWsTyp().equals("T") || workState.getWsTyp().equals("E")) {
			String sDt = workState.getWsBgnDe();
			String eDt = workState.getWsEndDe();

			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userNo", workState.getUserNo());
			if (eDt == null || eDt.equals("") || eDt.equals("99999999") || eDt.equals("99991231")) {
				param.put("attendDt", sDt);
				loginService.updatePastAttendCheck(param);
			} else {
				String date = sDt;
				while(CalendarUtil.getDateDiff(eDt, date) >= 0) {
					param.put("attendDt", date);
					loginService.updatePastAttendCheck(param);
					
					date = CalendarUtil.getDate(date, 1);	
				}
			}
		}
	}
	
	@Override
	public void deleteWorkState(WorkStateVO absenceVO) throws Exception {
		
		WorkStateVO workState = selectWorkState(absenceVO);
		workStateDAO.deleteWorkState(workState);
		//workStateDAO.deleteWorkState(absenceVO);		
		deleteWorkStateUpdatePastAttendCheck(workState);
	}
	
	@Override
	public void deleteWorkStateByDocId(WorkStateVO absenceVO) throws Exception {
		WorkStateVO workState = selectWorkStateByDocId(absenceVO);		
		workStateDAO.deleteWorkState(workState);
		if(workState != null)
			deleteWorkStateUpdatePastAttendCheck(workState);
	}
	
	@Override
	public List<EgovMap> selectOvertimeList(WorkStateVO searchVO) throws Exception {
		return workStateDAO.selectOvertimeList(searchVO);
	}
	
	@Override
	public EgovMap selectOvertime(WorkStateVO searchVO) throws Exception {
		return workStateDAO.selectOvertime(searchVO);
	}

	@Override
	public List<WorkStateVO> selectOvertimeDetailList(WorkStateVO searchVO)
			throws Exception {
		return workStateDAO.selectOvertimeDetailList(searchVO);
	}

	@Override
	public EgovMap selectOvertimeListSum(WorkStateVO searchVO) throws Exception {
		return workStateDAO.selectOvertimeListSum(searchVO);
	}

	@Override
	public WorkStateStatistic selectDailyWorkStateStatistic(WorkStateStatistic searchVO) throws Exception {
		return workStateDAO.selectDailyWorkStateStatistic(searchVO);
	}

	@Override
	public List<WorkStateDetail> selectDailyWorkStateDetail(WorkStateDetail wsDetail) throws Exception {
		return workStateDAO.selectDailyWorkStateDetail(wsDetail);
	}
	
	@Override
	public List<WorkStateDetail> selectAbsenceStateDatail(WorkStateDetail wsDetail) throws Exception {
		return workStateDAO.selectAbsenceStateDatail(wsDetail);
	}	

	@Override
	public List<WorkStateStatistic> selectWorkStateStatistic(WorkStateStatistic searchVO) throws Exception {
		return workStateDAO.selectWorkStateStatistic(searchVO);
	}
	
	@Override
	public List<WorkStateDetail> selectWorkStateDetail(WorkStateStatistic searchVO) throws Exception {
		return workStateDAO.selectWorkStateDetail(searchVO);
	}

	
	
}
