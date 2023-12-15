package kms.com.admin.schedule.web;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.Schedule;
import kms.com.community.service.ScheduleService;
import kms.com.community.service.ScheduleVO;
import kms.com.member.service.MemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class AdminScheduleController {

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** EgovPropertyService */
    @Resource(name = "KmsScheduleService")
    private ScheduleService scheduleService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    

    /**
     * 일정공유 - 상세일정
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/holiday/holidayList.do")
    public String scheduleList(@ModelAttribute("searchVO") ScheduleVO searchVO, HttpServletRequest req, Model model) throws Exception {
    	
    	List<ScheduleVO> holidayList = scheduleService.selectHolidayList(searchVO);
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId("KMS006");
    	List codeResult = cmmUseService.selectCmmCodeDetail(vo);
    	
    	model.addAttribute("typeList", codeResult);
    	model.addAttribute("resultList", holidayList);
    	
    	return "/admin/holiday/holidayL";
    }
    
    /**
     * 일정공유 - 등록페이지
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/holiday/addHolidayView.do")
    public String addScheduleView(@ModelAttribute("searchVO") ScheduleVO searchVO, HttpServletRequest req, Model model) throws Exception {
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId("KMS006");
    	List codeResult = cmmUseService.selectCmmCodeDetail(vo);
    	
    	model.addAttribute("typeList", codeResult);
    	
    	return "/admin/holiday/holidayW";
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
    @RequestMapping("/admin/holiday/addHoliday.do")
    public String addSchedule(@ModelAttribute("searchVO") ScheduleVO searchVO, @ModelAttribute("schedule") Schedule schedule,
    		MultipartHttpServletRequest req, Model model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	schedule.setUserNo(user.getNo());
    	
    	String date = schedule.getDate();
    	
    	schedule.setScheYear(date.substring(0,4));
    	schedule.setScheMonth(date.substring(4,6));
    	schedule.setScheDate(date.substring(6,8));
    	
    	schedule.setScheCn(CommonUtil.unscript(schedule.getScheCn()));
    	
    	scheduleService.addSchedule(schedule);

    	return "redirect:/admin/holiday/holidayList.do";
    }
    
    /**
     * 일정공유 - 수정페이지
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/holiday/modifyHoliday.do")
    public String modifySchedule(@ModelAttribute("searchVO") ScheduleVO searchVO, HttpServletRequest req, Model model) throws Exception {
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId("KMS006");
    	List codeResult = cmmUseService.selectCmmCodeDetail(vo);
    	
    	ScheduleVO result = scheduleService.selectSchedule(searchVO);

    	model.addAttribute("typeList", codeResult);
    	model.addAttribute("result", result);
    	
    	return "/admin/holiday/holidayM";
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
    @RequestMapping("/admin/holiday/updateHoliday.do")
    public String updateSchedule(@ModelAttribute("searchVO") ScheduleVO searchVO, Schedule schedule,
    		MultipartHttpServletRequest req, Model model) throws Exception {
    	
		String date = schedule.getDate();
		
		schedule.setScheYear(date.substring(0,4));
		schedule.setScheMonth(date.substring(4,6));
		schedule.setScheDate(date.substring(6,8));
		
    	schedule.setScheCn(CommonUtil.unscript(schedule.getScheCn()));
		
		scheduleService.updateSchedule(schedule);
		
    	return "redirect:/admin/holiday/holidayList.do";
    }
    
    /**
     * 일정공유 - 삭제
     * @param searchVO
     * @param req
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/admin/holiday/deleteHoliday.do")
    public String deleteSchedule(@ModelAttribute("searchVO") ScheduleVO searchVO, HttpServletRequest req, Model model) throws Exception {
    	
    	scheduleService.deleteSchedule(searchVO);
    	
    	return "redirect:/admin/holiday/holidayList.do";
    }

}
