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

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class WorkStateMobileController {

	@Resource(name="KmsMemberService")
	MemberService memberService;

	@Resource(name="KmsWorkStateService")
	WorkStateService workStateService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@RequestMapping("/mobile/member/dailyWorkStateStatistic.do")
	public String dailyWorkStateStatistic(@ModelAttribute("searchVO") WorkStateStatistic searchVO,
			WorkStateVO wsVO,
			Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		if (commandMap.get("moveDate") != null && commandMap.get("moveDate").equals("") == false) {
			searchVO.setSearchDate(CalendarUtil.getDate(searchVO.getSearchDate(), Integer.parseInt((String)commandMap.get("moveDate"))));
			wsVO.setSearchDate(CalendarUtil.getDate(wsVO.getSearchDate(), Integer.parseInt((String)commandMap.get("moveDate"))));
		}
		searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()));
		
		WorkStateStatistic result = workStateService.selectDailyWorkStateStatistic(searchVO);
		
		model.addAttribute("result", result);
		
		wsVO.setSearchOrgIdList(CommonUtil.makeValidIdList(wsVO.getSearchOrgId()));
		
		String move = (String)commandMap.get("move");
		
		if (move != null && move.equals("") == false) {
			wsVO.setSearchDate(CalendarUtil.getDate(wsVO.getSearchDate(), Integer.parseInt(move)));
		}
		
		Map<String, Object> result2 = workStateService.selectAbsenceStateAll(wsVO);
		
		model.addAttribute("result2", result2);
		
		
		WorkStateDetail wsDetail = new WorkStateDetail();
		wsDetail.setSearchDate(CalendarUtil.getToday());
		wsDetail.setSearchAttendCd("LT");
		
		List<WorkStateDetail> resultList = workStateService.selectDailyWorkStateDetail(wsDetail);
		
		model.addAttribute("resultList", resultList);
		
		return "mobile/human_resource/hr_dailyWorkStateS";
	}
}
