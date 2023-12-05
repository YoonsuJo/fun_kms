package kms.com.common.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.admin.organ.service.OrganService;
import kms.com.admin.organ.service.OrganVO;
import kms.com.common.service.CommonService;
import kms.com.common.service.LoginService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.NoteService;
import kms.com.cooperation.service.DayReportService;
import kms.com.cooperation.service.MissionService;
import kms.com.cooperation.service.TaskVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CommonController {

	@Resource(name = "KmsCommonService")
	private CommonService commonService;
	
	@Resource(name="KmsMemberService")
	MemberService memberService;

	@Resource(name="KmsDayReportService")
	private DayReportService dayReportService;

		@Resource(name = "KmsNoteService")
		private NoteService noteService;
	
	/** EgovMessageSource */
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "OrganService")
		private OrganService organService;
	
	@Resource(name = "KmsLoginService")
		private LoginService loginService;
	
	
	
	@Resource(name = "KmsMissionService")
	protected MissionService missionService;
	
	
	/** log */
	protected static final Log LOG = LogFactory.getLog(LoginController.class);
	
	
	@RequestMapping(value="/common/getCheckList.do")
	public String getCheckList(HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

		if (!SessionUtil.isLogin(req)) {
			return "fail";
		}
		MemberVO user = SessionUtil.getMember(req);
//		EgovMap chkList = commonService.getCheckList(user);
		
		
		List<EgovMap> currentUserList = commonService.selectCurrentUserList();
		
		
		if (user.isTaxAdmin()) {
			List<EgovMap> taxChkList = commonService.getTaxCheckList(null);
			req.setAttribute("taxChkList", taxChkList);
		}
		
		List<EgovMap> myMenuList = commonService.getMyMenuList(user);
/*
		MissionVO missionVO = new MissionVO();
		missionVO.setUserNo(user.getUserNo());
		missionVO.setType("today");
		int todayIcCnt = missionService.selectMissionInCompleteTotCnt(missionVO);
		missionVO.setType("seven");
		int sevenIcCnt = missionService.selectMissionInCompleteTotCnt(missionVO);
		missionVO.setType("thirty");
		int thirtyIcCnt = missionService.selectMissionInCompleteTotCnt(missionVO);
		missionVO.setType("next");
		int nextIcCnt = missionService.selectMissionInCompleteTotCnt(missionVO);		
*/
		Map<String,Object> param = new HashMap<String,Object>();
		
		String searchUserNm = user.getUserNm() + "(" + user.getUserId() + ")";
		String today = CalendarUtil.getToday();
		param.put("searchUserNm", searchUserNm);
		
		param.put("taskState", "P");
		param.put("searchType", "today");
//		int todayPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(param);
//		
//		param.put("searchType", "seven");
//		param.put("searchDateFrom",  CalendarUtil.getFirstDateOfThisWeek2(CalendarUtil.getToday())); //기존 일요일 구하는 함수 변형한 월요일 구하는 함수로 변경
//		param.put("searchDateTo", CalendarUtil.getLastDateOfThisWeek(CalendarUtil.getToday()));
//		
//		int sevenPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(param);
//		
//		param.put("searchType", "thirty");
//		
//		param.put("searchDateFrom",  today.substring(0,6) + "01");
//		 
//		Calendar cal = Calendar.getInstance(); //캘린더 인스턴스 얻기
//		String endDate = Integer.toString(cal.getActualMaximum(Calendar.DATE)); //달의 마지막일 얻기
//		
//		param.put("searchDateTo", today.substring(0,6)+endDate);
//
//		int thirtyPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(param);
//		
//		param.put("searchType", "next");
//		int nextPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(param);		
//		
//		chkList.put("todayPCnt", todayPCnt);
//		chkList.put("sevenPCnt", sevenPCnt);
//		chkList.put("thirtyPCnt", thirtyPCnt);
//		chkList.put("nextPCnt", nextPCnt);
//		
//		req.setAttribute("chkList", chkList);
		req.setAttribute("currentUserList", currentUserList);
		req.setAttribute("myMenuList", myMenuList);
		
		//EgovMap commList = commonService.getCommunityUnreadCnt(user);
		//req.setAttribute("commList", commList);
		return "/common/include/checkList";
	}
	
	@RequestMapping(value = "/common/getCheckListAjax.do")
	public void getCheckListAjax(
			HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		EgovMap chkList = commonService.getCheckList(user);
		
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		String searchUserNm = user.getUserNm() + "(" + user.getUserId() + ")";
		String today = CalendarUtil.getToday();
		param.put("searchUserNm", searchUserNm);
		
		param.put("taskState", "P");
		param.put("searchType", "today");
		int todayPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(param);
		
		param.put("searchType", "seven");
		param.put("searchDateFrom",  CalendarUtil.getFirstDateOfThisWeek2(CalendarUtil.getToday())); //기존 일요일 구하는 함수 변형한 월요일 구하는 함수로 변경
		param.put("searchDateTo", CalendarUtil.getLastDateOfThisWeek(CalendarUtil.getToday()));
		
		int sevenPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(param);
		
		param.put("searchType", "thirty");
		
		param.put("searchDateFrom",  today.substring(0,6) + "01");
		 
		Calendar cal = Calendar.getInstance(); //캘린더 인스턴스 얻기
		String endDate = Integer.toString(cal.getActualMaximum(Calendar.DATE)); //달의 마지막일 얻기
		
		param.put("searchDateTo", today.substring(0,6)+endDate);

		int thirtyPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(param);
		
		param.put("searchType", "next");
		int nextPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(param);		
		
		chkList.put("todayPCnt", todayPCnt);
		chkList.put("sevenPCnt", sevenPCnt);
		chkList.put("thirtyPCnt", thirtyPCnt);
		chkList.put("nextPCnt", nextPCnt);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("checkList", chkList);
		
		res.setContentType("charset=UTF-8");
		
		ServletOutputStream out = res.getOutputStream();
		
		out.write(jsonObject.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}	
	
	@RequestMapping(value = "/common/getCheckReferenceListAjax.do")
	public void getCheckReferenceListAjax(
			HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		EgovMap chkListReference = commonService.getReferenceList(user);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("checkListReference", chkListReference);
		
		res.setContentType("charset=UTF-8");
		
		ServletOutputStream out = res.getOutputStream();
		
		out.write(jsonObject.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}	

	@RequestMapping(value="/mobile/include/getCheckList.do")
	public String getCheckMobileList(HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

		if (!SessionUtil.isLogin(req)) {
			return "fail";
		}
		
		MemberVO user = SessionUtil.getMember(req);
		EgovMap chkList = commonService.getCheckList(user);
		req.setAttribute("chkList", chkList);
		
		List<EgovMap> currentUserList = commonService.selectCurrentUserList();
		req.setAttribute("currentUserList", currentUserList);		
		return "mobile/include/menu";
	}
	
	@RequestMapping(value="/common/getCalendar.do")
	public String getCalendar(Map<String, Object> commandMap, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		EgovMap result = commonService.getCalendar(commandMap, user);
		
		model.addAttribute("calendarInfo", result);
		
		return "include/calendar";
	}
	
	@RequestMapping(value="/common/getSchedule.do")
	public String getSchedule(Map<String, Object> commandMap, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		EgovMap result = commonService.getSchedule(commandMap, user);
		
		model.addAttribute("scheduleInfo", result);
		

		Map<String,Object> param = new HashMap<String,Object>();
		param.put("searchUserNo", user.getNo());
		param.put("limitSize", 9999);
		
		List<TaskVO> taskList = dayReportService.selectTaskList(param);
		
		model.addAttribute("taskList", taskList);
		model.addAttribute("today", CalendarUtil.getToday());
		
		
		return "include/schedule";
	}
	
	
	
	@RequestMapping(value="/common/memberSearchLayer.do")
	public String memberSearchLayer(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		model.addAttribute("type", commandMap.get("type"));
		
		if (commandMap.get("type").equals("head")) {
			return "include/search_layer";
		}
		
		MemberVO memberVO = new MemberVO();
		
		if (commandMap.get("pageIndex") == null) {
			commandMap.put("pageIndex", 1);
		}
		
		memberVO.setPageUnit(propertyService.getInt("pageUnit"));
		memberVO.setPageSize(propertyService.getInt("pageSize"));
		memberVO.setPageIndex(Integer.parseInt(String.valueOf(commandMap.get("pageIndex"))));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(memberVO.getPageUnit());
		paginationInfo.setPageSize(memberVO.getPageSize());
	
		memberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		memberVO.setLastIndex(paginationInfo.getLastRecordIndex());
		memberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		memberVO.setWorkStList(new String[]{"W","L"});
		memberVO.setSearchCondition("1");
		memberVO.setSearchKeyword((String)commandMap.get("searchKeyword"));
		
		List<MemberVO> memList = memberService.selectMemberList(memberVO);
		int totCnt = memberService.selectMemberListTotCnt(memberVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchUrl", commandMap.get("searchUrl"));
		model.addAttribute("memList", memList);
		model.addAttribute("memPaginationInfo", paginationInfo);
		
		return "include/search_layer";
	}
	
	@RequestMapping(value="/ajax/organ/OrganTree.do")
	public String selectOrganTreeList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") OrganVO searchVO
			, ModelMap model
			, HttpServletRequest req
			) throws Exception {
		
		List OrganTreeList = organService.selectOrganTreeList(searchVO);
		
		// 20140812, dwkim, 겸직부서 리스트 추가.
		List OrganTreeListSec = new ArrayList();
		
		MemberVO user = SessionUtil.getMember(req);
		// 겸직부서가 존재할 경우에만..
		if (user.getOrgnztIdSec() != null) {
			searchVO.setOrgnztId(user.getOrgnztIdSec());	// 겸직부서 조회
			OrganTreeListSec = organService.selectOrganTreeList(searchVO);
			OrganTreeList.addAll(OrganTreeListSec);
		}
		// 20140812, dwkim, 겸직부서 리스트 추가.끝
		
		model.addAttribute("resultListTree", OrganTreeList);
		
		//return "admin/include/docContent"; // admin/organ/OrganList
		return "/ajax/organTree";
	}
	
	// 외부 접속 로그 확인 처리
	@RequestMapping("/ajax/confirmOuterNetLoginLog.do")
	public void confirmOuterNetLoginLog(HttpServletRequest req, HttpServletResponse res) throws Exception {
		if(!SessionUtil.isLogin(req)) {
			return;
		}
		
		MemberVO user = SessionUtil.getMember(req);
		commonService.updataOuterNetLoginLog(user);
		user.setOuterNetLoginLogList(null);		// 외부 접속 로그 목록 제거(다시 로그인 하기 전까지 리스트에 남는 문제 방지)
	}
	
	@RequestMapping("/ajax/getNoteIdXml.do")
	public void getNoteIdXml(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		if (!SessionUtil.isLogin(req)) {
			return;
		}
		
		MemberVO user = SessionUtil.getMember(req);
		List<String> resultList = noteService.getNoteIdList(user);
		String noteIds = "";
		for (int i=0; i<resultList.size(); i++) {
			if (i != 0)
				noteIds += ",";
			noteIds += resultList.get(i);
		}		
		res.setContentType("text/xml;charset=UTF-8");
		
		String out = "";
		out += "<noteIds>" + noteIds + "</noteIds>";
		res.getWriter().println( CommonUtil.getXMLStr(out) );
	}
	
	
	@RequestMapping(value="/common/updateCurrentUser.do")
	public void updateCurrentUser(HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

		if (!SessionUtil.isLogin(req))
			return;
		
		MemberVO user = SessionUtil.getMember(req);
		Map<String, Object> param = new HashMap<String,Object>();
		param.put("userNo", user.getUserNo());
		commonService.updateCurrentUser(param);
	}

	@RequestMapping(value="/common/displayMessage.do")
	public String displayMessage(HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		
		/* 중복 로그인 관련 메시지 */
		if (!SessionUtil.isLogin(req))
			return "/common/none";
		
		MemberVO user = SessionUtil.getMember(req);
		Map<String, Object> param = new HashMap<String,Object>();
		param.put("userNo", user.getUserNo());
		
		Map<String, Object> result = loginService.selectRecentLoginLog(param);
		if (result != null && !result.get("ip").toString().equals(req.getRemoteAddr())) {
			model.addAttribute("message", "※ 같은 계정으로 다른 IP에서 로그인되었습니다. " + result.get("ip").toString()
					+ " (" + result.get("tm").toString() + ")");
			//return "/common/message";
		}
		
		return "/common/none";
	}
	
	@RequestMapping(value="/common/displayMessageSimple.do")
	public String displayMessageSimple(HttpServletRequest req, HttpServletResponse res, ModelMap model
			,String msg, String color) throws Exception {
		
		model.addAttribute("message", msg);
		model.addAttribute("color", color);
		
		return "/common/message";
		
	}

	@RequestMapping(value="/mobile/file/file.do")
	public String fileDownload(HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		return "mobile/file/file";
	}
}
