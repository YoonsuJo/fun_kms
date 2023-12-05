package kms.com.cooperation.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.DayReport;
import kms.com.cooperation.service.DayReportDetail;
import kms.com.cooperation.service.DayReportService;
import kms.com.cooperation.service.DayReportVO;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.Task;
import kms.com.cooperation.service.TaskContent;
import kms.com.cooperation.service.TaskVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.WorkState;
import kms.com.member.service.WorkStateService;
import kms.com.member.service.impl.MemberDAO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import Altibase.jdbc.driver.ex;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class DayReportController {

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name="KmsDayReportService")
	private DayReportService dayReportService;
    
	@Resource(name="projectService")
	private ProjectService projectService;
	
    @Resource(name = "KmsMemberService")
    private MemberService memberService;
    
    @Resource(name="KmsMemberDAO")
    private MemberDAO memberDAO;
	
    @Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    //야근등록
	@Resource(name="KmsWorkStateService")
	WorkStateService workStateService;
	
	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;
	
    
    @RequestMapping("/cooperation/selectDayReport.do")
	public String selectDayReport(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		commandMap.remove("taskId");
		commandMap.remove("taskState");
		
		MemberVO user = SessionUtil.getMember(req);
		List<EgovMap> resultList1 = null;
		DayReportVO searchVO = new DayReportVO();


		////////////////////////////////////////////////////////////////////
		String searchDate = (String)commandMap.get("searchDate");
		String searchUserNm = (String)commandMap.get("searchUserNm");
		
		String dateMove = (String)commandMap.get("dateMove");
		
		if (searchDate == null || searchDate.equals("")) {
			searchDate = CalendarUtil.getToday();
		}
		if (dateMove != null && dateMove.equals("") == false) {
			searchDate = CalendarUtil.getDate(searchDate, Integer.parseInt(dateMove));
		}
		if (searchUserNm == null || searchUserNm.equals("")) {
			searchUserNm = user.getUserNm() + "(" + user.getUserId() + ")";
		}

		
		List<String> userMixList = CommonUtil.makeValidIdListArray(searchUserNm);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
    	param.put("alarmUserList", 0);
		List<MemberVO> memberList = memberService.selectMemberListById(param);

		searchVO.setUserNo(memberList.get(0).getUserNo());
		searchVO.setUserNm(memberList.get(0).getUserNm());
		searchVO.setUserId(memberList.get(0).getUserId());
		searchVO.setMyOrgId(memberList.get(0).getOrgnztId());
		
		model.addAttribute("quickUserNm", memberList.get(0).getUserNm());
		
		if(!"N".equals(memberList.get(0).getPosition())) { //팀장    		
    		resultList1 = dayReportService.selectDayReportUserList1(searchVO);
    	} else {
    		resultList1 = dayReportService.selectDayReportUserList2(searchVO);
    	}
    	if(user.isAdmin()){ //운영자
    		model.addAttribute("orgnztId", "");	//조직트리 전체검색
    	}else{
    		model.addAttribute("orgnztId", user.getOrgnztId()); //조직트리 예하부서검색
    	}
    	
    	searchVO.setUserNo(memberList.get(0).getUserNo());
    	
    	commandMap.put("userNo", searchVO.getUserNo());	
    	commandMap.put("myOrgId", searchVO.getMyOrgId());
    	commandMap.put("today", CalendarUtil.getToday());
		commandMap.put("searchDate", searchDate);
		commandMap.put("searchUserNm", searchUserNm);
		
		if (user.isDetailDayReportTyp()) {
			List<DayReportDetail> resultList = dayReportService.selectDayReportDetail(commandMap);
			List<Map<String, Object>> dateList = CalendarUtil.getDateList((String)commandMap.get("sDate"));
			
			model.addAttribute("resultList", resultList);
			model.addAttribute("dateList", dateList);
			model.addAttribute("searchVO", commandMap);
			model.addAttribute("resultList1", resultList1);
			
			return "cooperation/coop_dayReportLD"; 
		} else {
			Map<String, Object> result = dayReportService.selectDayReportBrief(commandMap);
			
			List<Map<String, Object>> dateList = CalendarUtil.getDateList((String)commandMap.get("sDate"));
			
			model.addAttribute("processList", result.get("processList"));
			model.addAttribute("endList", result.get("endList"));
			model.addAttribute("workTime", result.get("workTime"));
			model.addAttribute("leftTime", result.get("leftTime"));
			model.addAttribute("dateList", dateList);
			model.addAttribute("searchVO", commandMap);
			
			return "cooperation/coop_dayReportLB"; 
		}
	}
    
    @RequestMapping("/cooperation/selectDayReportUser.do")
	public String selectDayReportUser(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		commandMap.remove("taskId");
		commandMap.remove("taskState");
		
		MemberVO user = SessionUtil.getMember(req);		
		if(user.isAdmin()){
			commandMap.put("myOrgId", "");
		} else {
			commandMap.put("myOrgId", user.getOrgnztId());
			commandMap.put("myOrgIdSec", user.getOrgnztIdSec());
		}
		
		String searchDateFrom = (String)commandMap.get("searchDateFrom");
		String searchDateTo = (String)commandMap.get("searchDateTo");		
		String searchUserNm = (String)commandMap.get("searchUserNm");
		String mode = (String)commandMap.get("mode");
		String searchUserNo = (String)commandMap.get("searchUserNo");
		
		if (searchDateFrom == null || searchDateFrom.equals("")) 
			searchDateFrom = CalendarUtil.getDate(CalendarUtil.getToday(), -7);
		if (searchDateTo == null || searchDateTo.equals("")) 
			searchDateTo = CalendarUtil.getToday();
		if (searchUserNm == null || searchUserNm.equals("")) {
			if (searchUserNo == null || searchUserNo.equals(""))
				searchUserNm = user.getUserNm() + "(" + user.getUserId() + ")";
			else {
				MemberVO memberVO = new MemberVO();
				memberVO.setNo(Integer.parseInt(searchUserNo));
				memberVO = memberDAO.selectMember(memberVO);
				searchUserNm = memberVO.getUserNm() + "(" + memberVO.getUserId() + ")";
			}
		}
		if (mode == null || mode.equals("")) 
			mode = "0";
		if (searchUserNo == null || searchUserNo.equals(""))
			searchUserNo = "0";
		
		commandMap.put("today", CalendarUtil.getToday());
		commandMap.put("searchDateFrom", searchDateFrom);
		commandMap.put("searchDateTo", searchDateTo);
		commandMap.put("searchUserNm", searchUserNm);
		commandMap.put("mode", mode);
		commandMap.put("searchUserNo", searchUserNo);
		
		List<DayReportDetail> resultList = dayReportService.selectDayReportDetailUser(commandMap);
		List<Map<String, Object>> dateList = CalendarUtil.getDateList((String)commandMap.get("sDate"));
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("dateList", dateList);
		model.addAttribute("searchVO", commandMap);
		
		return "cooperation/coop_dayReportLDUser";	
	}
    
    @RequestMapping("/cooperation/selectDayReportUserList.do")
	public String selectDayReportUserList(@ModelAttribute("searchVO") DayReportVO searchVO
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("KMS039");
    	List<CmmnDetailCode> excludeLeaderCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
    	CmmnDetailCode excludeLeader = new CmmnDetailCode();
    	CmmnDetailCode exceptionUsers = new CmmnDetailCode();    	   
    	if(excludeLeaderCode.size() > 1){
    		excludeLeader = (CmmnDetailCode)excludeLeaderCode.get(0);
    		exceptionUsers = (CmmnDetailCode)excludeLeaderCode.get(1);
	    }
    	
    	searchVO.setExcludeLeader(excludeLeader.getCodeDc());	
    	searchVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
    	searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()) );
    	searchVO.setSearchUserMixList(CommonUtil.makeValidIdList(searchVO.getSearchUserMix()) );
    	
    	List<EgovMap> resultList = new ArrayList<EgovMap>();   
    	List<EgovMap> resultListSec = new ArrayList<EgovMap>();
    	
    	if(user.isAdmin()){
    		searchVO.setMyOrgId(""); //비워둬야 전체검색 LIKE CONCAT('%', #myOrgId#, '%')
    		model.addAttribute("orgnztId", "");	//조직트리 전체검색
    		resultList = dayReportService.selectDayReportUserList(searchVO);    
    	} else if(user.isDayreportuserlist()) {
    		searchVO.setMyOrgId(user.getOrgnztId()); //예하부서 검색
    		model.addAttribute("orgnztId", user.getOrgnztId()); //조직트리 예하부서검색
    		resultList = dayReportService.selectDayReportUserList(searchVO);
    		
    		// 겸직부서 리스트 추가.
			// 겸직부서가 존재할 경우에만..
			if (user.getOrgnztIdSec() != null && !"".equals(user.getOrgnztIdSec())) {
				searchVO.setMyOrgId(user.getOrgnztIdSec());	// 겸직부서 조회
				resultListSec = dayReportService.selectDayReportUserList(searchVO);
				resultList.addAll(resultListSec);
			}
    	} else {
    		model.addAttribute("message", "업무일지 작성현황 조회권한이 없습니다.");
			return "error/messageError";
    	}
    		
		model.addAttribute("resultList", resultList);		
		return "cooperation/coop_dayReportUserList";
	}
    
    @RequestMapping(value="/cooperation/selectDayReportUserListExcel1.do")
	public String selectDayReportUserListExcel1(@ModelAttribute("searchVO") DayReportVO searchVO
			, Map<String,Object> commandMap
			, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(req);
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
    	codeVO.setCodeId("KMS039");
    	List<CmmnDetailCode> excludeLeaderCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
    	CmmnDetailCode excludeLeader = new CmmnDetailCode();
    	CmmnDetailCode exceptionUsers = new CmmnDetailCode();    	   
    	if(excludeLeaderCode.size() > 1){
    		excludeLeader = (CmmnDetailCode)excludeLeaderCode.get(0);
    		exceptionUsers = (CmmnDetailCode)excludeLeaderCode.get(1);
	    }
    	
    	searchVO.setExcludeLeader(excludeLeader.getCodeDc());	
    	searchVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
    	searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()) );
    	if(user.isAdmin()){
    		searchVO.setMyOrgId(""); //비워둬야 전체검색 LIKE CONCAT('%', #myOrgId#, '%')
    		model.addAttribute("orgnztId", "");	//조직트리 전체검색
    	} else if(user.isDayreportuserlist()) {
    		searchVO.setMyOrgId(user.getOrgnztId()); //예하부서 검색
    		model.addAttribute("orgnztId", user.getOrgnztId()); //조직트리 예하부서검색
    	} else {
    		model.addAttribute("message", "업무일지 작성현황 조회권한이 없습니다.");
			return "error/messageError";
    	}
    	searchVO.setSearchUserMixList(CommonUtil.makeValidIdList(searchVO.getSearchUserMix()) );
    	
    	List<EgovMap> resultList = dayReportService.selectDayReportUserList(searchVO);    	
		model.addAttribute("resultList", resultList);		
		    	
		String filerealname = "업무일지_작성현황_"+ CalendarUtil.getToday() + ".xls";
	    String filedownname = new String(filerealname.getBytes("euc-kr"),"8859_1");
	
		res.setHeader("Content-Disposition", "attachment; filename=" + filedownname); 
	    res.setHeader("Content-Description", "JSP Generated Data");
	    return "cooperation/coop_dayReportUserListExcel";
	}
	
	@RequestMapping("/cooperation/selectTaskInfo.do")
	public String selectTaskInfo(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		// 팀원들의 정보도 조회하기 위해 수정
		MemberVO user = SessionUtil.getMember(req);		
		if(user.isAdmin()){
			commandMap.put("myOrgId", "");
		} else {
			commandMap.put("myOrgId", user.getOrgnztId());
			commandMap.put("myOrgIdSec", user.getOrgnztIdSec());
		}
		
		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		
		List<Task> taskHistoryList = dayReportService.selectTaskHistoryList(commandMap);
		
		
		model.addAttribute("result", result);
		model.addAttribute("taskHistoryList", taskHistoryList);
		model.addAttribute("searchVO", commandMap);
		
		return "cooperation/coop_dayReportV";
	}
	
	
	@RequestMapping("/cooperation/insertTaskView.do")
	public String insertTaskView(MemberVO memberVO, Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO member = (MemberVO) memberService.selectMember(memberVO).get("member");
		
		String date = (String)commandMap.get("date");
		if (date == null || date.equals("")) date = CalendarUtil.getToday();
		
		String param_returnUrl =  (String)commandMap.get("param_returnUrl");
		
		model.addAttribute("date", date);
		model.addAttribute("member", member);
		model.addAttribute("param_returnUrl", param_returnUrl);

		return "cooperation/coop_pop_taskW";
	}
	@RequestMapping("/cooperation/insertTask.do")
	public String insertTask(Task task, HttpServletRequest req, ModelMap model, Map<String,Object> commandMap) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		
		
		task.setWriterNo(user.getUserNo());
		task.setWriterNm(user.getUserNm());
		task.setWriterId(user.getUserId());
		
		task.setUserMixList(CommonUtil.makeValidIdList(task.getUserNm()));
		
		
		dayReportService.insertTask(task);

		
		//부재현황 등록
		WorkState workState = new WorkState();
		workState.setUserNo(user.getUserNo());	
		workState.setWriterNo(user.getUserNo());	
		workState.setUserMoblphonNo(user.getMoblphonNo());
		workState.setUserIp(user.getUserIp());
		workState.setIsInnerNetwork(user.getIsInnerNetwork());
		
		workState.setWsTyp((String)commandMap.get("wsTyp"));
		workState.setWsBgnDe((String)commandMap.get("taskStartdate"));
		workState.setWsBgnTm((String)commandMap.get("taskStarttime"));
		workState.setWsEndDe((String)commandMap.get("taskDuedate"));
		workState.setWsEndTm((String)commandMap.get("taskDuetime"));
		workState.setWsPlace((String)commandMap.get("wsPlace"));
		
		String wsPurpose = (String)commandMap.get("prjNm")+"\r\n"+task.getTaskSj()+"\r\n";
		wsPurpose += task.getTaskCn()+"\r\n";
		workState.setWsPurpose(wsPurpose);
		
		String sMsgExist = "중복외근등록 불가\\n해당 일자 시간에 이미 등록된 데이터가 있습니다";
		String param_returnUrl = "";
		model.addAttribute("message", "");
		
		if (workState.getWsTyp().equals("O")) { //외근 O
			int iCount = workStateService.checkExistAbsentData(workState);
			if(iCount == 0){
				workStateService.insertWorkState(workState);
				param_returnUrl =  "/cooperation/selectDayReportMyList.do";
			} else {
				model.addAttribute("message", sMsgExist);
			}
		}else if(workState.getWsTyp().equals("T") || workState.getWsTyp().equals("S")) { //출장 파견 T S
			workStateService.insertWorkState(workState);
			
			param_returnUrl =  "/cooperation/selectDayReportMyList.do";
		}else{
			param_returnUrl =  req.getParameter("param_returnUrl");
		}
		
		if(model.get("message").equals("") == false){
			return "error/messageError";			
		}
		
		model.addAttribute("param_returnUrl", param_returnUrl);
		
		return "cooperation/closePage";	
	}
	@RequestMapping("/cooperation/updateTaskView.do")
	public String updateTaskView(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		
		model.addAttribute("result", result);
		model.addAttribute("searchVO", commandMap);
		
		return "cooperation/coop_pop_taskM";
	}
	@RequestMapping("/cooperation/updateTask.do")
	public String updateTask(Map<String,Object> commandMap, Task task, HttpServletRequest req, ModelMap model) throws Exception {
		
		List<String> userMixList = CommonUtil.makeValidIdListArray(req.getParameter("leaderMixes"));
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
    	param.put("alarmUserList", 0);
		List<MemberVO> memberList = memberService.selectMemberListById(param);

		task.setUserNo(memberList.get(0).getUserNo());
		task.setUserNm(memberList.get(0).getUserNm());
		task.setUserId(memberList.get(0).getUserId());
		task.setRootUrl(req.getRequestURL().substring(0, req.getRequestURL().indexOf("/", "http://".length())));
		
		
		/*
		프로젝트 변경 = CP
		담당자 변경 - CL 
		시작일 변경 - CS 
		시작 시작 변경 - CDS 
		
		예정일 변경 - CD 
		예정 시간 변경 - CDT
		
		시작일 변경 - CS 
		내용 수정 - CC
		미완료 - P
		완료처리 - C 

		*/
		MemberVO user = SessionUtil.getMember(req);
		TaskVO task2 = dayReportService.selectTaskInfo(commandMap);
			if(!task.getPrjId().equals(task2.getPrjId())){
				Task taskHistory = new Task();
				taskHistory.setTaskId(task.getTaskId());
				taskHistory.setHistoryStat("CP");
				taskHistory.setWriterNo(user.getUserNo());
				taskHistory.setHistoryCn(task2.getPrjId()+"->"+task.getPrjId());
				dayReportService.insertTaskStateHistory(taskHistory);
			}

		
		
		//담장자 변경		
		String userNm = task2.getUserNm() + "(" + task2.getUserId() + ")";
		String cUserNm = (String)commandMap.get("leaderMixes");
		if(!userNm.equals(cUserNm)){	
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CL");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(userNm+"->"+cUserNm);
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		//시작일 변경
		if(!task.getTaskStartdate().equals(task2.getTaskStartdate())){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CS");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskStartdate()+"->"+task.getTaskStartdate());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		/*시작 시간 변경*/
		if(!task.getTaskStarttime().equals(task2.getTaskStarttime())){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CST");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskStarttime()+"->"+task.getTaskStarttime());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		
		
		//예정일 변경
		if(!task.getTaskDuedate().equals(task2.getTaskDuedate())){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CD");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskDuedate()+"->"+task.getTaskDuedate());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}

		/*예정 시간 변경*/
		if(!task.getTaskDuetime().equals(task2.getTaskDuetime())){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CDT");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskDuetime()+"->"+task.getTaskDuetime());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		
		
		//시작일 변경
		if(!task.getTaskStartdate().equals(task2.getTaskStartdate())){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CS");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskStartdate()+"->"+task.getTaskStartdate());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		

		
		//내용 수정
		if(!task.getTaskCn().equals(task2.getTaskCn())){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CC");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn("내용 수정");
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		
		
		dayReportService.updateTask(task);
		
		return "cooperation/closePage";
	}
	@RequestMapping("/cooperation/updateTaskState.do")
	public String updateTaskState(Map<String,Object> commandMap, Task task, HttpServletRequest req, ModelMap model) throws Exception {

		
		MemberVO user = SessionUtil.getMember(req);
		
		/*
		프로젝트 변경 = CP
		담당자 변경 - CL 
		시작일 변경 - CS 
		예정일 변경 - CD 
		미완료 - P
		완료처리 - C 
		
		
			*/
		
		TaskVO task2 = dayReportService.selectTaskInfo(commandMap);
	
		task.setUserNo(null); //담당자 변경시 셋
		//담장자 변경		
		String userNm = task2.getUserNm() + "(" + task2.getUserId() + ")";
		String cUserNm = (String)commandMap.get("leaderMixes");
		if(!"".equals(cUserNm) && cUserNm != null ){
			List<String> userMixList = CommonUtil.makeValidIdListArray(cUserNm);
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
	    	param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
	
			task.setUserNo(memberList.get(0).getUserNo());
			task.setUserNm(memberList.get(0).getUserNm());
			task.setUserId(memberList.get(0).getUserId());
			
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CL");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(userNm+"->"+cUserNm);
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		//시작일 변경
		if(!"".equals(task.getTaskStartdate()) && task.getTaskStartdate() != null){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CS");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskStartdate()+"->"+task.getTaskStartdate());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		//예정일 변경
		if(!"".equals(task.getTaskDuedate()) && task.getTaskDuedate() != null){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CD");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskDuedate()+"->"+task.getTaskDuedate());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		
		//처리 상태 변경
		if(task.getTaskState() != task2.getTaskState()){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat(task.getTaskState());
			taskHistory.setWriterNo(user.getUserNo());
			String taskStat = "";
			if("C".equals(task.getTaskState())){
				taskStat = "완료";
			}else{
				taskStat = "미완료";
			}
			
			String taskStat2 = "";
			if("C".equals(task2.getTaskState())){
				taskStat2 = "완료";
			}else{
				taskStat2 = "미완료";
			}
			taskHistory.setHistoryCn(taskStat2+"->"+taskStat);
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
	
		dayReportService.updateTaskState(task);

		model.addAttribute("searchVO", commandMap);
		
		return "forward:" + commandMap.get("param_returnUrl");
	}
	@RequestMapping("/cooperation/updateTaskState2.do")
	public String updateTaskState2(Map<String,Object> commandMap, Task task, HttpServletRequest req, ModelMap model) throws Exception {
		
MemberVO user = SessionUtil.getMember(req);
		
		/*
		프로젝트 변경 = CP
		담당자 변경 - CL 
		시작일 변경 - CS 
		예정일 변경 - CD 
		미완료 - P
		완료처리 - C 
		
		
			*/
		
		TaskVO task2 = dayReportService.selectTaskInfo(commandMap);
	
		task.setUserNo(null); //담당자 변경시 셋
		//담장자 변경		
		String userNm = task2.getUserNm() + "(" + task2.getUserId() + ")";
		String cUserNm = (String)commandMap.get("leaderMixes");
		if(!"".equals(cUserNm) && cUserNm != null ){
			List<String> userMixList = CommonUtil.makeValidIdListArray(cUserNm);
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
	    	param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
	
			task.setUserNo(memberList.get(0).getUserNo());
			task.setUserNm(memberList.get(0).getUserNm());
			task.setUserId(memberList.get(0).getUserId());
			
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CL");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(userNm+"->"+cUserNm);
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		//시작일 변경
		if(!"".equals(task.getTaskStartdate()) && task.getTaskStartdate() != null){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CS");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskStartdate()+"->"+task.getTaskStartdate());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		//예정일 변경
		if(!"".equals(task.getTaskDuedate()) && task.getTaskDuedate() != null){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat("CD");
			taskHistory.setWriterNo(user.getUserNo());
			taskHistory.setHistoryCn(task2.getTaskDuedate()+"->"+task.getTaskDuedate());
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		
		//처리 상태 변경
		if(task.getTaskState() != task2.getTaskState()){
			Task taskHistory = new Task();
			taskHistory.setTaskId(task.getTaskId());
			taskHistory.setHistoryStat(task.getTaskState());
			taskHistory.setWriterNo(user.getUserNo());
			String taskStat = "";
			if("C".equals(task.getTaskState())){
				taskStat = "완료";
			}else{
				taskStat = "미완료";
			}
			
			String taskStat2 = "";
			if("C".equals(task2.getTaskState())){
				taskStat2 = "완료";
			}else{
				taskStat2 = "미완료";
			}
			taskHistory.setHistoryCn(taskStat2+"->"+taskStat);
			dayReportService.insertTaskStateHistory(taskHistory);			
		}
		
		
		
		dayReportService.updateTaskState(task);
		
		model.addAttribute("searchVO", commandMap);
		
		return "forward:/cooperation/selectTaskInfo.do";
	}
	@RequestMapping("/cooperation/deleteTask.do")
	public String deleteTask(Map<String,Object> commandMap, Task task, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.deleteTask(task);
		
		model.addAttribute("searchVO", commandMap);
		
		String param_returnUrl = (String)commandMap.get("param_returnUrl");
		if(param_returnUrl != "" && param_returnUrl != null){
		return "forward:" + commandMap.get("param_returnUrl");
		}else{
		return "forward:/cooperation/selectDayReport.do";
		}
	}
	@RequestMapping("/cooperation/insertDayReportView.do")
	public String insertDayReportView(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		
		MemberVO user = SessionUtil.getMember(req);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userNo", user.getUserNo());
		List<EgovMap> headList = memberService.selectHeaderList(param);
		
		model.addAttribute("result", result);
		model.addAttribute("today", CalendarUtil.getToday());
		model.addAttribute("yesterday", CalendarUtil.getYesterday());
		model.addAttribute("thisTime", CalendarUtil.getThisTime());
		model.addAttribute("headList", headList);
		model.addAttribute("searchVO", commandMap);
		
		return "cooperation/coop_pop_dayReportW";
	}
	@RequestMapping("/cooperation/insertDayReport.do")
	public String insertDayReport(Map<String,Object> commandMap, 
				MultipartHttpServletRequest multiRequest, ModelMap model) throws Exception {
		
		String taskId = (String)commandMap.get("taskId");
		Integer userNo = Integer.parseInt((String)commandMap.get("userNo"));
		Integer cnt = Integer.parseInt((String)commandMap.get("cnt"));
		cnt = ((2 <= cnt) && (cnt <= 5)) ? cnt : 1;	// 한번에 등록할 수 있는 실적 최대갯수는 5. 혹시나 jsp에서 더 큰수가 넘어올 경우를 대비. 
		
		String type = (String)commandMap.get("type");
		
		MemberVO memberVO = new MemberVO();
		memberVO.setNo(userNo);
		MemberVO member = memberDAO.selectMember(memberVO);
		String userId = member.getUserId();
		String userNm = member.getUserNm();
		
		String wsPurpose = (String)commandMap.get("prjNm")+"\r\n"+(String)commandMap.get("taskNm")+"\r\n";
		
		
		if (cnt == 1) {
			String dayReportDt = (String)commandMap.get("dayReportDt");
			String dayReportTm = (String)commandMap.get("dayReportTm");
			String dayReportCn = (String)commandMap.get("dayReportCn");
			
			DayReport dayReport = new DayReport();
			
			dayReport.setUserNo(userNo);
			dayReport.setUserId(userId);
			dayReport.setUserNm(userNm);
			dayReport.setTaskId(taskId);
			dayReport.setDayReportDt(dayReportDt);
			dayReport.setDayReportTm(dayReportTm);
			dayReport.setDayReportCn(CommonUtil.unscript(dayReportCn));
			dayReport.setPrjId((String)commandMap.get("prjId"));
			
			List<FileVO> result = null;
			String atchFileId = "";

			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "DAY_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
			dayReport.setAttachFileId(atchFileId);
			
			dayReportService.insertDayReport(dayReport);
			
			wsPurpose += dayReport.getDayReportCn()+"\r\n";
			
		} else {
			
			List<DayReport> dayReportList = new ArrayList<DayReport>();
			
			String[] dayReportDt = (String[])commandMap.get("dayReportDt");
			String[] dayReportTm = (String[])commandMap.get("dayReportTm");
			String[] dayReportCn = (String[])commandMap.get("dayReportCn");

			for (int i=0; i<cnt; i++) {
				DayReport dayReport = new DayReport();

				dayReport.setUserNo(userNo);
				dayReport.setUserId(userId);
				dayReport.setUserNm(userNm);
				dayReport.setTaskId(taskId);
				dayReport.setDayReportDt(dayReportDt[i]);
				dayReport.setDayReportTm(dayReportTm[i]);
				dayReport.setDayReportCn(CommonUtil.unscript(dayReportCn[i]));
				
				dayReportList.add(dayReport);
				
				wsPurpose += dayReport.getDayReportCn()+"\r\n";
				
			}
			dayReportService.insertDayReport(dayReportList);
		}
		
		if("end".equals(type)){
			Task taskHistory = new Task();
			taskHistory.setTaskId(taskId);
			taskHistory.setHistoryStat("C");
			taskHistory.setTaskState("C");
			taskHistory.setWriterNo(userNo);
			taskHistory.setHistoryCn("미완료->완료");
			dayReportService.insertTaskStateHistory(taskHistory);			
			dayReportService.updateTaskState(taskHistory);	
		}
		
		
		//연장근무 등록
		MemberVO user = SessionUtil.getMember(multiRequest);				
		WorkState workState = new WorkState();
		workState.setUserNo(user.getUserNo());	
		workState.setWriterNo(user.getUserNo());	
		workState.setUserMoblphonNo(user.getMoblphonNo());
		workState.setUserIp(user.getUserIp());
		workState.setIsInnerNetwork(user.getIsInnerNetwork());
		workState.setWsTyp((String)commandMap.get("wsTyp"));
		workState.setWsBgnDe((String)commandMap.get("wsBgnDe"));
		workState.setWsBgnTm((String)commandMap.get("wsBgnTm"));
		workState.setWsHrCnt(Integer.parseInt((String)commandMap.get("wsHrCnt")));
		workState.setWsPurpose(wsPurpose);
		
		if (workState.getWsTyp().equals("N")) {
			Calendar cal = Calendar.getInstance();
			int iHour = cal.get(Calendar.HOUR_OF_DAY);
			int iWsBgnTm = Integer.parseInt(workState.getWsBgnTm());
			int iToday = Integer.parseInt(CalendarUtil.getToday());
			int iYesterday = Integer.parseInt(CalendarUtil.getYesterday());
			int iWsBgnDe = Integer.parseInt(workState.getWsBgnDe());				
			String sMsg = "당일 야근 해당시간에만 등록 가능합니다";
			model.addAttribute("message", "");
	
			// 등록장소 입력
			workState.setWsPlace(user.getIsInnerNetworkPrint2());
			String wsId = workStateService.selectExistAbsentDataWsId(workState);
			workState.setWsId(wsId);
			
			// 당일 등록은 22시 23시만 해당시간 이후에만 등록
			if(iToday == iWsBgnDe) {
				if(iHour > 21 && iHour >= iWsBgnTm) {
					if(wsId == null || wsId.equals("") )
						workStateService.insertWorkState(workState);
					else
						workStateService.updateWorkState(workState);
				} else 							
					model.addAttribute("message", sMsg);
				
			} // 전일 등록은 6시 이전까지만 등록.6시는 5시~5:59:59까지 등록가능
			else if(iYesterday == iWsBgnDe) {
				if( (iHour < 6 && iWsBgnTm > 21) ||//22, 23, 24시
				   (iHour < 6 && iHour >= iWsBgnTm) || //1, 2, 3, 4, 5시
				   (iHour == 5 && iWsBgnTm == 6) ) { // 6시 야근등록은 5시~5:59:59까지 등록
					
					if(wsId == null || wsId.equals("") )
						workStateService.insertWorkState(workState);
					else
						workStateService.updateWorkState(workState);
				} else {
					model.addAttribute("message", sMsg);
				}
			} else { // 당일 전일 외 아예 다른 날
				model.addAttribute("message", sMsg);
			}
			
			if(model.get("message").equals("") == false){
				return "error/messageError";			
			}
			
			model.addAttribute("param_returnUrl", "/member/selectOvertimeView.do");
	
		}
		
		//== 푸쉬 보고 대상자에게 푸쉬 메세지 발송 ==
		// 푸쉬 보고 대상자 휴대전화 번호 설정
		String[] moblphonList;
		String moblphon = "";
		List<String> rPhoneList = new ArrayList<String>();
		try {
			moblphonList = (String[])commandMap.get("headMoblphonNo");
			
			for (int i = 0; i < moblphonList.length; i++) {
				String toPhoneNo = moblphonList[i].replace("-", "");
				if (toPhoneNo != null && !toPhoneNo.equals("")) {
					rPhoneList.add(toPhoneNo);
				}
			}
		} catch(Exception ex) {
			moblphon = (String)commandMap.get("headMoblphonNo");
			if (moblphon!=null) {
				rPhoneList.add(moblphon.replace("-", ""));
			}
		}
		
		// 푸쉬 대상을 선택하지 않으면, 푸쉬 메세지가 발송되지 않는다.
		if (moblphon!=null) {
			// 공통 파라미터 가공
			String title = (String)commandMap.get("taskNm");
			String urlMsg = "\n\n" + "관련 프로젝트 : " + (String)commandMap.get("prjNm") + "\n"
					+ multiRequest.getRequestURL().substring(0, multiRequest.getRequestURL().indexOf("/", "http://".length()))  
					+ "/cooperation/selectProjectV.do?prjId=" + (String)commandMap.get("prjId");
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setTitle(title);
			pushVO.setAddMsg(urlMsg);
			// 내용: Link 추가
			
			String pushType = "task";
			
			// 푸쉬 발송(실적 등록 갯수만큼 푸쉬)
			if (cnt == 1) {
				pushVO.setMsg((String)commandMap.get("dayReportCn"));
				String pushResult = pushSender.sendMessage(pushType, pushVO);
			} else {
				String[] dayReportCn = (String[])commandMap.get("dayReportCn");
				for (int i=0; i<cnt; i++) {
					pushVO.setMsg(dayReportCn[i]);
					String pushResult = pushSender.sendMessage(pushType, pushVO);
				}
			}
		}
		
		return "cooperation/closePage";
		
	}
	@RequestMapping("/cooperation/updateDayReportView.do")
	public String updateDayReportView(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		DayReport dayReport = dayReportService.selectDayReport(commandMap);
		
		MemberVO user = SessionUtil.getMember(req);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userNo", user.getUserNo());
		List<EgovMap> headList = memberService.selectHeaderList(param);
		
		model.addAttribute("dayReport", dayReport);
		model.addAttribute("result", result);
		model.addAttribute("today", CalendarUtil.getToday());
		model.addAttribute("headList", headList);
		
		return "cooperation/coop_pop_dayReportM";
	}
	
	@RequestMapping("/cooperation/updateDayReport.do")
	public String updateDayReport(DayReport dayReport, Map<String,Object> commandMap,
			MultipartHttpServletRequest multiRequest, ModelMap model) throws Exception {

		dayReport.setDayReportCn(CommonUtil.unscript(dayReport.getDayReportCn()));
		
		String atchFileId = dayReport.getAttachFileId();

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId)) {
				List<FileVO> result = fileUtil.parseFileInf(files, "DAY_", 0,
						atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				dayReport.setAttachFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "DAY_", cnt,
						atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}
		
		dayReportService.updateDayReport(dayReport);
		
		//== 푸쉬 보고 대상자에게 푸쉬 메세지 발송 ==
		// 푸쉬 보고 대상자 휴대전화 번호 설정
		String[] moblphonList;
		String moblphon = "";
		List<String> rPhoneList = new ArrayList<String>();
		try {
			moblphonList = (String[])commandMap.get("headMoblphonNo");
			
			for (int i = 0; i < moblphonList.length; i++) {
				String toPhoneNo = moblphonList[i].replace("-", "");
				if (toPhoneNo != null && !toPhoneNo.equals("")) {
					rPhoneList.add(toPhoneNo);
				}
			}
		} catch(Exception ex) {
			moblphon = (String)commandMap.get("headMoblphonNo");
			if (moblphon!=null) {
				rPhoneList.add(moblphon.replace("-", ""));
			}
		}
		
		// 푸쉬 대상을 선택하지 않으면, 푸쉬 메세지가 발송되지 않는다.
		if (moblphon!=null) {
			// 공통 파라미터 가공
			String title = (String)commandMap.get("taskNm");
			String urlMsg = "\n\n" + "관련 프로젝트 : " + (String)commandMap.get("prjNm") + "\n"
					+ multiRequest.getRequestURL().substring(0, multiRequest.getRequestURL().indexOf("/", "http://".length()))  
					+ "/cooperation/selectProjectV.do?prjId=" + (String)commandMap.get("prjId");
			MemberVO user = SessionUtil.getMember(multiRequest);
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setTitle(title);
			pushVO.setAddMsg(urlMsg);
			
			String pushType = "task";
			
			// 푸쉬 발송(실적 등록 갯수만큼 푸쉬)
			pushVO.setMsg(dayReport.getDayReportCn());
			String pushResult = pushSender.sendMessage(pushType, pushVO);
		}

		return "cooperation/closePage";
	}
	@RequestMapping("/cooperation/deleteDayReport.do")
	public String deleteDayReport(DayReport dayReport, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.deleteDayReport(dayReport);
		
		return "redirect:/cooperation/selectTaskInfo.do?taskId=" + dayReport.getTaskId();
	}
	
	@RequestMapping("/cooperation/insertTaskContentView.do")
	public String insertTaskContentView(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchUserNo", user.getNo());
		param.put("eDate", "99991231");
		param.put("taskId", (String)commandMap.get("taskId"));
		param.put("taskContentTyp", (String)commandMap.get("taskContentTyp"));
		
		List<TaskVO> taskList = dayReportService.selectTaskList(param);
		
		model.addAttribute("link", commandMap);
		model.addAttribute("taskList", taskList);
		
		return "cooperation/coop_pop_taskContentW";
	}
	@RequestMapping("/cooperation/insertTaskContent.do")
	public String insertTaskContent(Task task, TaskContent taskContent, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		taskContent.setUserNo(user.getNo());
		taskContent.setTaskCntSj(URLDecoder.decode(taskContent.getTaskCntSj(), "UTF-8"));
		
		if ("Y".equalsIgnoreCase((String)commandMap.get("newTask"))) {
			task.setUserId(user.getUserId());
			task.setWriterNo(user.getNo());
			task.setTaskState("P");
			
			String[] userMixList = {user.getUserNm() + "(" + user.getUserId() + ")"};
			task.setUserMixList(userMixList);
			
			dayReportService.insertTask(task);
			taskContent.setTaskId(task.getTaskId());
			
			dayReportService.insertTaskContent(taskContent);
		}
		if ("N".equalsIgnoreCase((String)commandMap.get("newTask"))) {
			dayReportService.insertTaskContent(taskContent);
		}
		
		return "cooperation/closePage";
	}
	@RequestMapping("/cooperation/deleteTaskContent.do")
	public String deleteTaskContent(Map<String,Object> commandMap,TaskContent taskContent, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.deleteTaskContent(taskContent);		
				
		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		List<Task> taskHistoryList = dayReportService.selectTaskHistoryList(commandMap);
		model.addAttribute("result", result);
		model.addAttribute("taskHistoryList", taskHistoryList);
		model.addAttribute("searchVO", commandMap);
		
		return "cooperation/coop_dayReportV";
		
	}
	
	
	
	@RequestMapping("/ajax/dayReportLayer.do")
	public String dayReportLayer(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		
		model.addAttribute("result", result);
		
		return "cooperation/dayReportLayer";
	}
	@RequestMapping("/ajax/projectInputAble.do")
	public void projectInputAble(Map<String,Object> commandMap, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

		String prjId = (String)commandMap.get("prjId");
		Integer userNo = Integer.parseInt((String)commandMap.get("userNo"));
		Integer cnt = Integer.parseInt((String)commandMap.get("cnt"));
		
		String out = "Y";
		
		if (cnt == 1) {
			String dayReportDt = (String)commandMap.get("dayReportDt");
			
			ProjectInputVO projectInputVO = new ProjectInputVO();
			projectInputVO.setUserNo(userNo);
			projectInputVO.setPrjId(prjId);
			projectInputVO.setYear(dayReportDt.substring(0,4));
			projectInputVO.setMonth(String.valueOf(Integer.parseInt(dayReportDt.substring(4,6))));

			if (projectService.selectUserPrjInputCnt(projectInputVO) == 0) {
				out = "N";
			}
		} else {
			String[] dayReportDt = (String[])commandMap.get("dayReportDt");

			for (int i=0; i<cnt; i++) {
				ProjectInputVO projectInputVO = new ProjectInputVO();
				projectInputVO.setUserNo(userNo);
				projectInputVO.setPrjId(prjId);
				projectInputVO.setYear(dayReportDt[i].substring(0,4));
				projectInputVO.setMonth(String.valueOf(Integer.parseInt(dayReportDt[i].substring(4,6))));
				
				if (projectService.selectUserPrjInputCnt(projectInputVO) == 0) {
					out = "N";
				}
			}
		}

    	res.setContentType("text/xml;charset=UTF-8");
		res.getWriter().println( CommonUtil.getXMLStr("<result>" + out + "</result>") );
	}
		
	@RequestMapping("/cooperation/selectDayReportList.do")
	public String selectDayReportList(Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("date", commandMap.get("date"));
		param.put("sDate", commandMap.get("date"));
		param.put("eDate", commandMap.get("date"));
		param.put("userNo", commandMap.get("param_userNo"));
		param.put("taskId", commandMap.get("taskId"));
		
		List<DayReport> resultList = dayReportService.selectDayReportList(param);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", param);
		
		return "cooperation/coop_pop_dayReportL";
	}
	@RequestMapping("/cooperation/deleteDayReportPop.do")
	public String deleteDayReportPop(DayReport dayReport, Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.deleteDayReport(dayReport);
		
		return "forward:" + commandMap.get("param_returnUrl");
	}
	
	
	@RequestMapping("/cooperation/postTaskList.do")
	public String postTaskList(HttpServletRequest request, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("userNo", commandMap.get("param_userNo"));
		param.put("eDate", commandMap.get("param_eDate"));

		List<Task> resultList = dayReportService.selectPostTaskList(param);

		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", commandMap);
		
		return "cooperation/coop_postTaskL";
	}
		
	
	@RequestMapping("/cooperation/getDayReportStats.do")
	public String getDayReportStats(Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		String sDate = (String)commandMap.get("sDate");
		String eDate = (String)commandMap.get("eDate");
		
		if (sDate == null || "".equals(sDate)) {
			sDate = CalendarUtil.getToday();
		}
		if (eDate == null || "".equals(eDate)) {
			eDate = CalendarUtil.getToday();
		}
		commandMap.put("sDate", sDate);
		commandMap.put("eDate", eDate);
		
		List<String> dateList = new ArrayList<String>();
		
		int i=0;
		while (CalendarUtil.getDateDiff(eDate, CalendarUtil.getDate(sDate, i)) >= 0) {
			dateList.add(CalendarUtil.getDate(sDate, i));			
			i++;
		}
		commandMap.put("dateList", dateList);
		
		List<EgovMap> resultList = dayReportService.selectDayReportTmSum(commandMap);
		
		model.addAttribute("searchVO", commandMap);
		model.addAttribute("dateList", dateList);
		model.addAttribute("resultList", resultList);
		
		return "cooperation/coop_dayReportTm";
	}
	@RequestMapping("/cooperation/getDayReportStatsExcel.do")
	public String getDayReportStatsExcel(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

		String sDate = (String)commandMap.get("sDate");
		String eDate = (String)commandMap.get("eDate");
		
		if (sDate == null || "".equals(sDate)) {
			sDate = CalendarUtil.getFirstDateOfThisWeek(CalendarUtil.getToday(), 0);
		}
		if (eDate == null || "".equals(eDate)) {
			eDate = CalendarUtil.getToday();
		}
		commandMap.put("sDate", sDate);
		commandMap.put("eDate", eDate);
		
		List<String> dateList = new ArrayList<String>();
		
		int i=0;
		while (CalendarUtil.getDateDiff(eDate, CalendarUtil.getDate(sDate, i)) >= 0) {
			dateList.add(CalendarUtil.getDate(sDate, i));			
			i++;
		}
		commandMap.put("dateList", dateList);		
		List<EgovMap> resultList = dayReportService.selectDayReportTmSum(commandMap);		
		model.addAttribute("dateList", dateList);
		model.addAttribute("resultList", resultList);

		res.setHeader("Content-Disposition", "attachment; filename=expenseDetail_excel.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "cooperation/coop_dayReportTmExcel";
	}
	
	
	
	
	//나의 업무
	@RequestMapping("/cooperation/selectDayReportMyList.do")
	public String selectDayReportMyList(@ModelAttribute("searchVO") DayReportVO searchVO, Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		commandMap.remove("taskId");
		commandMap.remove("taskState");
			
		MemberVO user = SessionUtil.getMember(req);
			
		List<EgovMap> resultList1 = null;

		searchVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		searchVO.setPageSize(propertyService.getInt("pageSize"));

		
		
		
		////////////////////////////////////////////////////////////////////
		String searchDate = (String)commandMap.get("searchDate");
		if (searchDate == null || searchDate.equals("")) {
			searchDate = CalendarUtil.getToday();
		}
		
		String dateMove = (String)commandMap.get("dateMove");
		if (dateMove != null && dateMove.equals("") == false) {
			searchDate = CalendarUtil.getDate(searchDate, Integer.parseInt(dateMove));
		}
		
		
		
		if("".equals(searchVO.getIncludeEnd()) || searchVO.getIncludeEnd() == null){
			searchVO.setIncludeEnd("Y");
		}
					
		String searchType = searchVO.getSearchType();
		
		if("".equals(searchVO.getSearchType()) || searchVO.getSearchType() == null){
			searchVO.setSearchType("today");
			searchType = searchVO.getSearchType();
		}
		
		
		String searchUserNm = (String)commandMap.get("searchUserNm");

		if (searchUserNm == null || searchUserNm.equals("")) {
			searchUserNm = user.getUserNm() + "(" + user.getUserId() + ")";
		}
		
		List<String> userMixList = CommonUtil.makeValidIdListArray(searchUserNm);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
    	param.put("alarmUserList", 0);
		List<MemberVO> memberList = memberService.selectMemberListById(param);

		searchVO.setUserNo(memberList.get(0).getUserNo());
		searchVO.setUserNm(memberList.get(0).getUserNm());
		searchVO.setUserId(memberList.get(0).getUserId());
		searchVO.setMyOrgId(memberList.get(0).getOrgnztId());
		
		model.addAttribute("quickUserNm", memberList.get(0).getUserNm());
		
		if(!"N".equals(memberList.get(0).getPosition())) { //팀장    		
    		resultList1 = dayReportService.selectDayReportUserList1(searchVO);
    	} else {
    		resultList1 = dayReportService.selectDayReportUserList2(searchVO);
    	}
    	if(user.isAdmin()){ //운영자
    		model.addAttribute("orgnztId", "");	//조직트리 전체검색
    	}else{
    		model.addAttribute("orgnztId", user.getOrgnztId()); //조직트리 예하부서검색
    	}
		
    	
    	String searchDateFrom = (String)commandMap.get("searchDateFrom");
    	if (searchDateFrom == null || searchDateFrom.equals("")) {
    		searchDateFrom = CalendarUtil.getToday();
		}
		
		String searchDateTo = (String)commandMap.get("searchDateTo");
    	if (searchDateTo == null || searchDateTo.equals("")) {
    		searchDateTo = CalendarUtil.getToday();
		}
    	
    	String today = CalendarUtil.getToday();
    	
    	commandMap.put("searchDateFrom", searchDateFrom);
    	commandMap.put("searchDateTo", searchDateTo);
    	commandMap.put("searchFirstDateOfThisWeek",  CalendarUtil.getFirstDateOfThisWeek2(CalendarUtil.getToday())); //기존 일요일 구하는 함수 변형한 월요일 구하는 함수로 변경
		commandMap.put("searchLastDateOfThisWeek", CalendarUtil.getLastDateOfThisWeek(CalendarUtil.getToday()));
		commandMap.put("today", today);
		commandMap.put("searchDate", searchDate);
		commandMap.put("searchType", searchType);
		commandMap.put("searchUserNm", searchUserNm);
		commandMap.put("includeEnd", searchVO.getIncludeEnd());
		commandMap.put("pageYn", "N");
		
		
		List<DayReport> resultList = dayReportService.selectDayReportMyList(commandMap);
		
		int totCnt = dayReportService.selectDayReportMyListTotCnt(commandMap);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		paginationInfo.setTotalRecordCount(totCnt);	
		
		
		
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultList1", resultList1);
		model.addAttribute("searchVO", commandMap);

		
		
		
		commandMap.put("searchType", "today");
		commandMap.put("taskState", "C");
		int todayCCnt = dayReportService.selectDayReportMyListCompleteTotCnt(commandMap);
		commandMap.put("taskState", "P");
		int todayPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(commandMap);
		
		commandMap.put("searchType", "seven");
		commandMap.put("searchDateFrom",  CalendarUtil.getFirstDateOfThisWeek2(CalendarUtil.getToday())); //기존 일요일 구하는 함수 변형한 월요일 구하는 함수로 변경
		commandMap.put("searchDateTo", CalendarUtil.getLastDateOfThisWeek(CalendarUtil.getToday()));
		
		commandMap.put("taskState", "C");
		int sevenCCnt = dayReportService.selectDayReportMyListCompleteTotCnt(commandMap);
		commandMap.put("taskState", "P");
		int sevenPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(commandMap);
		
		commandMap.put("searchType", "thirty");
		commandMap.put("searchDateFrom",  today.substring(0,6) + "01");
		
		Calendar cal = Calendar.getInstance(); //캘린더 인스턴스 얻기
		String endDate = Integer.toString(cal.getActualMaximum(Calendar.DATE)); //달의 마지막일 얻기
		commandMap.put("searchDateTo", today.substring(0,6)+endDate);

		
		commandMap.put("taskState", "C");
		int thirtyCCnt = dayReportService.selectDayReportMyListCompleteTotCnt(commandMap);
		commandMap.put("taskState", "P");
		int thirtyPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(commandMap);
		
		commandMap.put("searchType", "next");
		commandMap.put("taskState", "C");
		int nextCCnt = dayReportService.selectDayReportMyListCompleteTotCnt(commandMap);
		commandMap.put("taskState", "P");
		int nextPCnt = dayReportService.selectDayReportMyListCompleteTotCnt(commandMap);		
		
		
		
		
		commandMap.put("searchType", searchType); //오늘, 7일내, 30일이내, 향후 Cnt를 구한후 다시 원래의 type으로 셋팅
		commandMap.put("searchDateFrom", searchDateFrom); //오늘, 7일내, 30일이내, 향후 Cnt를 구한후 다시 셋팅
		commandMap.put("searchDateTo", searchDateTo); //오늘, 7일내, 30일이내, 향후 Cnt를 구한후 다시 셋팅

		
		model.addAttribute("todayCCnt", todayCCnt);
		model.addAttribute("todayPCnt", todayPCnt);
		model.addAttribute("sevenCCnt", sevenCCnt);
		model.addAttribute("sevenPCnt", sevenPCnt);
		model.addAttribute("thirtyCCnt", thirtyCCnt);
		model.addAttribute("thirtyPCnt", thirtyPCnt);
		model.addAttribute("nextCCnt", nextCCnt);
		model.addAttribute("nextPCnt", nextPCnt);
		
		return "cooperation/coop_dayReportMyL"; 
		
	}

	   
	@RequestMapping("/cooperation/selectDayReportOrderList.do")
	public String selectDayReportOrderList(@ModelAttribute("searchVO") DayReportVO searchVO, Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		commandMap.remove("taskId");
		commandMap.remove("taskState");
			
		MemberVO user = SessionUtil.getMember(req);
		
	
		
		searchVO.setUserId(user.getUserId());
		searchVO.setUserNo(user.getUserNo());
		
		
		
		if("N".equals(searchVO.getStateDYn()) && "N".equals(searchVO.getStateDYn()) && "N".equals(searchVO.getStateDYn())){
			searchVO.setStateDYn("Y");
			searchVO.setStatePYn("Y");
			searchVO.setStateCYn("N");
		}
		
		if("".equals(searchVO.getStateDYn()) || searchVO.getStateDYn() == null){
			searchVO.setStateDYn("Y");
		}
		if("".equals(searchVO.getStatePYn()) || searchVO.getStatePYn() == null){
			searchVO.setStatePYn("Y");
		}
		if("".equals(searchVO.getStateCYn()) || searchVO.getStateCYn() == null){
			searchVO.setStateCYn("N");
		}

		if("".equals(searchVO.getSearchWriterNm()) || searchVO.getSearchWriterNm() == null ){
			
			if("".equals(searchVO.getSearchUserNm()) || searchVO.getSearchUserNm() == null){
				searchVO.setSearchWriterNm(user.getUserNm()+"("+user.getUserId()+")");
			}
		}
		
		if("".equals(searchVO.getSearchUserNm()) || searchVO.getSearchUserNm() == null){
			//searchVO.setSearchUserNm(user.getUserNm()+"("+user.getUserId()+"),");
		}
		if("".equals(searchVO.getSearchSdate()) || searchVO.getSearchSdate() == null){
			searchVO.setSearchSdate(CalendarUtil.getSevenDayAgo());
		}
		if("".equals(searchVO.getSearchEdate()) || searchVO.getSearchEdate() == null){
			searchVO.setSearchEdate(CalendarUtil.getSevenDayNext());
		}
		
		searchVO.setSearchFirstDateOfThisWeek(CalendarUtil.getFirstDateOfThisWeek2(CalendarUtil.getToday()));
		searchVO.setSearchLastDateOfThisWeek(CalendarUtil.getLastDateOfThisWeek(CalendarUtil.getToday()));
		
		searchVO.setSearchUserIdList(CommonUtil.parseIdFromMixs(searchVO.getSearchUserNm()));
		
		searchVO.setToday(CalendarUtil.getToday());
		
		searchVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<DayReport> resultList = dayReportService.selectDayReportOrderList(searchVO);
		
		int totCnt = dayReportService.selectDayReportOrderListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);	
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", searchVO);

		return "cooperation/coop_dayReportOrderL"; 
		
	}
	   
	@RequestMapping("/cooperation/selectDayReportMyDList.do")
	public String selectDayReportMyDList(@ModelAttribute("searchVO") DayReportVO dayReportVO, Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
			
		MemberVO user = SessionUtil.getMember(req);
		
		List<EgovMap> resultList1 = null;
	
		if("".equals(dayReportVO.getSearchUserNm()) || dayReportVO.getSearchUserNm() == null){
			//dayReportVO.setSearchUserNm(user.getUserNm()+"("+user.getUserId()+"),");
			Map<String,Object> searchParam = new HashMap<String,Object>();
			searchParam.put("userId", user.getUserId());
			searchParam.put("orgnztId", user.getOrgnztId());
			searchParam.put("position", user.getPosition());
			List<EgovMap> teamList = memberService.selectTeamList(searchParam);
			dayReportVO.setSearchUserNm(memberService.selectTeamListToString(teamList));
		}
		if("".equals(dayReportVO.getSearchSdate()) || dayReportVO.getSearchSdate() == null){
			dayReportVO.setSearchSdate(CalendarUtil.getToday());
		}
		if("".equals(dayReportVO.getSearchEdate()) || dayReportVO.getSearchEdate() == null){
			dayReportVO.setSearchEdate(CalendarUtil.getToday());
		}
		
		List<String> userMixList = CommonUtil.makeValidIdListArray(dayReportVO.getSearchUserNm());
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
    	param.put("alarmUserList", 0);
		List<MemberVO> memberList = memberService.selectMemberListById(param);

		dayReportVO.setUserNo(user.getUserNo());
		dayReportVO.setUserNm(user.getUserNm());
		dayReportVO.setUserId(user.getUserId());
		dayReportVO.setMyOrgId(user.getOrgnztId());
		
		model.addAttribute("quickUserNm", memberList.get(0).getUserNm());
		
		if(!"N".equals(memberList.get(0).getPosition())) { //팀장    		
    		resultList1 = dayReportService.selectDayReportUserList1(dayReportVO);
    	} else {
    		resultList1 = dayReportService.selectDayReportUserList2(dayReportVO);
    	}
    	if(user.isAdmin()){ //운영자
    		model.addAttribute("orgnztId", "");	//조직트리 전체검색
    	}else{
    		model.addAttribute("orgnztId", user.getOrgnztId()); //조직트리 예하부서검색
    	}
    	
		
		
		dayReportVO.setSearchUserIdList(CommonUtil.parseIdFromMixs(dayReportVO.getSearchUserNm()));
		dayReportVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		dayReportVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(dayReportVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(dayReportVO.getPageUnit());
		paginationInfo.setPageSize(dayReportVO.getPageSize());
		
		dayReportVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		dayReportVO.setLastIndex(paginationInfo.getLastRecordIndex());
		dayReportVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		

		
		List<TaskVO> resultList =  dayReportService.selectDayReportMyDList(dayReportVO);
		
		//List<DayReportVO> resultList = dayReportService.selectDayReportMyDList(dayReportVO);
		int totCnt = dayReportService.selectDayReportMyTListTotCnt(dayReportVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO", dayReportVO);
		model.addAttribute("resultList1", resultList1);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "cooperation/coop_dayReportMyDL"; 
	}
}
