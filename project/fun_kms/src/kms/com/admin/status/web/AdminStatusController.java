package kms.com.admin.status.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.admin.status.service.KmsStatusService;
import kms.com.common.utils.CalendarUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.List;
import java.util.Map;


@Controller
public class AdminStatusController {

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@Resource(name = "StatusService")
	private KmsStatusService statusService;
	
	@Resource(name = "KmsMemberService")
    private MemberService memberService;
	
    /**
     * @param searchVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/admin/status/loginStatusL.do")
    public String selectLoginStatusList(Map<String, Object> commandMap,ModelMap model)throws Exception {
    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(commandMap.get("searchDate") == null) commandMap.put("searchDate", CalendarUtil.getToday().substring(0, 8));
    	
    	String searchDate = commandMap.get("searchDate").toString();
    	
    	String moveYear = (String)commandMap.get("moveYear");
		if (moveYear != null && moveYear.equals("") == false) {
			searchDate = CalendarUtil.getDate(searchDate, "MONTH", Integer.parseInt(moveYear) * 12);
			commandMap.put("searchDate", searchDate);
		}
		
		commandMap.put("searchYear", commandMap.get("searchDate").toString().substring(0, 4));
    	
    	List resultList = statusService.selectLoginStatusList(commandMap);
    	
    	model.addAttribute("firstDate", CalendarUtil.getToday().substring(0, 6) + "01");
    	model.addAttribute("todayDate", CalendarUtil.getToday());
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("searchDate", searchDate);
    	model.addAttribute("thisYear", CalendarUtil.getToday().substring(0, 4).equals(searchDate.substring(0, 4)));
    	
        return "admin/status/loginStatusL";
    }
    
    @RequestMapping(value="/admin/status/loginStatusExcel.do")
	public String selectLoginStatusExcel(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

		String sDate = (String)commandMap.get("startDt");
		String eDate = (String)commandMap.get("endDt");
		
		if (sDate == null || "".equals(sDate)) {
			sDate = CalendarUtil.getFirstDateOfThisWeek(CalendarUtil.getToday(), 0);
		}
		if (eDate == null || "".equals(eDate)) {
			eDate = CalendarUtil.getToday();
		}
		commandMap.put("startDt", sDate);
		commandMap.put("endDt", eDate);
		
		model.addAttribute("startDt", sDate);
		model.addAttribute("endDt", eDate);
		
		List<EgovMap> resultList = statusService.selectLoginStatusExcel(commandMap);
		
		model.addAttribute("resultList", resultList);

		res.setHeader("Content-Disposition", "attachment; filename=loginStatusExcel.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
        return "admin/status/loginStatusExcel";
	}
    
    
    @RequestMapping(value="/admin/status/loginStatusV.do")
    public String selectLoginStatus(Map<String, Object> commandMap,
    		ModelMap model)
            throws Exception {
    	
    	if (commandMap.get("searchMonth") == null)
    		commandMap.put("searchMonth", CalendarUtil.getToday().substring(0, 6));
    	
    	List resultList = statusService.selectLoginStatus(commandMap);
    	model.addAttribute("resultList", resultList);
    	
    	MemberVO member = new MemberVO();
    	int no = 0;
    	if (commandMap.get("searchUserNo") != null)
    		no = Integer.parseInt(commandMap.get("searchUserNo").toString());
    	member.setNo(no);
    	Map<String, Object> memberInfo = memberService.selectMember(member);
    	model.addAttribute("memberInfo", memberInfo);
    	
    	String searchDate = commandMap.get("searchDate").toString();
    	model.addAttribute("searchDate", searchDate);
    	
        return "admin/status/loginStatusV";
    }

}
