package kms.com.community.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.admin.score.service.ScoreService;
import kms.com.admin.score.service.ScoreVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.CalendarVO;
import kms.com.community.service.Schedule;
import kms.com.community.service.ScheduleService;
import kms.com.community.service.ScheduleVO;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * @Class Name : TblMailsendController.java
 * @Description : TblMailsend Controller class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class ScheduleController {

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** EgovPropertyService */
    @Resource(name = "KmsScheduleService")
    private ScheduleService scheduleService;
	
    @Resource(name = "ScoreService")
    private ScoreService scoreService;
    
    /**
     * 일정공유 - 달력페이지
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/community/scheduleCalendar.do")
    public String scheduleCalendar(@ModelAttribute("searchVO") ScheduleVO searchVO,
    		Map<String,Object> commandMap, HttpServletRequest req, Model model) throws Exception {

    	MemberVO user = SessionUtil.getMember(req);
    	searchVO.setUserNo(user.getNo());
    	searchVO.setOrgnztId(user.getOrgnztId());
    	
    	String moveMonth = (String)commandMap.get("moveMonth");
    	if (moveMonth == null) moveMonth = "0";
    	
    	searchVO.setScheDate("01");
    	String dateForm = CalendarUtil.getDate(searchVO.getDateForm(), "MONTH", Integer.parseInt(moveMonth));
    	
    	String year = dateForm.substring(0,4);
    	String month = dateForm.substring(4,6);
    	
    	searchVO.setScheYear(year);
    	searchVO.setScheMonth(month);
    	searchVO.setScheDate(null);
    	
    	int firstDay = CalendarUtil.getFirstDayOfMonth(year, month); // 그 달의 1일의 요일
    	int lastDate = CalendarUtil.getLastDateOfMonth(year, month); // 그 달의 1일의 요일
    	
    	List<CalendarVO> resultList = scheduleService.getCalendar(searchVO);
    	
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("firstDay", firstDay);
    	model.addAttribute("lastDate", lastDate);
    	
		return "/community/comm_Schedule";
    }
    
    /**
     * 일정공유 - 상세일정
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/community/scheduleList.do")
    public String scheduleList(@ModelAttribute("searchVO") ScheduleVO searchVO,
    		Map<String,Object> commandMap, HttpServletRequest req, Model model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	searchVO.setUserNo(user.getNo());
    	searchVO.setOrgnztId(user.getOrgnztId());

    	String moveMonth = (String)commandMap.get("moveMonth");
    	String moveDate = (String)commandMap.get("moveDate");
    	if (moveMonth == null) moveMonth = "0";
    	if (moveDate == null) moveDate = "0";

    	String dateForm = CalendarUtil.getDate(searchVO.getDateForm(), "MONTH", Integer.parseInt(moveMonth));
    	dateForm = CalendarUtil.getDate(dateForm, "DATE", Integer.parseInt(moveDate));
    	
    	String year = dateForm.substring(0,4);
    	String month = dateForm.substring(4,6);
    	String date = dateForm.substring(6,8);

    	searchVO.setScheYear(year);
    	searchVO.setScheMonth(month);
    	searchVO.setScheDate(date);
    	
    	int day = CalendarUtil.getDay(year + month + date);
    	String[] dayKor = {"", "일", "월", "화", "수", "목", "금", "토"};
    	Map<String, Object> map = scheduleService.selectScheduleList(searchVO);
    	
    	model.addAttribute("companySchedule", map.get("companySchedule"));
    	model.addAttribute("teamSchedule", map.get("teamSchedule"));
    	model.addAttribute("privateSchedule", map.get("privateSchedule"));
    	model.addAttribute("holiday", map.get("holiday"));
    	model.addAttribute("day", dayKor[day]);
    	
    	return "/community/comm_ScheduleDetailL";
    }
    
    /**
     * 일정공유 - 등록페이지
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/community/addScheduleView.do")
    public String addScheduleView(@ModelAttribute("searchVO") ScheduleVO searchVO, HttpServletRequest req, Model model) throws Exception {
    	
    	return "/community/comm_ScheduleW";
    }
    
    /**
     * 일정공유 - 등록
     * @param searchVO
     * @param schedule
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/community/addSchedule.do")
    public String addSchedule(final MultipartHttpServletRequest req, @ModelAttribute("searchVO") ScheduleVO searchVO,
    		@ModelAttribute("schedule") Schedule schedule, Model model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	schedule.setUserNo(user.getNo());
    	
    	String date = schedule.getDate();
    	
    	schedule.setScheYear(date.substring(0,4));
    	schedule.setScheMonth(date.substring(4,6));
    	schedule.setScheDate(date.substring(6,8));

    	searchVO.setScheYear(date.substring(0,4));
    	searchVO.setScheMonth(date.substring(4,6));
    	searchVO.setScheDate(date.substring(6,8));
    	
    	schedule.setScheCn(CommonUtil.unscript(searchVO.getScheCn()));
    	
    	
    	scheduleService.addSchedule(schedule);
		
    	return "redirect:/community/scheduleCalendar.do";
    }
    
    /**
     * 일정공유 - 수정페이지
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/community/modifySchedule.do")
    public String modifySchedule(@ModelAttribute("searchVO") ScheduleVO searchVO, HttpServletRequest req, Model model) throws Exception {
    	
    	ScheduleVO result = scheduleService.selectSchedule(searchVO);
    	
    	model.addAttribute("result", result);
    	
    	return "/community/comm_ScheduleM";
    }
    
    /**
     * 일정공유 - 수정
     * @param searchVO
     * @param schedule
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/community/updateSchedule.do")
    public String updateSchedule(final MultipartHttpServletRequest req, @ModelAttribute("searchVO") ScheduleVO searchVO,
    		@ModelAttribute("schedule") Schedule schedule, Model model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	
    	if (schedule.getUserNo() == user.getNo() || user.isAdmin()) {
    		String date = schedule.getDate();
    		
    		schedule.setScheYear(date.substring(0,4));
    		schedule.setScheMonth(date.substring(4,6));
    		schedule.setScheDate(date.substring(6,8));
    		
    		searchVO.setScheYear(date.substring(0,4));
    		searchVO.setScheMonth(date.substring(4,6));
    		searchVO.setScheDate(date.substring(6,8));
    		
        	schedule.setScheCn(CommonUtil.unscript(searchVO.getScheCn()));
    		
    		scheduleService.updateSchedule(schedule);
    	}
    	return "redirect:/community/scheduleList.do";
    }
    
    /**
     * 일정공유 - 삭제
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/community/deleteSchedule.do")
    public String deleteSchedule(@ModelAttribute("searchVO") ScheduleVO searchVO, HttpServletRequest req, Model model) throws Exception {
    	
    	scheduleService.deleteSchedule(searchVO);
    	
    	return "redirect:/community/scheduleCalendar.do";
    }

    @RequestMapping("/ajax/getScheduleXml.do")
    public void getSchedule(@ModelAttribute("searchVO") ScheduleVO searchVO,
    		HttpServletRequest req,  HttpServletResponse res, Model model) throws Exception {
    	
    	ScheduleVO result = scheduleService.selectSchedule(searchVO);
    	
    	res.setContentType("text/xml;charset=UTF-8");
		
		String out = "";
		out += "<title><![CDATA[" + result.getScheSj() + "]]></title>";
		if ("1".equals(result.getScheTmTyp()) && result.getScheTmFrom() != null && result.getScheTmFrom().equals("") == false) {
			if (result.getScheTmTo() != null && result.getScheTmTo().equals("") == false) {
				out += "<time>" + result.getScheTmFrom() + "~" + result.getScheTmTo() + "</time>";
			} else {
				out += "<time>" + result.getScheTmFrom() + "부터</time>";
			}
		} else {
			out += "<time>하루종일</time>";
		}
		out += "<write>" + result.getUserNm() + "(" + result.getUserId() + ")</write>";
		out += "<content><![CDATA[" + result.getScheCn() + "]]></content>";
		
		res.getWriter().println( CommonUtil.getXMLStr(out) );
    }
    
    
    
}
