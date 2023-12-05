package kms.com.cooperation.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.DayReport;
import kms.com.cooperation.service.DayReportDetail;
import kms.com.cooperation.service.DayReportService;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.Task;
import kms.com.cooperation.service.TaskContent;
import kms.com.cooperation.service.TaskVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class DayReportMobileController {

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
	
	@RequestMapping("/mobile/cooperation/selectDayReport.do")
	public String selectDayReport(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		commandMap.remove("taskId");
		commandMap.remove("taskState");
		
		MemberVO user = SessionUtil.getMember(req);
		
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
		commandMap.put("today", CalendarUtil.getToday());
		commandMap.put("searchDate", searchDate);
		commandMap.put("searchUserNm", searchUserNm);
		
		List<DayReportDetail> resultList = dayReportService.selectDayReportDetail(commandMap);
		List<Map<String, Object>> dateList = CalendarUtil.getDateList((String)commandMap.get("sDate"));
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("dateList", dateList);
		model.addAttribute("searchVO", commandMap);
		
		return "mobile/cooperation/coop_dayReportLD"; 
	}
	@RequestMapping("/mobile/cooperation/selectTaskInfo.do")
	public String selectTaskInfo(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		
		model.addAttribute("result", result);
		model.addAttribute("searchVO", commandMap);
		
		return "cooperation/coop_dayReportV";
	}
	
	@RequestMapping("/mobile/cooperation/insertTaskView.do")
	public String insertTaskView(MemberVO memberVO, Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO member = (MemberVO) memberService.selectMember(memberVO).get("member");
		
		String date = (String)commandMap.get("date");
		if (date == null || date.equals("")) date = CalendarUtil.getToday();
		
		model.addAttribute("date", date);
		model.addAttribute("member", member);
		
		return "mobile/cooperation/coop_dayReportW";
	}
	@RequestMapping("/mobile/cooperation/insertTask.do")
	public String insertTask(Task task, HttpServletRequest req, ModelMap model) throws Exception {
		
		task.setUserMixList(CommonUtil.makeValidIdList(task.getUserNm()));
		
		dayReportService.insertTask(task);
		
		return "redirect:/mobile/cooperation/selectDayReport.do?searchDate="+task.getTaskStartdate();
	}
	@RequestMapping("/mobile/cooperation/updateTaskView.do")
	public String updateTaskView(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		
		model.addAttribute("result", result);
		model.addAttribute("searchVO", commandMap);
		
		return "mobile/cooperation/coop_dayReportE";
	}
	@RequestMapping("/mobile/cooperation/updateTask.do")
	public String updateTask(Task task, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.updateTask(task);
		
		return "redirect:/mobile/cooperation/selectDayReport.do?searchDate="+task.getTaskStartdate();
	}
	@RequestMapping("/mobile/cooperation/updateTaskState.do")
	public String updateTaskState(Map<String,Object> commandMap, Task task, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.updateTaskState(task);

		model.addAttribute("searchVO", commandMap);

		return "redirect:" + (String)commandMap.get("param_returnUrl");
	}
	@RequestMapping("/mobile/cooperation/updateTaskState2.do")
	public String updateTaskState2(Map<String,Object> commandMap, Task task, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.updateTaskState(task);
		
		model.addAttribute("searchVO", commandMap);
		
		return "forward:/cooperation/selectTaskInfo.do";
	}
	@RequestMapping("/mobile/cooperation/deleteTask.do")
	public String deleteTask(Map<String,Object> commandMap, Task task, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.deleteTask(task);
		
		model.addAttribute("searchVO", commandMap);
		
		return "forward:/mobile/cooperation/selectDayReport.do";
	}
	@RequestMapping("/mobile/cooperation/insertDayReportView.do")
	public String insertDayReportView(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		
		model.addAttribute("result", result);
		model.addAttribute("today", CalendarUtil.getToday());
		model.addAttribute("searchVO", commandMap);
		
		return "mobile/cooperation/performance_dayReportW";
	}
	@RequestMapping("/mobile/cooperation/insertDayReport.do")
	public String insertDayReport(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		String taskId = (String)commandMap.get("taskId");
		Integer userNo = Integer.parseInt((String)commandMap.get("userNo"));
//		Integer cnt = Integer.parseInt((String)commandMap.get("cnt"));
		
		// 모바일APP에서는 실적을 한 번에 1건만 등록하므로 조건 분기 삭제
//		if (cnt == 1) {
			String dayReportDt = (String)commandMap.get("dayReportDt");
			String dayReportTm = (String)commandMap.get("dayReportTm");
			String dayReportCn = (String)commandMap.get("dayReportCn");
			
			DayReport dayReport = new DayReport();
			
			dayReport.setUserNo(userNo);
			dayReport.setTaskId(taskId);
			dayReport.setDayReportDt(dayReportDt);
			dayReport.setDayReportTm(dayReportTm);
			dayReport.setDayReportCn(CommonUtil.unscript(dayReportCn));
			
			dayReportService.insertDayReport(dayReport);
//		} else {
//			
//			List<DayReport> dayReportList = new ArrayList<DayReport>();
//			
//			String[] dayReportDt = (String[])commandMap.get("dayReportDt");
//			String[] dayReportTm = (String[])commandMap.get("dayReportTm");
//			String[] dayReportCn = (String[])commandMap.get("dayReportCn");
//
//			for (int i=0; i<cnt; i++) {
//				DayReport dayReport = new DayReport();
//
//				dayReport.setUserNo(userNo);
//				dayReport.setTaskId(taskId);
//				dayReport.setDayReportDt(dayReportDt[i]);
//				dayReport.setDayReportTm(dayReportTm[i]);
//				dayReport.setDayReportCn(CommonUtil.unscript(dayReportCn[i]));
//				
//				dayReportList.add(dayReport);
//			}
//			dayReportService.insertDayReport(dayReportList);
//		}
		
		return "redirect:/mobile/cooperation/selectDayReport.do";
	}
	@RequestMapping("/mobile/cooperation/updateDayReportView.do")
	public String updateDayReportView(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		DayReport dayReport = dayReportService.selectDayReport(commandMap);
		
		model.addAttribute("dayReport", dayReport);
		model.addAttribute("result", result);
		model.addAttribute("today", CalendarUtil.getToday());
		
		return "mobile/cooperation/performance_dayReportE";
	}
	@RequestMapping("/mobile/cooperation/updateDayReport.do")
	public String updateDayReport(DayReport dayReport, HttpServletRequest req, ModelMap model) throws Exception {

		dayReport.setDayReportCn(CommonUtil.unscript(dayReport.getDayReportCn()));
		
		dayReportService.updateDayReport(dayReport);

		return "redirect:/mobile/cooperation/selectDayReport.do?searchDate="+dayReport.getDayReportDt();
	}
	@RequestMapping("/mobile/cooperation/deleteDayReport.do")
	public String deleteDayReport(DayReport dayReport, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.deleteDayReport(dayReport);
		
		return "redirect:/mobile/cooperation/selectDayReport.do";
	}
	
	@RequestMapping("/mobile/cooperation/insertTaskContentView.do")
	public String insertTaskContentView(Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("searchUserNo", user.getNo());
		param.put("eDate", "99991231");
		
		List<TaskVO> taskList = dayReportService.selectTaskList(param);
		
		model.addAttribute("link", commandMap);
		model.addAttribute("taskList", taskList);
		
		return "cooperation/coop_pop_taskContentW";
	}
	@RequestMapping("/mobile/cooperation/insertTaskContent.do")
	public String insertTaskContent(Task task, TaskContent taskContent, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		taskContent.setUserNo(user.getNo());
		
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
	
	@RequestMapping("/mobile/cooperation/deleteTaskContent.do")
	public String deleteTaskContent(TaskContent taskContent, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.deleteTaskContent(taskContent);
		
		return "redirect:/cooperation/selectTaskInfo.do?taskId=" + taskContent.getTaskId();
	}
	
	@RequestMapping("/mobile/ajax/dayReportLayer.do")
	public String dayReportLayer(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		TaskVO result = dayReportService.selectTaskInfo(commandMap);
		
		model.addAttribute("result", result);
		
		return "cooperation/dayReportLayer";
	}
	
	@RequestMapping("/mobile/ajax/projectInputAble.do")
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
		
	@RequestMapping("/mobile/cooperation/selectDayReportList.do")
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
	
	@RequestMapping("/mobile/cooperation/deleteDayReportPop.do")
	public String deleteDayReportPop(DayReport dayReport, Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportService.deleteDayReport(dayReport);
		
		return "redirect:/mobile/cooperation/selectDayReport.do";
	}
		
	@RequestMapping("/mobile/cooperation/postTaskList.do")
	public String postTaskList(HttpServletRequest request, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("userNo", commandMap.get("param_userNo"));
		param.put("eDate", commandMap.get("param_eDate"));

		List<Task> resultList = dayReportService.selectPostTaskList(param);

		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", commandMap);
		
		return "cooperation/coop_postTaskL";
	}
		
	@RequestMapping("/mobile/cooperation/getDayReportStats.do")
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
	@RequestMapping("/mobile/cooperation/getDayReportStatsExcel.do")
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
}
