package kms.com.member.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.app.service.KmsApprovalService;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.DiningMoneyAdd;
import kms.com.member.service.DiningMoneyDetail;
import kms.com.member.service.DiningMoneyMonth;
import kms.com.member.service.DiningMoneyStatistic;
import kms.com.member.service.MemberVO;
import kms.com.member.service.SelfDevDetail;
import kms.com.member.service.SelfDevStatistic;
import kms.com.member.service.WellBeingService;
import kms.com.member.service.WorkStateVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class WellBeingController {
	
	@Resource(name="approvalService")
	KmsApprovalService approvalService;
	
	@Resource(name="KmsWellBeingService")
	WellBeingService wbService;

	@RequestMapping("/member/selectSelfDevStatistic.do")
	public String selectVacationSummaryList(@ModelAttribute("searchVO") SelfDevStatistic searchVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()));
		
		List<SelfDevStatistic> list = approvalService.selectSelfDevStatisticList(searchVO);
		
		if (list.size() == 1) {
			model.addAttribute("result", list.get(0));			
			return "human_resource/hr_selfDevV";
		}
		else {
			model.addAttribute("resultList", list);			
			return "human_resource/hr_selfDevL";
		}
	}
	
	@RequestMapping("/member/selectSelfDevView.do")
	public String selectVacationSummaryView(@ModelAttribute("searchVO") SelfDevStatistic searchVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
	    
		MemberVO user = SessionUtil.getMember(req);
	    
		if (searchVO.getUserNo() == null || searchVO.getUserNo() == 0) {
			searchVO.setUserNo(user.getNo());
		}
		
		SelfDevStatistic result = approvalService.selectSelfDevStatistic(searchVO);
		
		model.addAttribute("result", result);
		
		return "human_resource/hr_selfDevV";
	}
	
	@RequestMapping("/member/selectSelfDevDetail.do")
	public String selectVacationSummaryDetail(@ModelAttribute("searchVO") SelfDevDetail searchVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		searchVO.setSearchYear((String)commandMap.get("param_searchYear"));
		searchVO.setUserNo(Integer.parseInt((String)commandMap.get("param_userNo")));
		
		List<SelfDevDetail> resultList = approvalService.selectSelfDevStatisticDetail(searchVO);
		
		model.addAttribute("resultList", resultList);
		
		return "human_resource/hr_selfDevD";
	}
	

	
	@RequestMapping("/member/diningMoneyStatisticList.do")
	public String diningMoneyStatisticList(@ModelAttribute("searchVO") DiningMoneyStatistic searchVO, ModelMap model) throws Exception {
		
		searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()));
		
		List<DiningMoneyStatistic> resultList = wbService.selectDiningMoneyStatisticList(searchVO);
		
		if (resultList.size() == 1) {
			model.addAttribute("result", resultList.get(0));

			return "human_resource/hr_diningMoneyStatisticV";
		}
		else {
			model.addAttribute("resultList", resultList);
			
			return "human_resource/hr_diningMoneyStatisticL";
		}
	}
	
	@RequestMapping("/member/diningMoneyStatisticView.do")
	public String diningMoneyStatisticView(@ModelAttribute("searchVO") DiningMoneyStatistic searchVO,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		if (searchVO.getSearchOrgId().trim().equals("")) {
			MemberVO user = SessionUtil.getMember(req);
			searchVO.setSearchOrgId(user.getOrgnztId());
			searchVO.setSearchOrgNm(user.getOrgnztNm());
		}
		
		DiningMoneyStatistic result = wbService.selectDiningMoneyStatistic(searchVO);
		
		model.addAttribute("result", result);
		
		return "human_resource/hr_diningMoneyStatisticV";
	}
	
	@RequestMapping("/member/diningMoneyDetailList.do")
	public String diningMoneyDetailList(@ModelAttribute("searchVO") DiningMoneyDetail searchVO,
			Map<String, Object> commandMap, ModelMap model) throws Exception {

		searchVO.setSearchYear(Integer.parseInt((String)commandMap.get("param_searchYear")));
		searchVO.setSearchOrgId((String)commandMap.get("param_searchOrgId"));
		
		List<DiningMoneyDetail> resultList = wbService.selectDiningMoneyDetailList(searchVO);
		
		model.addAttribute("resultList", resultList);
		
		return "human_resource/hr_diningMoneyStatisticD";
	}
	
	@RequestMapping("/member/diningMoneyBudget.do")
	public String diningMoneyBudget(@ModelAttribute("searchVO") DiningMoneyMonth searchVO, ModelMap model) throws Exception {

		List<DiningMoneyMonth> monthResultList = wbService.selectDiningMoneyMonth(searchVO);
		List<DiningMoneyAdd> addResultList = wbService.selectDiningMoneyAddList(searchVO);
		
		model.addAttribute("monthResultList", monthResultList);
		model.addAttribute("addResultList", addResultList);
		
		return "human_resource/hr_diningMoneyBudgetL";
	}
	
	@RequestMapping("/member/insertDiningMoneyAddView.do")
	public String insertDiningMoneyAddView(@ModelAttribute("searchVO") DiningMoneyMonth searchVO, ModelMap model) throws Exception {
		
		return "human_resource/hr_diningMoneyBudgetW";
	}
	
	@RequestMapping("/member/insertDiningMoneyAdd.do")
	public String insertDiningMoneyAdd(@ModelAttribute("searchVO") DiningMoneyMonth searchVO,
			DiningMoneyAdd diningMoneyAdd, ModelMap model) throws Exception {
		
		diningMoneyAdd.setYyyymm(diningMoneyAdd.getYyyymm().substring(0,6));
		
		wbService.insertDiningMoneyAdd(diningMoneyAdd);
		
		return "forward:/member/diningMoneyBudget.do";
	}
	
	@RequestMapping("/member/deleteDiningMoneyAdd.do")
	public String deleteDiningMoneyAdd(@ModelAttribute("searchVO") DiningMoneyMonth searchVO,
			DiningMoneyAdd diningMoneyAdd, ModelMap model) throws Exception {
		
		wbService.deleteDiningMoneyAdd(diningMoneyAdd);
		
		return "forward:/member/diningMoneyBudget.do";
	}

	
	
	
}
