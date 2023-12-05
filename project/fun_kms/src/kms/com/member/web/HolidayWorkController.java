package kms.com.member.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kms.com.app.service.KmsApprovalService;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.HolidayWorkDetail;
import kms.com.member.service.HolidayWorkStatistic;
import kms.com.member.service.MemberVO;

@Controller
public class HolidayWorkController {
	@Resource(name="approvalService")
	KmsApprovalService approvalService;

	@RequestMapping("/member/selectHolidayWorkStatisticList.do")
	public String selectHolidayWorkStatisticList(@ModelAttribute("searchVO") HolidayWorkStatistic searchVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()));
		
		List<HolidayWorkStatistic> resultList = approvalService.selectHolidayWorkStatisticList(searchVO);
		
		if (resultList.size() == 1) {
			model.addAttribute("result", resultList.get(0));
			
			return "human_resource/hr_holidayWorkStatisticV";
		}
		else {
			HolidayWorkStatistic sum = new HolidayWorkStatistic();
			for (int i=0; i<resultList.size(); i++) {
				HolidayWorkStatistic hwStatistic = resultList.get(i);
				
				sum.setHol01(sum.getHol01() + hwStatistic.getHol01());
				sum.setHol02(sum.getHol02() + hwStatistic.getHol02());
				sum.setHol03(sum.getHol03() + hwStatistic.getHol03());
				sum.setHol04(sum.getHol04() + hwStatistic.getHol04());
				sum.setHol05(sum.getHol05() + hwStatistic.getHol05());
				sum.setHol06(sum.getHol06() + hwStatistic.getHol06());
				sum.setHol07(sum.getHol07() + hwStatistic.getHol07());
				sum.setHol08(sum.getHol08() + hwStatistic.getHol08());
				sum.setHol09(sum.getHol09() + hwStatistic.getHol09());
				sum.setHol10(sum.getHol10() + hwStatistic.getHol10());
				sum.setHol11(sum.getHol11() + hwStatistic.getHol11());
				sum.setHol12(sum.getHol12() + hwStatistic.getHol12());
				sum.setHolSum(sum.getHolSum() + hwStatistic.getHolSum());
			}
			model.addAttribute("resultList", resultList);
			model.addAttribute("sum", sum);
			
			return "human_resource/hr_holidayWorkStatisticL";
		}
	}
	
	@RequestMapping("/member/selectHolidayWorkStatisticView.do")
	public String selectHolidayWorkStatisticView(@ModelAttribute("searchVO") HolidayWorkStatistic searchVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
	    
		MemberVO user = SessionUtil.getMember(req);
	    
		if (searchVO.getSearchUserNo() == 0) {
			searchVO.setSearchUserNo(user.getNo());
		}
		
		HolidayWorkStatistic result = approvalService.selectHolidayWorkStatistic(searchVO);
		
		model.addAttribute("result", result);
		
		return "human_resource/hr_holidayWorkStatisticV";
	}
	
	@RequestMapping("/member/selectHolidayWorkDetail.do")
	public String selectHolidayWorkDetail(@ModelAttribute("searchVO") HolidayWorkStatistic searchVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		List<HolidayWorkDetail> resultList = approvalService.selectHolidayWorkDetail(searchVO);
		
		model.addAttribute("resultList", resultList);
		
		return "human_resource/hr_holidayWorkStatisticD";
	}
	
	
}
