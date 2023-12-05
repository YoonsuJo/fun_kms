package kms.com.cooperation.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.DayReportService;
import kms.com.cooperation.service.DayReportVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ProgressController {

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
	
	@RequestMapping("/cooperation/selectProcessList.do")
	public String selectProcessList(@ModelAttribute("searchVO") DayReportVO dayReportVO, Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		
		// 검색조건 없이 초기페이지
		if (dayReportVO.getSearchUserNm().equals("") && dayReportVO.getSearchOrgId().equals("") && dayReportVO.getSearchPrjId().equals("")) {
			dayReportVO.setSearchUserNm(user.getUserNm() + "(" + user.getUserId() + ")");
		}
		dayReportVO.setSearchOrgIdList(CommonUtil.makeValidIdList(dayReportVO.getSearchOrgId()));
		dayReportVO.setSearchKeyword("0");
		
		dayReportVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		dayReportVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(dayReportVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(dayReportVO.getPageUnit());
		paginationInfo.setPageSize(dayReportVO.getPageSize());
	
		dayReportVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		dayReportVO.setLastIndex(paginationInfo.getLastRecordIndex());
		dayReportVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		List<DayReportVO> resultList = dayReportService.searchDayReportList(dayReportVO);
		int totCnt = dayReportService.searchDayReportListTotCnt(dayReportVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO", dayReportVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "cooperation/coop_progressL";
	}
	
	@RequestMapping("/cooperation/searchProcessList.do")
	public String searchProcessList(@ModelAttribute("searchVO") DayReportVO dayReportVO, Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		dayReportVO.setSearchUserIdList(CommonUtil.parseIdFromMixs(dayReportVO.getSearchUserId()));
		
		dayReportVO.setPageUnit(propertyService.getInt("pageUnit_15"));
		dayReportVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(dayReportVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(dayReportVO.getPageUnit());
		paginationInfo.setPageSize(dayReportVO.getPageSize());
		
		dayReportVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		dayReportVO.setLastIndex(paginationInfo.getLastRecordIndex());
		dayReportVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<DayReportVO> resultList = dayReportService.searchDayReportList(dayReportVO);
		int totCnt = dayReportService.searchDayReportListTotCnt(dayReportVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "cooperation/coop_progressS";
	}
}
