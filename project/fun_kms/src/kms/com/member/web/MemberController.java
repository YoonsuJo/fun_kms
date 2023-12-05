package kms.com.member.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import kms.com.app.service.ApprovalCommentVO;
import kms.com.app.service.ApprovalReaderVO;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.common.config.ConditionSettingKey;
import kms.com.common.config.PathConfig;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.service.LoginService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.BBSAttributeManageService;
import kms.com.community.service.BoardMaster;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.MailVO;
import kms.com.community.service.NoteService;
import kms.com.cooperation.service.DayReportDetail;
import kms.com.cooperation.service.DayReportService;
import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultPersonVO;
import kms.com.management.service.InputResultService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.member.service.PositionHistoryVO;
import kms.com.member.service.WorkStateDetail;
import kms.com.member.service.WorkStateService;
import kms.com.member.service.WorkStateStatistic;
import kms.com.member.service.WorkStateVO;
import kms.com.salary.service.KmsSalaryService;
import kms.com.salary.service.MemberEvaVO;
import kms.com.salary.service.SalaryVO;
import kms.com.support.service.CarVO;

import org.apache.catalina.connector.Request;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cop.bbs.service.Satisfaction;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MemberController {
	Logger logT = Logger.getLogger("TENY");
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;

	@Resource(name="KmsWorkStateService")
	WorkStateService workStateService;
	
	@Resource(name="approvalService")
	KmsApprovalService approvalService;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;
	
	@Resource(name = "KmsBBSAttributeManageService")
	private BBSAttributeManageService bbsAttrbService;
	
	@Resource(name = "KmsSalaryService")
	private KmsSalaryService salaryService;    
	@Resource(name="KmsDayReportService")
	private DayReportService dayReportService;
	@Resource(name="KmsInputResultService")
	InputResultService irService;
	
	/** EgovLoginService */
	@Resource(name = "KmsLoginService")
	private LoginService loginService;
	
	@Autowired
	private DefaultBeanValidator beanValidator;

	Logger log = Logger.getLogger(this.getClass());
	
	
	@RequestMapping("/member/selectMemberMain.do")
	public String selectMemberMain(@ModelAttribute("searchVO") MemberVO memberVO,
			@ModelAttribute("searchVOws") WorkStateVO wsVO, Map<String,Object> commandMap, 
			HttpServletRequest req, ModelMap model) throws Exception {    	
				
		MemberVO user = SessionUtil.getMember(req);
		
		//사용자정보
		if (memberVO.getStringNo() == null || memberVO.getStringNo().equals("") || memberVO.getStringNo().equals("null")) {
			memberVO.setNo(user.getNo());
		}
				
		//memberVO 세팅
		memberVO = memberService.selectMemberBasic(memberVO);
		String searchDate = wsVO.getSearchDate();
		String searchDateFrom = CalendarUtil.getDate(searchDate, -7);
		String searchUserNm = memberVO.getUserNm() + "(" + memberVO.getUserId() + ")";
		//기존 근무현황 정보
		EgovMap state = memberService.selectMemberState(memberVO); //selectMemberState 전체 코드에서 여기서만 호출
		//근태기록 정보
		wsVO.setUserNo(memberVO.getUserNo());
		List<WorkStateVO> workstateList = workStateService.selectAbsenceStateMember(wsVO);
		WorkStateStatistic wssVO = new WorkStateStatistic();
		wssVO.setSearchDateFrom(searchDate);
		wssVO.setSearchDateTo(searchDate);
		wssVO.setSearchUserNo(memberVO.getUserNo());    	
		List<WorkStateDetail> workStateDetail = workStateService.selectWorkStateDetail(wssVO);    	
				
		//나의업무보고 정보
		commandMap.put("today", CalendarUtil.getToday());
		commandMap.put("searchDate", searchDate);		
		commandMap.put("searchUserNm", searchUserNm);		
		List<DayReportDetail> dayReportDetail = dayReportService.selectDayReportDetail(commandMap);
		List<Map<String, Object>> dateList = CalendarUtil.getDateList((String)commandMap.get("sDate")); //sDate는 월요일 날짜
		
		//요일 변환 (getDay 요일번호 : 일~토 = 1~7, dayReportDetail 요일번호 : 월~일 = 0~6) 
		int dayofweek = CalendarUtil.getDay(searchDate) - 2;
		if(dayofweek < 0)
			dayofweek = 6;		
		
		//관련 프로젝트 목록 정보
		InputResultPerson inputResultPerson = new InputResultPerson();
		inputResultPerson.setSearchCondition("0"); //userMix 검색
		inputResultPerson.setSearchUserMix(searchUserNm);
		inputResultPerson.setSearchUserMixList(CommonUtil.makeValidIdList(searchUserNm));
		inputResultPerson.setSearchDate(searchDate);
		String searchAllInputPrj = (String)commandMap.get("searchAllInputPrj");
		inputResultPerson.setSearchAllInputPrj(searchAllInputPrj);
		model.addAttribute("searchAllInputPrj", searchAllInputPrj);
		List<InputResultPersonVO> inputResultPersonList = irService.selectInputResultPerson(inputResultPerson);		
		
		model.addAttribute("thisYear", CalendarUtil.getToday().substring(0,4));
		model.addAttribute("state", state);
		//2013-01-22 추가
		model.addAttribute("workstateList", workstateList);
		if(workStateDetail.size() > 0)
			model.addAttribute("workStateDetail", workStateDetail.get(0));
		model.addAttribute("dayReportDetail", dayReportDetail.get(dayofweek));
		model.addAttribute("dateList", dateList.get(dayofweek));
		model.addAttribute("inputResultPersonList", inputResultPersonList);
		model.addAttribute("searchVO", memberVO);
		model.addAttribute("searchDate", searchDate);
		model.addAttribute("searchDateFrom", searchDateFrom);		
		
		return "human_resource/human_resource_Main";
	}
	
	//로그인 오버라이드 - 권한있는 사용자들만 허용
	@RequestMapping("/member/chngMemberLogin.do")
	public String chngMemberLogin(@ModelAttribute("searchVO") MemberVO memberVO,
			HttpServletRequest req, ModelMap model) throws Exception {    	
				
		MemberVO user = SessionUtil.getMember(req);    	
		boolean auth = false;
		if (user.isLoginauth() ){
			auth = true;
		}      
		if(auth == false){
			model.addAttribute("message", "권한이 없습니다.");
			return "error/messageError";
		}
		user = loginService.actionLoginOverride(memberVO);
				
		//내부 IP코드 검사
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS018");
		List<CmmnDetailCode> codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		String userIp = req.getRemoteAddr();
		boolean isInnerNetwork = false;
		for (int i=0; i<codeResult.size(); i++) {
			if (userIp.contains(codeResult.get(i).getCode())) {
				isInnerNetwork = true;				
			}
		}		
		user.setIsInnerNetwork(isInnerNetwork ? "Y" : "N");
		
		req.getSession().setAttribute(ConditionSettingKey.MEMBER, user);
		return "redirect:/main.do";
	}

	@RequestMapping("/member/selectAbilityChart.do")
	public String selectAbilityChart(ModelMap model) throws Exception{

		return "human_resource/hr_pop_AbilityChart01";
	}
	
	@RequestMapping("/member/selectMemberSalaryNego.do")
	public String selectMemberSalaryNego(@ModelAttribute("searchVO") SalaryVO salaryVO,// String userNo, String year,
			HttpServletRequest req, ModelMap model)	throws Exception{
		
		MemberVO user = SessionUtil.getMember(req);
		//userNo 없는 조회 초기값 초기화
		String salaryUserNo = salaryVO.getUserNo();		
		if(salaryUserNo == null || salaryUserNo.equals("") ){
			salaryUserNo = user.getStringNo();
			salaryVO.setUserNo(salaryUserNo);
		}
		
		//연봉협상 기간 변수 세팅
		memberService.setMemberNegoYn(user);
		
		boolean auth = false;
		if (user.isSalaryadmin() || user.getStringNo().equals(salaryUserNo) ) {
			auth = true;
		}      
		if(auth == false){
			model.addAttribute("message", "조회 권한이 없습니다.");
			return "error/messageError";
		}
		if(user.getIsNegoYn().equals("Y") == false){
			model.addAttribute("message", "연봉협상 기간이 아닙니다.");
			return "error/messageError";
		}
		
		salaryVO.setSearchOrgIdList(CommonUtil.makeValidIdList(salaryVO.getSearchOrgId()));
		
		Calendar cal = Calendar.getInstance();
		String thisYear = Integer.toString(CalendarUtil.getYear());
		String lastYear = Integer.toString(CalendarUtil.getLastYear());    	
		int month = CalendarUtil.getMonth();
		if(salaryVO.getYear()==null){
			if(month > 2)
				salaryVO.setYear(thisYear);
			else
				salaryVO.setYear(lastYear);
		}
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(codeVO);    	
		model.addAttribute("rankList", rankList);
		
		codeVO.setCodeId("KMS033");
		List<CmmnDetailCode> degreeCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("degreeCode", degreeCode);
		
		codeVO.setCodeId("KMS034");
		List<CmmnDetailCode> statusCode = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("statusCode", statusCode);
		
		codeVO.setCodeId("KMS036");
		List exceptionList = cmmUseService.selectCmmCodeDetail(codeVO);
		CmmnDetailCode exceptionUsers = (CmmnDetailCode)exceptionList.get(0);    	
		salaryVO.setExceptionUsersList(exceptionUsers.getCodeDc().split(",") );
		
		codeVO.setCodeId("KMS035");
		List<CmmnDetailCode> negoPeriod = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("negoStart", negoPeriod.get(0).getCodeDc());
		model.addAttribute("negoEnd", negoPeriod.get(1).getCodeDc());
		String today = CalendarUtil.getToday().substring(4,8);    	
		model.addAttribute("today", today);
		
		String year = salaryVO.getYear();    	
				
		model.addAttribute("showSalaryHope", "N");
		if(year.equals(thisYear) || ( year.equals(lastYear) && month < 2 ) ){
			model.addAttribute("showSalaryHope", "Y");
		}    	
		
		List resultList = salaryService.selectMemberSalaryNego(salaryVO);
		
		if(resultList.size()>0){
			model.addAttribute("memberVO", resultList.get(0));
			model.addAttribute("resultList", resultList);  	
			model.addAttribute("year", year);
			model.addAttribute("thisYear", thisYear);
			return "human_resource/salaryRealNegoMain";
		} else{
			model.addAttribute("message", "데이터가 없습니다.");
			return "error/messageError";
		}
		
	}

	@RequestMapping("/member/updateMemberSalaryNego.do")
	public String updateMemberSalaryNego(@ModelAttribute("searchVO") SalaryVO salaryVO,// String userNo, String year,
			HttpServletRequest req, ModelMap model)	throws Exception{
				
		MemberVO user = SessionUtil.getMember(req);	
		String userNo = user.getStringNo();
		String salaryUserNo = salaryVO.getUserNo();		
		boolean auth = false;    	
		if ( user.isAdmin() || userNo.equals(salaryUserNo) ) {
			auth = true;
		}        
		if(auth == false){
			model.addAttribute("message", "수정 권한이 없습니다.");
			return "error/messageError";
		}		
		salaryService.updateUserSalaryReal2(salaryVO); //비삭제 순수 업데이트(not delete insert)
		
		//동의인 경우 차년도 데이터 입력
		if(salaryVO.getStatus().equals("2")) {			
			MemberVO memberVO = new MemberVO();
			memberVO.setNo(Integer.parseInt(salaryVO.getUserNo()) );
			memberVO = memberService.selectMemberBasic(memberVO);
			salaryService.insertMemberSalaryNextYear(salaryVO); //차년도 연봉
			salaryService.insertMemberEvaAuto(memberVO, salaryVO.getNextYear()); //차년도 평가정보
		}
		return "redirect:/member/selectMemberSalaryNego.do?userNo=" + salaryVO.getUserNo() + "&year=" + salaryVO.getYear();
	}
	
	@RequestMapping("/member/selectEmpContract.do")
	public String selectEmpContract(@ModelAttribute("searchVO") SalaryVO salaryVO, //String userNo, String year, String print,
			HttpServletRequest req, ModelMap model)	throws Exception{
				
		MemberVO user = SessionUtil.getMember(req);	
		String salaryUserNo = salaryVO.getUserNo();
		//userNo 없이 조회 들어오는 초기값 세팅
		if(salaryUserNo == null || salaryUserNo.equals("")){			
			salaryUserNo = user.getStringNo();
		}
		
		//연봉협상 기간 변수 세팅
		memberService.setMemberNegoYn(user);
		
		boolean auth = false;    	
		if ( user.isSalaryadmin() || user.getStringNo().equals(salaryUserNo) ) {
			auth = true;
		}        
		if(auth == false){
			//model.addAttribute("message", "조회 권한이 없습니다.");
			//return "error/messageError";
			salaryUserNo = user.getStringNo();
		}
		
		MemberVO memberVO = new MemberVO();
		memberVO.setNo(Integer.parseInt(salaryUserNo));
		memberVO = memberService.selectMemberBasic(memberVO);
		model.addAttribute("memberVO", memberVO);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS032"); //회사주소
		
		//기존 CODE_ID = 'KMS007' 데이터의 CODE에 회사 코드를 영문으로 박아둔걸 시스템에서 CODE_ID 없이 CODE만 갖고 막 사용하는 부분이 있음. 
		//그것도 selectpk 함수를 써서 두줄 이상 나오면 시스템 오류나고 집 그림 나옴.
		//전체 시스템 검사 및 수정은 시간도 오래걸리고 또 어떤 문제가 생길지 몰라서 그냥 이 추가된 KMS032코드를 불러와서 하드코딩 매치함
		String companyId = memberVO.getCompnyId();
		if(companyId.equals("dosanet")){
			vo.setCode("1");
		}else if(companyId.equals("probits")){
			vo.setCode("2");
		}else if(companyId.equals("saeha")){
			vo.setCode("3");
		}else if(companyId.equals("libtech")){
			vo.setCode("4");
		}else if(companyId.equals("saehasoft")){ // 새하소프트는 사용하지 않는 코드로 박아둠
			vo.setCode("5");
		}else if(companyId.equals("ssomon")){
			vo.setCode("6");
		}else{ //회사코드 없는 경우
			vo.setCode("0");			
		}
		
		CmmnDetailCode codeResult = cmmUseService.selectCmmCodeDetailCode(vo);		
		model.addAttribute("company", codeResult);
			
		Calendar cal = Calendar.getInstance();
		salaryVO.setUserNo(Integer.toString(memberVO.getNo()));
		String year = salaryVO.getYear();
		if(year==null || year.equals("")){
			if( cal.get(Calendar.MONTH) < 3)
				salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR) - 1) );
			else
				salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
			//연봉계약서는 당해년도 조회
			salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
		}
		String print = salaryVO.getPrint();
		salaryVO = salaryService.selectUserSalaryRealMember(salaryVO);
		if(salaryVO == null){
			model.addAttribute("message", "없는 사원 또는 퇴사자 번호입니다.");
			return "error/messageError";
		}    	
		if(user.getIsNegoYn().equals("Y") == false){
			model.addAttribute("message", "연봉협상 기간이 아닙니다.");
			return "error/messageError";
		}
		if(salaryVO.getSalaryReal() < 1){
			model.addAttribute("message", "연봉이 0원입니다. 연봉협상 동의 후 열람가능합니다.");
			return "error/messageError";
		}
		
		long salary = salaryVO.getSalaryReal();
		long carCost = salaryVO.getCarCost();
		long mealCost = salaryVO.getMealCost();
		long babyCost = salaryVO.getBabyCost();
		long communicationCost = salaryVO.getCommunicationCost();
		
		model.addAttribute("salary1", Math.ceil((double)salary/12) - carCost - mealCost - babyCost - communicationCost);
		model.addAttribute("salary2", carCost);
		model.addAttribute("salary3", mealCost);
		model.addAttribute("salary5", babyCost);
		model.addAttribute("salary6", communicationCost);
		model.addAttribute("salary4", Math.ceil((double)salary/12));
		model.addAttribute("salaryVO", salaryVO);
		
		if(print != null && print.equals("Y")){    		
			return "human_resource/hr_emContract_pop_print";
		}
		return "human_resource/hr_emContract";
		//return "human_resource/hr_pop_emContract";
	}	
	
	@RequestMapping("/member/selectMemberList.do")
	public String selectMemberList(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

		memberVO.setSearchOrgIdList(CommonUtil.makeValidIdList(memberVO.getSearchOrgId()));
		memberVO.setWorkStList(memberVO.getWorkStArray());

		List<MemberVO> resultList;
		String mode = memberVO.getMode();
		
		if (memberVO.getMode() != null && mode.equals("album")) {
			PaginationInfo paginationInfo = new PaginationInfo();
			
			paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(propertyService.getInt("pageSize"));
		
			memberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			memberVO.setLastIndex(paginationInfo.getLastRecordIndex());
			memberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			resultList = memberService.selectMemberList(memberVO);
			int totCnt = memberService.selectMemberListTotCnt(memberVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
		} else {
			resultList = memberService.selectMemberList(memberVO);
		}
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("rankList", rankList);
		model.addAttribute("resultList", resultList);
		
		if (memberVO.getMode() != null && mode.equals("album"))
			return "human_resource/hr_member_albumL";
		else
			return "human_resource/hr_memberL";
	}
	
	
	@RequestMapping("/member/selectMember.do")
	public String selectMember(@ModelAttribute("searchVO") MemberVO memberVO,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		logT.debug("START");
	
		Map<String, Object> result;
		if((memberVO == null) || (memberVO.getNo() == null) || (memberVO.getNo() == 0)){
			MemberVO user = SessionUtil.getMember(req);
			result = memberService.selectMember(user);
			memberVO.setSearchCondition("MYPAGE");
		}
		else {
			result = memberService.selectMember(memberVO);
		}
		
		model.addAttribute("result", result);
		
		return "human_resource/hr_memberV";
	}
	
	@RequestMapping("/member/selectMemberFilesV.do")
	public String selectMemberPhotoV(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		Map<String, Object> result = memberService.selectMember(memberVO);    	
		model.addAttribute("result", result);    	
		return "human_resource/hr_filesV";
	}
	
	@RequestMapping("/member/updtMemberView.do")
	public String updtMemberView(@ModelAttribute("searchVO") MemberVO memberVO,
				HttpServletRequest req, ModelMap model) throws Exception {
			
		logT.debug("START");

		Map<String, Object> result;
		if((memberVO == null) || (memberVO.getNo() == null) || (memberVO.getNo() == 0)){
			MemberVO user = SessionUtil.getMember(req);
			result = memberService.selectMember(user);
		}
		else {
			result = memberService.selectMember(memberVO);
		}
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS005");
		List<CmmnDetailCode> offmCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
		codeVO.setCodeId("KMS007");
		List<CmmnDetailCode> compnyCode = cmmUseService.selectCmmCodeDetail(codeVO);
		
		model.addAttribute("result", result);
		model.addAttribute("offmCode", offmCode);
		model.addAttribute("compnyCode", compnyCode);
				
		return "human_resource/hr_memberM";
	}
	
	@RequestMapping("/member/updtMember.do")
	public String updtMember(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model,HttpServletRequest req) throws Exception {
		/* 2013.07.24 김대현 웹메일 주소 */
		MemberVO user = SessionUtil.getMember(req);
		user.setEmailLink(memberVO.getEmailLink());
		
		memberService.updtMember(memberVO);
		return "redirect:/member/selectMember.do?no=" + memberVO.getNo();
	}

	/* 2013.07.25 김대현 웹메일 주소 */
	//상단 메뉴에서 회사 웹메일 링크 주소를 변경
	@RequestMapping("/member/updtMemberEmailLink.do")
	public String updtMemberEmailLink(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model, HttpServletRequest req) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		user.setEmailLink(memberVO.getEmailLink());
		memberService.updtMemberEmailLink(memberVO);
		model.addAttribute("message", "emailLinkWriteOk");   	
		return "redirect:"+req.getParameter("curPage");
	}
	
	@RequestMapping("/member/updateUiSetting.do")
	public String updateUiSetting(Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		String showRight = commandMap.get("showRight") == null ? user.getShowRightValue() : (String)commandMap.get("showRight");
		String dayReportTyp = commandMap.get("dayReportTyp") == null ? user.getDayReportTyp() : (String)commandMap.get("dayReportTyp");
		
		user.setShowRight(showRight);
		user.setDayReportTyp(dayReportTyp);
		
		memberService.updtMemberUiSetting(user);
		
		return "success";
	}
		
	
	@RequestMapping("/member/popPhoto.do")
	public String popPhoto(Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		String picTyp = (String)commandMap.get("picTyp");
		
		if (picTyp.equals("picFileId")) {
			commandMap.put("title", "소개사진");
		} else if (picTyp.equals("picFileId2")) {
			commandMap.put("title", "증명사진");
		}
		
		model.addAttribute("commandMap", commandMap);
		
		return "human_resource/hr_pop_photoW";
	}
	@RequestMapping("/member/uploadPhoto.do")
	public String uploadPhoto(final MultipartHttpServletRequest multiRequest, Map<String, Object> map, ModelMap model) throws Exception {
		/* 임시 */
		String no = ((String[])multiRequest.getParameterMap().get("no"))[0];
		String picTyp = ((String[])multiRequest.getParameterMap().get("picTyp"))[0];
		
		String atchFileId = "";
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			List<FileVO> result = fileUtil.parseFileInf(files, "PIC_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		map.put("no", no);
		map.put(picTyp, atchFileId);
		
		memberService.uploadPhoto(map);
		
		return "human_resource/closePage";
	}
	
	@RequestMapping("/member/popInsa.do")
	public String popInsa(Map<String, Object> commandMap, ModelMap model) throws Exception {

		model.addAttribute("commandMap", commandMap);
		
		return "human_resource/hr_pop_insaW";
	}
	@RequestMapping("/member/uploadInsa.do")
	public String uploadInsa(final MultipartHttpServletRequest multiRequest, Map<String, Object> map, ModelMap model) throws Exception {
		/* 임시 */
		String userNo = ((String[])multiRequest.getParameterMap().get("userNo"))[0];
		String fileTyp = ((String[])multiRequest.getParameterMap().get("fileTyp"))[0];
		String note = ((String[])multiRequest.getParameterMap().get("note"))[0];
		
		String atchFileId = "";
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			List<FileVO> result = fileUtil.parseFileInf(files, "INS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		map.put("userNo", userNo);
		map.put("fileTyp", fileTyp);
		map.put("atchFileId", atchFileId);
		map.put("note", note);
		
		memberService.uploadInsa(map);
		
		return "human_resource/closePage";
	}
	@RequestMapping("/member/deleteInsa.do")
	public String deleteInsa(Map<String, Object> commandMap, ModelMap model) throws Exception {
		/* 임시 */
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", commandMap.get("userNo"));
		memberService.deleteInsa(map);
		
		return "forward:/member/selectMemberFilesV.do";
	}
	@RequestMapping("/member/updtMemberMsn.do")
	public void updtMemberMsn(Msn msn, HttpServletResponse res, ModelMap model) throws Exception {
		
		String command = msn.getCommand();
		
		if (command.equals("delete")) {
			memberService.deleteMemberMsn(msn);
		} else if (command.equals("insert")){
			memberService.insertMemberMsn(msn);
		}
		MemberVO memberVO = new MemberVO();
		memberVO.setNo(msn.getUserNo());
		List<Msn> msnList = memberService.getMemberMsnList(memberVO);
		
		res.setContentType("text/xml;charset=UTF-8");
		String out = "<data><![CDATA[";
		
		for (int i=0; i<msnList.size(); i++) {
			Msn t = msnList.get(i);
			out += "<div class=\"msn_data_input1\">" + t.getMsnTyp() + "</div>";
			out += "<div class=\"msn_data_input2\">" + t.getMsnAdres() + "</div>";
			out += "<div class=\"msn_data_btn\"><a href=\"javascript:msnDelete('" + t.getStringNo() + "');\">";
			out += "<img src=\"" + PathConfig.imagePath + "/btn/btn_delete03.gif\"/></a></div>";
		}
		
		out += "<div class=\"msn_data_input1\"><input type=\"text\" class=\"span_6\" name=\"msnTyp\"/></div>";
		out += "<div class=\"msn_data_input2\"><input type=\"text\" class=\"span_11\" name=\"msnAdres\"/></div>";
		out += "<div class=\"msn_data_btn\"><a href=\"javascript:msnInsert();\">";
		out += "<img src=\"" + PathConfig.imagePath + "/btn/btn_add03.gif\"/></a></div>";
		
		out += "]]></data>";
		
		res.getWriter().println( CommonUtil.getXMLStr(out) );
		
	}
	
	
	
	@RequestMapping("/member/selectPositionHistoryList.do")
	public String selectPositionHistoryList(@ModelAttribute("searchVO") MemberVO memberVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		if (memberVO.getStringNo() == null || memberVO.getStringNo().equals("") || memberVO.getStringNo().equals("null")) {
			memberVO.setNo(user.getNo());
		}
		memberVO.setWorkStList(memberVO.getWorkStArray());
		
		Map<String, Object> memberResult = memberService.selectMember(memberVO);
		List<PositionHistoryVO> positionHistoryList = memberService.selectPositionHistoryList(memberVO);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		
		PositionHistoryVO positionHistory = memberService.selectPositionHistory(memberVO);
		
		model.addAttribute("rankList", rankList);
		model.addAttribute("resultList", positionHistoryList);
		model.addAttribute("memberResult", memberResult);
		
		return "human_resource/hr_positionHistoryL";
	}
	@RequestMapping("/member/selectPositionHistorySearch.do")
	public String selectPositionHistorySearch(@ModelAttribute("searchVO") MemberVO memberVO, HttpServletRequest req, ModelMap model) throws Exception {

		memberVO.setSearchOrgIdList(CommonUtil.makeValidIdList(memberVO.getSearchOrgId()));
		memberVO.setWorkStList(memberVO.getWorkStArray());
		
		List<PositionHistoryVO> resultList = memberService.selectPositionHistorySearch(memberVO);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("rankList", rankList);
		model.addAttribute("resultList", resultList);
		
		return "human_resource/hr_positionHistoryS";
	}

	
	@RequestMapping("/member/selectMemberInc.do")
	public String selectMemberInc(@ModelAttribute("searchVO") MemberVO memberVO, Map<String, Object> commandMap, ModelMap model) throws Exception {

		String userNo = (String)commandMap.get("param_userNo");

		memberVO.setNo(Integer.parseInt(userNo));
		
		Map<String, Object> result = memberService.selectMember(memberVO);
		
		model.addAttribute("result", result);
		
		return "human_resource/include/hr_memberI";
	}
	@RequestMapping("/member/selectPositionHistoryInc.do")
	public String selectPositionHistoryInc(@ModelAttribute("searchVO") MemberVO memberVO, Map<String, Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {

		String userNo = (String)commandMap.get("param_userNo");

		memberVO.setNo(Integer.parseInt(userNo));
		
		List<PositionHistoryVO> positionHistoryList = memberService.selectPositionHistoryList(memberVO);
		
		model.addAttribute("resultList", positionHistoryList);
		
		return "human_resource/include/hr_positionHistoryI";
	}
	
	

	@RequestMapping("/member/chkUserId.do")
	public void chkUserId(@ModelAttribute("searchVO") MemberVO memberVO, HttpServletResponse res, ModelMap model) throws Exception {
		int cnt = memberService.memberIdChk(memberVO);

		res.setContentType("text/xml;charset=UTF-8");
		String out = "<result>";
		
		if (cnt > 0) {
			out += "fail";
		}
		else {
			out += "success";
		}
		
		out += "</result>";
		
		res.getWriter().println( CommonUtil.getXMLStr(out) );
	}
	
	@RequestMapping("/ajax/selectUserListJson.do")
	public void selectUserListJson(@ModelAttribute("searchVO") MemberVO memberVO
			,HttpServletResponse res, ModelMap model) throws Exception {
		
		List<MemberVO> voList= memberService.selectSimpleMemberList(memberVO);
		JSONArray userJsonArray = new JSONArray(); 
		userJsonArray.addAll(voList);
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		out.write(userJsonArray.toString().getBytes("utf-8"));
		out.flush();
		out.close();
	}
	
	

	@RequestMapping(value="/ajax/member/userTree.do")
	public String selectUserTreeList (@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		List userTreeList = memberService.selectUserTreeList(memberVO);
		model.addAttribute("resultListTree", userTreeList);
		
		//return "admin/include/docContent"; // admin/organ/OrganList
		return "/ajax/userTree";
	} 
	
	@RequestMapping(value="/ajax/member/userTreeTeam.do")
	public String selectUserTreeTeamList (@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model,
			HttpServletRequest request) throws Exception {
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		List userTreeList = null;
		List userTreeListSec = null;
		memberVO.setNo(user.getNo());
		memberVO.setOrgnztId(user.getOrgnztId());
		if (user.isAdmin()) { //Admin
			memberVO.setOrgnztId("");
			userTreeList = memberService.selectUserTreeTeamList_Admin(memberVO);
		}else{
			userTreeList = memberService.selectUserTreeTeamList(memberVO);
			
			// 겸직부서에 대한 트리메뉴 Get
			// 겸직부서가 존재할 경우에만..
			if (user.getOrgnztIdSec() != null) {
				memberVO.setOrgnztId(user.getOrgnztIdSec());	// 겸직부서 조회
				userTreeListSec = memberService.selectUserTreeTeamList(memberVO);
			}
		}
		model.addAttribute("resultListTree", userTreeList);
		model.addAttribute("resultListTreeSec", userTreeListSec);
		//return "admin/include/docContent"; // admin/organ/OrganList
		return "/ajax/userTree";
	} 
	
	@RequestMapping(value="/ajax/member/usrSearchLayer.do")
	public String selectUsrSearchLayer (@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		String keyword = URLDecoder.decode(memberVO.getSearchKeyword().trim(),"UTF-8"); 
		memberVO.setSearchKeywordList(keyword.split(","));
		List resultList = memberService.selectSearchLayerMemberList(memberVO);
		model.addAttribute("resultList", resultList);
		
		//return "admin/include/docContent"; // admin/organ/OrganList
		return "/ajax/usrSearchLayer";
	}
	
	
	/*
	 * userMixs를 받아 json형태의 결과를 리턴함
	 * errorCode 에는 각 에러의 정보를,
	 * errorInform 에는 error 코드가 3일 시, 몇 번째 입력에서 valid하지 않은 값이 들어있는 지를 array형태로 가지고 있음. {0,3,5 ...}
	 * error code
	 * 1 -> valid input
	 * 2 -> 입력형식이 잘못 되었음.
	 * 3 -> valid 하지 않은 이름이나 userId가 들어가 있음.
	 * 
	 */
	
	@RequestMapping(value="/ajax/checkValidUserMixs.do")
	public void checkValidUserMixs (
			String userMixs
			,HttpServletResponse res
			,ModelMap model
	) throws Exception {
		
		JSONObject js =  memberService.checkValidUserMixs(userMixs);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out=res.getOutputStream();
		out.write(js.toString().getBytes("utf-8"));
		out.flush();
		out.close();
	}      
	
	@RequestMapping(value="/ajax/checkValidUserMixsAuth.do")
	public void checkValidUserMixsAuth (@ModelAttribute("searchVO") MemberVO memberVO
			,Map<String, Object> commandMap
			,String userMixs
			,HttpServletRequest request
			,HttpServletResponse res
			,ModelMap model
	) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		
		
		if (user.isAdmin()) { //Admin
			commandMap.put("isAdmin", "true");
			
		}else{
			commandMap.put("isAdmin", "false");
		}
		
		commandMap.put("orgnztId", user.getOrgnztId());
		commandMap.put("orgnztIdSec", user.getOrgnztIdSec());
		commandMap.put("userMixs", userMixs);
		
		//JSONObject js =  memberService.checkValidUserMixs(userMixs);
		JSONObject js =  memberService.checkValidUserMixsAuth(commandMap);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out=res.getOutputStream();
		out.write(js.toString().getBytes("utf-8"));
		out.flush();
		out.close();
	} 
	
	
	
	@RequestMapping(value="/ajax/checkValidLaborUserMixs.do")
	public void checkValidLaborUserMixs (
			 Map<String, Object> commandMap
			 ,String data
			,HttpServletRequest request
			,HttpServletResponse res
			,ModelMap model
	) throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		String writerMix = user.getUserNm() + "(" + user.getUserId() + "),";
		
		String[] dataArray = data.split("AND");
		
		String reviewerMixs = dataArray[0];
		String laborUserMixs = dataArray[1];
		
		commandMap.put("reviewerMixs", reviewerMixs);
		commandMap.put("laborUserMixs", laborUserMixs);
		commandMap.put("writerMix", writerMix);
		
		JSONObject js =  memberService.checkValidLaborUserMixs(commandMap);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out=res.getOutputStream();
		out.write(js.toString().getBytes("utf-8"));
		out.flush();
		out.close();
	} 
	
	@RequestMapping(value="/ajax/openUserLayer.do")
	public String openUserLayer (
			int userNo
			,@ModelAttribute("memberVO") MemberVO memberVO
			,HttpServletResponse res
			,ModelMap model
	) throws Exception {
		memberVO.setNo(userNo);
		memberVO = memberService.selectMemberBasic(memberVO);
		model.addAttribute("memberVO", memberVO);
		return "/ajax/userLayer";
	}       
		
	/* 이력사항리스트 */     
	@RequestMapping("/member/selectMemberCareerList.do")
	public String selectMemberCareerList(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model, HttpServletRequest req) throws Exception {

		memberVO.setSearchOrgIdList(CommonUtil.makeValidIdList(memberVO.getSearchOrgId()));
		memberVO.setWorkStList(memberVO.getWorkStArray());
		
		memberVO.setSearchUserIdList(CommonUtil.parseIdFromMixs(memberVO.getSearchUserMix()));
		
		List resultList = memberService.selectMemberCareerList(memberVO);
		model.addAttribute("resultList", resultList);
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(codeVO);
		model.addAttribute("rankList", rankList);
		
		return "human_resource/hr_memberCareerL";
	}
	
	/* 이력사항 상세보기 */
	@RequestMapping("/member/selectMemberCareerDetail.do")
	public String selectMemberCareerDetail(@ModelAttribute("searchVO") MemberVO memberVO,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		//권한검사. 부서장 H 또는 자기 자신인 경우
		MemberVO user = SessionUtil.getMember(req);
		model.addAttribute("memberCareerAuthorized", "");
		if(user.getPosition().equals("H") 
				|| memberVO.getNo().equals(user.getNo())
				|| user.isAdmin())
			model.addAttribute("memberCareerAuthority", true);
		
		EgovMap careerMain = memberService.selectMemberCareerMain(memberVO); //이력 기본정보
		List<EgovMap> careerEdu = memberService.selectMemberCareerEdu(memberVO); //학력
		List<EgovMap> careerTrain = memberService.selectMemberCareerTrain(memberVO); //교육
		List<EgovMap> careerLicense = memberService.selectMemberCareerLicense(memberVO); //자격증
		List<EgovMap> careerWork = memberService.selectMemberCareerWork(memberVO); //근무처 경력
		List<EgovMap> careerSkill = memberService.selectMemberCareerSkill(memberVO); //경력
		memberVO = memberService.selectMemberBasic(memberVO); //기본 인사정보
					
		model.addAttribute("careerMain", careerMain); //기본 이력정보
		model.addAttribute("careerEdu", careerEdu); //학력
		model.addAttribute("careerTrain", careerTrain); //교육
		model.addAttribute("careerLicense", careerLicense); //자격증
		model.addAttribute("careerWork", careerWork); //근무처 경력
		model.addAttribute("careerSkill", careerSkill); //기술경력
		model.addAttribute("info", memberVO); //기본 인사정보
		
		return "human_resource/hr_memberCareerV";    	
	}
	
	/* 이력사항 상세보기 인쇄*/
	@RequestMapping("/member/printMemberCareerDetail.do")
	public String selectMemberCareerDetailPrint(@ModelAttribute("searchVO") MemberVO memberVO,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		//권한검사. 부서장 H 또는 자기 자신인 경우
		MemberVO user = SessionUtil.getMember(req);
		model.addAttribute("memberCareerAuthorized", "");
		if(user.getPosition().equals("H") 
				|| memberVO.getNo().equals(user.getNo())
				|| user.isAdmin())
			model.addAttribute("memberCareerAuthority", true);
		
		EgovMap careerMain = memberService.selectMemberCareerMain(memberVO); //이력 기본정보
		List<EgovMap> careerEdu = memberService.selectMemberCareerEdu(memberVO); //학력
		List<EgovMap> careerTrain = memberService.selectMemberCareerTrain(memberVO); //교육
		List<EgovMap> careerLicense = memberService.selectMemberCareerLicense(memberVO); //자격증
		List<EgovMap> careerWork = memberService.selectMemberCareerWork(memberVO); //근무처 경력
		List<EgovMap> careerSkill = memberService.selectMemberCareerSkill(memberVO); //경력
		memberVO = memberService.selectMemberBasic(memberVO); //기본 인사정보
					
		model.addAttribute("careerMain", careerMain); //기본 이력정보
		model.addAttribute("careerEdu", careerEdu); //학력
		model.addAttribute("careerTrain", careerTrain); //교육
		model.addAttribute("careerLicense", careerLicense); //자격증
		model.addAttribute("careerWork", careerWork); //근무처 경력
		model.addAttribute("careerSkill", careerSkill); //기술경력
		model.addAttribute("info", memberVO); //기본 인사정보
		
		return "human_resource/hr_memberCareerVPopPrint";
	}
	
	/* 이력사항 상세보기 엑셀출력*/
	@RequestMapping("/member/selectMemberCareerExcel.do")
	public String selectMemberCareerDetailExcel(@ModelAttribute("searchVO") MemberVO memberVO, 
			HttpServletRequest req, HttpServletResponse res, Map<String, Object> commandMap, ModelMap model) throws Exception {

		//권한검사. 부서장 H 또는 자기 자신인 경우
		MemberVO user = SessionUtil.getMember(req);
		model.addAttribute("memberCareerAuthorized", "");
		if(user.getPosition().equals("H") 
				|| memberVO.getNo().equals(user.getNo())
				|| user.isAdmin())
			model.addAttribute("memberCareerAuthority", true);
		
		EgovMap careerMain = memberService.selectMemberCareerMain(memberVO); //이력 기본정보
		List<EgovMap> careerEdu = memberService.selectMemberCareerEdu(memberVO); //학력
		List<EgovMap> careerTrain = memberService.selectMemberCareerTrain(memberVO); //교육
		List<EgovMap> careerLicense = memberService.selectMemberCareerLicense(memberVO); //자격증
		List<EgovMap> careerWork = memberService.selectMemberCareerWork(memberVO); //근무처 경력
		List<EgovMap> careerSkill = memberService.selectMemberCareerSkill(memberVO); //경력
		memberVO = memberService.selectMemberBasic(memberVO); //기본 인사정보
					
		model.addAttribute("careerMain", careerMain); //기본 이력정보
		model.addAttribute("careerEdu", careerEdu); //학력
		model.addAttribute("careerTrain", careerTrain); //교육
		model.addAttribute("careerLicense", careerLicense); //자격증
		model.addAttribute("careerWork", careerWork); //근무처 경력
		model.addAttribute("careerSkill", careerSkill); //기술경력
		model.addAttribute("info", memberVO); //기본 인사정보
		
		String filerealname = "사원이력정보_" + CalendarUtil.getToday() + "_" + memberVO.getUserNm() + "_" + memberVO.getRankNm() + ".xls";
		String filedownname = new String(filerealname.getBytes("euc-kr"),"8859_1");
	
		res.setHeader("Content-Disposition", "attachment; filename=" + filedownname); 
		res.setHeader("Content-Description", "JSP Generated Data");
		return "human_resource/hr_memberCareerVExcel1";
	}
	
	/* 이력 수정 View Bypass */
	@RequestMapping("/member/updtCareerViewBypass.do")
	public String updtCareerViewBypass(String userNo, 
			HttpServletRequest req, ModelMap model) throws Exception {
		//no=178,178,178,178,178,178 파라메터가 이렇게 넘어와서 MemberVO 초기화할때 예외발생하나 브레이크포인트 디버깅이 걸리지 않아서 bypass
		return "redirect:/member/updtCareerView.do?no=" + userNo;
	}
	
	/* 이력 수정 View */
	@RequestMapping("/member/updtCareerView.do")
	public String updtCareerView(@ModelAttribute("searchVO") MemberVO memberVO, 
			HttpServletRequest req, ModelMap model) throws Exception {
		
		//권한검사. 부서장 H 또는 자기 자신, 관리자 외에는 에러 리턴    	
		MemberVO user = SessionUtil.getMember(req);
		model.addAttribute("message","");
		if(user.getPosition().equals("H") == false 
				&& memberVO.getNo().equals(user.getNo()) == false
				&& user.isAdmin() == false){
			model.addAttribute("message", "본인 및 관리자만 이력정보 수정 가능합니다.");
			return "/error/messageError";
		}
		model.addAttribute("userNo", memberVO.getNo());
		EgovMap careerMain = memberService.selectMemberCareerMain(memberVO); //이력 기본정보
		List<EgovMap> careerEdu = memberService.selectMemberCareerEdu(memberVO); //학력
		List<EgovMap> careerTrain = memberService.selectMemberCareerTrain(memberVO); //교육
		List<EgovMap> careerLicense = memberService.selectMemberCareerLicense(memberVO); //자격증
		List<EgovMap> careerWork = memberService.selectMemberCareerWork(memberVO); //근무처 경력
		List<EgovMap> careerSkill = memberService.selectMemberCareerSkill(memberVO); //경력
		memberVO = memberService.selectMemberBasic(memberVO); //기본 인사정보
		
		model.addAttribute("careerMain", careerMain); //기본 이력정보
		model.addAttribute("careerEdu", careerEdu); //학력
		model.addAttribute("careerTrain", careerTrain); //교육
		model.addAttribute("careerLicense", careerLicense); //자격증
		model.addAttribute("careerWork", careerWork); //근무처 경력
		model.addAttribute("careerSkill", careerSkill); //기술경력
		model.addAttribute("info", memberVO); //기본 인사정보
		
		return "human_resource/hr_memberCareerM";
	}
	
	//이력 업데이트
	@RequestMapping("/member/updtMemberCareer.do")
	public String updtMemberCareer(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") MemberVO memberVO,
			Map<String, Object> param, ModelMap model) throws Exception {
			
		String atchFileId = memberVO.getAtchFileId();    	
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
				List<FileVO> result = fileUtil.parseFileInf(files, "CAR_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				memberVO.setAtchFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "CAR_", cnt, atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}    	
		memberService.updtMemberCareerAll(memberVO);
		return "redirect:/member/updtCareerView.do?no=" + memberVO.getNo();
		//return "redirect:/member/selectMember_career.do?no=" + memberVO.getNo() + "&workSt=" + memberVO.getWorkSt();
	}
	@RequestMapping("/member/deleteMemberCareer.do")
	public String deleteMemberCareer(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		memberService.deleteMemberCareer(memberVO);    	
		return "forward:/member/selectMemberCareerList.do";
	}
	
	@RequestMapping("/member/ajax/selectMemberList.do")
	public void selectMemberListAjax(@ModelAttribute("searchVO") MemberVO memberVO, 
			HttpServletRequest request, HttpServletResponse res, ModelMap model) throws Exception {

		memberVO.setWorkStList(new String[]{"W","L"});
		
		List<MemberVO> resultList = memberService.selectMemberList(memberVO);
		
		List<JSONObject> result = new ArrayList<JSONObject>();
		for(MemberVO tmpVO : resultList) {
			if (tmpVO.getMoblphonNo()!=null && !"".equals(tmpVO.getMoblphonNo())) {
				JSONObject tmpResult = new JSONObject();
				tmpResult.put("userNo", tmpVO.getUserNo());
				tmpResult.put("userNm", tmpVO.getUserNm());
				tmpResult.put("moblphonNo", tmpVO.getMoblphonNo());
				tmpResult.put("orgnztNm", tmpVO.getOrgnztNm().replace("&amp;", "&"));
				tmpResult.put("rankNm", tmpVO.getRankNm());
				result.add(tmpResult);
			}
		}
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
}
