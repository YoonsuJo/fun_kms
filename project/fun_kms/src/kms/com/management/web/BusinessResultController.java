package kms.com.management.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Getter;
import lombok.Setter;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.common.service.BusinessSectorVO;
import kms.com.common.service.CommonService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.member.service.MemberVO;
import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultService;
import kms.com.management.service.PlanResultVO;
import kms.com.management.service.ProjectResultVO;
import kms.com.management.service.StepResultVO;
import kms.com.management.service.BusinessResultService;
import kms.com.management.service.impl.BusinessResultDAO;
import kms.com.management.vo.BizStatisticVO;
import kms.com.management.vo.BizStatisticRateVO;
import kms.com.management.fm.BizStatisticFm;

@Controller
public class BusinessResultController {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name = "KmsBusinessResultService")
	BusinessResultService brService;
	
	@Resource(name = "KmsCommonService")
	CommonService commonService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="KmsInputResultService")
	InputResultService irService;
	
	@Resource(name="KmsBusinessResultDAO")
	private BusinessResultDAO businessResultDAO;

	/* TENY_170429 
	 * 월간사업실적을 조회하는 화면의 controller
	 * 입력 : 사업실적을 조회하고자 하는 부서 ID,
	 *			사업실적을 조회하고자 하는 연월(yyyymm) 			
	 */
	@RequestMapping("/management/monthResultStatistic.do")
	public String monthResultStatistic(@ModelAttribute("searchVO") BizStatisticFm bsFm, 
			ModelMap model, Map<String, Object> commandMap) throws Exception {

		logT.debug("START");
		if(!"Y".equals(bsFm.getSearchConditionYn())) { // 검색조건이 없다면
			bsFm.setSearchYear(Integer.parseInt(CalendarUtil.getToday().substring(0,4)));
			bsFm.setSearchMonth(Integer.parseInt(CalendarUtil.getToday().substring(4,6)));
		}
		// 사업실적을 평가하는 단위부서 목록을 구한다.
		List<BusinessSectorVO> busiSectorList = commonService.selectBusinessSectorList(bsFm.getSearchYear());
		//	부서 id 목록(예 : "ORGAN_00000000000002, ORGAN_00000000000004") 
		String operationOrgnztId = "";
		int sectorNo = 140;
		//총계 번호를 구하기 위하여 추가
		for(BusinessSectorVO bsi : busiSectorList){
			if("총계".equals(bsi.getBusiSectorNm())){
				sectorNo = bsi.getNo();
				break;
			}
		}
		if(!"Y".equals(bsFm.getSearchConditionYn())){ // 검색조건이 없을때 총계 번호 구한다.
			bsFm.setSearchSectorNo(sectorNo);
			
			//경영기획실 조직 아이디(공통비를 구하기 위하여 하드코딩)
		}
		
		//총계 일때만 공통비를 불러온다.
		if(bsFm.getSearchSectorNo() == sectorNo) {
			operationOrgnztId = "ORGAN_00000000000004";
		}

		String orgnztIdList = bsFm.findOrgnztId(busiSectorList, bsFm.getSearchSectorNo());
		int year = bsFm.getSearchYear();
		int month = bsFm.getSearchMonth();
		String searchYM = String.format("%04d%02d", year, month);
		
		// 월사업실적을 구한다 (조건, 평가단위부서, 선택 년월
		// TENY_170429 수정되기 전의 버전은 주석처리해둠
		// MonthResultVO result = brService.selectMonthResultStatistic(bsFm, reCalc);
		BizStatisticVO bsPlanMonth 		= businessResultDAO.selectBizStatisticPlan(searchYM, orgnztIdList,operationOrgnztId);
		BizStatisticVO bsPlanMonthSum 	= businessResultDAO.selectBizStatisticPlanSum(searchYM, orgnztIdList,operationOrgnztId);
		BizStatisticVO bsResultMonth 		= businessResultDAO.selectBizStatisticResult(searchYM, orgnztIdList,operationOrgnztId);
		BizStatisticVO bsResultMonthSum= businessResultDAO.selectBizStatisticResultSum(searchYM, orgnztIdList,operationOrgnztId);
		model.addAttribute("bsPlanMonth", 			bsPlanMonth);
		model.addAttribute("bsPlanMonthSum", 	bsPlanMonthSum);
		model.addAttribute("bsResultMonth", 		bsResultMonth);
		model.addAttribute("bsResultMonthSum", 	bsResultMonthSum);

		BizStatisticRateVO bsrMonthVO 				= new BizStatisticRateVO(bsPlanMonth, 		bsResultMonth);
		BizStatisticRateVO bsrMonthSumVO 			= new BizStatisticRateVO(bsPlanMonthSum,	bsResultMonthSum);
		model.addAttribute("bsrMonthVO", 			bsrMonthVO);
		model.addAttribute("bsrMonthSumVO", 	bsrMonthSumVO);
		
		String sectorVal = orgnztIdList;
		
		// 선택된 부서의 하위부서를 구한다. ( 내려주면 어디에다 쓸까? )
		List<EgovMap> orgList = commonService.selectUnderOrgList(CommonUtil.makeValidIdList(sectorVal));
		
		// 선택된 달의 업무실적 미작성자 목록을 구한다.
		InputResultPerson searchVO = new InputResultPerson();
		searchVO.setSearchDate(bsFm.getSearchYear() + String.format("%02d", bsFm.getSearchMonth()) + "01");
		List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInput(searchVO);
		
//		model.addAttribute("bsResultMonthExp", 	bsResultMonthExp);

		model.addAttribute("orgList", orgList);
		model.addAttribute("sectorList", busiSectorList);
		model.addAttribute("notInputMemberList", notInputMemberList);
		
//		return "management/mgmt_monthResultStatistic";
		return "management/mgmt_monthBizStatistic";
	}

	@RequestMapping("/management/stepResultStatistic.do")
	public String stepResultStatisticPreview(@ModelAttribute("searchVO") StepResultVO brVO, ModelMap model) throws Exception {
		
		if (brVO.getSearchId().equals("")) { 		// TENY_170510 검색하고자 하는 최상위조직 ID가 없으면 SearchID를 ORGAN_TOP_ORGAN_CODE로 설정
			brVO.setSearchId(propertyService.getString("topOrgId"));
		}
		brVO.setTyp(brVO.getSearchId().substring(0,3));
		
		String searchDate = Integer.toString(brVO.getSearchYear()) + String.format("%02d", brVO.getSearchMonth() );
		String searchYear = Integer.toString(brVO.getSearchYear());
		if(brVO.getStartDate().equals("")){
			brVO.setStartDate(searchYear + "1231");
		}
		if(brVO.getEndDate().equals("")){
			brVO.setEndDate(searchYear + "0101");
		}
		//월별 검색시 말일 날짜 구해서 날짜 세팅하기. 년도 단위로 변경
		//시작일 종료일을 검새조건으로 사용한다면 JSP단에서 월클릭시 값 변경해서 넘기기
		//brVO.setStartDate(searchDate + "31");
		//brVO.setEndDate(searchDate + "01");
		brVO.setStartDate(searchYear + "1231");  // 왜 start date가 0101이 아닐까?
		brVO.setEndDate(searchYear + "0101");

		boolean reCalc = false;
		if ("Y".equals(brVO.getSearchRecalcYn())) reCalc = true;
		List<StepResultVO> resultList = brService.selectStepResultStatistic(brVO, reCalc);
		
		model.addAttribute("resultList", resultList);
		
		return "management/mgmt_stepResultStatistic";
	}
	
	@RequestMapping("/ajax/stepResultStatistic.do")
	public String stepResultStatistic(@ModelAttribute("searchVO") StepResultVO brVO, Map<String,Object> commandMap, ModelMap model) throws Exception {

		if (brVO.getSearchId().equals("")) brVO.setSearchId(propertyService.getString("topOrgId"));
		
		StepResultVO result = brService.selectStepResultStatisticRow(brVO);
		
		model.addAttribute("result", result);
		model.addAttribute("cnt", commandMap.get("cnt"));
		model.addAttribute("prtTyp", commandMap.get("prtTyp"));
		
		return "management/mgmt_stepResultStatisticRow";
	}
	
	@RequestMapping("/management/planResultStatistic.do")
	public String planResultStatisticPreview(@ModelAttribute("searchVO") PlanResultVO prVO, ModelMap model) throws Exception {

		if (prVO.getSearchOrgId().equals("")) prVO.setSearchOrgId(propertyService.getString("topOrgId"));
		prVO.setSearchOrgIdList(CommonUtil.makeValidIdList(prVO.getSearchOrgId()));
		
		String searchYear = Integer.toString(prVO.getSearchYear());
		prVO.setStartDate(searchYear + "1231");
		prVO.setEndDate(searchYear + "0101");
		
		Map<String, Object> result = brService.selectPlanResultStatisticPreview(prVO);
		List<EgovMap> busiIdList = commonService.selectBusiIdList(prVO.getSearchYear());
		
		model.addAttribute("resultList", result.get("resultList"));
		model.addAttribute("busiIdList", busiIdList);
		model.addAttribute("sum", result.get("sum"));
		
		return "management/mgmt_planResultStatistic";
	}
	
	@RequestMapping("/ajax/planResultStatistic.do")
	public String planResultStatistic(@ModelAttribute("searchVO") PlanResultVO prVO, Map<String,Object> commandMap, ModelMap model) throws Exception {

		if (prVO.getSearchOrgId().equals("")) prVO.setSearchOrgId(propertyService.getString("topOrgId"));
		
		PlanResultVO result = brService.selectPlanResultStatistic(prVO);
		
		model.addAttribute("result", result);
		model.addAttribute("isSum", false);
		
		return "management/mgmt_planResultStatisticRow";
	}
	
	@RequestMapping("/ajax/planResultOrgSumStatistic.do")
	public String planResultOrgSumStatistic(@ModelAttribute("searchVO") PlanResultVO prVO, Map<String,Object> commandMap, ModelMap model) throws Exception {

		if (prVO.getSearchOrgId().equals("")) prVO.setSearchOrgId(propertyService.getString("topOrgId"));
		
		prVO.setSearchOrgIdList(CommonUtil.makeValidIdList(prVO.getSearchOrgId()));
		
		PlanResultVO result = brService.selectPlanResultOrgSumStatistic(prVO);
		
		model.addAttribute("result", result);
		model.addAttribute("isSum", true);
		
		return "management/mgmt_planResultStatisticRow";
	}
		
	@RequestMapping("/management/projectResultStatistic.do")
	public String projectResultStatisticPreview(@ModelAttribute("searchVO") ProjectResultVO prVO, ModelMap model) throws Exception {

		if (prVO.getSearchOrgId().equals("")) prVO.setSearchOrgId(propertyService.getString("topOrgId"));
		prVO.setSearchOrgIdList(CommonUtil.makeValidIdList(prVO.getSearchOrgId()));
		
		boolean reCalc = false;
		if ("Y".equals(prVO.getSearchRecalcYn())) reCalc = true;
		
		String searchYear = Integer.toString(prVO.getSearchYear());
		prVO.setStartDate(searchYear + "1231");
		prVO.setEndDate(searchYear + "0101");
		
		Map<String, Object> result = brService.selectProjectResultStatistic(prVO, reCalc);
		List<EgovMap> busiIdList = commonService.selectBusiIdList(prVO.getSearchYear());
		
		model.addAttribute("resultList", result.get("resultList"));
		model.addAttribute("busiIdList", busiIdList);
		model.addAttribute("sum", result.get("sum"));
		
		return "management/mgmt_projectResultStatistic";
	}
	
	@RequestMapping("/ajax/projectResultStatistic.do")
	public String projectResultStatistic(@ModelAttribute("searchVO") ProjectResultVO prVO, Map<String,Object> commandMap, ModelMap model) throws Exception {

		if (prVO.getSearchOrgId().equals("")) prVO.setSearchOrgId(propertyService.getString("topOrgId"));
		
		ProjectResultVO result = brService.selectProjectResultStatisticRow(prVO);
		
		model.addAttribute("result", result);
		model.addAttribute("isSum", false);
		
		return "management/mgmt_projectResultStatisticRow";
	}
	
	@RequestMapping("/ajax/projectResultOrgSumStatistic.do")
	public String projectResultOrgSumStatistic(@ModelAttribute("searchVO") ProjectResultVO prVO, Map<String,Object> commandMap, ModelMap model) throws Exception {

		if (prVO.getSearchOrgId().equals("")) prVO.setSearchOrgId(propertyService.getString("topOrgId"));
		
		prVO.setSearchOrgIdList(CommonUtil.makeValidIdList(prVO.getSearchOrgId()));
		
		ProjectResultVO result = brService.selectProjectResultOrgSumStatistic(prVO);
		
		model.addAttribute("result", result);
		model.addAttribute("isSum", true);
		
		return "management/mgmt_projectResultStatisticRow";
	}
	
	@RequestMapping("/ajax/laborResultStatistic.do")
	public void laborResultStatistic(@ModelAttribute("searchVO") ProjectResultVO prVO,
			HttpServletRequest request, HttpServletResponse res, ModelMap model) throws Exception {

		ProjectResultVO result = brService.selectLaborResultStatistic(prVO);
		
		long salary = result.getSalary();
   		ServletOutputStream out=res.getOutputStream();
		out.write(Long.toString(salary).getBytes());
		out.flush();
		out.close();
	}
	
	@RequestMapping("/ajax/commLaborResultStatistic.do")
	public void commLaborResultStatistic(@ModelAttribute("searchVO") ProjectResultVO prVO,
			HttpServletRequest request, HttpServletResponse res, ModelMap model) throws Exception {

		ProjectResultVO result = brService.selectCommLaborResultStatistic(prVO);
		
		long salary = result.getSalary();
   		ServletOutputStream out=res.getOutputStream();
		out.write(Long.toString(salary).getBytes());
		out.flush();
		out.close();
	}
	
	@RequestMapping("/management/saleResultStatistic.do")
	public String saleResultStatistic(@ModelAttribute("searchVO") ProjectResultVO prVO, ModelMap model) throws Exception {
		
		boolean reCalc = false;
		if ("Y".equals(prVO.getSearchRecalcYn())) reCalc = true;
		List<ProjectResultVO> resultList = brService.selectSaleResultStatistic(prVO, reCalc);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("divideBy", 1000000);
		
		return "management/mgmt_saleResultStatistic";
	}
	
	@RequestMapping("/management/perfResultStatistic.do")
	public String procResultStatistic(@ModelAttribute("searchVO") ProjectResultVO prVO, ModelMap model) throws Exception {
		
		boolean reCalc = false;
		if ("Y".equals(prVO.getSearchRecalcYn())) reCalc = true;
		List<ProjectResultVO> resultList = brService.selectPerfResultStatistic(prVO, reCalc);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("divideBy", 1000000); //100만
		
		return "management/mgmt_perfResultStatistic";
	}
	
	@RequestMapping("/management/commResultStatistic.do")
	public String commResultStatistic(@ModelAttribute("searchVO") ProjectResultVO prVO, ModelMap model) throws Exception {
		
		boolean reCalc = false;
		if ("Y".equals(prVO.getSearchRecalcYn())) reCalc = true;
		List<ProjectResultVO> resultList = brService.selectCommResultStatistic(prVO, reCalc);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("divideBy", 1000000);
		
		return "management/mgmt_commResultStatistic";
	}
	
	@RequestMapping(value="/ajax/selectUnderOrgList.do")
	public void selectUnderOrgList(Map<String, Object> commandMap, HttpServletResponse res, ModelMap model) throws Exception{
		
		List<EgovMap> orgList = commonService.selectOrgList((String)commandMap.get("searchOrgId"));

		String id = "";
		String nm = "";
		
		for (int i=0; i<orgList.size(); i++) {
			EgovMap tmp = orgList.get(i);
			
			id += tmp.get("id") + ",";
			nm += tmp.get("nm") + ",";
		}
		
		res.setContentType("text/xml;charset=UTF-8");
		
		String out = "";
		
		out += "<id>" + id + "</id>";
		out += "<nm>" + nm + "</nm>";
		
		res.getWriter().println( CommonUtil.getXMLStr(out) );
	}
	
	@RequestMapping("/management/updateStatistic.do")
	public String updateStatistic(HttpServletRequest request, HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

		String updateYear = (String) commandMap.get("updateYear");
		String updateMonth = (String) commandMap.get("updateMonth");
		
		brService.updateStatistic(updateYear, updateMonth);
		
		request.setAttribute("year", updateYear);
		request.setAttribute("month", updateMonth);
		
		return "management/mgmt_updateStatisticsTmp";
	}
	
	@RequestMapping("/management/updateStatisticDate.do")
	public String updateStatisticDate(HttpServletRequest request, HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

		String updateYear = (String) commandMap.get("updateYear");
		String updateMonth = (String) commandMap.get("updateMonth");
		
		brService.updateStatisticDate(updateYear, updateMonth);
		
		request.setAttribute("year", updateYear);
		request.setAttribute("month", updateMonth);
		
		return "management/mgmt_updateStatisticsDateTmp";
	}
	
	
	
}
