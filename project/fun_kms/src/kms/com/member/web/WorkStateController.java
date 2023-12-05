package kms.com.member.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.WorkState;
import kms.com.member.service.WorkStateDetail;
import kms.com.member.service.WorkStateService;
import kms.com.member.service.WorkStateStatistic;
import kms.com.member.service.WorkStateVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class WorkStateController {

	@Resource(name="KmsMemberService")
	MemberService memberService;

	@Resource(name="KmsWorkStateService")
	WorkStateService workStateService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@RequestMapping("/member/dailyWorkStateStatistic.do")
	public String dailyWorkStateStatistic(@ModelAttribute("searchVO") WorkStateStatistic searchVO,
			WorkStateVO wsVO,
			Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("KMS039");
    	List<CmmnDetailCode> excludeLeaderCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
    	CmmnDetailCode excludeLeader = new CmmnDetailCode();
    	CmmnDetailCode exceptionUsers = new CmmnDetailCode();
    	   
    	if(excludeLeaderCode.size() > 1){
    		excludeLeader = (CmmnDetailCode)excludeLeaderCode.get(0);
    		exceptionUsers  = (CmmnDetailCode)excludeLeaderCode.get(1);
	    }
    	
    	searchVO.setExcludeLeader(excludeLeader.getCodeDc());	
    	searchVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
    	
		if (commandMap.get("moveDate") != null && commandMap.get("moveDate").equals("") == false) {
			searchVO.setSearchDate(CalendarUtil.getDate(searchVO.getSearchDate(), Integer.parseInt((String)commandMap.get("moveDate"))));
			wsVO.setSearchDate(CalendarUtil.getDate(wsVO.getSearchDate(), Integer.parseInt((String)commandMap.get("moveDate"))));
		}
		searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()));
		//일일근태기록 최상단 근태기록 통계 
		WorkStateStatistic result = workStateService.selectDailyWorkStateStatistic(searchVO);		
				
		wsVO.setSearchOrgIdList(CommonUtil.makeValidIdList(wsVO.getSearchOrgId()));		
		String move = (String)commandMap.get("move");		
		if (move != null && move.equals("") == false) {
			wsVO.setSearchDate(CalendarUtil.getDate(wsVO.getSearchDate(), Integer.parseInt(move)));
		}
		//부재현황
		Map<String, Object> result2 = workStateService.selectAbsenceStateAll(wsVO);
		
		model.addAttribute("result", result);
		model.addAttribute("result2", result2);		
		return "human_resource/hr_dailyWorkStateS";
	}
	
	@RequestMapping("/member/dailyWorkStateDatail.do")
	public String dailyWorkStateDatail(Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		//일일근태기록 및 부재등록현황 출근기록 상세내역 부분
		WorkStateDetail wsDetail = new WorkStateDetail();
		
		wsDetail.setSearchDate((String)commandMap.get("param_searchDate"));
		wsDetail.setSearchOrgId((String)commandMap.get("param_searchOrgId"));
		wsDetail.setSearchAttendCd((String)commandMap.get("param_attendCd"));
		wsDetail.setSearchOrgIdList(CommonUtil.makeValidIdList(wsDetail.getSearchOrgId()));
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("KMS039");
    	List<CmmnDetailCode> excludeLeaderCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
    	CmmnDetailCode excludeLeader = new CmmnDetailCode();
    	CmmnDetailCode exceptionUsers = new CmmnDetailCode();
    	   
    	if(excludeLeaderCode.size() > 1){
    		excludeLeader = (CmmnDetailCode)excludeLeaderCode.get(0);
    		exceptionUsers  = (CmmnDetailCode)excludeLeaderCode.get(1);
	    }
    	
    	wsDetail.setExcludeLeader(excludeLeader.getCodeDc());	
    	wsDetail.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
    	
		List<WorkStateDetail> resultList = workStateService.selectDailyWorkStateDetail(wsDetail);		
		model.addAttribute("resultList", resultList);
		
		return "human_resource/hr_dailyWorkStateD";
	}
	
	@RequestMapping("/member/insertWorkStateExceptionView.do")
	public String insertWorkStateExceptionView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		if (user.isAdmin() == false){
			return "error/authError";
		}
		else return "human_resource/hr_workStateExceptionW";
	}
	@RequestMapping("/member/insertWorkStateException.do")
	public String insertWorkStateException(HttpServletRequest req, WorkState workState, Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		workState.setWriterNo(user.getNo());
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userMixList", CommonUtil.makeValidIdList(((String)commandMap.get("userMixes"))));
		
		List<Integer> userNoList = memberService.selectUserNoList(param);
		
		for (int i=0; i<userNoList.size(); i++) {
			workState.setUserNo(userNoList.get(i));
			workStateService.insertWorkState(workState);
		}
		
		return "redirect:/member/dailyWorkStateStatistic.do";
	}
	
	@RequestMapping("/member/updateWorkStateExceptionView.do")
	public String updateWorkStateExceptionView(HttpServletRequest req, WorkStateVO workStateVO, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		WorkState result = workStateService.selectWorkState(workStateVO);
		
		model.addAttribute("result", result);
		model.addAttribute("ref", req.getHeader("referer"));
		
		if (user.isAdmin() == false){
			return "error/authError";
		}
		return "human_resource/hr_workStateExceptionM";
	}
	@RequestMapping("/member/updateWorkStateException.do")
	public String updateWorkStateException(HttpServletRequest req, WorkState workState, Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		workStateService.updateWorkState(workState);
		
		if (commandMap.get("ref") == null || commandMap.get("ref").equals(""))
			return "redirect:/member/dailyWorkStateStatistic.do";
		else return "redirect:/member/workStateStatistic.do"; 
	}
	
	@RequestMapping("/member/deleteWorkStateException.do")
	public String deleteWorkStateException(HttpServletRequest req, WorkStateVO workStateVO, 
			Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		workStateService.deleteWorkState(workStateVO);
		String ref = req.getHeader("referer");
		
		if (ref.substring(ref.indexOf("/member/")).equals("/member/workStateDatail.do")) {
			return "redirect:/member/workStateStatistic.do";
		}
		return "redirect:/member/dailyWorkStateStatistic.do";
	}
	
	
	@RequestMapping("/member/workStateStatistic.do")
	public String workStateStatistic(@ModelAttribute("searchVO") WorkStateStatistic searchVO, ModelMap model) throws Exception {

		searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()));
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("KMS039");
    	List<CmmnDetailCode> excludeLeaderCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
    	CmmnDetailCode excludeLeader = new CmmnDetailCode();
    	CmmnDetailCode exceptionUsers = new CmmnDetailCode();
    	   
    	if(excludeLeaderCode.size() > 1){
    		excludeLeader = (CmmnDetailCode)excludeLeaderCode.get(0);
    		exceptionUsers  = (CmmnDetailCode)excludeLeaderCode.get(1);
	    }
    	
    	searchVO.setExcludeLeader(excludeLeader.getCodeDc());	
    	searchVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
    	
		List<WorkStateStatistic> resultList = workStateService.selectWorkStateStatistic(searchVO);
		
		WorkStateStatistic resultSum = new WorkStateStatistic();
		for (int i = 0; i < resultList.size(); i++) {
			WorkStateStatistic ws = resultList.get(i);
			resultSum.setDateCnt(resultSum.getDateCnt() + ws.getDateCnt());
			resultSum.setVac(resultSum.getVac() + ws.getVac());
			resultSum.setBizTrip(resultSum.getBizTrip() + ws.getBizTrip());
			resultSum.setSend(resultSum.getSend() + ws.getSend());
			resultSum.setWorkOut(resultSum.getWorkOut() + ws.getWorkOut());
			
			resultSum.setNight(resultSum.getNight() + ws.getNight());
			resultSum.setEtc(resultSum.getEtc() + ws.getEtc());
			
			resultSum.setEarlyAtnd(resultSum.getEarlyAtnd() + ws.getEarlyAtnd());
			resultSum.setAtnd(resultSum.getAtnd() + ws.getAtnd());

			resultSum.setLate(resultSum.getLate() + ws.getLate());
		}
		//부재일수 소계, 면제일수 소계, 유효일수, 출근일수 소계 계산식 주석
		//getAbs = vac + bizTrip + send + workOut;
		//getException= night + etc;
		//getValid = earlyAtnd + atnd + late;
		//getAttend = earlyAtnd + atnd;				
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultSum", resultSum);
		
		return "human_resource/hr_workStateS";
	}
	
	@RequestMapping("/member/workStateDetail.do")
	public String workStateDatail(@ModelAttribute("searchVO") WorkStateStatistic searchVO, 
			HttpServletRequest req, ModelMap model, String mode) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);		
		String today = CalendarUtil.getToday();
		String lastWeek = CalendarUtil.getDate(today, -7);
		String lastMonth = CalendarUtil.getDate(today, "MONTH", -1);
		String firstDayoftheYear = today.substring(0,4) + "0101";
		String lastYear = String.valueOf(Integer.parseInt(today.substring(0,4)) - 1);
		String firstDayoftheLastYear = lastYear + "0101";
		String lastDayoftheLastYear = lastYear + "1231";
		
		if(mode == null)
			mode = "";
		
		if(mode.equals("week")){
			searchVO.setSearchDateFrom(lastWeek);
			searchVO.setSearchDateTo(today);
		}else if(mode.equals("month")){
			searchVO.setSearchDateFrom(lastMonth);
			searchVO.setSearchDateTo(today);
		}else if(mode.equals("year")){
			searchVO.setSearchDateFrom(firstDayoftheYear);
			searchVO.setSearchDateTo(today);			
		}else if(mode.equals("lastyear")){
			searchVO.setSearchDateFrom(firstDayoftheLastYear);
			searchVO.setSearchDateTo(lastDayoftheLastYear);			
		}
		
		
		int searchUserNo = searchVO.getSearchUserNo();
		if(searchUserNo == 0){
			searchVO.setSearchUserNo(user.getNo());
		}
		model.addAttribute("searchUserNo", user.getNo());
		List<WorkStateDetail> resultList = workStateService.selectWorkStateDetail(searchVO);		
		model.addAttribute("resultList", resultList);		
		return "human_resource/hr_workStateDetailL";
	}
	
	
}
