package kms.com.management.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.app.service.ApprovalExpenseVO;
import kms.com.app.service.ApprovalPresetVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.app.service.KmsPresetService;
import kms.com.app.service.KmsSelfdevService;
import kms.com.app.service.SelfdevVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.management.service.ExpenseDetail;
import kms.com.management.service.ExpenseService;
import kms.com.management.service.ExpenseVO;
import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultPersonVO;
import kms.com.management.service.InputResultService;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class ExpenseController {
	
	@Resource(name="KmsExpenseService")
	ExpenseService expService;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
		
	@Resource(name = "presetService")
	private KmsPresetService presetService;
	
	@Resource(name="KmsSelfdevService")
	KmsSelfdevService selfdevService;
	
	@Autowired
	private DefaultBeanValidator beanValidator;

	Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping("/management/selectExpenseStatistic.do")
	public String selectExpenseStatistic(@ModelAttribute("searchVO") ExpenseVO expenseVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		if (CommonUtil.isMixedId(expenseVO.getSearchUserMixes()))
			expenseVO.setSearchUserId(CommonUtil.parseIdFromMixs(expenseVO.getSearchUserMixes()));
		
		expenseVO.setSearchOrgIdList(CommonUtil.makeValidIdList(expenseVO.getSearchOrgId()));
		
		Map<String, Object> result = expService.selectExpenseList(expenseVO);
		
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
    	List comCdList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("resultList", result.get("resultList"));
		model.addAttribute("sum", result.get("sum"));
		model.addAttribute("comCdList", comCdList);
		
		return "management/mgmt_ExpenseS";
	}
	
	
	@RequestMapping("/management/selectExpenseDetail.do")
	public String selectExpenseDetail(@ModelAttribute("searchVO") ExpenseVO expenseVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		if (CommonUtil.isMixedId(expenseVO.getSearchUserMixes()))
			expenseVO.setSearchUserId(CommonUtil.parseIdFromMixs(expenseVO.getSearchUserMixes()));

		expenseVO.setSearchOrgIdList(CommonUtil.makeValidIdList(expenseVO.getSearchOrgId()));
		
		String month = String.format("%02d", Integer.parseInt(expenseVO.getSearchMonth()));
		expenseVO.setSearchMonth(month);
		
		String moveMonth = (String)commandMap.get("moveMonth");
		if (moveMonth != null && moveMonth.equals("") == false) {
			String yyyymmdd = CalendarUtil.getDate(expenseVO.getSearchYear() + expenseVO.getSearchMonth() + "01", "MONTH", Integer.parseInt(moveMonth));
			expenseVO.setSearchYear(yyyymmdd.substring(0,4));
			expenseVO.setSearchMonth(yyyymmdd.substring(4,6));
		}
		
		List<ExpenseDetail> resultList = expService.selectExpenseDetailList(expenseVO);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List comCdList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("comCdList", comCdList);
		
		return "management/mgmt_ExpenseD";
	}
	
	@RequestMapping("/admin/approval/eappExpV.do")
	public String selectEappExpView(@ModelAttribute("searchVO") ExpenseVO searchVO, Model model)
	        throws Exception {
	    
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007"); //회사이름 코드
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		
		JSONObject result = expService.selectExpenseDetail(searchVO);
		if(result == null)
			return null;
		int templtId = Integer.parseInt(result.get("templtId").toString());
		int writerNo = Integer.parseInt(result.get("writerNo").toString());
		String docId = result.get("docId").toString();
		String expDt = result.get("expDt").toString();
		
		JSONObject appTyp = new JSONObject();
		appTyp.put("templtId", templtId);
		model.addAttribute("appTyp", appTyp);
		
		if(templtId==11) { //자기개발비
			SelfdevVO selfdevVO = new SelfdevVO();
			selfdevVO.setUserNo(writerNo);
			//해당 문서에서 작성된 자기개발비는 미포함.
			selfdevVO.setSearchDocId(docId);
			selfdevVO.setYear(expDt.substring(0,4) );
			model.addAttribute("selfdevVO", selfdevService.selectSelfdevUsrInfo(selfdevVO));
		}		
		if(templtId==11) { //자기개발비
			ApprovalPresetVO searchPresetVO = new ApprovalPresetVO();
			searchPresetVO.setPresetTyp("S");//selfdevPresetCode);
			model.addAttribute("presetPrjList", presetService.selectSpeicalPresetPrjList(searchPresetVO));
			model.addAttribute("presetPrjCnt", presetService.selectSpeicalPresetPrjCnt(searchPresetVO));
		} else if(templtId==13) { //상품매입
			ApprovalPresetVO searchPresetVO = new ApprovalPresetVO();
			searchPresetVO.setPresetTyp("C");//costPresetCode);
			model.addAttribute("presetPrjList", presetService.selectSpeicalPresetPrjList(searchPresetVO));
			model.addAttribute("presetPrjCnt", presetService.selectSpeicalPresetPrjCnt(searchPresetVO));
		} else { //업무경비
			ApprovalPresetVO presetVO = new ApprovalPresetVO();
			presetVO.setUseAt("Y");	
			presetVO.setPresetTyp("G");
			List presetList = presetService.selectPresetList(presetVO);
			model.addAttribute("presetList", presetList);
			model.addAttribute("presetPrjList", new JSONObject());
			model.addAttribute("presetPrjCnt", new JSONObject());
		}
		
		model.addAttribute("specificVOList", result);
		//model.addAttribute("specificVOList", approvalService.selectExpenseList(searchVO));
		//model.addAttribute("specificVOCnt", approvalService.selectExpenseCnt(searchVO));
		//model.addAttribute("specificVOSum", approvalService.selectExpenseSum(searchVO));
				
	    return "approval/appr_ExpV";
	}
	
	@RequestMapping("/admin/approval/eappExpU.do")
	public String updateEappExpView(@ModelAttribute("searchVO") ExpenseVO expenseVO, Model model)
	        throws Exception {

		expService.updateExpenseDetailt(expenseVO);	    
	    return "admin/approval/approvalV";
	}

	@RequestMapping("/management/selectExpenseDetailExcel.do")
	public String selectExpenseDetailExcel(ExpenseVO expenseVO, Map<String, Object> commandMap,
			HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		
		if (CommonUtil.isMixedId(expenseVO.getSearchUserMixes()))
			expenseVO.setSearchUserId(CommonUtil.parseIdFromMixs(expenseVO.getSearchUserMixes()));

		expenseVO.setSearchOrgIdList(CommonUtil.makeValidIdList(expenseVO.getSearchOrgId()));
		
		List<ExpenseDetail> resultList = expService.selectExpenseDetailList(expenseVO);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List comCdList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("comCdList", comCdList);
		
		res.setHeader("Content-Disposition", "attachment; filename=expenseDetail_excel.xls"); 
	    res.setHeader("Content-Description", "JSP Generated Data");
		return "management/mgmt_ExpenseExcel";
	}
	
	

}
