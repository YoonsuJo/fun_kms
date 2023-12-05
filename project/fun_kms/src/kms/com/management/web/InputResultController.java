package kms.com.management.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.naming.directory.SearchControls;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultPersonVO;
import kms.com.management.service.InputResultProject;
import kms.com.management.service.InputResultProjectDetail;
import kms.com.management.service.InputResultProjectDetailVO;
import kms.com.management.service.InputResultProjectVO;
import kms.com.management.service.InputResultDeptVO;
import kms.com.management.service.InputResultService;
import kms.com.management.service.ProjectInputPlanDailyVO;
import kms.com.management.service.ProjectInputPlanManagement;
import kms.com.management.service.ProjectInputPlanManagementVO;
import kms.com.management.service.SalesVO;
import kms.com.member.service.MemberVO;
import kms.com.salary.service.SalaryVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class InputResultController {
	
	@Resource(name="KmsInputResultService")
	InputResultService irService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Autowired
	private DefaultBeanValidator beanValidator;

	Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping("/management/selectInputResultPerson.do")
	public String selectInputResultPerson(@ModelAttribute("searchVO") InputResultPerson inputResultPerson, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		inputResultPerson.setSearchUserMixList(CommonUtil.makeValidIdList(inputResultPerson.getSearchUserMix()));
		inputResultPerson.setSearchOrgIdList(CommonUtil.makeValidIdList(inputResultPerson.getSearchOrgId()));
		
		String moveMonth = commandMap.get("moveMonth") == null ? "0" : (String)commandMap.get("moveMonth");
		inputResultPerson.setSearchDate(CalendarUtil.getDate(inputResultPerson.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
		
		List<InputResultPersonVO> resultList = irService.selectInputResultPerson(inputResultPerson);
		List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInput(inputResultPerson);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("notInputMemberList", notInputMemberList);
		
		return "management/mgmt_inputResultPerson";
	}
	
	@RequestMapping("/ajax/management/selectInputResultPerson.do")
    public String selectInputResultPersonAjax(@ModelAttribute("searchVO") InputResultPerson inputResultPerson, Map<String, Object> commandMap,
		HttpServletRequest req, ModelMap model) throws Exception {
    	
		inputResultPerson.setSearchUserMixList(CommonUtil.makeValidIdList(inputResultPerson.getSearchUserMix()));
		inputResultPerson.setSearchOrgIdList(CommonUtil.makeValidIdList(inputResultPerson.getSearchOrgId()));
		
		String moveMonth = commandMap.get("moveMonth") == null ? "0" : (String)commandMap.get("moveMonth");
		inputResultPerson.setSearchDate(CalendarUtil.getDate(inputResultPerson.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
		
		List<InputResultPersonVO> resultList = irService.selectInputResultPerson(inputResultPerson);
		List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInput(inputResultPerson);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("notInputMemberList", notInputMemberList);
		
		return "management/mgmt_inputResultPersonAjax";
    }	
	//개인별 투입 계획 현황
	@RequestMapping("/management/selectInputResultPlanPersonStatus.do")
	public String selectInputResultPlanPersonStatus(@ModelAttribute("searchVO") InputResultPerson inputResultPerson, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		inputResultPerson.setSearchUserMixList(CommonUtil.makeValidIdList(inputResultPerson.getSearchUserMix()));
		inputResultPerson.setSearchOrgIdList(CommonUtil.makeValidIdList(inputResultPerson.getSearchOrgId()));
		
		String moveMonth = commandMap.get("moveMonth") == null ? "0" : (String)commandMap.get("moveMonth");
		inputResultPerson.setSearchDate(CalendarUtil.getDate(inputResultPerson.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
		
		List<InputResultPersonVO> resultList = irService.selectInputResultPlanPersonStatus(inputResultPerson);
		List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInputStatus(inputResultPerson);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("notInputMemberList", notInputMemberList);
		
		return "management/mgmt_inputResultPlanPersonStatus";
	}	
	//개인별 투입 계획/실적
	@RequestMapping("/management/selectInputResultPlanPerson.do")
	public String selectInputResultPlanPerson(@ModelAttribute("searchVO") InputResultPerson inputResultPerson, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		inputResultPerson.setSearchUserMixList(CommonUtil.makeValidIdList(inputResultPerson.getSearchUserMix()));
		inputResultPerson.setSearchOrgIdList(CommonUtil.makeValidIdList(inputResultPerson.getSearchOrgId()));
		
		String moveMonth = commandMap.get("moveMonth") == null ? "0" : (String)commandMap.get("moveMonth");
		inputResultPerson.setSearchDate(CalendarUtil.getDate(inputResultPerson.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
		
		List<InputResultPersonVO> resultList = irService.selectInputResultPlanPerson(inputResultPerson);
		List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInput(inputResultPerson);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("notInputMemberList", notInputMemberList);
		
		return "management/mgmt_inputResultPlanPerson";
	}
	
	@RequestMapping("/management/selectInputResultPlanProject.do")
	public String selectInputResultPlanProject(@ModelAttribute("searchVO") InputResultPerson inputResultPerson, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		if(inputResultPerson.getSearchCondition()==null || "".equals(inputResultPerson.getSearchCondition())){
			inputResultPerson.setSearchCondition("1");
		}
		
		inputResultPerson.setSearchUserMixList(CommonUtil.makeValidIdList(inputResultPerson.getSearchUserMix()));
		inputResultPerson.setSearchOrgIdList(CommonUtil.makeValidIdList(inputResultPerson.getSearchOrgId()));
		
		String moveMonth = commandMap.get("moveMonth") == null ? "0" : (String)commandMap.get("moveMonth");
		inputResultPerson.setSearchDate(CalendarUtil.getDate(inputResultPerson.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
		
		List<InputResultPersonVO> resultList = irService.selectInputResultPlanProject(inputResultPerson);
		List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInput(inputResultPerson);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("notInputMemberList", notInputMemberList);
		
		return "management/mgmt_inputResultPlanProject";
	}
	
	@RequestMapping("/management/selectInputResultProject.do")
	public String selectInputResultProject(@ModelAttribute("searchVO") InputResultProject inputResultProject, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		inputResultProject.setSearchOrgIdList(CommonUtil.makeValidIdList(inputResultProject.getSearchOrgId()));
		
		String moveMonth = commandMap.get("moveMonth") == null ? "0" : (String)commandMap.get("moveMonth");
		inputResultProject.setSearchDate(CalendarUtil.getDate(inputResultProject.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
								   
		List<InputResultProjectVO> resultList = irService.selectInputResultProject(inputResultProject);
		model.addAttribute("resultList", resultList);
		
		List<InputResultProject> resultSum = irService.selectInputResultSum(inputResultProject);
		model.addAttribute("resultSum", resultSum);
		
		return "management/mgmt_inputResultProject";
	}
	
	/* TENY_170606 hm_daily_result 를 반영함 */
	@RequestMapping("/management/selectInputResultProjectDetail.do")
	public String selectInputResultProjectDetail(@ModelAttribute("searchVO") InputResultProjectDetail inputResultProjectDetail, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		//인건비로 연봉 유추가 가능하므로 연봉관리자나 기능한정 특수 권한 부여자만 허용
		MemberVO user = SessionUtil.getMember(req);
		boolean auth = false;
        if (user.isInputresult() || user.isSalaryadmin()) {
    		auth = true;
        }      
		if(auth == false){
	     	model.addAttribute("message", "조회 권한이 없습니다.");
			return "error/messageError";
	    }
		
		String moveMonth = commandMap.get("moveMonth") == null ? "0" : (String)commandMap.get("moveMonth");
		//if (inputResultProjectDetail.getSearchDate() == null || inputResultProjectDetail.getSearchDate().equals("")) 의미없는 월변경 불가 에러발생 조건검사 - 주석처리로 오류수정
			inputResultProjectDetail.setSearchDate(CalendarUtil.getDate(inputResultProjectDetail.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
		
		List<InputResultProjectDetailVO> resultList = irService.selectInputResultProjectDetail(inputResultProjectDetail);		
		model.addAttribute("resultList", resultList);
		
		return "management/mgmt_inputResultProjectDetail";
	}
	
	@RequestMapping("/management/selectInputResultDept.do")
	public String selectInputResultDept(@ModelAttribute("searchVO") InputResultDeptVO inputResultDeptVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		inputResultDeptVO.setSearchOrgIdList(CommonUtil.makeValidIdList(inputResultDeptVO.getSearchOrgId()));
		
		String moveMonth = commandMap.get("moveMonth") == null ? "0" : (String)commandMap.get("moveMonth");
		inputResultDeptVO.setSearchDate(CalendarUtil.getDate(inputResultDeptVO.getSearchDate(), "MONTH", Integer.parseInt(moveMonth)));
		
		InputResultDeptVO result = irService.selectInputResultDept(inputResultDeptVO);
		
		model.addAttribute("result", result);
		
		return "management/mgmt_inputResultDept";
	}
		
	@RequestMapping("/management/prjInputPlanMgmt.do")
	public String prjInputPlanMgmt(@ModelAttribute("searchVO") ProjectInputPlanManagementVO searchVO,
			Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		String moveMonth = (String)commandMap.get("moveMonth");
		if (moveMonth != null && moveMonth.equals("") == false) {
			String yyyymmdd = CalendarUtil.getDate(searchVO.getSearchYear() + searchVO.getSearchMonth() + "01", "MONTH", Integer.parseInt(moveMonth));
			searchVO.setSearchYear(yyyymmdd.substring(0,4));
			searchVO.setSearchMonth(yyyymmdd.substring(4,6));
		}
		
		List<ProjectInputPlanManagementVO> resultList = irService.selectProjectInputPlanManagementList(searchVO);
		List<MemberVO> notInputMemberList = irService.selectNotInputMemberList(searchVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("notInputMemberList", notInputMemberList);
		
		return "management/mgmt_projectInputPlanL";
	}
	
	@RequestMapping("/management/prjInputPlanView.do")
	public String prjInputPlanView(@ModelAttribute("searchVO") ProjectInputPlanManagementVO searchVO,
			Map<String, Object> commandMap, ModelMap model) throws Exception {

		String moveMonth = (String)commandMap.get("moveMonth");
		if (moveMonth != null && moveMonth.equals("") == false) {
			String yyyymmdd = CalendarUtil.getDate(searchVO.getSearchYear() + searchVO.getSearchMonth() + "01", "MONTH", Integer.parseInt(moveMonth));
			searchVO.setSearchYear(yyyymmdd.substring(0,4));
			searchVO.setSearchMonth(yyyymmdd.substring(4,6));
		}
		
		List<ProjectInputPlanDailyVO> resultList = irService.selectProjectInputPlanDailyList(searchVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("lastDate", CalendarUtil.getLastDateOfMonth(searchVO.getSearchYear(), searchVO.getSearchMonth()));
		
		return "management/mgmt_projectInputPlanV";
	}
	
	@RequestMapping("/management/inputPrjInputPlanView.do")
	public String inputPrjInputPlanView(@ModelAttribute("searchVO") ProjectInputPlanManagementVO searchVO,
			Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		model.addAttribute("searchVO", searchVO);
		
		return "management/mgmt_projectInputPlanW";
	}
	@RequestMapping("/management/insertPrjInputPlan.do")
	public String insertPrjInputPlan(@ModelAttribute("searchVO") ProjectInputPlanManagementVO searchVO,
			ProjectInputPlanManagement prjInputPlanMgmt,
			HttpServletRequest req, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		prjInputPlanMgmt.setRegUserNo(user.getNo());
		
		String[] userMixList = prjInputPlanMgmt.getUserNm().split(",");
		for (int i=0; i<userMixList.length; i++) {
			userMixList[i] = userMixList[i].trim();
		}
		prjInputPlanMgmt.setUserMixList(userMixList);
		
		irService.insertProjectInputPlan(prjInputPlanMgmt);
		
		String searchCondition = "";
		searchCondition = searchCondition + "?searchYear=" + searchVO.getSearchYear();
		searchCondition = searchCondition + "&searchMonth=" + searchVO.getSearchMonth();
		searchCondition = searchCondition + "&searchOrgId=" + searchVO.getSearchOrgId();
		searchCondition = searchCondition + "&searchOrgNm=" + searchVO.getSearchOrgNm();
		searchCondition = searchCondition + "&searchPrjId=" + searchVO.getSearchPrjId();
		searchCondition = searchCondition + "&searchPrjNm=" + searchVO.getSearchPrjNm();
		
		return "redirect:/management/prjInputPlanMgmt.do" + searchCondition;
	}
	@RequestMapping("/management/updatePrjInputPlanView.do")
	public String updatePrjInputPlanView(@ModelAttribute("searchVO") ProjectInputPlanManagementVO searchVO,
			Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		ProjectInputPlanManagementVO result = irService.selectProjectInputPlanManagement(searchVO);
		
		model.addAttribute("result", result);
		model.addAttribute("searchVO", searchVO);
		
		return "management/mgmt_projectInputPlanM";
	}
	@RequestMapping("/management/updatePrjInputPlan.do")
	public String updatePrjInputPlan(@ModelAttribute("searchVO") ProjectInputPlanManagementVO searchVO,
			ProjectInputPlanManagement prjInputPlanMgmt,
			HttpServletRequest req, Map<String, Object> commandMap, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		prjInputPlanMgmt.setModUserNo(user.getNo());
		
		irService.updateProjectInputPlan(prjInputPlanMgmt);
		
		String searchCondition = "";
		searchCondition = searchCondition + "?searchYear=" + searchVO.getSearchYear();
		searchCondition = searchCondition + "&searchMonth=" + searchVO.getSearchMonth();
		searchCondition = searchCondition + "&searchOrgId=" + searchVO.getSearchOrgId();
		searchCondition = searchCondition + "&searchOrgNm=" + searchVO.getSearchOrgNm();
		searchCondition = searchCondition + "&searchPrjId=" + searchVO.getSearchPrjId();
		searchCondition = searchCondition + "&searchPrjNm=" + searchVO.getSearchPrjNm();

		return "redirect:/management/prjInputPlanMgmt.do" + searchCondition;
	}
	@RequestMapping("/management/deletePrjInputPlan.do")
	public String deletePrjInputPlan(@ModelAttribute("searchVO") ProjectInputPlanManagementVO searchVO,
			ProjectInputPlanManagement prjInputPlanMgmt,
			HttpServletRequest req, Map<String, Object> commandMap, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		prjInputPlanMgmt.setModUserNo(user.getNo());
		
		irService.deleteProjectInputPlan(prjInputPlanMgmt);
		
		String searchCondition = "";
		searchCondition = searchCondition + "?searchYear=" + searchVO.getSearchYear();
		searchCondition = searchCondition + "&searchMonth=" + searchVO.getSearchMonth();
		searchCondition = searchCondition + "&searchOrgId=" + searchVO.getSearchOrgId();
		searchCondition = searchCondition + "&searchOrgNm=" + searchVO.getSearchOrgNm();
		searchCondition = searchCondition + "&searchPrjId=" + searchVO.getSearchPrjId();
		searchCondition = searchCondition + "&searchPrjNm=" + searchVO.getSearchPrjNm();
		
		return "redirect:/management/prjInputPlanMgmt.do" + searchCondition;
	}

}
