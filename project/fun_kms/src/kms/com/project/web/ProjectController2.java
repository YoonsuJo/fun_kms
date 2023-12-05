package kms.com.project.web;

import java.util.Calendar;
import java.util.HashMap;
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

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.common.service.BusinessSectorVO;
import kms.com.common.service.CommonService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.ProjectVO;
import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;
import kms.com.member.vo.UserVO;
import kms.com.management.vo.BizStatisticVO;
import kms.com.management.vo.MonthResultVO;
import kms.com.management.vo.BizStatisticRateVO;
import kms.com.management.dao.SalesDAO;
import kms.com.management.fm.BizStatisticFm;
import kms.com.management.service.BusinessResultService;
import kms.com.project.dao.ProjectDAO2;
import kms.com.project.vo.StepResultVO;

@Controller
public class ProjectController2 {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name = "KmsCommonService")
	CommonService commonService;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "projectService")
	private ProjectService projectService;

	@Resource(name = "kmsPrjIdGnrService")
	private EgovIdGnrService idgenService;
	
	@Resource(name = "KmsBusinessResultService")
	BusinessResultService brService;

	@Resource(name="KmsProjectDAO2")
	private ProjectDAO2 projectDAO;

	@Resource(name="KmsMemberDAO")
	private MemberDAO memberDAO;

	@Resource(name = "KmsSalesDAO")
	private SalesDAO salesDAO;

	///////////////////////////////////////////////////////////////////////
	// RequestMapping
	
	@RequestMapping(value = "/project/writeProjectPop.do")
	public String writeProjectPop(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception {
		
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS008");
		List codeList1 = cmmUseService.selectCmmCodeDetail(vo);
		vo.setCodeId("KMS009");
		List codeList2= cmmUseService.selectCmmCodeDetail(vo);
		vo.setCodeId("KMS010");
		List codeList3= cmmUseService.selectCmmCodeDetail(vo);

		ProjectVO projectVO = new ProjectVO();
		//sub project인 경우 부모 prj 의 부서정보를 얻어와야 함.
		if("S".equals(searchVO.getType()) && searchVO.getPrntPrjId()!=null ) {
			searchVO.setPrjId(searchVO.getPrntPrjId());
			ProjectVO prntpVO = projectService.selectProjectView(searchVO);
			//부모 프로젝트가 중단, 종료 시 생성 될 수 없음.
			if(!"P".equals(prntpVO.getStat()) ) {
				model.addAttribute("message", "중단, 종료 프로젝트 하위에 프로젝트를 생성할 수 없습니다.");
				return "error/messageError";
			}
			projectVO.setOrgnztId(prntpVO.getOrgnztId());
			projectVO.setOrgnztNm(prntpVO.getOrgnztNm());
			projectVO.setPrntPrjId(prntpVO.getPrjId());
			projectVO.setPrntPrjNm(prntpVO.getPrjNm());
			projectVO.setPrntPrjCd(prntpVO.getPrjCd());
			
			// 상위 프로젝트, 하위 프로젝트 시작일 종료일 
			HashMap<String, String> mapDate = projectService.selectStartCompDate(projectVO);
			model.addAttribute("mapDate", mapDate);
		}
			
		model.addAttribute("projectVO", projectVO);
		model.addAttribute("codeList1", codeList1);
		model.addAttribute("codeList2", codeList2);
		model.addAttribute("codeList3", codeList3);
		model.addAttribute("isReload", commandMap.get("isReload"));

		return "/project/ProjectWMPop";
	}

	@RequestMapping(value = "/project/modifyProjectPop.do")
	public String modifyProjectPop(
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

		model.addAttribute("returnUrl", (String)commandMap.get("returnUrl"));
		model.addAttribute("isReload", commandMap.get("isReload"));
		return "/project/ProjectWMPop";
	}

	@RequestMapping(value = "/project/viewProjectPop.do")
	public String viewProjectPop(
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
		searchVO.setSearchLeaderNo(Integer.toString(user.getNo()));
		if(projectService.selectPrjAuth(searchVO)>0) model.addAttribute("prjAuth","Y");
		
		searchVO.setSearchUserNo(user.getNo());
		model.addAttribute("prjAuth2",projectService.selectPrjAuth2(searchVO));
		logT.debug("END");
		return "/project/ProjectVPop";
	}

	@RequestMapping(value = "/project/insertProject.do")
	public String insertProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception {
		
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
		
		if(commandMap.get("isReload").equals("Y")) {
			return "/common/returnPage/windowReloadNClose";
		}
		return "redirect:/project/viewProjectPop.do?prjId="+projectVO.getPrjId();
	}

	@RequestMapping(value = "/project/updateProject.do")
	public String updateProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception {

		// TENY_20170709 프로젝트 정보 수정에서는 상태를 종료시킬 수 없다.
		if("E".equals(projectVO.getStat())) {
			model.addAttribute("message", "프로젝트 수정 화면에서는 종료시킬 수 없으며 종료된 프로젝트는 수정할 수 없습니다.");
			return "error/messageError";
		}
		
		MemberVO user = SessionUtil.getMember(request);
		
		ProjectVO bfProjectVO = projectService.selectProjectView(searchVO);

		projectVO.setLeaderId(CommonUtil.parseIdFromMixs(projectVO.getLeaderMix())[0]);
		projectVO.setWriterNo(user.getNo());
		projectService.updateProject(projectVO);
		//update 후에 prjTree and orgPrjTree 생성
		projectService.updatePrjTree(projectVO);
		brService.updateStatisticDate(projectVO.getPrjId());

		//2013.07.30 김대현
		//update 후에 BUDGET_PRJ 예산관리 프로젝트 업데이트
		projectService.updateBudgetPrj(projectVO);
		
		if(commandMap.get("isReload").equals("Y")) {
			return "/common/returnPage/windowReloadNClose";
		}
		return "redirect:/project/viewProjectPop.do?prjId="+projectVO.getPrjId();
	}
	
	//프로젝트 이동 페이지
	@RequestMapping(value = "/project/ProjectMovePop.do")
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
		
		
		return "/project/ProjectMovePop";
	}
	
	@RequestMapping(value = "/project/updateProjectStatEnd.do")
	public String updateProjectStatEnd(			
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("projectVO") ProjectVO projectVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		logT.debug("START");
		
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
		}

		// [2015/02/09, dwkim] 누적 계산서발행예정금액 or 미수금액 둘중 하나라도 1,000원 이상 남아있다면 종료 및 중단처리 할수 없도록 수정(사장님 지시사항)
//		if( !"P".equals(projectVO.getStat()) && projectService.selectReceivablePrjCnt(searchVO)>0 ) {
//			model.addAttribute("message", "미수금이 남아있는 프로젝트는 중단, 종료될 수 없습니다.");
//			return "error/messageError";
//		}
//
//		if( projectDAO.selectProjectBondCheckYCount(searchVO.getPrjId()) > 0 ) {
//			model.addAttribute("message", "수금이 완료되지 않은 프로젝트입니다.");
//			return "error/messageError";
//		}

		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		searchVO.setStat("E");
		searchVO.setWriterNo(user.getNo());
		projectService.updateProjectEnd(searchVO);

		logT.debug("END");
		
		return "redirect:/project/viewProjectPop.do?prjId="+searchVO.getPrjId();
	}	
	

	@RequestMapping("/project/stepResultStatistic.do")
	public String stepResultStatistic(@ModelAttribute("searchVO") StepResultVO brVO,
			ModelMap model) throws Exception {
		
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

/*		boolean reCalc = false;
		if ("Y".equals(brVO.getSearchRecalcYn())) reCalc = true;
		List<StepResultVO> resultList = brService.selectStepResultStatistic(brVO, reCalc);
		
		model.addAttribute("resultList", resultList);
*/		
		boolean reCalc = false;
		List<StepResultVO> resultList = projectDAO.selectStepResultStatistic(brVO, reCalc);
		model.addAttribute("resultList", resultList);
		return "/project/stepResultStatistic";
	}
	
	// TENY_170624 프로젝트 관리 기능 개선
	@RequestMapping(value = "/project/listProject.do")
	public String listProject(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		// 처음 페이지를 오픈했을때
		// 내가 프로젝트 관리자로 되어있는 진행중인 프로젝트들을 리스트 하자
		if(searchVO.getInitFlag().equals("N")){  
			searchVO.setInitFlag("Y");
			MemberVO user = SessionUtil.getMember(request);
			searchVO.setSearchUserNo(user.getNo());
			searchVO.setSearchLeaderMix(user.getUserNm() + "(" + user.getUserId() + ")");

			searchVO.setSearchStatL(new String[] {"P"});
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
		return "/project/ProjectL";
	}

	@RequestMapping(value = "/project/listMyProject.do")
	public String listMyProject(@ModelAttribute("searchVO") ProjectVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();
		MemberVO user = SessionUtil.getMember(request);
		if(!searchVO.getSearchUseYn().equals("Y")) { // 페이지가 처음인경우
			searchVO.setSearchDate(CalendarUtil.getToday());
			searchVO.setSearchUserInputNo(user.getUserNo());
			searchVO.setSearchUserInputNm(user.getUserNm());
		}
		else { // 페이지 조회가 처음이 아닌경우 
			searchVO.setSearchDate(CalendarUtil.getDate(searchVO.getSearchDate(), "MONTH", searchVO.getDateMove()));
		}
		param.put("userNo", searchVO.getSearchUserInputNo());
		param.put("year", Integer.parseInt(searchVO.getSearchDate().substring(0, 4)));
		param.put("month", Integer.parseInt(searchVO.getSearchDate().substring(4, 6)));
		
//		List resultList = projectDAO.selectProjectUserIncluded(searchVO);
//		model.addAttribute("resultList",resultList);

 		List <ProjectVO> resultList = projectDAO.selectMyProjectList(param);
 		model.addAttribute("resultList", resultList);

		/* TENY_170404 자신의 부서원들의 리스트를 검색한다 */
		/* TENY_170417 겸직인경우 겸직의 부서원들의 리스트를 추가로 검색한다 */
 		param.clear();
 		param.put("topOrgId", user.getOrgnztId());
 		param.put("orgnztIdSec", user.getOrgnztIdSec());
		List<UserVO> userList= memberDAO.selectUserList(param);
		model.addAttribute("userList", userList);

		model.addAttribute("searchVO", searchVO);
		
		List<MonthResultVO> mrVOList = salesDAO.selectMonthLaborOfUser(searchVO.getSearchDate(), searchVO.getSearchUserInputNo());
		model.addAttribute("mrVOList", mrVOList);
		
		return "/project/ProjectMyList";
	}
}
