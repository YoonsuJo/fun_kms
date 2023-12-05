package kms.com.management.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.app.service.ApprovalVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.common.service.CommonService;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.member.service.MemberVO;
import kms.com.management.dao.SalesDAO;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.OuterPurchaseVO;
import kms.com.management.service.SalesService;
import kms.com.management.service.SalesVO;

import kms.com.management.fm.BizStatisticFm;
import kms.com.management.vo.MonthResultVO;

@Controller
public class SalesController {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name="KmsSalesService")
	private SalesService salesService;
	
	@Resource(name = "KmsSalesDAO")
	private SalesDAO salesDAO;

	@Resource(name = "KmsCommonService")
	private CommonService commonService;
	
	@Resource(name = "approvalService")
	private KmsApprovalService approvalService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@RequestMapping("/management/innerSalesList.do")
	public String innerSalesList(@ModelAttribute("searchVO") InnerSalesVO innerSalesVO, ModelMap model) throws Exception {
		
		innerSalesVO.setSearchOrgIdSalesList(CommonUtil.makeValidIdList(innerSalesVO.getSearchOrgIdSales()));
		innerSalesVO.setSearchOrgIdPurchaseList(CommonUtil.makeValidIdList(innerSalesVO.getSearchOrgIdPurchase()));
		
		List<InnerSalesVO> resultList = salesService.selectInnerSalesList(innerSalesVO);
		
		model.addAttribute("resultList", resultList);
		
		return "management/mgmt_innerSalesL";
	}
	
	@RequestMapping("/management/innerSalesDetailList.do")
	public String innerSalesDetailList(@ModelAttribute("searchVO") InnerSalesVO innerSalesVO, ModelMap model) throws Exception {

		innerSalesVO.setSearchOrgIdSalesList(CommonUtil.makeValidIdList(innerSalesVO.getSearchOrgIdSales()));
		innerSalesVO.setSearchOrgIdPurchaseList(CommonUtil.makeValidIdList(innerSalesVO.getSearchOrgIdPurchase()));
		
		List<InnerSalesDetailVO> resultList = salesService.selectInnerSalesDetailList(innerSalesVO);
		
		model.addAttribute("resultList", resultList);
		
		return "management/mgmt_innerSalesV";
	}
	
	
	@RequestMapping("/management/salesList.do")
	public String salesList(@ModelAttribute("searchVO") SalesVO searchVO
			, ModelMap model) throws Exception {
		
		searchVO.setSearchMonth(Integer.toString(Integer.parseInt(searchVO.getSearchMonth()) ) );
		searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()));
		
		List<SalesVO> resultList = salesService.selectSalesList(searchVO);
		model.addAttribute("resultList", resultList);
		
		List<SalesVO> resultSum = salesService.selectSalesSum(searchVO);
		model.addAttribute("resultSum", resultSum);
		
		List busiIdList = commonService.selectBusiIdList(Integer.parseInt(searchVO.getSearchYear()));
		model.addAttribute("busiIdList",busiIdList);		
		
		model.addAttribute("divideby", 1000);
		return "management/mgmt_salesV";
	}
	
	@RequestMapping("/management/updateSalesDecideYn.do")
	public String updateSalesDecideYn(@ModelAttribute("searchVO") SalesVO searchVO
			,@ModelAttribute("approvalVO") ApprovalVO approvalVO
			,HttpServletRequest request, HttpServletResponse response
			, ModelMap model, Map<String, Object> commandMap) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		ApprovalVO vo = approvalService.viewApprovalDoc(approvalVO);
		
		if(!user.isAdmin() && vo.getWriterNo()!=user.getNo())
		{
			return "error/authError";
		}
			
		approvalVO.setDecideYn("Y");
		approvalService.updateSalesDocDecideYn(approvalVO);

		// 20140808, dwkim, 매출일, 최종수금예정일 변경
		String templtId = (String)commandMap.get("templtId");
		Map<String, String> param = new HashMap<String, String>();
		param.put("docId", (String)commandMap.get("docId"));
		param.put("stDt", (String)commandMap.get("stDt"));
		param.put("colDueDt", (String)commandMap.get("colDueDt"));
		if ("21".equals(templtId)) {	// 일반매출 : 매출일, 최종수금예정일
			approvalService.updateGenSales(param);
		} else if ("20".equals(templtId)) {	// 종합매출 : 최종수금예정일
			approvalService.updateTotSales(param);
		}
		
		return "redirect:/management/salesList.do?searchOrgId=" + searchVO.getSearchOrgId() + "&searchCondition=" +searchVO.getSearchCondition() 
		+"&searchYear=" + searchVO.getSearchYear() + "&searchMonth=" +searchVO.getSearchMonth() +"&searchBusiId=" + searchVO.getSearchBusiId();
	}

	@RequestMapping("/management/updateSalesBondManageYn.do")
	public String updateSalesBondManageYn(@ModelAttribute("searchVO") SalesVO searchVO
			,@ModelAttribute("approvalVO") ApprovalVO approvalVO
			,HttpServletRequest request, HttpServletResponse response
			, ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		if(!user.isAdmin())
		{
			return "error/authError";
		}
		
		approvalService.updateSalesDocBondManageYn(approvalVO);
		
		return "redirect:/management/bondNoPublish.do?prjId=" + searchVO.getPrjId();
	}
	
	@RequestMapping("/management/outerPurchaseList.do")
	public String outerPurchaseList(@ModelAttribute("searchVO") OuterPurchaseVO outerPurchaseVO, ModelMap model) throws Exception {
		
		outerPurchaseVO.setSearchOrgIdList(CommonUtil.makeValidIdList(outerPurchaseVO.getSearchOrgId()));
		outerPurchaseVO.setSearchPrjIdList(CommonUtil.makeValidIdList(outerPurchaseVO.getSearchPrjId()));

		List<OuterPurchaseVO> resultList = new ArrayList<OuterPurchaseVO>();
		if (!"EXP".equals(outerPurchaseVO.getSearchType())) {
			resultList = salesService.selectOuterPurchaseSumList(outerPurchaseVO);
		} else {
			resultList = salesService.selectOuterPurchaseList(outerPurchaseVO);
			
			//검색조건 셀렉트 박스
			ComDefaultCodeVO vo = new ComDefaultCodeVO();
			vo.setCodeId("KMS000"); // 결재상태		
			List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
			model.addAttribute("docStatList", codeResult);
		}
		
		model.addAttribute("resultList", resultList);
		
		return "management/mgmt_outerPurchaseL";
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// TENY_170504 월간사업실적에서 실적부분을 Popup으로 띄우는 기능들.
	// TENY_170504 월별 매출목록을 리스트 한다. POPUP으로 띄우는게 좋겠음.
	@RequestMapping("/management/MonthResultList.do")
	public String MonthSalesOutList(@ModelAttribute("searchVO") BizStatisticFm bsFm,
		ModelMap model, Map<String, Object> commandMap) throws Exception{
		logT.debug("START");

		logT.debug("searchYM : " + bsFm.getSearchYM());
		
		List<MonthResultVO> mrVOList = salesService.selectMonthResultList(bsFm);
		
		model.addAttribute("searchVO", bsFm);
		model.addAttribute("mrVOList", mrVOList);
		model.addAttribute("divideby", 1000);
		
		return "management/mgmt_MonthResultLPop";
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// TENY_170504 월간사업실적에서 실적부분을 Popup으로 띄우는 기능들.
	// TENY_170504 월별 매출목록을 리스트 한다. POPUP으로 띄우는게 좋겠음.
	@RequestMapping("/management/MonthLaborResultOfProject.do")
	public String MonthLaborResultOfProject(@ModelAttribute("searchVO") BizStatisticFm bsFm,
		ModelMap model, Map<String, Object> commandMap) throws Exception{
		logT.debug("START");
		
		logT.debug("searchYM : " + bsFm.getSearchYM());
		
		List<MonthResultVO> mrVOList = salesService.selectMonthLaborOfProject(bsFm);
		
		model.addAttribute("searchVO", bsFm);
		model.addAttribute("mrVOList", mrVOList);
		model.addAttribute("divideby", 1000);
		
		return "management/mgmt_MonthLaborResultOfProjectPop";
	}

}
