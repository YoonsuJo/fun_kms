package kms.com.cooperation.web;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import kms.com.admin.dbManage.service.AdminDbManageService;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.DayReportService;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.ProjectVO;
import kms.com.management.dao.SalesDAO;
import kms.com.management.service.BusinessResultService;
import kms.com.management.service.StepResultVO;
import kms.com.management.vo.MonthResultVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;
import kms.com.member.vo.UserVO;
import kms.com.cooperation.service.impl.ProjectDAO;
import kms.com.daily.dao.DailyDAO;
import kms.com.daily.vo.DailyResultVO;

@Controller
public class ProjectController {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name = "projectService")
	private ProjectService projectService;

	@Resource(name="KmsDayReportService")
	private DayReportService dayReportService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;
	
	@Resource(name = "kmsPrjIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Resource(name = "approvalService")
	private KmsApprovalService approvalService;
	
	@Resource(name="KmsAdminDbManageService")
	private AdminDbManageService adminDbManageService;

	@Resource(name = "KmsBusinessResultService")
	BusinessResultService brService;
	
	@Resource(name = "KmsMemberService")
    private MemberService memberService;
	
	@Resource(name="KmsMemberDAO")
	private MemberDAO memberDAO;

	@Resource(name="KmsProjectDAO")
	private ProjectDAO projectDAO;

	@Resource(name="KmsDailyDAO")
	private DailyDAO dailyDAO;

	@Resource(name = "KmsSalesDAO")
	private SalesDAO salesDAO;

	@RequestMapping(value = {"/cooperation/selectProjectList.do", "/ajax/selectProjectList.do"})
	public String selectProjectList(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		searchVO.setSearchUserNo(user.getNo());

		if(searchVO.getSearchStatL()==null || "".equals(searchVO.getSearchStatL())){
			String[] setParam = {"P"};
			searchVO.setSearchStatL(setParam);
		}

		if(searchVO.getSearchOrgnztId()==null || "".equals(searchVO.getSearchOrgnztId())){
			if (searchVO.getSearchPrntPrjId() == null || searchVO.getSearchPrntPrjId().equals(""))
				searchVO.setSearchOrgnztId(user.getOrgnztId()+",");
		}

		if(searchVO.getSearchOrgnztNm()==null || "".equals(searchVO.getSearchOrgnztNm())){
			if (searchVO.getSearchPrntPrjId() == null || searchVO.getSearchPrntPrjId().equals(""))
				searchVO.setSearchOrgnztNm(user.getOrgnztNm()+",");
		}
		
		List resultList = projectService.selectProjectList(searchVO);
		model.addAttribute("resultList", resultList);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS010");
    	List codeList3= cmmUseService.selectCmmCodeDetail(vo);
     	model.addAttribute("codeList3", codeList3);
    	if("/cooperation/selectProjectList.do".equals(request.getRequestURI()))
    		model.addAttribute("treeMode", "Y");
    	else
    		model.addAttribute("treeMode", "N");
		if("/cooperation/selectProjectList.do".equals(request.getRequestURI()))
			return "/cooperation/coop_projectL";
		else
			return "/cooperation/include/projectListTable";
	}

	@RequestMapping(value = "/cooperation/selectProjectList2.do")
	public String selectProjectList2(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		
		searchVO.setSearchUserNo(user.getNo());
		if(searchVO.getInitFlag().equals("N")){
			searchVO.setInitFlag("Y");
			searchVO.setSearchStatL(new String[] {"P"});
			searchVO.setSearchOrgnztId(user.getOrgnztId());
			searchVO.setSearchOrgnztNm(user.getOrgnztNm());
		}

		if(searchVO.getSearchLeaderMix()!=null && !"".equals(searchVO.getSearchLeaderMix())){
			if(CommonUtil.isMixedId(searchVO.getSearchLeaderMix()))
				searchVO.setSearchLeaderId(CommonUtil.parseIdFromMixs(searchVO.getSearchLeaderMix())[0]);
			else
				searchVO.setSearchLeaderNm(searchVO.getSearchLeaderMix());
		}
		if(searchVO.getSearchUserInputMix()!=null && !"".equals(searchVO.getSearchUserInputMix())){
			if(CommonUtil.isMixedId(searchVO.getSearchUserInputMix()))
				searchVO.setSearchUserInputId(CommonUtil.parseIdFromMixs(searchVO.getSearchUserInputMix())[0]);
			else
				searchVO.setSearchUserInputNm(searchVO.getSearchUserInputMix());
		}
		List resultList = projectService.selectProjectList(searchVO);
		int resultCnt = projectService.selectProjectCnt(searchVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS010");
		List codeList3= cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("codeList3", codeList3);
		model.addAttribute("treeMode", "N");
		return "/cooperation/coop_projectL2";
	}
	
	@RequestMapping(value = "/admin/project/selectProjectList.do")
	public String selectProjectListAdmin(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		
		searchVO.setSearchUserNo(user.getNo());
		if(searchVO.getInitFlag().equals("N")){
			searchVO.setInitFlag("Y");
			searchVO.setSearchStatL(new String[] {"E", "P", "S"});
			
			// 검색할 생성일, 수정일 default 설정
			Date today = new Date();
			Date startDate = new Date();
			SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
			startDate.setTime(today.getTime()-7*(1000*60*60*24));
			String stDt = simple.format(startDate);
			String enDt = simple.format(today);
			
			searchVO.setSearchRegStDt(stDt);
			searchVO.setSearchRegEnDt(enDt);
		}

		if(searchVO.getSearchLeaderMix()!=null && !"".equals(searchVO.getSearchLeaderMix())){
			if(CommonUtil.isMixedId(searchVO.getSearchLeaderMix()))
				searchVO.setSearchLeaderId(CommonUtil.parseIdFromMixs(searchVO.getSearchLeaderMix())[0]);
			else
				searchVO.setSearchLeaderNm(searchVO.getSearchLeaderMix());
		}
		if(searchVO.getSearchUserInputMix()!=null && !"".equals(searchVO.getSearchUserInputMix())){
			if(CommonUtil.isMixedId(searchVO.getSearchUserInputMix()))
				searchVO.setSearchUserInputId(CommonUtil.parseIdFromMixs(searchVO.getSearchUserInputMix())[0]);
			else
				searchVO.setSearchUserInputNm(searchVO.getSearchUserInputMix());
		}
		List resultList = projectService.selectProjectList(searchVO);
		int resultCnt = projectService.selectProjectCnt(searchVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS010");
		List codeList3= cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("codeList3", codeList3);
		model.addAttribute("treeMode", "N");
		model.addAttribute("searchVO", searchVO);
		return "admin/project/coop_projectL";
	}
	
	@RequestMapping(value = {"/ajax/selectProjectList3.do"})
	public String selectProjectList3(Map<String, Object> commandMap,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("pageUnit", 9999);
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(Integer.parseInt((String)commandMap.get("pageIndex")));
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		MemberVO user = SessionUtil.getMember(request);
		
		param.put("searchUserNo", user.getNo());

		// 참여중인 프로젝트
		param.put("searchUserInputNo", user.getNo());

		// 관심 프로젝트
		if (commandMap.get("interestPrjOnly") != null)
			param.put("interestPrjOnly", "Y");

		List resultList = projectService.selectProjectListPaging(param);
		
		int totCnt = projectService.selectProjectListPagingCnt(param);

		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS010");
    	List codeList3= cmmUseService.selectCmmCodeDetail(vo);
    	model.addAttribute("codeList3", codeList3);
		
    	return "/cooperation/include/projectListTablePaging";
	}
	
	@RequestMapping(value = "/cooperation/selectProjectV.do")
	public String selectProjectV(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("searchProjectChildVO") ProjectVO searchProjectChildVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		logT.debug("START");
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS008");
    	List codeList1 = cmmUseService.selectCmmCodeDetail(vo);
    	vo.setCodeId("KMS009");
    	List codeList2= cmmUseService.selectCmmCodeDetail(vo);
    	vo.setCodeId("KMS010");
    	List codeList3= cmmUseService.selectCmmCodeDetail(vo);
    	searchVO.setSearchUserNo(user.getUserNo());
    	ProjectVO projectVO = projectService.selectProjectView(searchVO);
		model.addAttribute("projectVO", projectVO);
		model.addAttribute("codeList1", codeList1);
		model.addAttribute("codeList2", codeList2);
		model.addAttribute("codeList3", codeList3);
		Calendar cal = Calendar.getInstance();
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String month = Integer.toString(cal.get(Calendar.MONTH)+1);
			
		ProjectInputVO projectInputVO = new ProjectInputVO();
		projectInputVO.setPrjId(searchVO.getPrjId());
		projectInputVO.setYear(year);
		projectInputVO.setMonth(month);
		//프로젝트 해당 년 월 투입 한 사람 1명의 이름 + 인원  갯수 구하기
		model.addAttribute("defaultPrjCnt",projectService.selectDefaultPrjCnt(searchVO));
		model.addAttribute("prjInputCnt",projectService.selectPrjInputCnt(projectInputVO));
		model.addAttribute("prjInputMaxUser",projectService.selectPrjInputMaxUser(projectInputVO));
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		
		//프로젝트 수정 권한 가져오기
		// 상위 프로젝트 트리에 PL인지 여부 확인 
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		if(projectService.selectPrjAuth(searchVO)>0)
			model.addAttribute("prjAuth","Y");
		// 프로젝트 부서 및 그 상위부서의 장인지 확인
		searchVO.setSearchUserNo(user.getNo());
		model.addAttribute("prjAuth2",projectService.selectPrjAuth2(searchVO));
		logT.debug("END");
		return "/cooperation/coop_projectV";
	}
	
	@RequestMapping(value = "/cooperation/selectProjectPopV.do")
	public String selectPopProjectV(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("searchProjectChildVO") ProjectVO searchProjectChildVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		logT.debug("START");
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS008");
    	List codeList1 = cmmUseService.selectCmmCodeDetail(vo);
    	vo.setCodeId("KMS009");
    	List codeList2= cmmUseService.selectCmmCodeDetail(vo);
    	vo.setCodeId("KMS010");
    	List codeList3= cmmUseService.selectCmmCodeDetail(vo);
    	searchVO.setSearchUserNo(user.getUserNo());
    	ProjectVO projectVO = projectService.selectProjectView(searchVO);
		model.addAttribute("projectVO", projectVO);
		model.addAttribute("codeList1", codeList1);
		model.addAttribute("codeList2", codeList2);
		model.addAttribute("codeList3", codeList3);
		Calendar cal = Calendar.getInstance();
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String month = Integer.toString(cal.get(Calendar.MONTH)+1);
			
		ProjectInputVO projectInputVO = new ProjectInputVO();
		projectInputVO.setPrjId(searchVO.getPrjId());
		projectInputVO.setYear(year);
		projectInputVO.setMonth(month);
		//프로젝트 해당 년 월 투입 한 사람 1명의 이름 + 인원  갯수 구하기
		model.addAttribute("defaultPrjCnt",projectService.selectDefaultPrjCnt(searchVO));
		model.addAttribute("prjInputCnt",projectService.selectPrjInputCnt(projectInputVO));
		model.addAttribute("prjInputMaxUser",projectService.selectPrjInputMaxUser(projectInputVO));
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		
		//프로젝트 수정 권한 가져오기
		// 상위 프로젝트 트리에 PL인지 여부 확인 
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		if(projectService.selectPrjAuth(searchVO)>0) 
			model.addAttribute("prjAuth","Y");
		// 프로젝트 부서 및 그 상위부서의 장인지 확인
		searchVO.setSearchUserNo(user.getNo());
		model.addAttribute("prjAuth2",projectService.selectPrjAuth2(searchVO));
		logT.debug("END");
		return "/cooperation/coop_pop_projectV";
	}

	@RequestMapping(value = "/cooperation/writeProject.do")
	public String writeProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS008");
		List codeList1 = cmmUseService.selectCmmCodeDetail(vo);
		vo.setCodeId("KMS009");
		List codeList2= cmmUseService.selectCmmCodeDetail(vo);
		vo.setCodeId("KMS010");
		List codeList3= cmmUseService.selectCmmCodeDetail(vo);
		//sub project인 경우 부모 prj 의 부서정보를 얻어와야 함.
		if("S".equals(searchVO.getType()) && searchVO.getPrntPrjId()!=null ) {
			searchVO.setPrjId(searchVO.getPrntPrjId());
			ProjectVO projectVO2 = projectService.selectProjectView(searchVO);
			//부모 프로젝트가 중단, 종료 시 생성 될 수 없음.
			if(!"P".equals(projectVO2.getStat()) ) {
				model.addAttribute("message", "중단, 종료 프로젝트 하위에 프로젝트를 생성할 수 없습니다.");
				return "error/messageError";
			}
			projectVO.setOrgnztId(projectVO2.getOrgnztId());
			projectVO.setOrgnztNm(projectVO2.getOrgnztNm());
			projectVO.setPrntPrjId(projectVO2.getPrjId());
			projectVO.setPrntPrjNm(projectVO2.getPrjNm());
			projectVO.setPrntPrjCd(projectVO2.getPrjCd());
			
			// 상위 프로젝트, 하위 프로젝트 시작일 종료일 
			HashMap<String, String> mapDate = projectService.selectStartCompDate(projectVO);
			model.addAttribute("mapDate", mapDate);
		}
			
		model.addAttribute("projectVO", projectVO);
		model.addAttribute("codeList1", codeList1);
		model.addAttribute("codeList2", codeList2);
		model.addAttribute("codeList3", codeList3);
		model.addAttribute("mode", "W");
		model.addAttribute("title","프로젝트 생성");
		return "/cooperation/coop_projectW";
	}
	
	@RequestMapping(value = "/cooperation/modifyProject.do")
	public String modifyProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		searchVO.setSearchUserNo(user.getNo());
		
		if(!user.isAdmin() && !user.isProjectadmin() 
				&& projectService.selectPrjAuth(searchVO)==0 
				&& projectService.selectPrjAuth2(searchVO).equals("N") ) {
			model.addAttribute("message", "프로젝트 수정 권한이 없습니다.");
			return "error/messageError";
		}
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		projectVO = projectService.selectProjectView(searchVO);
		vo.setCodeId("KMS008");
		List codeList1 = cmmUseService.selectCmmCodeDetail(vo);
		vo.setCodeId("KMS009");
		List codeList2= cmmUseService.selectCmmCodeDetail(vo);
		vo.setCodeId("KMS010");
		List codeList3= cmmUseService.selectCmmCodeDetail(vo);
		
		// 상위 프로젝트, 하위 프로젝트 시작일 종료일 
		HashMap<String, String> mapDate = projectService.selectStartCompDate(projectVO);
		model.addAttribute("mapDate", mapDate);
		
		model.addAttribute("projectVO", projectVO);
		model.addAttribute("codeList1", codeList1);
		model.addAttribute("codeList2", codeList2);
		model.addAttribute("codeList3", codeList3);
		model.addAttribute("mode", "M");
		model.addAttribute("title","프로젝트 수정");
		model.addAttribute("returnUrl", (String)commandMap.get("returnUrl"));
		return "/cooperation/coop_projectW";
	}
	
	
	@RequestMapping(value = "/cooperation/insertProject.do")
	public String insertProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		 MemberVO user = (MemberVO) SessionUtil.getMember(request);
		 if("S".equals(projectVO.getType()) ) {
			searchVO.setPrjId(projectVO.getPrntPrjId());
			ProjectVO projectVO2 = projectService.selectProjectView(searchVO);
			//부모 프로젝트가 중단, 종료 시 생성 될 수 없음.
			if(!"P".equals(projectVO2.getStat()) ) {
				model.addAttribute("message", "중단, 종료 프로젝트 하위에 프로젝트를 생성할 수 없습니다.");
				return "error/messageError";
			}
		}
		projectVO.setLeaderId(CommonUtil.parseIdFromMixs(projectVO.getLeaderMix())[0]);
		String prjId = idgenService.getNextStringId();
		projectVO.setPrjId(prjId);
		projectVO.setWriterNo(user.getNo());
		if(projectVO.getPrntPrjId()==null || "".equals(projectVO.getPrntPrjId()) )
			projectVO.setPrntPrjId(prjId);
		projectService.insertProject(projectVO);
		//insert 후 prjTree and orgPrjTree 생성
		projectService.updatePrjTree(projectVO);
		 
		//하위 프로젝트 생성시 상위 프로젝트 투입인력 가져오기.
		if("S".equals(projectVO.getType())&& "Y".equals(projectVO.getInsertPrntPrjInput()) ) {
			 projectService.insertPrntPrjInput(projectVO);
		}
		
		return "redirect:/cooperation/selectProjectV.do?prjId="+prjId;
	}
	
	
	@RequestMapping(value = "/cooperation/updateProject.do")
	public String updateProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		
		ProjectVO bfProjectVO = projectService.selectProjectView(searchVO);
		if( !"P".equals(projectVO.getStat()) && projectService.selectDefaultPrjCnt(searchVO)>0) {
			model.addAttribute("message", "부서 기본 프로젝트는 중단, 종료될 수 없습니다.");
			return "error/messageError";
		}
		//프리셋에 등록된 프로젝트 일 경우, 중단/종료 불가, 비용지출옵션 -> 누구나로 고정.
		if(projectService.selectPresetPrjCnt(searchVO)>0) {
			if(!"P".equals(projectVO.getStat()) ) {
				model.addAttribute("message", "지출결의서 프리셋에 등록된 프로젝트는 종료, 중단될 수 없습니다.");
				return "error/messageError";
			}			
			if(!"ALL".equals(projectVO.getManageCostRule()) ) {
				model.addAttribute("message", "지출결의서 프리셋에 등록된 프로젝트의 비용지출은 누구나에서 변경될 수 없습니다.");
				return "error/messageError";
			}
		}
		// [2015/02/09, dwkim] 누적 계산서발행예정금액 or 미수금액 둘중 하나라도 1,000원 이상 남아있다면 종료 및 중단처리 할수 없도록 수정(사장님 지시사항)
//		if( !user.isAdmin() && !"P".equals(projectVO.getStat()) && projectService.selectReceivablePrjCnt(searchVO)>0 ) {
//			model.addAttribute("message", "미수금이 남아있는 프로젝트는 중단, 종료될 수 없습니다.");
//			return "error/messageError";
//		}
		
		projectVO.setLeaderId(CommonUtil.parseIdFromMixs(projectVO.getLeaderMix())[0]);
		projectVO.setWriterNo(user.getNo());
		projectService.updateProject(projectVO);
		//update 후에 prjTree and orgPrjTree 생성
		projectService.updatePrjTree(projectVO);
		brService.updateStatisticDate(projectVO.getPrjId());

		//2013.07.30 김대현
		//update 후에 BUDGET_PRJ 예산관리 프로젝트 업데이트
		projectService.updateBudgetPrj(projectVO);
		
		String returnUrl = (String)commandMap.get("returnUrl");
		if (!"".equals(returnUrl)) return "redirect:/" + returnUrl;
		
		return "redirect:/cooperation/selectProjectV.do?prjId="+projectVO.getPrjId();
	}
	
	
	@RequestMapping(value = "/cooperation/updateProjectEnd.do")
	public String updateProjectEnd(			
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		if(projectService.selectDefaultPrjCnt(searchVO)>0)
		{
			model.addAttribute("message", "부서 기본 프로젝트는 중단, 종료될 수 없습니다.");
			return "error/messageError";
		}
		//프리셋에 등록된 프로젝트 일 경우, 중단/종료 불가, 비용지출옵션 -> 누구나로 고정.
		if(projectService.selectPresetPrjCnt(searchVO)>0)
		{
			model.addAttribute("message", "지출결의서 프리셋에 등록된 프로젝트는 종료, 중단될 수 없습니다.");
			return "error/messageError";
		}

		searchVO.setStat("E");
		projectService.updateProjectEnd(searchVO);

		
		return "redirect:/cooperation/selectProjectPopV.do?prjId="+searchVO.getPrjId();
	}	
	
	//프로젝트 이동 페이지
	@RequestMapping(value = "/cooperation/moveProjectW.do")
	public String moveProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
	/*	if(projectService.selectDefaultPrjCnt(searchVO)>0)
		{
			model.addAttribute("message", "부서 기본 프로젝트는 이동할 수 없습니다.");
			return "error/messageError";
		}*/
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		projectVO = projectService. selectProjectView(searchVO);
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		searchVO.setSearchUserNo(user.getNo());
		
		if(!user.isAdmin() && !user.isProjectadmin() && projectService.selectPrjAuth(searchVO)==0 && projectService.selectPrjAuth2(searchVO).equals("N"))
		{
			model.addAttribute("message", "프로젝트 이동 권한이 없습니다.");
			return("error/messageError");
		}
		model.addAttribute("projectVO", projectService. selectProjectView(searchVO));
		
		
		return "/cooperation/coop_moveProjectW";
	}
	
	//프로젝트 이동기능
	@RequestMapping(value = "/cooperation/moveProjectU.do")
	public String updateMoveProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		searchVO.setSearchUserNo(user.getNo());
		
		if(!user.isAdmin() && !user.isProjectadmin() 
				&& projectService.selectPrjAuth(searchVO)==0 
				&& projectService.selectPrjAuth2(searchVO).equals("N"))	{
			model.addAttribute("message", "프로젝트 이동 권한이 없습니다.");
			return("error/messageError");
		}
		//* 옮기는 위치가 valid한 지 검사해야 함.
		ProjectVO bfProjectVO = projectService.selectProjectView(searchVO);
		
		//진행중인 프로젝트는 중단, 종료 프로젝트 하위로 옮기지 못함.
		if("P".equals(bfProjectVO.getStat()) && "S".equals(searchVO.getType()) ) {
			ProjectVO targetPrntPrjVO = new ProjectVO();
			targetPrntPrjVO.setPrjId(searchVO.getPrntPrjId());
			targetPrntPrjVO = projectService.selectProjectView(targetPrntPrjVO);
			if(!"P".equals(targetPrntPrjVO.getStat()) ) {
				model.addAttribute("message", "진행중인 프로젝트는 중단,종료인 프로젝트 하위로 이동할 수 없습니다.");
				return "error/messageError";
			}
		}
		//프로젝트는 하위 프로젝트 혹은 자기 자신을 밑으로 옮기지 못함.
		projectService.moveProjectU(projectVO);
		
		//프로젝트 이동 후에 prjTree and orgPrjTree 생성
		projectService.updatePrjTree(projectVO);
		
		//2013.07.30 김대현
		//update 후에 BUDGET_PRJ 예산관리 프로젝트 업데이트
		projectService.updateBudgetPrj(projectVO);	
		
		return "redirect:/cooperation/selectProjectV.do?prjId="+projectVO.getPrjId();
	}
	
	//프로젝트 이관 페이지
	@RequestMapping(value = "/cooperation/transferProjectW.do")
	public String transferProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
	/*	if(projectService.selectDefaultPrjCnt(searchVO)>0)
		{
			model.addAttribute("message", "부서 기본 프로젝트는 이동할 수 없습니다.");
			return "error/messageError";
		}*/
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		projectVO = projectService. selectProjectView(searchVO);
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		searchVO.setSearchUserNo(user.getNo());
		
		if(!user.isAdmin() && !user.isProjectadmin() && projectService.selectPrjAuth(searchVO)==0 
				&& projectService.selectPrjAuth2(searchVO).equals("N")) {
			model.addAttribute("message", "프로젝트 이관 권한이 없습니다.");
			return("error/messageError");
		}
		model.addAttribute("projectVO", projectService. selectProjectView(searchVO));		
		
		return "/cooperation/coop_transferProjectW";
	}
		
	//프로젝트 이관기능	
	@RequestMapping(value = "/cooperation/transferProjectU.do")
	public String updateMoveDataProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		searchVO.setSearchUserNo(user.getNo());
		
		if(!user.isAdmin() && !user.isPrjtransferadmin() 
				&& projectService.selectPrjAuth(searchVO)==0 
				&& projectService.selectPrjAuth2(searchVO).equals("N"))	{
			model.addAttribute("message", "프로젝트 이관 권한이 없습니다.");
			return("error/messageError");
		}
		
		int underPrjDataCnt = projectService.selectUnderPrjDataCnt(projectVO);
		if(underPrjDataCnt > 0)	{
			model.addAttribute("message", "하위 프로젝트를 먼저 처리 하십시오.");
			return("error/messageError");
		}
		
		List<EgovMap> prjInputNoList = projectService.selectProjectInputForTransfer(projectVO); //중복된 투입 인력 검색
		
		String prjInputNoL = "";
		if(prjInputNoList.size() > 0){
			for(int i= 0; i < prjInputNoList.size(); i++){
				prjInputNoL += prjInputNoList.get(i).get("prjInputNo").toString() + ",";
			}	
			projectVO.setPrjInputNoL(prjInputNoL.split(","));		
		}else{
			projectVO.setPrjInputNoL(null);	
		}
		projectService.transferProjectU(projectVO);		
		//return "redirect:/cooperation/selectProjectV.do?prjId="+projectVO.getTransferPrjId();
		return "redirect:/cooperation/selectProjectV.do?prjId="+projectVO.getPrjId();
	}
	
	
	@RequestMapping(value = "/ajax/writeProjectInput.do")
	public String writeProjectInput(
			@ModelAttribute("projectInputVO") ProjectInputVO projectInputVO,
			@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		Calendar cal = Calendar.getInstance();
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
    	if(projectInputVO.getYear()==null)
    		projectInputVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		
		model.addAttribute("resultList", projectService.selectProjectInput(projectInputVO));
		//프로젝트 수정 권한 가져오기
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		if(projectService.selectPrjAuth(searchVO)>0 || user.isProjectadmin()) 
			model.addAttribute("prjAuth","Y");
		
		searchVO.setSearchUserNo(user.getNo());
		model.addAttribute("prjAuth2",projectService.selectPrjAuth2(searchVO));

		return "/cooperation/include/projectInput";
	}
	
	
	@RequestMapping(value = "/ajax/updateProjectInput.do")
	public String updateProjectInput(
			@ModelAttribute("projectInputVO") ProjectInputVO projectInputVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		projectInputVO.setWriterNo(user.getNo());
		projectService.updateProjectInput(projectInputVO);
		
		return "success";
	}
	
	@RequestMapping(value = "/ajax/projectOrganTree.do")
	public String projectOrganTree(
			@ModelAttribute("searchVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		projectVO.setSearchKeyword(URLDecoder.decode(projectVO.getSearchKeyword(),"UTF-8"));
		model.addAttribute("resultListTree", projectService.projectOrganTree(projectVO));
		
		return "/ajax/projectOrganTree";
	}
	
	@RequestMapping(value = "/ajax/projectMyOrganTree.do")
	public String projectMyOrganTree(
			@ModelAttribute("searchVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		projectVO.setOrgnztId(user.getOrgnztId());
		
		projectVO.setSearchKeyword(URLDecoder.decode(projectVO.getSearchKeyword(),"UTF-8"));
		model.addAttribute("resultListTree", projectService.projectOrganTree(projectVO));
		model.addAttribute("type", "T");
		
		return "/ajax/projectOrganTree";
	}
	
	@RequestMapping(value = "/ajax/projectUserIncluded.do")
	public String projectUserIncluded(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
				ModelMap model) throws Exception {
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		searchVO.setSearchUserInputNo(user.getUserNo());
		List resultList = projectService.selectProjectUserIncluded(searchVO);
		model.addAttribute("resultList",resultList);
		
		return "/ajax/projectUserIncluded";
	}
		
	@RequestMapping(value = "/ajax/insertPrntPrjInput.do")
	public String insertPrntPrjInput(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		 projectService.insertPrntPrjInput(searchVO);
		return "success";
	}
		
/*	@RequestMapping(value = "/ajax/taskList.do")
	public String taskList(HttpServletRequest request, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("prjId", commandMap.get("param_prjId"));
		param.put("includeUnderProject", commandMap.get("includeUnderProject"));
		
		param.put("pageUnit", propertyService.getInt("pageUnit"));
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(Integer.parseInt((String)commandMap.get("pageIndex")));
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		param.put("searchYear", (String)commandMap.get("searchYear"));
		
		List<Task> resultList = dayReportService.selectTaskListByPrjId(param);
		int totCnt = dayReportService.selectTaskListByPrjIdTotCnt(param);

		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		
		return "cooperation/include/projectTask";
	}
*/
	@RequestMapping(value = "/ajax/resultList.do")
	public String resultList(HttpServletRequest request, Map<String, Object> commandMap, ModelMap model) throws Exception {
		logT.debug("START");

		Map<String, Object> param = new HashMap<String, Object>();

		String prjId = (String)commandMap.get("param_prjId");
		if((prjId == null) || (prjId.length() == 0))
			return "error";

		param.put("prjId", prjId);
		param.put("includeUnderProject", commandMap.get("includeUnderProject"));
		
		param.put("pageUnit", propertyService.getInt("pageUnit"));
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(Integer.parseInt((String)commandMap.get("pageIndex")));
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		param.put("searchYear", (String)commandMap.get("searchYear"));
		String searchYear = (String)commandMap.get("searchYear");
		
		List<DailyResultVO> resultList = dailyDAO.selectResultListByPrjId(prjId, searchYear,
					paginationInfo.getRecordCountPerPage(), paginationInfo.getFirstRecordIndex());
		int totCnt = dailyDAO.selectResultListByPrjIdTotCnt(prjId, (String)commandMap.get("searchYear"));

		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);

		logT.debug("END");

		return "cooperation/include/projectResult";
	}

	@RequestMapping(value = "/ajax/cooperation/selectProjectMonthlyReport.do")
	public String selectProjectMonthlyReport(@ModelAttribute("searchVO") ProjectVO searchVO,
	HttpServletRequest request, HttpServletResponse response,
	ModelMap model) throws Exception {
		
		// 올해 실적 가져오기
		List<StepResultVO> resultList =  projectService.selectProjectMonthlyReport(searchVO);
		
		// 전년도 실적 합계 가져오기
		int searchYear = Integer.parseInt(searchVO.getSearchYear()) - 1;
		searchVO.setSearchYear(Integer.toString(searchYear));
		StepResultVO resultPreYearSum = projectService.selectProjectMonthlyReportPreSum(searchVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultPreYearSum", resultPreYearSum);
		return "cooperation/include/projectMonthlyReport";
	}
	@RequestMapping("/ajax/salesList.do")
	public String salesListAjax(@ModelAttribute("searchVO") ProjectVO projectVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		//매출건
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("prjId", commandMap.get("prjId"));		
		param.put("pageUnit", 999999);
		// param.put("pageUnit", 5);
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(Integer.parseInt((String)commandMap.get("pageIndex")));
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		param.put("includeInnerSales", "Y");	// 사내매출보고서 포함
		param.put("includeSalesTrans", "Y");	// 매출이관보고서 포함
		
		param.put("searchYear", (String)commandMap.get("searchYear"));
		
		List<ApprovalVO> resultList = approvalService.selectSalesListAjax(param);
		//int totCnt = approvalService.selectSalesListAjaxTotCnt(param);

		//paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		
		return "/cooperation/include/projectSales";
	}
	@RequestMapping("/ajax/purchaseInList.do")
	public String purchaseInListAjax(@ModelAttribute("searchVO") ProjectVO projectVO, ModelMap model) throws Exception {
		
		List<ApprovalVO> resultList = approvalService.selectPurchaseInAjax(projectVO);
		model.addAttribute("resultList", resultList);
		
		return "/cooperation/include/projectPurchaseIn";
	}
	@RequestMapping("/ajax/purchaseOutList.do")
	public String purchaseOutListAjax(@ModelAttribute("searchVO") ProjectVO projectVO, ModelMap model) throws Exception {
		
		List<ApprovalVO> resultList = approvalService.selectPurchaseOutAjax(projectVO);
		model.addAttribute("resultList", resultList);
		
		return "/cooperation/include/projectPurchaseOut";
	}

	//프로젝트 삭제 가능 확인만 하는 기능
	@RequestMapping(value="/cooperation/projectListForDelete.do")
    public String selectProjectListForDeleteCooperation(Map<String, Object> commandMap, ModelMap model) throws Exception {

		boolean deleteEnable = false;
		List<EgovMap> schemaChangeList = adminDbManageService.selectSchemaChangeList(null);
		if (schemaChangeList.size() == 0) {
			deleteEnable = true;
			model.addAttribute("deleteEnableYn", "Y");
		}
		//model.addAttribute("deleteEnableYn", "Y"); //삭제기능 제외이므로 조회는 언제나 가능
		
		if (deleteEnable) {
			String searchKeyword = (String) commandMap.get("searchKeyword");
			model.addAttribute("searchKeyword", searchKeyword);
			
			if (searchKeyword != null && !"".equals(searchKeyword)) {
				List<EgovMap> resultList = projectService.selectProjectListForDelete(commandMap);
				model.addAttribute("resultList", resultList);;
			}
		}
		
		return "cooperation/projectListForDelete2";
    }
	
	@RequestMapping(value="/cooperation/deleteProject.do")
    public String cooperationDeleteProject(Map<String, Object> commandMap, ModelMap model) throws Exception {

		boolean deleteEnable = false;
		List<EgovMap> schemaChangeList = adminDbManageService.selectSchemaChangeList(null);
		if (schemaChangeList.size() == 0) {
			deleteEnable = true;
			model.addAttribute("deleteEnableYn", "Y");
		}

		String searchKeyword = (String) commandMap.get("searchKeyword");
		model.addAttribute("searchKeyword", searchKeyword);
		
		if (deleteEnable) {
			projectService.deleteProject(commandMap);
		}
		
		return "redirect:/cooperation/projectListForDelete.do";
    }
	
	
	@RequestMapping(value="/cooperation/deleteProjectSubData.do")
    public String cooperationDeleteProjectSubData(Map<String, Object> commandMap, ModelMap model) throws Exception {

		boolean deleteEnable = false;
		List<EgovMap> schemaChangeList = adminDbManageService.selectSchemaChangeList(null);
		if (schemaChangeList.size() == 0) {
			deleteEnable = true;
			model.addAttribute("deleteEnableYn", "Y");
		}
		String mode = (String) commandMap.get("mode");
		if (mode.equals("resTotal")) {
			projectService.deleteProjectResTotal(commandMap);
		}
		String searchKeyword = (String) commandMap.get("searchKeyword");
		model.addAttribute("searchKeyword", searchKeyword);
		return "redirect:/cooperation/projectListForDelete.do";
    } 
	
	
	@RequestMapping(value="/admin/project/projectListForDelete.do")
    public String selectProjectListForDelete(Map<String, Object> commandMap, ModelMap model) throws Exception {

		boolean deleteEnable = false;
		List<EgovMap> schemaChangeList = adminDbManageService.selectSchemaChangeList(null);
		if (schemaChangeList.size() == 0) {
			deleteEnable = true;
			model.addAttribute("deleteEnableYn", "Y");
		}
		
		if (deleteEnable) {
			String searchKeyword = (String) commandMap.get("searchKeyword");
			model.addAttribute("searchKeyword", searchKeyword);
			
			if (searchKeyword != null && !"".equals(searchKeyword)) {
				List<EgovMap> resultList = projectService.selectProjectListForDelete(commandMap);
				model.addAttribute("resultList", resultList);;
			}
		}		
		return "admin/project/projectListForDelete";
    } 

	@RequestMapping(value="/admin/project/deleteProjectSubData.do")
    public String deleteProjectSubData(Map<String, Object> commandMap, ModelMap model) throws Exception {

		boolean deleteEnable = false;
		List<EgovMap> schemaChangeList = adminDbManageService.selectSchemaChangeList(null);
		if (schemaChangeList.size() == 0) {
			deleteEnable = true;
			model.addAttribute("deleteEnableYn", "Y");
		}
		String mode = (String) commandMap.get("mode");
		if (mode.equals("resTotal")) {
			projectService.deleteProjectResTotal(commandMap);
		}
		String searchKeyword = (String) commandMap.get("searchKeyword");
		model.addAttribute("searchKeyword", searchKeyword);
		return "redirect:/admin/project/projectListForDelete.do";
    } 
	
	@RequestMapping(value="/admin/project/deleteProject.do")
    public String deleteProject(Map<String, Object> commandMap, ModelMap model) throws Exception {

		boolean deleteEnable = false;
		List<EgovMap> schemaChangeList = adminDbManageService.selectSchemaChangeList(null);
		if (schemaChangeList.size() == 0) {
			deleteEnable = true;
			model.addAttribute("deleteEnableYn", "Y");
		}

		String searchKeyword = (String) commandMap.get("searchKeyword");
		model.addAttribute("searchKeyword", searchKeyword);
		
		if (deleteEnable) {
			projectService.deleteProject(commandMap);
		}
		
		return "redirect:/admin/project/projectListForDelete.do";
    }
	
	@RequestMapping(value = {"/cooperation/switchPrjInterest.do"})
	public String switchPrjInterest(
			@ModelAttribute("searchVO") ProjectVO searchVO, @RequestParam("returnUrl") String returnUrl,
			HttpServletRequest request, HttpServletResponse response, Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		commandMap.put("searchUserNo", user.getNo());
		
		projectService.switchPrjInterest(commandMap);
		
		return "forward:" + returnUrl;
	}


	@RequestMapping(value = "/cooperation/selectProjectDetailList.do")
	public String selectPerformProjectList(@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, 
			HttpServletResponse response,ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		searchVO.setSearchUserNo(user.getNo());

		if(searchVO.getSearchStatL()==null || "".equals(searchVO.getSearchStatL())){
			String[] setParam = {"P"};
			searchVO.setSearchStatL(setParam);
		}

		if(searchVO.getSearchOrgnztId()==null || "".equals(searchVO.getSearchOrgnztId())){
			searchVO.setSearchOrgnztId(user.getOrgnztId()+",");
		}

		if(searchVO.getSearchOrgnztNm()==null || "".equals(searchVO.getSearchOrgnztNm())){
			searchVO.setSearchOrgnztNm(user.getOrgnztNm()+",");
		}
		
		List resultList = projectService.selectProjectDetailList(searchVO);
		List rowCnt = projectService.selectProjectRowCnt(searchVO);
		
		String orgTmp = "";
		for (int i = 0; i < resultList.size(); i++)
		{
			Map<String, Object> map = (Map<String, Object>) resultList.get(i);
			if (!orgTmp.equals(map.get("prjOrgId").toString()))
			{
				orgTmp = map.get("prjOrgId").toString();
				map.put("displayTd", "Y");
				for (int j = 0; j < rowCnt.size(); j++)
				{
					if (((Map<String, Object>) rowCnt.get(j)).get("prjOrgId").toString().equals(orgTmp))
						map.put("rowspanCnt", Integer.parseInt(((Map<String, Object>) rowCnt.get(j)).get("prjLv").toString()));
				}	
			}
			else
			{
				map.put("displayTd", "N");
			}
		}
		
		model.addAttribute("resultList", resultList);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS010");
    	List codeList3= cmmUseService.selectCmmCodeDetail(vo);
    	model.addAttribute("codeList3", codeList3);
    	model.addAttribute("treeMode", "Y");
    	model.addAttribute("rowCnt", rowCnt);
		return "/cooperation/coop_projectDetailL";
	}
	
	// ajax로 프로젝트 정보(타입 및 PL정보) 가져오기
	@RequestMapping(value = "/ajax/selectProjectInfo.do")
	public void selectProjectInfo(String prjId, 
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		JSONObject result = projectService.selectProjectInfo(prjId);
		//JSONObject result = approvalService.selectProjectPlan(searchVO);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
	
	// ajax로 프로젝트 정보(현재 매출이관 보고서 결재 진행중인지) 가져오기
	@RequestMapping(value = "/ajax/selectProjectInfoProgress.do")
	public void selectProjectInfoProgress(String prjId, 
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		JSONObject result = projectService.selectProjectInfoProgress(prjId);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
		
	// ajax로 프로젝트 정보(매출이관보고서 최종 전결승인일과 오늘과의 차이값) 가져오기
	@RequestMapping(value = "/ajax/getTransApprovalDateDiff.do")
	public void getTransApprovalDateDiff(String prjId, 
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {
		System.out.println("prjId: " + prjId);
		
		JSONObject result = projectService.getTransApprovalDateDiff(prjId);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
	
	@RequestMapping(value = "/cooperation/selectSalesProjectList.do")
	public String selectSalesProjectList(
		@ModelAttribute("searchVO") ProjectVO projectVO,
		Map<String, Object> commandMap, HttpServletRequest req,
		ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		projectVO.setUserNo(user.getNo().toString());
		projectVO.setSearchOrgnztId(user.getOrgnztId());
		if (user.getOrgnztIdSec() != null && !"".equals(user.getOrgnztIdSec())) {
			projectVO.setSearchOrgnztIdSec(user.getOrgnztIdSec());
		}
		
		int pageUnit = propertyService.getInt("pageUnit_15");
			// 설정된 쿠키값이 있을 경우.
		String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_sales_prj_pageunit");
		if (pageUnitCookie != null) 
			pageUnit = Integer.parseInt(pageUnitCookie);
		
		projectVO.setPageUnit(pageUnit);
		projectVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(projectVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(projectVO.getPageUnit());
		paginationInfo.setPageSize(projectVO.getPageSize());
		
		projectVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		projectVO.setLastIndex(paginationInfo.getLastRecordIndex());
		projectVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 프로젝트 타입 기본값 설정
		if ( projectVO.getSearchPrjType()==null || "".equals(projectVO.getSearchPrjType()) ) {
			projectVO.setSearchPrjType("0");	// 사업/영업
		}
		
		List<ProjectVO> resultList = projectService.selectSalesProjectList(projectVO);
		int totCnt = projectService.selectSalesProjectCnt(projectVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO", projectVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "cooperation/coop_salesPrjL";
	}
	
	@RequestMapping(value = "/cooperation/selectSalesProjectListAll.do")
	public String selectSalesProjectListAll(
		@ModelAttribute("searchVO") ProjectVO projectVO,
		Map<String, Object> commandMap, HttpServletRequest req,
		ModelMap model) throws Exception {
		
		projectVO.setSearchTypAll("Y");
		
		int pageUnit = propertyService.getInt("pageUnit_15");

		// 설정된 쿠키값이 있을 경우.
		String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_sales_prj_pageunit");
		if (pageUnitCookie != null) 
			pageUnit = Integer.parseInt(pageUnitCookie);
		
		projectVO.setPageUnit(pageUnit);
		projectVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(projectVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(projectVO.getPageUnit());
		paginationInfo.setPageSize(projectVO.getPageSize());
		
		projectVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		projectVO.setLastIndex(paginationInfo.getLastRecordIndex());
		projectVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 조직 및 관련 인원 셋팅
		projectVO.setSearchOrgnztIdList(CommonUtil.makeValidIdList(projectVO.getSearchOrgnztId()));
		
		if (projectVO.getSearchUserMixes()!=null && !"".equals(projectVO.getSearchUserMixes())) {
			String[] searchArrUserId = CommonUtil.parseIdFromMixs(projectVO.getSearchUserMixes());
			projectVO.setSearchArrUserNo(memberService.convertToUserNoFromUserId(searchArrUserId));
		}
		
		// 프로젝트 타입 기본값 설정
		if ( projectVO.getSearchPrjType()==null || "".equals(projectVO.getSearchPrjType()) ) {
			projectVO.setSearchPrjType("0");	// 사업/영업
		}
		
		List<ProjectVO> resultList = projectService.selectSalesProjectList(projectVO);
		int totCnt = projectService.selectSalesProjectCnt(projectVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO", projectVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "cooperation/coop_salesPrjAllL";
	}
	
	// 하위 프로젝트 생성권한이 있는 상위 프로젝트 정보 가져오기 
	@RequestMapping(value={"/ajax/selectPrntPrjList.do"})
	public String selectPrntPrjListAjax(@ModelAttribute("searchVO") ProjectVO searchVO, 
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		// 관리자 or 프로젝트 관리자가 아닌 경우, 사용자 조건에 따라서 검색
		if(!user.isAdmin() && !user.isProjectadmin())
			searchVO.setSearchUserNo(user.getNo());
		
		List<EgovMap> resultList = projectService.selectPrntPrjList(searchVO);
		
		model.addAttribute("resultList", resultList);
			
		return "/ajax/prntPrjList";
	}
	
	// 하위 프로젝트 생성권한이 있는 상위 프로젝트 갯수 가져오기
	@RequestMapping(value={"/ajax/selectPrntPrjListCnt.do"})
	public void selectPrntPrjListCntAjax(@ModelAttribute("searchVO") ProjectVO searchVO, 
			HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		// 관리자 or 프로젝트 관리자가 아닌 경우, 사용자 조건에 따라서 검색
		if(!user.isAdmin() && !user.isProjectadmin())
			searchVO.setSearchUserNo(user.getNo());
		
		String result = projectService.selectPrntPrjListCnt(searchVO);
		result = result==null ? "" : result;
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
	
	// 하위 프로젝트 생성권한이 있는 상위 프로젝트 정보 가져오기 
	@RequestMapping(value={"/ajax/selectPrntPrj.do"})
	public void selectPrntPrjAjax(@ModelAttribute("searchVO") ProjectVO searchVO, 
			HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		// 관리자 or 프로젝트 관리자가 아닌 경우, 사용자 조건에 따라서 검색
		if(!user.isAdmin() && !user.isProjectadmin())
			searchVO.setSearchUserNo(user.getNo());
		
		JSONObject result = projectService.selectPrntPrj(searchVO);
		//JSONObject result = approvalService.selectProjectPlan(searchVO);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
}