package kms.com.management.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import kms.com.common.service.BusinessSectorVO;
import kms.com.common.service.CommonService;
import kms.com.common.utils.CommonUtil;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.ProjectVO;
import kms.com.management.service.BusinessPlanService;
import kms.com.management.service.ExpenseService;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.PlanCostVO;
import kms.com.management.service.SalesService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class BusinessPlanController {
	@Resource(name="KmsBusinessPlanService")
	BusinessPlanService businnesPlanService;
	
	@Resource(name = "KmsCommonService")
	CommonService commonService;
	
	@Resource(name = "projectService")
	private ProjectService projectService;
	
	@RequestMapping("/management/prjPlanCostList.do")
	public String prjPlanCostList(@ModelAttribute("searchVO") PlanCostVO searchVO, ModelMap model) throws Exception {
		
		searchVO.setSearchOrgIdList(CommonUtil.makeValidIdList(searchVO.getSearchOrgId()));
		
		String searchYear = searchVO.getSearchYear();
		searchVO.setStartDate(searchYear + "1231");
		searchVO.setEndDate(searchYear + "0101");
		
		model.addAttribute("resultList",businnesPlanService.prjPlanCostList(searchVO));
		model.addAttribute("resultSum",businnesPlanService.prjPlanCostSum(searchVO));
		
		return "management/mgmt_prjPlanCostL";
	}
	
	@RequestMapping("/management/prjPlanCostDetailList.do")
	public String prjPlanCostDetailList(@ModelAttribute("searchVO") PlanCostVO searchVO, ModelMap model) throws Exception {
		List resultList = businnesPlanService.prjPlanCostDetailList(searchVO);
		ProjectVO prjVO = new ProjectVO();
		prjVO.setPrjId(searchVO.getSearchPrjId());
		prjVO = projectService.selectProjectView(prjVO);
		searchVO.setSearchPrjNm(prjVO.getPrjNm());
		model.addAttribute("resultList",businnesPlanService.prjPlanCostDetailList(searchVO));
		return "management/mgmt_prjPlanCostDetailL";
	}
	
	@RequestMapping("/management/selectAnnualBusinessPlan.do")
	public String annualBusinessPlan(@ModelAttribute("searchVO") PlanCostVO searchVO,
			ModelMap model) throws Exception {
		
		List<BusinessSectorVO> busiSectorList = commonService.selectBusinessSectorList(Integer.parseInt(searchVO.getSearchYear()));

		String sectorNo = "0";
		if (busiSectorList.size() > 0) {
			sectorNo = Integer.toString(busiSectorList.get(0).getNo());
		}
		if ("".equals(searchVO.getSearchSectorNo())) searchVO.setSearchSectorNo(sectorNo);
		else if(!sectorNo.equals(searchVO.getSearchSectorNo())) searchVO.setSearchSectorNo(sectorNo);

		String sectorVal = "";
		for(int i = 0; i < busiSectorList.size(); i++) {
				if (Integer.parseInt(searchVO.getSearchSectorNo()) == busiSectorList.get(i).getNo()) {
					sectorVal = busiSectorList.get(i).getBusiSectorVal();
					break;
				}
		}
		List<EgovMap> orgList = commonService.selectUnderOrgList(CommonUtil.makeValidIdList(sectorVal));

		List resultList = businnesPlanService.annualBusinessPlan(searchVO);
		if(resultList.size()==0)
		{
			resultList = new ArrayList<PlanCostVO>();
			for(int i=0; i<12;i++)
			{
				resultList.add(new PlanCostVO());
			}
		}
		model.addAttribute("sectorList",busiSectorList);
		model.addAttribute("orgList", orgList);
		model.addAttribute("resultList",resultList);
		model.addAttribute("resultSum",businnesPlanService.annualBusinessPlanSum(searchVO));
		model.addAttribute("divideBy",1000000);
		return "management/mgmt_annualBusinessPlanL";
	}
	
	@RequestMapping("/management/selectBusinessPlanApp.do")
	public String selectBusinessPlanApp(@ModelAttribute("searchVO") PlanCostVO searchVO,
			ModelMap model) throws Exception {

		List<BusinessSectorVO> busiSectorList = commonService.selectBusinessSectorList(Integer.parseInt(searchVO.getSearchYear()));
		
		String sectorNo = "0";
		if (busiSectorList.size() > 0) {
			sectorNo = Integer.toString(busiSectorList.get(0).getNo());
		}
		if ("".equals(searchVO.getSearchSectorNo())) searchVO.setSearchSectorNo(sectorNo);

		String sectorVal = "";
		for(int i = 0; i < busiSectorList.size(); i++) {
				if (Integer.parseInt(searchVO.getSearchSectorNo()) == busiSectorList.get(i).getNo()) {
					sectorVal = busiSectorList.get(i).getBusiSectorVal();
					break;
				}
		}
		List<EgovMap> orgList = commonService.selectUnderOrgList(CommonUtil.makeValidIdList(sectorVal));
		
		model.addAttribute("sectorList",busiSectorList);
		model.addAttribute("orgList", orgList);
		model.addAttribute("resultList",businnesPlanService.selectBusinessPlanApp(searchVO) );
		return "management/mgmt_BusinessPlanAppL";
	}
	
	
	
}
