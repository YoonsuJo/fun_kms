package kms.com.admin.statistics.web;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.com.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.admin.statistics.service.AdminStatisticsService;
import kms.com.common.utils.CalendarUtil;
import kms.com.member.service.ComplexProjectStatistic;
import kms.com.member.service.HolidayWorkStatisticDetail;
import kms.com.member.service.HolidayWorkStatisticDetailVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;


@Controller
public class AdminStatisticsController {

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@Resource(name="KmsAdminStatisticsService")
	private AdminStatisticsService adminStatisticsService;
   
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;

	@Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;

	@RequestMapping(value="/admin/statistics/dayReport.do")
    public String dayReport(Map<String, Object> commandMap, ModelMap model) throws Exception {

    	model.addAttribute("todayDate", CalendarUtil.getToday());    	
    	model.addAttribute("firstDate", CalendarUtil.getToday().substring(0, 6) + "01");
    	return "admin/statistics/stat_dayReport";
    } 
    
    @RequestMapping(value="/admin/statistics/holidayWork.do")
    public String holidayWork(Map<String, Object> commandMap, ModelMap model) throws Exception {
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId("KMS007");
    	List compList = cmmUseService.selectCmmCodeDetail(vo);
    	
    	model.addAttribute("compList", compList);
    	model.addAttribute("todayDate", CalendarUtil.getToday());    	
    	model.addAttribute("firstDate", CalendarUtil.getToday().substring(0, 6) + "01");
    	return "admin/statistics/stat_holidayWork";
    } 
    
    @RequestMapping(value="/admin/statistics/expense.do")
    public String expense(Map<String, Object> commandMap, ModelMap model) throws Exception {
    	
    	model.addAttribute("todayDate", CalendarUtil.getToday());    	
    	model.addAttribute("firstDate", CalendarUtil.getToday().substring(0, 6) + "01");
    	return "admin/statistics/stat_expense";
    } 
    
    @RequestMapping(value="/admin/statistics/carReservation.do")
    public String carReservation(Map<String, Object> commandMap, ModelMap model) throws Exception {
    	
    	model.addAttribute("todayDate", CalendarUtil.getToday());
    	model.addAttribute("firstDate", CalendarUtil.getToday().substring(0, 6) + "01");
    	return "admin/statistics/stat_carReservation";
    } 
    
    //개인별 프로젝트투입율 및 투입프로젝트/매입프로젝트 실적 집계
    @RequestMapping(value="/admin/statistics/complexProjectReport.do")
    public String complexProjectReport(Map<String, Object> commandMap, ModelMap model) throws Exception {
    	
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
    	vo.setCodeId("KMS007");
    	List compList = cmmUseService.selectCmmCodeDetail(vo);
    	
    	model.addAttribute("compList", compList);
    	model.addAttribute("todayDate", CalendarUtil.getToday());    	
    	model.addAttribute("firstDate", CalendarUtil.getToday().substring(0, 6) + "01");
    	    	    	
    	return "admin/statistics/stat_complexProjectReport";    	
    } 
    
    @RequestMapping(value="/admin/statistics/selectDayReportExcel1.do")
	public String selectDayReportExcel1(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

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
		List<EgovMap> resultList = adminStatisticsService.selectDayReportExcel1(commandMap);
		model.addAttribute("resultList", resultList);

		String filerealname = "관리자_업무실적_입력현황_"+ CalendarUtil.getToday() + ".xls";
	    String filedownname = new String(filerealname.getBytes("euc-kr"),"8859_1");
	
		res.setHeader("Content-Disposition", "attachment; filename=" + filedownname); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/statistics/stat_dayReportExcel1";
	}

    @RequestMapping(value="/admin/statistics/selectExpenseExcel1.do")
	public String selectExpenseExcel1(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

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
		List<EgovMap> resultList = adminStatisticsService.selectExpenseExcel1(commandMap);
		model.addAttribute("resultList", resultList);

		res.setHeader("Content-Disposition", "attachment; filename=expenseExcel1.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/statistics/stat_expenseExcel1";
	}

    @RequestMapping(value="/admin/statistics/selectExpenseExcel2.do")
	public String selectExpenseExcel2(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

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
		commandMap.put("cardOnly", true);
		
		model.addAttribute("startDt", sDate);
		model.addAttribute("endDt", eDate);
		List<EgovMap> resultList = adminStatisticsService.selectExpenseExcel1(commandMap);
		model.addAttribute("resultList", resultList);

		res.setHeader("Content-Disposition", "attachment; filename=expenseExcel2.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/statistics/stat_expenseExcel2";
	}

    @RequestMapping(value="/admin/statistics/selectHolidayWorkExcel1.do")
	public String selectHolidayWorkExcel1(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

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
		commandMap.put("includeResult", "Y");
		
		model.addAttribute("startDt", sDate);
		model.addAttribute("endDt", eDate);
		List<HolidayWorkStatisticDetail> resultList = adminStatisticsService.selectHolidayWorkExcel1(commandMap);
		model.addAttribute("resultList", resultList);
		
		String filerealname = "관리자_휴일근무내역_"+ CalendarUtil.getToday() + ".xls";
	    String filedownname = new String(filerealname.getBytes("euc-kr"),"8859_1");
	
		res.setHeader("Content-Disposition", "attachment; filename=" + filedownname); 
	    res.setHeader("Content-Description", "JSP Generated Data");

		return "admin/statistics/stat_holidayWorkExcel1";
	}

    @RequestMapping(value="/admin/statistics/selectHolidayWorkExcel2.do")
	public String selectHolidayWorkExcel2(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

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

		CmmnDetailCode comp = new CmmnDetailCode();
		comp.setCodeId("KMS007");
		comp.setCode((String)commandMap.get("compId"));
    	comp = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(comp);
    	model.addAttribute("compNm", comp.getCodeNm());

    	HolidayWorkStatisticDetailVO result = adminStatisticsService.selectHolidayWorkExcel2(commandMap);
		model.addAttribute("result", result);

		res.setHeader("Content-Disposition", "attachment; filename=holidayWorkExcel2.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/statistics/stat_holidayWorkExcel2";
	}

    @RequestMapping(value="/admin/statistics/selectCarReservationExcel1.do")
	public String selectCarReservationExcel1(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

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
		List<EgovMap> resultList = adminStatisticsService.selectCarReservationExcel1(commandMap);
		model.addAttribute("resultList", resultList);

		res.setHeader("Content-Disposition", "attachment; filename=carReservationExcel1.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/statistics/stat_carReservationExcel1";
	}

    @RequestMapping(value="/admin/statistics/selectCarReservationExcel2.do")
	public String selectCarReservationExcel2(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

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
		commandMap.put("persUseOnly", true);
		
		model.addAttribute("startDt", sDate);
		model.addAttribute("endDt", eDate);
		List<EgovMap> resultList = adminStatisticsService.selectCarReservationExcel1(commandMap);
		model.addAttribute("resultList", resultList);

		res.setHeader("Content-Disposition", "attachment; filename=carReservationExcel2.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/statistics/stat_carReservationExcel2";
	}
    

    @RequestMapping(value="/admin/statistics/selectComplexProjectReportExcel1.do")
	public String selectComplexProjectReportExcel1(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

		String sDate = (String)commandMap.get("startDt");		
		String eDate = (String)commandMap.get("endDt");
		
		if (sDate == null || "".equals(sDate)) {
			sDate = CalendarUtil.getFirstDateOfThisWeek(CalendarUtil.getToday(), 0);
		}
		if (eDate == null || "".equals(eDate)) {
			eDate = CalendarUtil.getToday();
		}
		sDate = sDate.substring(0,6);
		eDate = eDate.substring(0,6);
		
		commandMap.put("startDt", sDate);
		commandMap.put("endDt", eDate);
		commandMap.put("includeResult", "Y");
		
		model.addAttribute("startDt", sDate);
		model.addAttribute("endDt", eDate);
		List<ComplexProjectStatistic> resultList = adminStatisticsService.selectComplexProjectReportExcel1(commandMap);
		model.addAttribute("resultList", resultList);

		res.setHeader("Content-Disposition", "attachment; filename=complexProjectReportExcel1.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/statistics/stat_complexProjectReportExcel1";
	}

    @RequestMapping(value="/admin/statistics/selectComplexProjectReportExcel2.do")
	public String selectComplexProjectReportExcel2(HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

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

		CmmnDetailCode comp = new CmmnDetailCode();
		comp.setCodeId("KMS007");
		comp.setCode((String)commandMap.get("compId"));
    	comp = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(comp);
    	model.addAttribute("compNm", comp.getCodeNm());

    	HolidayWorkStatisticDetailVO result = adminStatisticsService.selectHolidayWorkExcel2(commandMap);
		model.addAttribute("result", result);

		res.setHeader("Content-Disposition", "attachment; filename=complexProjectReportExcel2.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/statistics/stat_complexProjectReportExcel2";
	}

}
