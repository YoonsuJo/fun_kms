package kms.com.management.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.management.service.ExpenseService;
import kms.com.management.service.FundService;
import kms.com.management.service.FundVO;
import kms.com.member.service.MemberVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class FundController {

	@Resource(name="KmsFundService")
	FundService fundService;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;
	
	/**
	 * 게시물에 대한 목록을 조회한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/management/fundW.do") 
	public String fundWrite(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		/* 상세코드 불러오기 Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS021");
		List typeList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS022");
		List accountList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("accountList", accountList);
		
		vo.setCodeId("KMS023");
		List bankBookList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("bankBookList", bankBookList);
		/* 상세코드 불러오기 End */
		
		// 회사구분을 불러옵니다. Start */
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		if (commandMap.get("searchDate") != null)
			model.addAttribute("searchDate", commandMap.get("searchDate").toString());
		if (commandMap.get("companyCd") != null)
			model.addAttribute("companyCd", commandMap.get("companyCd").toString());
		
		return "/management/mgmt_fundW";
	}
	
	@RequestMapping("/management/fundI.do") 
	public String fundInsert(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		fundService.insertFund(commandMap);
		
		if (commandMap.get("type").toString().equals("RW"))
		{
			commandMap.put("type", "RD");
			commandMap.put("bankBook", commandMap.get("bankBook2"));
			fundService.insertFund(commandMap);
		}
		else if (commandMap.get("type").toString().equals("RD"))
		{
			commandMap.put("type", "RW");
			commandMap.put("bankBook", commandMap.get("bankBook2"));
			fundService.insertFund(commandMap);
		}
		
		String searchDate = "";
		if (commandMap.get("searchDate") != null)
			searchDate = commandMap.get("searchDate").toString();
		String companyCd = "";
		if (commandMap.get("companyCd") != null)
			companyCd = commandMap.get("companyCd").toString();
		return "redirect:/management/fundWeeklyDetail.do?searchDate=" + searchDate + "&companyCd=" + companyCd;
	}
	
	@RequestMapping("/management/fundM.do") 
	public String fundModify(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		/* 상세코드 불러오기 Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS021");
		List typeList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS022");
		List accountList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("accountList", accountList);
		
		vo.setCodeId("KMS023");
		List bankBookList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("bankBookList", bankBookList);
		/* 상세코드 불러오기 End */
		
		// 회사구분을 불러옵니다. Start */
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		Map<String, Object> result = fundService.selectFund(commandMap);
		model.addAttribute("result", result);

		if (commandMap.get("searchDate") != null)
			model.addAttribute("searchDate", commandMap.get("searchDate").toString());
		String companyCd = "";
		if (commandMap.get("companyCd") != null)
			companyCd = commandMap.get("companyCd").toString();
		
		return "/management/mgmt_fundM";
	}
	
	@RequestMapping("/management/fundU.do") 
	public String fundUpdate(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		fundService.updateFund(commandMap);
		
		String searchDate = "";
		if (commandMap.get("searchDate") != null)
			searchDate = commandMap.get("searchDate").toString();
		String companyCd = "";
		if (commandMap.get("companyCd") != null)
			companyCd = commandMap.get("companyCd").toString();
		return "redirect:/management/fundWeeklyDetail.do?searchDate=" + searchDate + "&companyCd=" + companyCd;
	}
	
	@RequestMapping("/management/fundC.do") 
	public String fundChnage(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		/* 상세코드 불러오기 Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS021");
		List typeList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS022");
		List accountList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("accountList", accountList);
		
		vo.setCodeId("KMS023");
		List bankBookList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("bankBookList", bankBookList);
		/* 상세코드 불러오기 End */
		
		// 회사구분을 불러옵니다. Start */
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		Map<String, Object> result = fundService.selectFund(commandMap);
		model.addAttribute("result", result);

		if (commandMap.get("searchDate") != null)
			model.addAttribute("searchDate", commandMap.get("searchDate").toString());
		
		return "/management/mgmt_fundC";
	}
	
	@RequestMapping("/management/fundD.do") 
	public String fundDelete(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		fundService.deleteFund(commandMap);
		
		String searchDate = "";
		if (commandMap.get("searchDate") != null)
			searchDate = commandMap.get("searchDate").toString();
		String companyCd = "";
		if (commandMap.get("companyCd") != null)
			companyCd = commandMap.get("companyCd").toString();
		return "redirect:/management/fundWeeklyDetail.do?searchDate=" + searchDate + "&companyCd=" + companyCd;
	}
	
	@RequestMapping("/management/fundWeeklyDetail.do") 
	public String fundWeeklyDetail(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(req);
		if(!user.isAdmin() && !user.isFundAdmin()){
			return "error/authError";
		}

		String searchDate = "";
		if (commandMap.get("searchDate") != null && !commandMap.get("searchDate").toString().equals("")) {
			searchDate = commandMap.get("searchDate").toString();
			if (commandMap.get("moveDate") != null && !commandMap.get("moveDate").toString().equals(""))
				searchDate = CalendarUtil.getDate(searchDate, Integer.parseInt(commandMap.get("moveDate").toString()));
		} else
			searchDate = CalendarUtil.getToday();
		
		model.addAttribute("searchDate", searchDate);
		String startDate = CalendarUtil.getFirstDateOfThisWeek(searchDate);
		String endDate = CalendarUtil.getLastDateOfThisWeek(searchDate);
		
		Map<String, Object> param = new HashMap<String, Object>(); 
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
		// 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		String companyCd = ((CmmnDetailCode) companyList.get(0)).getCode();
		if (commandMap.get("companyCd") != null && !commandMap.get("companyCd").toString().equals(""))
			companyCd = commandMap.get("companyCd").toString();
		
		param.put("companyCd", companyCd);
		model.addAttribute("companyCd", companyCd);
		
		param.put("type", "D");
		param.put("plan", "N");
		List depositList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("depositList", depositList);
		model.addAttribute("depositListSize", depositList.size());
		long depositSum = 0;
		for (int i = 0; i < depositList.size(); i++) {
			String tmp = ((Map<String, Object>) depositList.get(i)).get("expense").toString();
			depositSum += Long.parseLong(tmp);
		}
		model.addAttribute("depositSum", depositSum);
		
		param.put("type", "W");
		param.put("plan", "N");
		List withdrawList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("withdrawList", withdrawList);
		model.addAttribute("withdrawListSize", withdrawList.size());
		long withdrawSum = 0;
		for (int i = 0; i < withdrawList.size(); i++) {
			String tmp = ((Map<String, Object>) withdrawList.get(i)).get("expense").toString();
			withdrawSum += Long.parseLong(tmp);
		}
		model.addAttribute("withdrawSum", withdrawSum);
		
		param.put("type", "W");
		param.put("plan", "Y");
		List planWithdrawList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("planWithdrawList", planWithdrawList);
		model.addAttribute("planWithdrawListSize", planWithdrawList.size());
		long withdrawPlanSum = 0;
		for (int i = 0; i < planWithdrawList.size(); i++) {
			String tmp = ((Map<String, Object>) planWithdrawList.get(i)).get("expense").toString();
			withdrawPlanSum += Long.parseLong(tmp);
		}
		model.addAttribute("withdrawPlanSum", withdrawPlanSum);
		
		param.put("type", "RD");
		param.put("plan", "N");
		List transferDepositList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("transferDepositList", transferDepositList);
		model.addAttribute("transferDepositListSize", transferDepositList.size());
		long transferDepositSum = 0;
		for (int i = 0; i < transferDepositList.size(); i++) {
			String tmp = ((Map<String, Object>) transferDepositList.get(i)).get("expense").toString();
			transferDepositSum += Long.parseLong(tmp);
		}
		model.addAttribute("transferDepositSum", transferDepositSum);
		
		param.put("type", "RW");
		param.put("plan", "N");
		List transferWithdrawList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("transferWithdrawList", transferWithdrawList);
		model.addAttribute("transferWithdrawListSize", transferWithdrawList.size());
		long transferWithdrawSum = 0;
		for (int i = 0; i < transferWithdrawList.size(); i++) {
			String tmp = ((Map<String, Object>) transferWithdrawList.get(i)).get("expense").toString();
			transferWithdrawSum += Long.parseLong(tmp);
		}
		model.addAttribute("transferWithdrawSum", transferWithdrawSum);
		
		return "/management/mgmt_fundWeeklyDetailList";
	}
	
	@RequestMapping("/management/fundWeekly.do") 
	public String fundWeekly(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(req);
		if(!user.isAdmin() && !user.isFundAdmin()) {
			return "error/authError";
		}
		
		String searchDate = "";
		if (commandMap.get("searchDate") != null && !commandMap.get("searchDate").toString().equals("")) {
			searchDate = commandMap.get("searchDate").toString();
			if (commandMap.get("moveDate") != null && !commandMap.get("moveDate").toString().equals(""))
				searchDate = CalendarUtil.getDate(searchDate, Integer.parseInt(commandMap.get("moveDate").toString()));
		} else
			searchDate = CalendarUtil.getToday();
		
		model.addAttribute("searchDate", searchDate);
		String startDate = CalendarUtil.getFirstDateOfThisWeek(searchDate);
		String endDate = CalendarUtil.getLastDateOfThisWeek(searchDate);
		
		Map<String, Object> param = new HashMap<String, Object>(); 
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
		// 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		String companyCd = ((CmmnDetailCode) companyList.get(0)).getCode();
		if (commandMap.get("companyCd") != null && !commandMap.get("companyCd").toString().equals("")) {
			companyCd = commandMap.get("companyCd").toString();
		}else {
			if(user.isFundAdmin()) {
				companyCd = "uprism";
			}
		}
			
		
		param.put("companyCd", companyCd);
		model.addAttribute("companyCd", companyCd);
		
		List normalList = fundService.selectFundListWeekly(param);
		model.addAttribute("normalList", normalList);
		model.addAttribute("normalListSize", normalList.size());
		
		param.put("cash", "CASH");
		List cashList = fundService.selectFundListWeekly(param);
		model.addAttribute("cashList", cashList);
		model.addAttribute("cashListSize", cashList.size());
		
		long base = 0;
		long depositSum = 0;
		long withdrawSum = 0;
		long withdrawPlanSum = 0;
		long result = 0;
		long total = 0;
		//받는게 다 long인데 Integer.parseInt 로 변환하면 오버플로우 java.lang.NumberFormatException 발생. 이런 사소한 실수가 생기지 않도록 기록		
		for (int i = 0; i < normalList.size(); i++) {
			String tmp = ((Map<String, Object>) normalList.get(i)).get("base").toString();
			base += Long.parseLong(tmp);
			
			tmp = ((Map<String, Object>) normalList.get(i)).get("depositSum").toString();
			depositSum += Long.parseLong(tmp);
			
			tmp = ((Map<String, Object>) normalList.get(i)).get("withdrawSum").toString();
			withdrawSum += Long.parseLong(tmp);
			
			tmp = ((Map<String, Object>) normalList.get(i)).get("withdrawPlanSum").toString();
			withdrawPlanSum += Long.parseLong(tmp);
		}
		
		total = depositSum - withdrawSum;
		result = total + base;
		
		model.addAttribute("sumBase", base);
		model.addAttribute("sumDepositSum", depositSum);
		model.addAttribute("sumWithdrawSum", withdrawSum);
		model.addAttribute("sumWithdrawPlanSum", withdrawPlanSum);
		model.addAttribute("sumTotal", total);
		model.addAttribute("sumResult", result);
		
		if (cashList.size() > 0)
		{
			String tmp = ((Map<String, Object>) cashList.get(0)).get("base").toString();
			base += Integer.parseInt(tmp);
			
			tmp = ((Map<String, Object>) cashList.get(0)).get("depositSum").toString();
			depositSum += Integer.parseInt(tmp);
			
			tmp = ((Map<String, Object>) cashList.get(0)).get("withdrawSum").toString();
			withdrawSum += Integer.parseInt(tmp);
			
			tmp = ((Map<String, Object>) cashList.get(0)).get("withdrawPlanSum").toString();
			withdrawPlanSum += Integer.parseInt(tmp);
		}
		
		total = depositSum - withdrawSum;
		result = total + base;
		
		model.addAttribute("totalBase", base);
		model.addAttribute("totalDepositSum", depositSum);
		model.addAttribute("totalWithdrawSum", withdrawSum);
		model.addAttribute("totalWithdrawPlanSum", withdrawPlanSum);
		model.addAttribute("totalTotal", total);
		model.addAttribute("totalResult", result);
		
		return "/management/mgmt_fundWeeklyList";
	}
	
	@RequestMapping("/management/fundMonthly.do") 
	public String fundMonthly(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(req);
		if(!user.isAdmin() && !user.isFundAdmin()) {
			return "error/authError";
		}
		
		String searchDate = "";
		if (commandMap.get("searchDate") != null && !commandMap.get("searchDate").toString().equals("")) {
			searchDate = commandMap.get("searchDate").toString();
			if (commandMap.get("moveDate") != null && !commandMap.get("moveDate").toString().equals(""))
				searchDate = CalendarUtil.getDate(searchDate, Integer.parseInt(commandMap.get("moveDate").toString()));
		} else
			searchDate = CalendarUtil.getToday();
		
		model.addAttribute("searchDate", searchDate);
		String searchMonth = searchDate.substring(0, 6);
		int endDate = CalendarUtil.getLastDateOfMonth(searchDate.substring(0, 4), searchDate.substring(4, 6));
		model.addAttribute("startDate", searchMonth + "01");
		model.addAttribute("endDate", searchMonth + endDate);
		
		Map<String, Object> param = new HashMap<String, Object>(); 
		param.put("searchMonth", searchMonth);
		
		// 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		String companyCd = ((CmmnDetailCode) companyList.get(0)).getCode();
		if (commandMap.get("companyCd") != null && !commandMap.get("companyCd").toString().equals("")) {
			companyCd = commandMap.get("companyCd").toString();
		}else {
			if(user.isFundAdmin()) {
				companyCd = "uprism";
			}
		}
		
		param.put("companyCd", companyCd);
		model.addAttribute("companyCd", companyCd);
		
		List resultList = fundService.selectFundListMonthly(param);
		
		List totalList = new ArrayList();
		for (int i = 1; i <= 31; i++) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("date", i);
			boolean search = false;
			for (int j = 0; j < resultList.size(); j++) {
				String tmp = ((Map<String, Object>) resultList.get(j)).get("date").toString();
				if (tmp.equals("" + (i > 9 ? i : "0" + i)) ) {
					m.put("base", ((Map<String, Object>) resultList.get(j)).get("base").toString());
					m.put("depositSum", ((Map<String, Object>) resultList.get(j)).get("depositSum").toString());
					m.put("withdrawSum", ((Map<String, Object>) resultList.get(j)).get("withdrawSum").toString());
					m.put("withdrawPlanSum", ((Map<String, Object>) resultList.get(j)).get("withdrawPlanSum").toString());
					m.put("result", ((Map<String, Object>) resultList.get(j)).get("result").toString());
					m.put("total", ((Map<String, Object>) resultList.get(j)).get("total").toString());
					
					search = true;
				}
			}
			if (!search) {
				m.put("base", 0);
				m.put("depositSum", 0);
				m.put("withdrawSum", 0);
				m.put("withdrawPlanSum", 0);
				m.put("result", 0);
				m.put("total", 0);
			}
			totalList.add(m);
		}
		
		long baseLong = 0;
		for (int i = 0; i <= 30; i++) {
			Map<String, Object> total = (Map<String, Object>) totalList.get(i);
			if (i == 0)
				baseLong = Long.parseLong(total.get("base").toString());
			total.put("base", baseLong);
			String totalTmp = total.get("total").toString();
			long totalTmpLong = Long.parseLong(totalTmp);
			baseLong += totalTmpLong;
			total.put("result", baseLong);
		}
		
		model.addAttribute("totalList", totalList);
		
		long base = 0;
		long depositSum = 0;
		long withdrawSum = 0;
		long withdrawPlanSum = 0;
		long result = 0;
		long total = 0;
		
		for (int i = 0; i < totalList.size(); i++) {
			String tmp = ((Map<String, Object>) totalList.get(i)).get("base").toString();
			base += Long.parseLong(tmp);
			
			tmp = ((Map<String, Object>) totalList.get(i)).get("depositSum").toString();
			depositSum += Long.parseLong(tmp);
			
			tmp = ((Map<String, Object>) totalList.get(i)).get("withdrawSum").toString();
			withdrawSum += Long.parseLong(tmp);
			
			tmp = ((Map<String, Object>) totalList.get(i)).get("withdrawPlanSum").toString();
			withdrawPlanSum += Long.parseLong(tmp);
		}
		
		total = depositSum - withdrawSum;
		result = total + base;
		
		model.addAttribute("sumBase", base);
		model.addAttribute("sumDepositSum", depositSum);
		model.addAttribute("sumWithdrawSum", withdrawSum);
		model.addAttribute("sumWithdrawPlanSum", withdrawPlanSum);
		model.addAttribute("sumTotal", total);
		model.addAttribute("sumResult", result);
		
		return "/management/mgmt_fundMonthlyList";
	}
	
	@RequestMapping("/management/fundDaily.do") 
	public String fundDaily(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		String searchDate = "";
		if (commandMap.get("searchDate") != null && !commandMap.get("searchDate").toString().equals("")) {
			searchDate = commandMap.get("searchDate").toString();
			if (commandMap.get("moveDate") != null && !commandMap.get("moveDate").toString().equals(""))
				searchDate = CalendarUtil.getDate(searchDate, Integer.parseInt(commandMap.get("moveDate").toString()));
		} else
			searchDate = CalendarUtil.getToday();
		
		model.addAttribute("searchDate", searchDate);
		
		Map<String, Object> param = new HashMap<String, Object>(); 
		param.put("startDate", searchDate);
		param.put("endDate", searchDate);
		model.addAttribute("startDate", searchDate);
		model.addAttribute("endDate", searchDate);
		
		// 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		String companyCd = ((CmmnDetailCode) companyList.get(0)).getCode();
		if (commandMap.get("companyCd") != null && !commandMap.get("companyCd").toString().equals(""))
			companyCd = commandMap.get("companyCd").toString();
		
		param.put("companyCd", companyCd);
		model.addAttribute("companyCd", companyCd);
		
		param.put("type", "D");
		param.put("plan", "N");
		List depositList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("depositList", depositList);
		model.addAttribute("depositListSize", depositList.size());
		long depositSum = 0;
		for (int i = 0; i < depositList.size(); i++) {
			String tmp = ((Map<String, Object>) depositList.get(i)).get("expense").toString();
			depositSum += Integer.parseInt(tmp);
		}
		model.addAttribute("depositSum", depositSum);
		
		param.put("type", "W");
		param.put("plan", "N");
		List withdrawList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("withdrawList", withdrawList);
		model.addAttribute("withdrawListSize", withdrawList.size());
		long withdrawSum = 0;
		for (int i = 0; i < withdrawList.size(); i++) {
			String tmp = ((Map<String, Object>) withdrawList.get(i)).get("expense").toString();
			withdrawSum += Integer.parseInt(tmp);
		}
		model.addAttribute("withdrawSum", withdrawSum);
		
		param.put("type", "W");
		param.put("plan", "Y");
		List planWithdrawList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("planWithdrawList", planWithdrawList);
		model.addAttribute("planWithdrawListSize", planWithdrawList.size());
		long withdrawPlanSum = 0;
		for (int i = 0; i < planWithdrawList.size(); i++) {
			String tmp = ((Map<String, Object>) planWithdrawList.get(i)).get("expense").toString();
			withdrawPlanSum += Integer.parseInt(tmp);
		}
		model.addAttribute("withdrawPlanSum", withdrawPlanSum);
		
		param.put("type", "RD");
		param.put("plan", "N");
		List transferDepositList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("transferDepositList", transferDepositList);
		model.addAttribute("transferDepositListSize", transferDepositList.size());
		long transferDepositSum = 0;
		for (int i = 0; i < transferDepositList.size(); i++) {
			String tmp = ((Map<String, Object>) transferDepositList.get(i)).get("expense").toString();
			transferDepositSum += Integer.parseInt(tmp);
		}
		model.addAttribute("transferDepositSum", transferDepositSum);
		
		param.put("type", "RW");
		param.put("plan", "N");
		List transferWithdrawList = fundService.selectFundListWeeklyDetail(param);
		model.addAttribute("transferWithdrawList", transferWithdrawList);
		model.addAttribute("transferWithdrawListSize", transferWithdrawList.size());
		long transferWithdrawSum = 0;
		for (int i = 0; i < transferWithdrawList.size(); i++) {
			String tmp = ((Map<String, Object>) transferWithdrawList.get(i)).get("expense").toString();
			transferWithdrawSum += Integer.parseInt(tmp);
		}
		model.addAttribute("transferWithdrawSum", transferWithdrawSum);
		
		return "/management/mgmt_fundDailyList";
	}
	
	@RequestMapping("/management/fundYearly.do") 
	public String fundYearly(@ModelAttribute("searchVO") FundVO fundVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		List resultList = fundService.selectFundListYearly(commandMap);
		
		model.addAttribute("resultList", resultList);
		
		return "/management/mgmt_fundYearlyList";
	}
}
