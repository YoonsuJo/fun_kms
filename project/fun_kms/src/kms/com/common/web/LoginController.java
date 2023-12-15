package kms.com.common.web;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.common.config.ConditionSettingKey;
import kms.com.common.service.CommonService;
import kms.com.common.service.LoginService;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.NoteService;
import kms.com.management.service.InputResultPerson;
import kms.com.management.service.InputResultService;
import kms.com.member.service.Member;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
@Controller
public class LoginController {
	Logger logT = Logger.getLogger("TENY");
	
	/** EgovLoginService */
	@Resource(name = "KmsLoginService")
	private LoginService loginService;
	
	/** EgovMessageSource */
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name="KmsInputResultService")
	InputResultService irService;
	
	@Resource(name = "KmsCommonService")
	private CommonService commonService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	/** log */
	protected static final Log LOG = LogFactory.getLog(LoginController.class);
	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/login.do")
	public String loginUsrView(HttpServletRequest req,
			HttpServletResponse res, ModelMap model, String bypass) 
			throws Exception {
		
		String userAgent = req.getHeader("USER-AGENT");
		model.addAttribute("userAgent", userAgent);
		String[] mobileos = {"iPhone", "iPod", "iPad", "Android", "BlackBerry", "Windows CE", "Nokia", "Webos", "Opera Mini", "Opera Mobi", "SonyEricsson", "IEMobile"};
		boolean isMobile = false;
		int j = -1;
		for(int i=0; i<mobileos.length; i++){
			j = userAgent.indexOf(mobileos[i]);
			if(j > -1){
				isMobile = true; break;
			}
		}
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS037");
		List<CmmnDetailCode> maintenanceList = cmmUseService.selectCmmCodeDetail(codeVO);
		
		CmmnDetailCode isMaintenance = new CmmnDetailCode();
		CmmnDetailCode maintenancePeriod = new CmmnDetailCode();
		CmmnDetailCode maintenanceReason = new CmmnDetailCode();
		
		if(maintenanceList.size() > 1){
			isMaintenance = (CmmnDetailCode)maintenanceList.get(0);
			maintenancePeriod = (CmmnDetailCode)maintenanceList.get(1);
			maintenanceReason = (CmmnDetailCode)maintenanceList.get(2);
			model.addAttribute("maintenancePeriod", maintenancePeriod);
			model.addAttribute("maintenanceReason", maintenanceReason);
		}
		
		model.addAttribute("userId", req.getParameter("userId"));
		
		if(isMaintenance.getCodeDc().equals("Y") && (bypass == null || bypass.equals("Y")==false) ){
			return "loginM";
		}
		
		if (SessionUtil.isLogin(req)){
			if(isMobile){
				return "redirect:/mobile/login.do";
			}else{
				return "redirect:/main.do";
			}
		}else{

			MemberVO memInfo = loginService.selectLoginPageMember();
			
			model.addAttribute("memInfo", memInfo);
			if (req.getParameter("loginFail") != null)
				model.addAttribute("loginFail",req.getParameter("loginFail"));

			if (req.getParameter("userId") != null)
				model.addAttribute("userId",req.getParameter("userId"));
			
			if(isMobile){
				// 모바일로 접근했을 때
				return "redirect:/mobile/login.do";
			}else{
				//일반적으로 접근할 때
				return "login";
			}
		}
		
	}
	
	/**
	 * 일반 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 MemberVO
	 * @param req - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value="/actionLogin.do")
	public String actionLogin(@ModelAttribute("memberVO") MemberVO memberVO,
			HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

		logT.debug("START");
		
		if (req.getMethod().equalsIgnoreCase("POST") == false) {
			return "redirect:/login.do";
		}
		
		// 접속IP
		String userIp = EgovClntInfo.getClntRealIP(req);
		//String userIp = req.getRemoteAddr();
		
		// 내부 아이피 여부 (2015.11.30)
		String innernetYn = "N";

		// 일반 로그인 처리
		MemberVO user = loginService.actionLogin(memberVO);
		
		if (user == null || user.equals(new Member())) {
			//memberVO.getUserId()
			return "redirect:/login.do?loginFail=true&userId=" + memberVO.getUserId();
		}
		// 퇴사자 로그인 불가
		if (user.getWorkSt().equals("R")) {
			return "redirect:/login.do?loginFail=true&userId=" + memberVO.getUserId();
		}
		// 휴직자 로그인 불가
		if (user.getWorkSt().equals("L")) {
			return "redirect:/login.do?loginFail=true&userId=" + memberVO.getUserId();
		}
				
		// 근태등록 S.  AT출근 EA조기출근  EN입사 ET면제 HD주말근무 LD이사급 LT지각 NT야근 OT외근 SD파견 TR출장 VC휴가    	
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("attendIp", userIp);
		param.put("attendDt", CalendarUtil.getToday());
		
		String currentTime = CalendarUtil.getCurrentTime().toString();
		int hour = Integer.parseInt(currentTime.substring(0, currentTime.indexOf(":")));
		
		//내부 IP코드 검사
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS018");
		List<CmmnDetailCode> codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		boolean isInnerNetwork = false;
		for (int i=0; i<codeResult.size(); i++) {
			if (userIp.contains(codeResult.get(i).getCode())) {
				isInnerNetwork = true;				
				innernetYn = "Y";		// 내부 아이피 여부 (2015.11.30)
			}
		}		
		//isInnerNetwork = true; //디버그 용도	
//		isInnerNetwork = false;
//		innernetYn = "N";
		//특별 근태 적용여부 검사 시작
		vo.setCodeId("KMS041"); // 1 특별근태적용회사코드 2 적용시작 3 적용종료 4 출근시간
		List<CmmnDetailCode> attendExceptionCodeList = cmmUseService.selectCmmCodeDetail(vo);    	
		CmmnDetailCode attendExceptionCode = new CmmnDetailCode();
		String[] attendExceptionCoList = null;
		int iToday = Integer.parseInt(CalendarUtil.getToday());
		int attendExceptionDateFrom = 0;
		int attendExceptionDateTo = 0;
		boolean isAttendExceptionCo = false;
		
		if(attendExceptionCodeList.size() > 3){
			attendExceptionCode = (CmmnDetailCode)attendExceptionCodeList.get(0);
			attendExceptionCoList = attendExceptionCode.getCodeDc().split(",");
			attendExceptionCode = (CmmnDetailCode)attendExceptionCodeList.get(1);
			attendExceptionDateFrom = Integer.parseInt(attendExceptionCode.getCodeDc());
			attendExceptionCode = (CmmnDetailCode)attendExceptionCodeList.get(2);
			attendExceptionDateTo = Integer.parseInt(attendExceptionCode.getCodeDc());
			attendExceptionCode = (CmmnDetailCode)attendExceptionCodeList.get(3);
			
			if(attendExceptionDateFrom <= iToday && iToday <= attendExceptionDateTo && attendExceptionCoList != null) {
				for (int i=0; i < attendExceptionCoList.length; i++) {
					if (user.getCompnyId().contains(attendExceptionCoList[i])) {
						isAttendExceptionCo = true;				
					}
				}
			}
		}
		//특별 근태 적용여부 검사 끝
		
		Map<String,Object> logParam = new HashMap<String,Object>();
		logParam.put("userNo", user.getNo());		
		
		// 중복 로그인 관련 처리
		// 1. 회사 외부에서 로그인한 경우 (회사 내부에선 중복 로그인해도 허용)
		if (isInnerNetwork == false) {			
			//최근 10분간의 로그인기록
			Map<String, Object> recentLoginLog = loginService.selectRecentLoginLog(logParam);
			// 2. 가장 최근 로그인했던 아이피와 다른 경우
			if (recentLoginLog != null && recentLoginLog.get("ip").toString().equals(userIp) == false) {
				List currentUserList = commonService.selectCurrentUserList();
				for (int i = 0; i < currentUserList.size(); i++)
					// 3. 해당 아이디로 이미 로그인이 되어있는 경우
					// 뒤에 조건을 user.getNo().toString()로 타입을 맞춰줘야 해줘야 작동함. 일단 원래 그대로 미작동으로 놔둠
					if (((Map<String, Object>) currentUserList.get(i)).get("userNo").toString().equals(user.getNo()) ) { 
						String readerArr[] = {""};
						readerArr[0] = user.getUserId();
						noteService.sendNote(user.getNo(), readerArr, "중복 로그인되었습니다. : " + user.getUserNm() + "(" + user.getUserId() + ")\n"
								+ "IP : " + userIp + " (" + CalendarUtil.getThisTime() + ")");
					}
			}
		}
		
		// 로그인 기록 남김
		logParam.put("userIp", userIp);
		logParam.put("userNo", user.getNo());
		logParam.put("mobileYn", "N");
		logParam.put("innernetYn", innernetYn);
		logParam.put("confirmYn", "N");		// 확인 안 한 상태가 기본값
		loginService.insertLoginLog(logParam);
		
		Boolean isHoliday = loginService.isHoliday(param);
				
		if (isInnerNetwork) {
			if (isHoliday) {
				param.put("userNo", user.getNo());
				param.put("attendCd", "HD");
				if (user.getAttendCd() == null) {
					loginService.insertAttendCheck(param);
					user = loginService.actionLogin(memberVO);
				}
				logT.info(CalendarUtil.getThisTime() + " 휴일 Login 로그 " + user.getUserNm() + "(" + user.getUserId() 
						+ ") 사번:" + user.getSabun() +  "(" + user.getNo()
						+ ") IP:" + userIp + " 본사접속:" + isInnerNetwork + " 휴일:" +isHoliday );
			} else if (hour >= 6) {
				List<EgovMap> list = loginService.selectAttendCheck(param);
				if (list.size() == 0) { // 최초출근자. 근태기록 추가. 무조건 정상출근으로 가정
					loginService.insertAttendChecks(param);
				}
				param.put("userNo", user.getNo());
				List<EgovMap> attend = loginService.selectAttendCheck(param);
				
				if (attend.size() == 0) { //신규입사자 
					param.put("attendCd", "EN");
					if(user.getWorkSt().equals("L") == false) //휴직자 로그인의 경우 제외
						loginService.insertAttendCheck(param);
				} else if (attend.get(0).get("attendTm") == null && "ET".equals(attend.get(0).get("attendCd")) == false){ // 출근
					param.put("typ", "login");
					//WS_BGN_DE가 빈문자열 ""이면 로그인 오류발생. NULL로 초기화
					loginService.updateWorkStateNullCheck(param);
					if(isAttendExceptionCo) //예외시간 적용
						loginService.updateAttendCheckEx(param);
					else //기본 근태등록
						loginService.updateAttendCheck(param);
					user = loginService.actionLogin(memberVO);
				}
				logT.info(CalendarUtil.getThisTime() + " 평일 Login 로그 " + user.getUserNm() + "(" + user.getUserId() 
						+ ") 사번:" + user.getSabun() +  "(" + user.getNo()
						+ ") IP:" + userIp + " 본사접속:" + isInnerNetwork + " 휴일:" +isHoliday );
			}
		}
		// 근태등록 END
		
		//연봉협상 기간 변수 세팅
		memberService.setMemberNegoYn(user);
		
		//나의업무현황 실적등록 0시간, 미투입 인력 메세지 출력 여부
		boolean loginPolicyYn = true;


		if (user != null && user.getUserId() != null && ("".equals(user.getUserId()) == false) && loginPolicyYn) {

			req.getSession().setAttribute(ConditionSettingKey.MEMBER, user);
			
			String today = CalendarUtil.getToday();
			int date = Integer.parseInt(today.substring(6));
			boolean checkNotInput = true; //실적입력 검사할지 여부
			switch (date) { //이 달의 첫 근무일인지 검사
			case 1 : // N월 1일의 경우
				checkNotInput = false;	// pass
				break;
			case 2 : // N월 2일의 경우
				if (CalendarUtil.getDay(today) == 1)
					checkNotInput = false;	// 한 주의 첫날(일요일)일 때 pass //토:1일 일:2일
				if (CalendarUtil.getDay(today) == 2)
					checkNotInput = false;	// 한 주의 둘째날(월요일)일 때 pass //일:1일 월:2일	
				break;
			case 3 : // N월 3일의 경우
				if (CalendarUtil.getDay(today) == 2)
					checkNotInput = false;	// 그 주의 둘째날(월요일)일 때 pass //토:1일 일:2일 월:3일
				break;
			default:
				String attendCd = user.getAttendCd();
				if (attendCd == null)
					checkNotInput = false;	// 그 날의 근태정보 확정되기 전 pass
				else if ("VC".equals(attendCd))
					checkNotInput = false;	// 휴가중일때 pass
				else if ("127.0.0.1".equals(userIp))
					checkNotInput = false;	// 로컬환경일 때
				else
					checkNotInput = true;
				break;
			}
			
//			if (checkNotInput) {
//				InputResultPerson inputResultPerson = new InputResultPerson();
//				
//				inputResultPerson.setSearchUserMix(user.getUserNm() + "(" + user.getUserId() + ")");
//				inputResultPerson.setSearchUserMixList(CommonUtil.makeValidIdList(inputResultPerson.getSearchUserMix()));
//				
//				List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInput(inputResultPerson);
//				
//				for (MemberVO m : notInputMemberList) {
//					if (m.getNo().equals(user.getUserNo()) ) {
//						model.addAttribute("noInput", "Y");          			
//						break;
//					}
//				}
//			}

			//user객체에 IP, [본사/외부] 조건 입력
			user.setUserIp(userIp);
			if(isInnerNetwork){
				user.setIsInnerNetwork("Y");
			}else{
				user.setIsInnerNetwork("N");			
			}
			// 외부 접속 로그 리스트
			List<EgovMap> outerNetList = loginService.selectOuterNetLoginLogList(user);
			user.setOuterNetLoginLogList(outerNetList);
			
			if (req.getSession().getAttribute( ConditionSettingKey.REDIRECT_PAGE ) != null) {
				return "redirect:" + req.getSession().getAttribute( ConditionSettingKey.REDIRECT_PAGE );
			}
			else {        	
				return "redirect:/main.do";
			}
		} else { //로그인 실패 : 로그인 페이지로 이동
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "index"; 
		}
	}    
	
	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/logout.do")
	public String actionLogout(HttpServletRequest request, HttpServletResponse response, ModelMap model) 
			throws Exception {
		
		// 모바일 안드로이드 앱에서 접근하면 에러발생
		MemberVO user = SessionUtil.getMember(request); 
		String userIp = request.getRemoteAddr();
		if(user != null)
			System.out.println(CalendarUtil.getThisTime() + " 평일 Logout 로그 " + user.getUserNm() + "(" + user.getUserId() 
				+ ") 사번:" + user.getSabun() +  "(" + user.getNo()	+ ") IP:" + userIp );
			
		request.getSession().removeAttribute(ConditionSettingKey.MEMBER);
		
		String userAgent = request.getHeader("USER-AGENT");
		String[] mobileos = {"iPhone","iPod","iPad","Android","BlackBerry","Windows CE", "Nokia","Webos","Opera Mini","SonyEricsson","Opera Mobi","IEMobile"};
		boolean isMobile = false;
		int j = -1;
		for(int i=0;i<mobileos.length;i++){
			j = userAgent.indexOf(mobileos[i]);
			if(j > -1){
				//System.out.println("os - : " + userAgent);
				isMobile = true; break;
			}
		}
		
		if(isMobile){
			// 모바일로 접근했을 때 로그인 페이지로 이동
			return "redirect:/mobile/login.do";
			//return "mobile_login_new";
		}else{
			//일반적으로 접근할 때 로그인 페이지로 이동
			return "redirect:/login.do";
			//return "login";
		}
		
	}
	
	@RequestMapping(value="/mobile/logout.do")
	public String mobileActionLogout(HttpServletRequest request, HttpServletResponse response, ModelMap model) 
			throws Exception {
		
		// 자동로그인 쿠키값 제거
		String cookieValue = URLEncoder.encode("N", "utf-8");
		Cookie cookie = new Cookie("KMS_LOGIN_AUTH", cookieValue);
		cookie.setMaxAge(-1);	// -1분
		response.addCookie(cookie);
		
		return "redirect:/logout.do";
	}
		
	@RequestMapping("/adminError.do")
	public String adminError() throws Exception {
		return "error/adminError";
	}
	
	@RequestMapping("/common/nkmsLogin.do")
	public String nkmsLogin(HttpServletRequest req, ModelMap model) throws Exception {

		String comp = req.getParameter("nkmsCompany");
		
		String loginPage = "";
		if ("saeha".equalsIgnoreCase(comp)) 
			loginPage = "http://kms.saeha.com/login.do?hCommand=superPathLogin";
		else 
			loginPage = "http://nkms.dosanet.co.kr/login.do?hCommand=superPathLogin";
		
		model.addAttribute("redirectUrl", loginPage + "&" + req.getQueryString());		
		return "nkmsLogin";
	}
	
	@RequestMapping("/common/vccLogin.do")
	public String vccLogin(HttpServletRequest req, ModelMap model) throws Exception {
		
		String loginPage = "http://vcc.dosanet.co.kr/SSO_dosa.do";
		model.addAttribute("redirectUrl", loginPage);
		return "vccLogin";
	}
	
	/************************************************************************************************
	 *
	 * 신규 모바일 로그인 화면으로 들어간다
	 * @author 2012.04.10 정은태 추가 
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 **********************************************************************************************/

	@RequestMapping(value="/mobile/login.do")
	public String mobileLoginUsrView(HttpServletRequest req,
			HttpServletResponse res,
			ModelMap model) 
			throws Exception {
		
		String userAgent = req.getHeader("USER-AGENT");
		model.addAttribute("userAgent", userAgent);
		
		if (SessionUtil.isLogin(req)){
				return "redirect:/mobile/support/selectBoardList.do?bbsId=BBSMSTR_000000000031";   //"redirect:/main.do";
		}else {
			MemberVO memInfo = loginService.selectLoginPageMember();
			
			model.addAttribute("memInfo", memInfo);
			
			if (req.getParameter("loginFail") != null)
				model.addAttribute("loginFail",req.getParameter("loginFail"));
			
			if (req.getParameter("userId") != null)
				model.addAttribute("userId",req.getParameter("userId"));

			return "mobile_login_new";
		}
	}
	
	
	/************************************************************************************************
	 *
	 * 프로그램 내용 - 모바일로 로그인하는 경우를 처리한다.
	 * @author 2012.04.10 정은태 추가 
	 * @param vo - 아이디, 비밀번호가 담긴 MemberVO
	 * @param req - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 * 
	 **********************************************************************************************/
	@RequestMapping(value={"/mobile/actionLogin.do"})
	public String mobileActionLogin(@ModelAttribute("memberVO") MemberVO memberVO,
			HttpServletRequest req, HttpServletResponse res, ModelMap model,
			Map<String, Object> commandMap) throws Exception {

		if (req.getMethod().equalsIgnoreCase("POST") == false) {
			//return "redirect:/login.do";
			return "redirect:/mobile/login.do";
		}

		// 접속IP
		String userIp = EgovClntInfo.getClntRealIP(req);
		//String userIp = req.getRemoteAddr();
		
		// 내부 아이피 여부 (2015.11.30)
		String innernetYn = "N";
		
		/*
		// 휴대폰 번호로 로그인 할 경우, CODE 값을 같이 받아와야 로그인 처리 될 수 있도록 검증작업
		if (memberVO.getMoblphonNo()!=null&&memberVO.getReLoginYn()==null) {
			String code = (String)commandMap.get("code");
			if (code==null) code = "code";
			if (!loginService.authAppLogin(code)) {
				//return "redirect:/mobile/login.do?authAppLoginFail=true";
				model.addAttribute("message", "잘못된 접속 시도입니다. 다시 로그인을 시도해주세요.");
				model.addAttribute("redirectUrl", "/mobile/login.do");
				return "error/messageRedirect";
			}
		}
		*/
		
		//memberVO.setMoblphonNo(memberVO.getMoblphonNo().trim());
		// 일반 로그인 처리
		MemberVO user = loginService.actionLogin(memberVO);
		
		if (user == null || user.equals(new Member())) {
			req.getSession().removeAttribute(ConditionSettingKey.MEMBER);
			// 자동로그인 쿠키값 제거
			String cookieValue = URLEncoder.encode("N", "utf-8");
			Cookie cookie = new Cookie("KMS_LOGIN_AUTH", cookieValue);
			cookie.setMaxAge(-1);	// -1분
			res.addCookie(cookie);
			//return "redirect:/mobile/login.do?loginFail=true&userId=" + memberVO.getUserId();
			model.addAttribute("message", "로그인에 실패하였습니다.아이디와 비밀번호를 확인 후 다시 시도해주세요.");
			model.addAttribute("message2", "");
			model.addAttribute("redirectUrl", "/mobile/login.do?loginFail=true&userId=" + memberVO.getUserId());
			return "error/messageRedirect";
			/*
			if (memberVO.getMoblphonNo()==null) {
				req.getSession().removeAttribute(ConditionSettingKey.MEMBER);
				//return "redirect:/mobile/login.do?loginFail=true&userId=" + memberVO.getUserId();
				model.addAttribute("message", "로그인에 실패하였습니다.아이디와 비밀번호를 확인 후 다시 시도해주세요.");
				model.addAttribute("message2", "");
				model.addAttribute("redirectUrl", "/mobile/login.do?loginFail=true&userId=" + memberVO.getUserId());
				return "error/messageRedirect";
			} else { // 폰번호로 로그인할 경우
				//return "redirect:/mobile/login.do?moblphonNologinFail=true&userId=" + memberVO.getUserId();
				model.addAttribute("message", "한마음 시스템에 일치하는 휴대폰 번호가 존재하지 않습니다.");
				model.addAttribute("message2", "");
				model.addAttribute("redirectUrl", "/mobile/login.do");
				return "error/messageRedirect";
			}
			*/
		}
		
		// 퇴사자 로그인 불가
		if (user.getWorkSt().equals("R")) {
			return "redirect:/mobile/login.do?loginFail=true&userId=" + memberVO.getUserId();
		}
		// 휴직자 로그인 불가
		if (user.getWorkSt().equals("L")) {
			return "redirect:/mobile/login.do?loginFail=true&userId=" + memberVO.getUserId();
		}
		
		// 근태등록 S. AT출근 EA조기출근  EN입사 ET면제 HD주말근무 LD이사급 LT지각 NT야근 OT외근 SD파견 TR출장 VC휴가
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("attendIp", userIp);
		param.put("attendDt", CalendarUtil.getToday());

		String currentTime = CalendarUtil.getCurrentTime().toString();
		int hour = Integer.parseInt(currentTime.substring(0, currentTime.indexOf(":")));
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS018");
		List<CmmnDetailCode> codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		boolean isInnerNetwork = false;		
		for (int i=0; i<codeResult.size(); i++) {
			if (userIp.contains(codeResult.get(i).getCode()) ) 
				isInnerNetwork = true;
				innernetYn = "Y";		// 내부 아이피 여부 (2015.11.30)
		}
		Boolean isHoliday = loginService.isHoliday(param);
		//특별 근태 적용여부 검사 시작
		vo.setCodeId("KMS041"); // 1 특별근태적용회사코드 2 적용시작 3 적용종료 4 출근시간
		List<CmmnDetailCode> attendExceptionCodeList = cmmUseService.selectCmmCodeDetail(vo);    	
		CmmnDetailCode attendExceptionCode = new CmmnDetailCode();
		String[] attendExceptionCoList = null;
		int iToday = Integer.parseInt(CalendarUtil.getToday());
		int attendExceptionDateFrom = 0;
		int attendExceptionDateTo = 0;
		boolean isAttendExceptionCo = false;
		
		if(attendExceptionCodeList.size() > 3){
			attendExceptionCode = (CmmnDetailCode)attendExceptionCodeList.get(0);
			attendExceptionCoList = attendExceptionCode.getCodeDc().split(",");
			attendExceptionCode = (CmmnDetailCode)attendExceptionCodeList.get(1);
			attendExceptionDateFrom = Integer.parseInt(attendExceptionCode.getCodeDc());
			attendExceptionCode = (CmmnDetailCode)attendExceptionCodeList.get(2);
			attendExceptionDateTo = Integer.parseInt(attendExceptionCode.getCodeDc());
			attendExceptionCode = (CmmnDetailCode)attendExceptionCodeList.get(3);
			
			if(attendExceptionDateFrom <= iToday && iToday <= attendExceptionDateTo && attendExceptionCoList != null) {
				for (int i=0; i < attendExceptionCoList.length; i++) {
					if (user.getCompnyId().contains(attendExceptionCoList[i])) {
						isAttendExceptionCo = true;				
					}
				}
			}
		}
		//특별 근태 적용여부 검사 끝
		
		if (isInnerNetwork) {
			if (isHoliday) {
				param.put("userNo", user.getNo());
				param.put("attendCd", "HD");
				if (user.getAttendCd() == null) {
					loginService.insertAttendCheck(param);
					user = loginService.actionLogin(memberVO);
				}
				System.out.println(CalendarUtil.getThisTime() + " 휴일 모바일 Login 로그 " + user.getUserNm() + "(" + user.getUserId() 
						+ ") 사번:" + user.getSabun() +  "(" + user.getNo()
						+ ") IP:" + userIp + " 본사접속:" + isInnerNetwork + " 휴일:" +isHoliday );
			} else if (hour >= 6) {
				List<EgovMap> list = loginService.selectAttendCheck(param);
				if (list.size() == 0) { // 최초출근자. 근태기록 추가. 무조건 정상출근으로 가정
					loginService.insertAttendChecks(param);
				} 
				param.put("userNo", user.getNo());
				List<EgovMap> attend = loginService.selectAttendCheck(param);
				
				if (attend.size() == 0) { //신규입사자
					param.put("attendCd", "EN");
					if(user.getWorkSt().equals("L") == false) //휴직자 로그인의 경우 제외
						loginService.insertAttendCheck(param);
				} else if (attend.get(0).get("attendTm") == null && "ET".equals(attend.get(0).get("attendCd")) == false){ // 출근
					param.put("typ", "login");
					//WS_BGN_DE가 빈문자열 ""이면 로그인 오류발생. NULL로 초기화
					loginService.updateWorkStateNullCheck(param);					
					if(isAttendExceptionCo) //예외시간 적용
						loginService.updateAttendCheckEx(param);
					else //기본 근태등록
						loginService.updateAttendCheck(param);
					user = loginService.actionLogin(memberVO);
				}
				System.out.println(CalendarUtil.getThisTime() + " 평일 모바일 Login 로그 " + user.getUserNm() + "(" + user.getUserId() 
						+ ") 사번:" + user.getSabun() +  "(" + user.getNo()
						+ ") IP:" + userIp + " 본사접속:" + isInnerNetwork + " 휴일:" +isHoliday );
			}
		}
		// 근태등록 END

		boolean loginPolicyYn = true;
		if (user != null && user.getUserId() != null && !user.getUserId().equals("") && loginPolicyYn) {

			req.getSession().setAttribute(ConditionSettingKey.MEMBER, user);
			
			String today = CalendarUtil.getToday();
			int date = Integer.parseInt(today.substring(6));
			boolean checkNotInput = true;
			switch (date) {
			case 1 : // N월1일 때
				checkNotInput = false;	// pass
				break;
			case 2 : // N월2일 때
				if (CalendarUtil.getDay(today) == 2)
					checkNotInput = false;	// 그 주의 첫째날(월요일)일 때 pass
				if (CalendarUtil.getDay(today) == 1)
					checkNotInput = false;	// 그 주의 마지막날(일요일)일 때 pass
				break;
			case 3 :
				if (CalendarUtil.getDay(today) == 2)
					checkNotInput = false;	// 그 주의 첫째날(월요일)일 때 pass
				break;
			}
			
			if (checkNotInput) {
				InputResultPerson inputResultPerson = new InputResultPerson();
				
				inputResultPerson.setSearchUserMix(user.getUserNm() + "(" + user.getUserId() + ")");
				inputResultPerson.setSearchUserMixList(CommonUtil.makeValidIdList(inputResultPerson.getSearchUserMix()));
				
				List<MemberVO> notInputMemberList = irService.selectInputResultPersonNotInput(inputResultPerson);
				
				for (MemberVO m : notInputMemberList) {
					if (m.getNo().equals(user.getUserNo())) {
						model.addAttribute("noInput", "Y");
						break;
					}
				}
			}
			
			Map<String,Object> logParam = new HashMap<String,Object>();
			logParam.put("userIp", userIp);
			logParam.put("userNo", user.getNo());
			logParam.put("mobileYn", "Y");
			logParam.put("innernetYn", innernetYn);
			logParam.put("confirmYn", "N");		// 확인 안 한 상태가 기본값
			loginService.insertLoginLog(logParam);
			
			//user객체에 IP, [본사/외부] 조건 입력
			user.setUserIp(userIp);
			if(isInnerNetwork){
				user.setIsInnerNetwork("Y");
			}else{
				user.setIsInnerNetwork("N");			
			}
			
			if (req.getSession().getAttribute( ConditionSettingKey.REDIRECT_PAGE ) != null) {
				return "redirect:" + req.getSession().getAttribute( ConditionSettingKey.REDIRECT_PAGE );
			}else {//공지사항 게시판 목록으로 이동
				return "redirect:/mobile/support/selectBoardList.do?bbsId=BBSMSTR_000000000031";  //support/selectBoardList.do?bbsId=BBSMSTR_000000000031
			}
		} else {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "index"; //로그인 페이지로 이동
		}
	}
	
	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/mobile/pcVersion.do")
	public String loginUsrViewPcVewsion(HttpServletRequest req,
			HttpServletResponse res,
			ModelMap model) 
			throws Exception {
		
		String userAgent = req.getHeader("USER-AGENT");
		model.addAttribute("userAgent", userAgent);    	
		String[] mobileos = {"iPhone","iPod","iPad","Android","BlackBerry","Windows CE", "Nokia","Webos","Opera Mini","SonyEricsson","Opera Mobi","IEMobile"};
		boolean isMobile = false;
		int j = -1;
		for(int i=0;i<mobileos.length;i++){
		   j = userAgent.indexOf(mobileos[i]);
		   if(j > -1){
			   isMobile = true; break;
		   }
		}
		
		if (SessionUtil.isLogin(req)){
			return "redirect:/main.do";
		}else{
			MemberVO memInfo = loginService.selectLoginPageMember();
			
			model.addAttribute("memInfo", memInfo);
			
			if (req.getParameter("loginFail") != null)
				model.addAttribute("loginFail",req.getParameter("loginFail"));
			
			if (req.getParameter("userId") != null)
				model.addAttribute("userId",req.getParameter("userId"));
			
			if (isMobile)
				return "mobile_login";
			else
				return "login";
		} 	

	}
}