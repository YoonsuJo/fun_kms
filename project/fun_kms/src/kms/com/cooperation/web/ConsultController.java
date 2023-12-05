package kms.com.cooperation.web;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.admin.authority.service.KmsAdminAuthService;
import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.NoteService;
import kms.com.cooperation.service.BusiCntctService;
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.cooperation.service.ConsultCommentVO;
import kms.com.cooperation.service.ConsultManage;
import kms.com.cooperation.service.ConsultManageRecieve;
import kms.com.cooperation.service.ConsultService;
import kms.com.cooperation.service.ConsultVO;
import kms.com.cooperation.service.CustomerVO;
import kms.com.cooperation.service.impl.ConsultDAO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ConsultController {
	
	@Resource(name = "KmsMemberDAO")
	private MemberDAO memberDAO;
	
	@Resource(name = "KmsConsultDAO")
	private ConsultDAO consultDAO;
	
	@Resource(name = "KmsConsultService")
	private ConsultService consultService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;
	
	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
		
	@Resource(name = "KmsBusinessContactService")
	protected BusiCntctService bCService;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name = "kmsAdminAuthService")
	protected KmsAdminAuthService adminAuthService;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private DefaultBeanValidator beanValidator;
	
	//고객사관리 리스트 화면
	@RequestMapping(value={"/cooperation/selectClientList.do"})
	public String selectClientList(Map<String,Object> commandMap, HttpServletRequest req,
			//HttpServletRequest request,
			ModelMap model) throws Exception {
		
		Map<String, Object> param = commandMap;
		
		int pageUnit = 30;
		if (commandMap.get("pageUnit") != null) 
			pageUnit = Integer.parseInt((String)commandMap.get("pageUnit"));
		param.put("pageUnit", pageUnit);
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int currentPageNo = 1;
		if (param.get("pageIndex") != null && !param.get("pageIndex").toString().equals(""))
			currentPageNo = Integer.parseInt((String)param.get("pageIndex"));
		
		param.put("pageIndex", currentPageNo);
		
		paginationInfo.setCurrentPageNo(currentPageNo);
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		MemberVO user = SessionUtil.getMember(req);
		
		//고객사리스트
		List resultList = consultService.selectConsultCustomerList(param);
		int totCnt = consultService.selectConsultCustomerListCnt(param);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", commandMap);
		
		return "expansion/exps_clientL";
	}
	
	//고객사관리 상세화면으로 이동한다.
	@RequestMapping(value={"/cooperation/selectClient.do"})
	public String selectClient(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		Map<String, Object> result = consultService.selectConsultCustomer(commandMap);
		model.addAttribute("result", result);
		
		return "expansion/exps_pop_clientV";
	}
	
	//고객사관리 수정화면으로 이동한다.
	@RequestMapping(value={"/cooperation/modifyClient.do"})
	public String modifyClient(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
			
		Map<String, Object> result = consultService.selectConsultCustomer(commandMap);
		model.addAttribute("result", result);
		
		return "expansion/exps_pop_clientM";
	}
	
	//고객사관리를 업데이트한다.
	@RequestMapping(value={"/cooperation/updateClient.do"})
	public String updateClient(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		consultService.updateConsultCustomer(commandMap);
		
		model.addAttribute("searchCust", commandMap.get("custNm"));
		model.addAttribute("url", "/cooperation/selectClientList.do");
		return "expansion/closePage";
	}
	
	//고객사관리 삭제
	@RequestMapping(value={"/cooperation/deleteClient.do"})
	public String deleteClient(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		consultService.deleteConsultCustomer(commandMap);
		
		model.addAttribute("url", "/cooperation/selectClientList.do");
		return "expansion/closePage";	
	}
	
		//고객사 등록을 위한 등록페이지로 이동한다.	
	@RequestMapping(value={"/cooperation/writeClient.do"})
	public String writeClient(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		if (commandMap.get("fromInsertConsult") != null)
			model.addAttribute("fromInsertConsult", commandMap.get("fromInsertConsult").toString());
		
		return "expansion/exps_pop_clientW";
	}
	
	//고객사 등록을 한다.
	@RequestMapping(value={"/cooperation/insertClient.do"})
	public String insertClient(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		consultService.insertConsultCustomer(commandMap);
		
		if (commandMap.get("directConsult") != null && commandMap.get("directConsult").toString().equals("Y")) {
			model.addAttribute("custNm", commandMap.get("custNm").toString());
			model.addAttribute("custManager", commandMap.get("custManager").toString());
			model.addAttribute("custTelno", commandMap.get("custTelno").toString());
			model.addAttribute("custEmail", commandMap.get("custEmail").toString());
			model.addAttribute("directConsult", "Y");
			model.addAttribute("url", "/cooperation/writeConsultManage.do");
			return "expansion/closePage";
		}
		
		model.addAttribute("url", "/cooperation/selectClientList.do");
		return "expansion/closePage";
	}
	
	@RequestMapping("/cooperation/insertConsultCustomerView.do")
	public String insertConsultCustomerView(@ModelAttribute("searchVO") CustomerVO customerVO, ModelMap model) throws Exception {
		return "expansion/exps_consultCustomerW";
	}
	
	@RequestMapping(value={"/cooperation/writeConsultCustomer.do"})
	public String writeBusinessContact(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		return "cooperation/coop_consultCustomerW";
	}
	
	@RequestMapping(value={"/cooperation/insertConsultCustomer.do"})
	public String insertBusinessContact(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		consultService.insertConsultCustomer(commandMap);
		
		return "redirect:/cooperation/selectConsultCustomer.do?no=" + commandMap.get("no");
	}
	
	@RequestMapping(value={"/cooperation/modifyConsultCustomer.do"})
	public String modifyBusinessContact(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		Map<String, Object> result = consultService.selectConsultCustomer(commandMap);
		model.addAttribute("result", result);
		
		return "cooperation/coop_consultCustomerM";
	}
	
	@RequestMapping(value={"/cooperation/updateConsultCustomer.do"})
	public String updateBusinessContact(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		consultService.updateConsultCustomer(commandMap);
		
		return "redirect:/cooperation/selectConsultCustomer.do?no=" + commandMap.get("no");
	}
	
	@RequestMapping(value={"/cooperation/deleteConsultCustomer.do"})
	public String deleteBusinessContact(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		consultService.deleteConsultCustomer(commandMap);
		
		return "redirect:/cooperation/selectConsultCustomer.do?no=" + commandMap.get("no");
	}
	
	
	//상담관리 리스트화면
	
	/* SearchVO
	 * 고객사	searchCuNm
	 * 고객명	searchcustManager
	 * 문의내용	searchQCn
	 * 처리상태	searchState
	 * 접수자	searchConNm
	 * 담당자	searchDamNm
	 * 접수일S	searchRegDtS
	 * 접수일E	searchRegDtE
	 * 전체기간	searchAllPeriod
	 * 접수방법	searchReceiveTyp
	 * 구분		searchTyp
	 * 상담분류	searchServiceTyp
	 * 장애항목	searchErrorTyp
	 */
	@RequestMapping(value={"/cooperation/selectConsultManageList.do"})
	public String selectConsultManageList(Map<String,Object> commandMap, HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		// 처리상태 Default 값 : [접수, 처리중]
		if ( commandMap.get("fromResultView") == null && commandMap.get("searchState") == null ) {
			String[] tmpState = {"1", "2"};
			commandMap.put("searchState", tmpState);
		}
		
		Map<String, Object> param = commandMap;
		
		param.put("fromResultView", "Y");
		
		int pageUnit = 30;
		if (commandMap.get("pageUnit") != null) 
			pageUnit = Integer.parseInt((String)commandMap.get("pageUnit"));
		else {
			String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_consult_pageunit");
			if (pageUnitCookie != null) 
				pageUnit = Integer.parseInt(pageUnitCookie);
		}
		
		param.put("pageUnit", pageUnit);
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int currentPageNo = 1;
		if (param.get("pageIndex") != null && !param.get("pageIndex").toString().equals(""))
			currentPageNo = Integer.parseInt((String)param.get("pageIndex"));
		
		param.put("pageIndex", currentPageNo);
		
		paginationInfo.setCurrentPageNo(currentPageNo);
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		// 액셀 출력일 때는 페이징 처리가 없으므로 LIMIT 없음
		if (commandMap.get("excel") != null && commandMap.get("excel").toString().equals("Y")) {
			param.put("recordCountPerPage", 99999);
			param.put("firstIndex", 0);
		}
		
		/*날짜세팅*/
		/* 여기선 사용하지 않음.
		Date today = new Date();
		Date weekBefore = new Date();

		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		weekBefore.setTime(today.getTime()-7*(1000*60*60*24));
		
		String curRegDtS = simple.format(weekBefore);
		String curRegDtE = simple.format(today);
				
		model.addAttribute("curRegDtS", curRegDtS);
		model.addAttribute("curRegDtE", curRegDtE);
		*/
		
		MemberVO user = SessionUtil.getMember(req);
		param.put("searchUserNo", user.getUserNo());
		
		
		//검색조건 셀렉트 박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		vo.setCodeId("KMS045"); //구분		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("typeList", codeResult);
		
		vo.setCodeId("KMS025");//상담분류		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("conList", codeResult);
		
		vo.setCodeId("KMS027");//장애분류		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("errorList", codeResult);
		
		vo.setCodeId("KMS028"); //처리상태		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("stateList", codeResult);
		
		vo.setCodeId("KMS030");//열람여부		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("openList", codeResult);
		
		vo.setCodeId("KMS043");//접수방법		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("receiveList", codeResult);
		
		vo.setCodeId("KMS046");//세부항목	
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("detailList", codeResult);
		
		//상담관리 리스트
		List<EgovMap> resultList = new ArrayList<EgovMap>();
		if (commandMap.get("excel") != null && commandMap.get("excel").toString().equals("Y")) {
			resultList = consultService.selectConsultManageListForExcel(param);
		} else {
			resultList = consultService.selectConsultManageList(param);
		}
		
		int totCnt = consultService.selectConsultManageListCnt(param);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// checkbox에 바인딩된 내용, javascript에서 쓸수있도록 String형 전환
		if (commandMap.get("searchState") != null)
			commandMap.put("searchState", consultService.convertSearchData((String[])commandMap.get("searchState")) );
		if (commandMap.get("searchReceiveTyp") != null)
			commandMap.put("searchReceiveTyp", consultService.convertSearchData((String[])commandMap.get("searchReceiveTyp")) );
		if (commandMap.get("searchTyp") != null)
			commandMap.put("searchTyp", consultService.convertSearchData((String[])commandMap.get("searchTyp")) );
		if (commandMap.get("searchServiceTyp") != null)
			commandMap.put("searchServiceTyp", consultService.convertSearchData((String[])commandMap.get("searchServiceTyp")) );
		if (commandMap.get("searchErrorTyp") != null)
			commandMap.put("searchErrorTyp", consultService.convertSearchData((String[])commandMap.get("searchErrorTyp")) );
		if (commandMap.get("searchDetailTyp") != null)
			commandMap.put("searchDetailTyp", consultService.convertSearchData((String[])commandMap.get("searchDetailTyp")) );
		if (commandMap.get("searchCompny") != null)
			commandMap.put("searchCompny", consultService.convertSearchData((String[])commandMap.get("searchCompny")) );
		
		model.addAttribute("searchVO", commandMap);
		
		String filerealname = "상담관리_리스트_"+ CalendarUtil.getToday() + ".xls";
		String filedownname = new String(filerealname.getBytes("euc-kr"),"8859_1");

		if (commandMap.get("excel") != null && commandMap.get("excel").toString().equals("Y")) {			
			res.setHeader("Content-Disposition", "attachment; filename=" + filedownname);
			res.setHeader("Content-Description", "JSP Generated Data");
			return "expansion/include/exps_consult_excel";
		}
		return "expansion/exps_consultManageL";
	}
	
	//상담관리 리스트화면
	@RequestMapping(value={"/cooperation/selectConsultManageListMine.do"})
	public String selectConsultManageListMine(Map<String,Object> commandMap, HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
				
		Map<String, Object> param = commandMap;

		/* 처리상태는 기본적으로 접수,처리중 건만 보이도록 함 */
		param.put("defaultSearchState", "Y");
		
		MemberVO user = SessionUtil.getMember(req);
		param.put("searchUserNo", user.getUserNo());
		
		//검색조건 셀렉트 박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		vo.setCodeId("KMS028"); //처리상태		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("stateList", codeResult);
		
		vo.setCodeId("KMS030");//열람여부		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("openList", codeResult);
		
		List<EgovMap> resultList = new ArrayList<EgovMap>();
		
		//상담관리 리스트
		resultList = consultService.selectConsultManageList(param);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchVO", commandMap);
		
		return "expansion/exps_consultManageLM";
	}
	
	
	//상담관리 리스트화면
	@RequestMapping(value={"/cooperation/withoutLogin/selectConsultManageList.do"})
	public String selectConsultManageListWithoutLogin(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		Map<String, Object> param = commandMap;

		param.put("pageUnit", 20);
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int currentPageNo = 1;
		if (param.get("pageIndex") != null && !param.get("pageIndex").toString().equals(""))
			currentPageNo = Integer.parseInt((String)param.get("pageIndex"));
		
		param.put("pageIndex", currentPageNo);
		
		paginationInfo.setCurrentPageNo(currentPageNo);
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		model.addAttribute("searchRegDtS", "");
		model.addAttribute("searchRegDtE", "");
		param.put("searchState", 4);
		param.put("searchTyp", 2);
		
		List resultList = consultService.selectConsultManageList(param);
		int totCnt = consultService.selectConsultManageListCnt(param);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", commandMap);
		
		return "expansion/exps_consultManageL_megameet";
	}
	
	//상담관리 리스트화면 - 고객사 이름 클릭
	@RequestMapping(value={"/cooperation/selectSearchCustNmConsultManageList.do"})
	public String selectSearchCustNmConsultManageList(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		Map<String, Object> param = commandMap;

		param.put("pageUnit", 10);
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int currentPageNo = 1;
		if (param.get("pageIndex") != null && !param.get("pageIndex").toString().equals(""))
			currentPageNo = Integer.parseInt((String)param.get("pageIndex"));
		
		param.put("pageIndex", currentPageNo);
		
		paginationInfo.setCurrentPageNo(currentPageNo);
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		model.addAttribute("searchRegDtS", "");
		model.addAttribute("searchRegDtE", "");
		
		List resultList = consultService.selectConsultManageList(param);
		int totCnt = consultService.selectConsultManageListCnt(param);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", commandMap);
		
		return "expansion/exps_consultManageL_pop";
	}
	
	@RequestMapping("/cooperation/selectConsultRecieveList.do")
	public String selectConsultRecieveList(@ModelAttribute("searchVO") ConsultManage consultManage,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		List<ConsultManageRecieve> resultList = consultService.selectConsultManageRecieve(consultManage);
		
		model.addAttribute("resultList", resultList);
		
		return "expansion/exps_pop_consultReadL";
	}
	
	
	
	//상담관리 상세화면으로 이동한다.
	@RequestMapping(value={"/cooperation/selectConsultManage.do"})
	public String selectConsultManage(@ModelAttribute("searchVO") ConsultManage consultManage,
			@ModelAttribute("comment") ConsultCommentVO consultCommentVO,  Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		//검색조건 셀렉트 박스 응용
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("authCode", "consultadmin");
		List chargedList = adminAuthService.selectAuthUserList(param);
		model.addAttribute("chargedList", chargedList);
		
		vo.setCodeId("KMS045"); //구분
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("typeList", codeResult);
		
		vo.setCodeId("KMS025");//상담분류		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("conList", codeResult);
		
		vo.setCodeId("KMS027");//장애분류		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("errorList", codeResult);
		
		vo.setCodeId("KMS028"); //처리상태		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("stateList", codeResult);
		
		vo.setCodeId("KMS030");//열람여부		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("openList", codeResult);
		
		vo.setCodeId("KMS043");//접수방법		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("receiveList", codeResult);
		
		vo.setCodeId("KMS046");//세부구분		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("detailList", codeResult);
		
		MemberVO user = SessionUtil.getMember(req);
		consultManage.setUserNo(user.getNo());
		ConsultManage result = (ConsultManage)consultService.selectConsultManage(consultManage);
		if(result.getSms_yn()==null){
			result.setSms_yn("N");
		}
		if(result.getIssue_yn()==null){
			result.setIssue_yn("N");
		}
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			consultCommentVO.setNo(Integer.parseInt((String)commandMap.get("commentNo")));
		}
		
		// mailto: Subject, Body
		HashMap<String, String> messageMap = new HashMap<String, String>();
		String subjectStr = " ";
		String bodyStr = " ";
		
		// Browser 체크
		String agent = CommonUtil.getBrowser(req);
		// IE인 경우에는 mailto로 outlook으로 보내도 인코딩이 깨지지 않는다.(타 브라우저는 한글 깨짐)
		if (agent.equals("MSIE")) {
			subjectStr = "새하컴즈 고객센터입니다.";
			bodyStr = "본문내용";
		}
		
		messageMap.put("subject", subjectStr);
		messageMap.put("body", bodyStr);
		
		model.addAttribute("message", messageMap);
		model.addAttribute("result", result);
		model.addAttribute("commandMap", commandMap);
		
		return "expansion/exps_consultManageV";
	}
	
	//상담관리 상세화면 자세히 펼쳐서 이동
	@RequestMapping(value={"/cooperation/selectConsultManageExpand.do"})
	public String selectConsultManageExpand(@ModelAttribute("searchVO") ConsultManage consultManage,
			@ModelAttribute("comment") ConsultCommentVO consultCommentVO,  Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		consultManage.setUserNo(user.getNo());
		ConsultManage result = (ConsultManage)consultService.selectConsultManage(consultManage);
		if(result.getSms_yn()==null){
			result.setSms_yn("N");
		}
		if(result.getIssue_yn()==null){
			result.setIssue_yn("N");
		}
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			consultCommentVO.setNo(Integer.parseInt((String)commandMap.get("commentNo")));
		}
		model.addAttribute("result", result);
		
		return "expansion/exps_consultManageVExpand";
	}
	
	//상담관리 상세화면으로 이동한다.
	@RequestMapping(value={"/cooperation/withoutLogin/selectConsultManage.do"})
	public String selectConsultManageWitoutLogin(@ModelAttribute("searchVO") ConsultManage consultManage,
			@ModelAttribute("comment") ConsultCommentVO consultCommentVO,  Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		consultManage.setUserNo(0);
		ConsultManage result = (ConsultManage)consultService.selectConsultManage(consultManage);
		if(result.getSms_yn()==null){
			result.setSms_yn("N");
		}
		if(result.getIssue_yn()==null){
			result.setIssue_yn("N");
		}
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			consultCommentVO.setNo(Integer.parseInt((String)commandMap.get("commentNo")));
		}
		model.addAttribute("result", result);
		
		return "expansion/exps_consultManageV_megameet";
	}
	
	//상담관리  수정 불러오기
	@RequestMapping(value={"/cooperation/updateConsultManageView.do"})
	public String updateConsultManageView(@ModelAttribute("searchVO") ConsultManage consultManage,
			HttpServletRequest req, HttpServletResponse res, ModelMap model, Map<String,Object> commandMap) throws Exception {
		
		//고객사 셀렉트 박스
		List custList = consultService.selectCustList(commandMap);
		model.addAttribute("customerList", custList);
		
		//검색조건 셀렉트 박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		vo.setCodeId("KMS045"); //구분		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("typeList", codeResult);
		
		vo.setCodeId("KMS025");//상담분류		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("conList", codeResult);
		
		vo.setCodeId("KMS027");//장애분류		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("errorList", codeResult);
		
		vo.setCodeId("KMS046");//세부분류		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("detailList", codeResult);
		
		vo.setCodeId("KMS043");//접수방법		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("receiveList", codeResult);
		
		vo.setCodeId("KMS007");//회사구분		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("compnyList", codeResult);
		
		vo.setCodeId("KMS028"); //처리상태
		List stateList = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("stateList", stateList);
		
		ConsultManage result = (ConsultManage)consultService.selectConsultManage(consultManage);

		model.addAttribute("result", result);
		model.addAttribute("commandMap", commandMap);
		
		return "expansion/exps_consultManageM";
		
	}
	
	//상담관리  수정
	@RequestMapping(value={"/cooperation/updateConsultManage.do"})
	public String updateConsultManage(MultipartHttpServletRequest multiRequest, 
			@ModelAttribute("searchVO") ConsultManage consultManage,ConsultManageRecieve consultManageRecieve,
			ModelMap model, Map<String,Object> commandMap) throws Exception {
		
		MemberVO user = SessionUtil.getMember(multiRequest);
			
		String atchFileId = consultManage.getAtch_file_id();
		
		
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
					List<FileVO> result = fileUtil.parseFileInf(files, "COP_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					consultManage.setAtch_file_id(atchFileId);
			} else {
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileMngService.getMaxFileSN(fvo);
					List<FileVO> _result = fileUtil.parseFileInf(files, "COP_", cnt, atchFileId, "");
					fileMngService.updateFileInfs(_result);
			}
			}
			consultManageRecieve.setUserNo(user.getNo());
			
			if(consultManage.getState().equals("3")) {
				if(!consultManage.getService_typ().equals("3")) {
					consultManage.setError_typ("0");
					consultManage.setDetail_typ("0");
				}
			}else {
				consultManage.setTyp("0");
				consultManage.setService_typ("0");
				consultManage.setError_typ("0");
				consultManage.setDetail_typ("0");
			}
				
		consultService.updateConsultManage(consultManage,consultManageRecieve);
		
		String url = "";
		if ("Y".equals(commandMap.get("fromResultView")))
			url = "/cooperation/selectConsultManage.do?fromResultView=Y&consult_no=" + consultManage.getConsult_no();
		else
			url = "/cooperation/selectConsultManage.do?consult_no=" + consultManage.getConsult_no();
		
		return "redirect:" + url;
		
		//return "redirect:/cooperation/selectConsultManage.do?consult_no=" + consultManage.getConsult_no();
		
	}
	
	//상담관리 삭제
	@RequestMapping(value={"/cooperation/deleteConsultManage.do"})
	public String deleteConsultManage(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		consultService.deleteConsultManage(commandMap);
		
		String url = "";
		if ("Y".equals(commandMap.get("fromResultView")))
			url = "/cooperation/selectConsultManageList.do";
		else
			url = "/cooperation/selectConsultManageListMine.do";
		
		return "redirect:" + url;
	}
	
	//상담관리 등록을 위한 등록페이지로 이동한다.
	@RequestMapping(value={"/cooperation/writeConsultManage.do"})
	public String writeConsultManage(Map<String,Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		Date today = new Date();
		Date tomorrow = new Date();

		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		tomorrow.setTime(today.getTime() + (1000*60*60*24)*1);
		String end_date = simple.format(tomorrow);
		
		//고객사 셀렉트 박스
		List custList = consultService.selectCustList(commandMap);
		model.addAttribute("customerList", custList);
		
		//셀렉트박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		vo.setCodeId("KMS025");//상담분류		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("conList", codeResult);
		
		vo.setCodeId("KMS027");//장애분류		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("errorList", codeResult);
		
		vo.setCodeId("KMS043");//접수방법		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("receiveList", codeResult);
		
		vo.setCodeId("KMS007");//회사구분		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("compnyList", codeResult);
		
		vo.setCodeId("KMS045");// 구분
		codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", codeResult);
		
		vo.setCodeId("KMS046");//상세분류
		codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("detailList", codeResult);
		
		// 상담관리 담당자 권한
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("authCode", "consultadmin");
		List chargedList = adminAuthService.selectAuthUserList(param);
		model.addAttribute("chargedList", chargedList);
		
		model.addAttribute("end_date", end_date);
		
		if (commandMap.get("directInsert") != null) {
			Map<String, Object> result = consultService.selectConsultCustomer(commandMap);
			model.addAttribute("result", result);
		} else if (commandMap.get("directConsult") != null) {
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("custNm", commandMap.get("custNm"));
			result.put("custManager", commandMap.get("custManager"));
			result.put("custTelno", commandMap.get("custTelno"));
			result.put("custEmail", commandMap.get("custEmail"));
			model.addAttribute("result", result);
		}
		
		return "expansion/exps_consultManageW";
	}
	
	 //상담관리 고객사 자동완성
	@RequestMapping(value={"/ajax/consultCompanyList.do"})
	public String consultCompanyList(Map<String,Object> commandMap, ConsultVO consultVO, HttpServletRequest req,
			ModelMap model) throws Exception {
		
		commandMap.put("firstIndex", 0);
		commandMap.put("recordCountPerPage", 3000);
		
		//고객사 셀렉트 박스
		List custList = consultService.selectConsultCustomerList(commandMap);
		model.addAttribute("customerList", custList);
			
		return "/ajax/consultCompanyList";
	}
	
	//상담관리 등록을 한다.
	@RequestMapping(value={"/cooperation/insertConsultManage.do"})
	public String insertConsultManage(ConsultManage consultManage, ConsultManageRecieve consultManageRecieve, MultipartHttpServletRequest multiRequest,
			HttpServletRequest request, Map<String,Object> commandMap,
			ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		List<FileVO> result = null;
		String atchFileId = "";
			
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "COP_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		consultManage.setAtch_file_id(atchFileId);
		consultManage.setWriter_no(user.getNo());
		consultManageRecieve.setUserNo(user.getNo());
		
		// 처리상태가 완료인 경우, 현재 시간을 처리시간으로
		if ( "3".equals(consultManage.getState()) ) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat timeFormat = new SimpleDateFormat("HH");
			
			long todaytime = System.currentTimeMillis();
			String date = dateFormat.format(new Date(todaytime));
			String time = timeFormat.format(new Date(todaytime));
			
			consultManage.setComplete_date(date);
			consultManage.setComplete_tm(time);
		}else {
			consultManage.setTyp("0");
			consultManage.setService_typ("0");
			consultManage.setError_typ("0");
			consultManage.setDetail_typ("0");
		}

		String consultNo = consultService.insertConsultManage(consultManage,consultManageRecieve);	
		
		if ("Y".equals(consultManage.getSms_yn())) {
		
			List<String> addUserIdList = CommonUtil.makeValidIdListArray(consultManageRecieve.getAdd());
			List<String> chargedUserIdList = CommonUtil.makeValidIdListArray(consultManageRecieve.getCharged());
			List<String> compUserIdList = CommonUtil.makeValidIdListArray(consultManageRecieve.getComp());
			
			List<String> userMixList = new ArrayList<String>();
			//userMixList.addAll(addUserIdList);
			userMixList.addAll(chargedUserIdList);
			userMixList.addAll(compUserIdList);
			
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
				//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
				param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
			String qcn = consultManage.getQ_cn();
			
			try {
				CommonUtil.smsSend("[상담관리]" + qcn, user, memberList);
			}catch(Exception e){
				// 문자나라 서버 연결안되는 경우 문자전송 실패 무시	    		
			}
		}
		
		// [2014/04/30 김동우] 상담관리 등록시, 처리담당자에게 쪽지 보내도록 기능 추가
	    if ("Y".equals((String)commandMap.get("push_yn"))) {
	    	String[] receiverList = consultManageRecieve.getChargedUserIdList();

	    	String url = multiRequest.getRequestURL().substring(0, multiRequest.getRequestURL().indexOf("/", "http://".length())) 
    				+ "/cooperation/selectConsultManage.do?consult_no=" + consultManage.getConsult_no();
	    	String message = "상담관리에 글이 등록되었습니다.\n\n"
	    			+ "접수자 : " + user.getUserNm() + "\n"
	    			+ "고객사 : " + consultManage.getCust_nm() + "\n"
	    			+ "문의내용 : " + consultManage.getQ_cn() + "\n\n"
	    			+ url;
	    	
	    	noteService.sendNote(consultManage.getWriter_no(), receiverList, message);
	    }
		
		
		//2014.04.25 김동우 PUSH 적용
		if ("Y".equals(commandMap.get("push_yn"))) {
			List<String> recUserMixList = CommonUtil.makeValidIdListArray(consultManageRecieve.getCharged());
			List<String> userMixList = new ArrayList<String>();
			userMixList.addAll(recUserMixList);
		
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
				param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
			
			// 푸쉬 발송대상의 전화번호 추출
			List<String> rPhoneList = new ArrayList<String>();
			for(int i = 0; i < memberList.size(); i++){
				String toPhoneNo = memberList.get(i).getMoblphonNo().replace("-", "");
				if(toPhoneNo != null && !toPhoneNo.equals("")){
					rPhoneList.add(toPhoneNo);
				}
			}
			
			// 푸쉬 발송 전 파라미터 가공
			String msg = consultManage.getQ_cn();
			int pushMsgMaxLength = Integer.parseInt(propertiesService.getString("pushMsgMaxLength"));
			if (msg.length() > pushMsgMaxLength) msg = msg.substring(0, pushMsgMaxLength);
			
			String urlMsg = "\n\n" + multiRequest.getRequestURL().substring(0, multiRequest.getRequestURL().indexOf("/", "http://".length())) 
					+ "/cooperation/selectConsultManage.do?consult_no=" + consultManage.getConsult_no();

			MemberVO senderVO = memberService.selectMemberBasic(user);

			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			pushVO.setAddMsg(urlMsg);
			
			// 푸쉬 발송
			String type = "consult";
			String pushResult = pushSender.sendMessage(type, pushVO);
		}
		
		return "redirect:/cooperation/selectConsultManage.do?consult_no=" + consultNo;	
	}
	
	//상담관리 처리상태변경 팝업
	@RequestMapping(value={"/cooperation/updateConsultStateView.do"})
	public String updateConsultStateView(ConsultManage consultManage, ModelMap model) throws Exception {
		
		//검색조건 셀렉트 박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		vo.setCodeId("KMS028"); //처리상태
		List stateList = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("stateList", stateList);
		
		vo.setCodeId("KMS029"); //만족도
		List satisList = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("satisList", satisList);
		
		Date today = new Date();

		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		String todayF = simple.format(today);
		ConsultManage result=(ConsultManage)consultService.selectConsultState(consultManage);
		
		model.addAttribute("todayF", todayF);
		model.addAttribute("result", result);
		
		
		
		return "expansion/exps_pop_consultStateM";
	}
	
	//처리상태 변경 등록
	@RequestMapping(value={"/cooperation/updateConsultState.do"})
	public String updateConsultState(ConsultManage consultManage, ConsultManageRecieve consultManageRecieve, ModelMap model, Map<String,Object> commandMap) throws Exception {
		
		consultService.updateConsultManage(consultManage,consultManageRecieve);
		
		String redirectUrl = "";
		if (commandMap.get("consultView") != null && "Y".equals(commandMap.get("consultView"))) {
			redirectUrl = "redirect:/cooperation/selectConsultManage.do?consult_no=" + consultManage.getConsult_no();
		} else {
			redirectUrl = "redirect:/cooperation/selectConsultManageListMine.do";
		}
		
		return redirectUrl;
	}
	
	// 지라관리 처리상태변경
	@RequestMapping(value={"/cooperation/updateConsultJiraView.do"})
	public String updateConsultJiraView(ConsultManage consultManage, ModelMap model) throws Exception {
	
		ConsultManage result=(ConsultManage)consultService.selectConsultJira(consultManage);
		
		model.addAttribute("result", result);
		
		return "expansion/exps_pop_consultJiraM";	
	}
	
	// 상품관리 등록번호 변경
	@RequestMapping(value={"/cooperation/updateConsultRequestIdView.do"})
	public String updateConsultRequestIdView(ConsultManage consultManage, ModelMap model) throws Exception {
	
		ConsultManage result=(ConsultManage)consultService.selectConsultManage(consultManage);
		
		model.addAttribute("result", result);
		
		return "expansion/exps_pop_consultRequestM";
	}
	
	@RequestMapping(value={"/cooperation/updateConsultRequestId.do"})
	public String updateConsultRequestId(ConsultManage consultManage, ModelMap model) throws Exception {
		
		consultService.updateConsultManage(consultManage);
		model.addAttribute("consult_no", consultManage.getConsult_no());
		model.addAttribute("url", "/cooperation/selectConsultManage.do");
		return "expansion/closePage";	
	}
	
	@RequestMapping(value={"/cooperation/deleteConsultRequestId.do"})
	public String deleteConsultRequestId(ConsultManage consultManage, ModelMap model) throws Exception {
		String consultNo = consultManage.getConsult_no();
		consultService.deleteRequestId(consultNo);
		return "redirect:/cooperation/selectConsultManage.do?consult_no=" + consultNo;
	}
	
	@RequestMapping(value={"/cooperation/updateConsultJira.do"})
	public String updateConsultJira(ConsultManage consultManage, ModelMap model) throws Exception {
		
		consultService.updateConsultJira(consultManage);
		model.addAttribute("consult_no", consultManage.getConsult_no());
		model.addAttribute("url", "/cooperation/selectConsultManage.do");
		return "expansion/closePage";	
	}
	
	//상담관리 통계
	@RequestMapping(value={"/cooperation/consultStatusList.do"})
	public String consultStatusList(Map<String,Object> commandMap, HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		Map<String, Object> param = commandMap;
		
		param.put("pageUnit", propertyService.getInt("pageUnit_15"));
		param.put("pageSize", propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int currentPageNo = 1;
		if (param.get("pageIndex") != null && !param.get("pageIndex").toString().equals(""))
			currentPageNo = Integer.parseInt((String)param.get("pageIndex"));
		
		param.put("pageIndex", currentPageNo);
		
		paginationInfo.setCurrentPageNo(currentPageNo);
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		/*날짜세팅*/

		Date today = new Date();
		Date weekBefore = new Date();

		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		weekBefore.setTime(today.getTime()-7*(1000*60*60*24));
		
		String curRegDtS = simple.format(weekBefore);
		String curRegDtE = simple.format(today);
		
		model.addAttribute("curRegDtS", curRegDtS);
		model.addAttribute("curRegDtE", curRegDtE);
		if (param.get("searchRegDtS") == null || "".equals(param.get("searchRegDtS"))){
			param.put("searchRegDtS", curRegDtS);
			param.put("searchRegDtE", curRegDtE);
		}
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("searchRegDtS", param.get("searchRegDtS"));
		m.put("searchRegDtE", param.get("searchRegDtE"));
		m.put("statisticsTyp", "serviceTyp");
		List serviceTypStatistics = consultService.selectConsultStatisticsList(m);
		int totalCnt = 0;
		for (int i = 0; i < serviceTypStatistics.size(); i++) {
			String tmp = ((Map<String, Object>) serviceTypStatistics.get(i)).get("cnt").toString();
			model.addAttribute("typCnt" + ((int) i + 1), tmp);
			totalCnt += Integer.parseInt(tmp);
		}
		model.addAttribute("typCnt12", totalCnt);
		
		m.put("statisticsTyp", "typ");
		List typStatistics = consultService.selectConsultStatisticsList(m);
		for (int i = 0; i < typStatistics.size(); i++) {
			String tmp = ((Map<String, Object>) typStatistics.get(i)).get("cnt").toString();
			model.addAttribute("serviceTyp" + ((int) i + 1), tmp); 
		}
		
		/*검색기간이전 미종료*/
		param.put("searchState", "4");
		int stateCnt = consultService.selectConsultManageList2Cnt(param);
		model.addAttribute("stateCnt", stateCnt);
		
		/*검색기간이전 지라 미종료*/
		param.put("searchState", "4");
		param.put("jiraYn", "Y");
		int stateJiraCnt = consultService.selectConsultManageList2Cnt(param);
		model.addAttribute("stateJiraCnt", stateJiraCnt);		
		
		/*종료*/
		param.put("searchState", "4");
		int stateCnt2 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("stateCnt2", stateCnt2);
		
		/*미종료*/
		param.put("searchState", "");
		param.put("searchState2", "4");
		int stateCnt3 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("stateCnt3", stateCnt3);
		param.put("searchState2", "");
		
		/*처리중*/
		param.put("searchState", "2");
		int stateCnt4 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("stateCnt4", stateCnt4);
		
		/*처리완료*/
		param.put("searchState", "3");
		int stateCnt5 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("stateCnt5", stateCnt5);
				
		/*지라등록건수*/
		param.put("searchJiraYn", "Y");
		param.put("searchState", "");
		int jiraCnt = consultService.selectConsultManageListCnt(param);
		model.addAttribute("jiraCnt", jiraCnt);
		
		/*지라등록-처리완료건수*/
		param.put("searchJiraYn", "Y");
		//param.put("searchState", "3");		
		param.put("searchState3", "Y");
		int jiraCnt2 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("jiraCnt2", jiraCnt2);
		param.put("searchState3", "");
		
		/*지라등록-미종료건수*/
		param.put("searchJiraYn", "Y");
		param.put("searchState", "");
		param.put("searchState2", "4");
		int jiraCnt3 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("jiraCnt3", jiraCnt3);
		
		/*지라등록-총미종료건수*/
		param.put("searchJiraYn", "Y");
		param.put("searchState2", "4");
		String searchRegDtS = param.get("searchRegDtS").toString();
		String searchRegDtE = param.get("searchRegDtE").toString();
		param.put("searchRegDtS", "");
		param.put("searchRegDtE", "");
		int jiraCnt4 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("jiraCnt4", jiraCnt4);
		
		/*내부이슈*/
		param.put("searchJiraYn", "");
		param.put("searchState", "");
		param.put("searchState2", "");
		param.put("searchIssueYn", "Y");
		int issueCnt = consultService.selectConsultManageListCnt(param);
		model.addAttribute("issueCnt", issueCnt);				
		
		/*내부이슈 종료*/
		param.put("searchIssueYn", "Y");
		param.put("searchState", "4");
		int issueCnt2 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("issueCnt2", issueCnt2);
		
		/*내부이슈 미종료*/
		param.put("searchState", "");
		param.put("searchIssueYn", "Y");
		param.put("searchState2", "4");
		int issueCnt3 = consultService.selectConsultManageListCnt(param);
		model.addAttribute("issueCnt3", issueCnt3);
		
		param.put("searchRegDtS", searchRegDtS);
		param.put("searchRegDtE", searchRegDtE);
		
		param.put("jiraYn", "");
		param.put("searchState", "");
		param.put("searchState2", "");
		param.put("searchState3", "");
		param.put("searchIssueYn", "");
		param.put("searchServiceTyp", "");
		param.put("searchTyp", "");
		
		//삼성화재 관련 코드
		param.put("searchCuNm", "삼성화재");
		int totCntTemp = consultService.selectConsultManageListCnt(param);
		model.addAttribute("cuNmCntSamsung", totCntTemp);		
		param.put("searchCuNm", "");
		
		int intSw = 0;
		if (param.get("status") != null && !param.get("status").toString().equals(""))
			intSw = Integer.parseInt(param.get("status").toString());
		switch (intSw) {
		case 0:
			break;
		case 1: case 2: case 3: case 4: case 5: case 60:			
			param.put("searchServiceTyp", intSw);			
			param.put("searchTyp", "");
			if(intSw == 60)
				param.put("searchServiceTyp", 6);			
			break;
		case 6: case 7: case 8: case 9: case 10: case 11: case 61:
			param.put("searchServiceTyp", "2");
			int tmp = intSw - 5;
			param.put("searchTyp", tmp);
			if(intSw == 61) //쏘몬 구분코드 7번 조회
				param.put("searchTyp", 7);
			break;
		case 12: // 12 : 총 합계 (유저수변경 제외)
			param.put("searchServiceTyp", "");
			param.put("searchTyp", "");
			param.put("excludeUserChangeTyp", "Y");		 	
			break;
		case 13:/*검색 기간 이전 미종료 건*/
			param.put("searchState", "4");
			break;
		case 14:/*검색 기간 이전 지라 미종료 건*/
			param.put("searchState", "4");
			param.put("jiraYn", "Y");
			break;
		case 15:/*종료*/
			param.put("searchState", "4");
			break;
		case 16:/*미종료*/
			param.put("searchState", "");
			param.put("searchState2", "4");
			break;
		case 17:/*처리중*/
			param.put("searchState", "2");
			break;
		case 18:/*처리완료*/
			param.put("searchState", "3");
			break;
		case 19:/*지라등록건수*/
			param.put("searchJiraYn", "Y");
			param.put("searchState", "");
			break;
		case 20:/*지라등록-처리완료건수*/
			param.put("searchJiraYn", "Y");
			//param.put("searchState", "3");
			param.put("searchState3", "Y");
			break;
		case 21:/*지라등록-미종료건수*/
			param.put("searchJiraYn", "Y");
			param.put("searchState", "");
			param.put("searchState2", "4");
			break;
		case 22:/*지라등록-총미종료건수*/
			param.put("searchJiraYn", "Y");
			param.put("searchState", "");
			param.put("searchState2", "4");
			param.put("searchRegDtS", "");
			param.put("searchRegDtE", "");
			break;
		case 23:/*내부이슈*/
			param.put("searchIssueYn", "Y");
			param.put("searchRegDtS", "");
			param.put("searchRegDtE", "");
			break;
		case 24:/*내부이슈 종료*/
			param.put("searchIssueYn", "Y");
			param.put("searchState", "4");
			param.put("searchRegDtS", "");
			param.put("searchRegDtE", "");
			break;
		case 25:/*내부이슈 미종료*/
			param.put("searchIssueYn", "Y");
			param.put("searchState", "");
			param.put("searchState2", "4");
			param.put("searchRegDtS", "");
			param.put("searchRegDtE", "");
			break;
		case 31://삼성화재
			param.put("searchCuNm", "삼성화재");			
			break;
		}
		List resultList = null;

		// 액셀 출력일 때는 페이징 처리가 없으므로 LIMIT 없음
		if (commandMap.get("excel") != null && commandMap.get("excel").toString().equals("Y")) {
			param.put("recordCountPerPage", 99999);
			param.put("firstIndex", 0);
		}
		
		if (intSw == 0)
			resultList = null;
		else if (intSw == 13 || intSw == 14) // 13 : 검색 기간 이전 미종료 건수, 12: 기간 이전 지라 미종료 
			resultList = consultService.selectConsultManageList2(param);
		else
			resultList = consultService.selectConsultManageList(param);
		model.addAttribute("resultList", resultList);
				
		
		int totCnt = 0;
		switch (intSw) {
		
		case 0: totCnt = 0; break;			
		case 1:
			totCnt = Integer.parseInt(model.get("typCnt" + intSw).toString());
			model.addAttribute("searchTitle", "일반상담 : " + Integer.toString(totCnt) + " 건");
			break;
		case 2: 
			totCnt = Integer.parseInt(model.get("typCnt" + intSw).toString());
			model.addAttribute("searchTitle", "영업문의 : " + Integer.toString(totCnt) + " 건");
			break;
		case 3:
			totCnt = Integer.parseInt(model.get("typCnt" + intSw).toString());
			model.addAttribute("searchTitle", "장애처리 : " + Integer.toString(totCnt) + " 건");
			break;
		case 4:
			totCnt = Integer.parseInt(model.get("typCnt" + intSw).toString());
			model.addAttribute("searchTitle", "화상상담 : " + Integer.toString(totCnt) + " 건");
			break;
		case 5: 
			totCnt = Integer.parseInt(model.get("typCnt" + intSw).toString());
			model.addAttribute("searchTitle", "기타 : " + Integer.toString(totCnt) + " 건");
			break;
		case 12: //총합계 유저수변경 제외
			//totCnt = Integer.parseInt(model.get("typCnt" + intSw).toString()); 
			totCnt = Integer.parseInt(model.get("typCnt" + intSw).toString()) - Integer.parseInt(model.get("typCnt6").toString());
			model.addAttribute("searchTitle", "총 합계 : " + Integer.toString(totCnt) + " 건");
			break;
		case 60:
			totCnt = Integer.parseInt(model.get("typCnt6").toString());
			model.addAttribute("searchTitle", "유저수변경 : " + Integer.toString(totCnt) + " 건");
			break;
		
		case 6:
			int tmp = intSw - 5;
			totCnt = Integer.parseInt(model.get("serviceTyp" + tmp).toString());
			model.addAttribute("searchTitle", "영업문의(멀티뷰) : " + Integer.toString(totCnt) + " 건");
			break;
		case 7:
			tmp = intSw - 5;
			totCnt = Integer.parseInt(model.get("serviceTyp" + tmp).toString());
			model.addAttribute("searchTitle", "영업문의(메가미트) : " + Integer.toString(totCnt) + " 건");
			break;
		case 8:
			tmp = intSw - 5;
			totCnt = Integer.parseInt(model.get("serviceTyp" + tmp).toString());
			model.addAttribute("searchTitle", "영업문의(스쿨넷) : " + Integer.toString(totCnt) + " 건");
			break;
		case 9:
			tmp = intSw - 5;
			totCnt = Integer.parseInt(model.get("serviceTyp" + tmp).toString());
			model.addAttribute("searchTitle", "영업문의(KT사내) : " + Integer.toString(totCnt) + " 건");
			break;
		case 10:
			tmp = intSw - 5;
			totCnt = Integer.parseInt(model.get("serviceTyp" + tmp).toString());
			model.addAttribute("searchTitle", "영업문의(메신저) : " + Integer.toString(totCnt) + " 건");
			break;
		case 11:
			tmp = intSw - 5;
			totCnt = Integer.parseInt(model.get("serviceTyp" + tmp).toString());
			model.addAttribute("searchTitle", "영업문의(코덱) : " + Integer.toString(totCnt) + " 건");
			break;
		case 61: //쏘몬 구분코드 7번 조회
			tmp = 7;
			totCnt = Integer.parseInt(model.get("serviceTyp" + tmp).toString());
			model.addAttribute("searchTitle", "영업문의(쏘몬) : " + Integer.toString(totCnt) + " 건");
			break;
		
		case 13: 
			totCnt = stateCnt; 
			model.addAttribute("searchTitle", "검색 기간 이전 미종료 : " + Integer.toString(totCnt) + " 건");			
			break;
		case 14: 
			totCnt = stateJiraCnt; 
			model.addAttribute("searchTitle", "검색 기간 이전 미종료(지라) : " + Integer.toString(totCnt) + " 건");
			break;
		case 15: 
			totCnt = stateCnt2; 
			model.addAttribute("searchTitle", "종료 : " + Integer.toString(totCnt) + " 건");
			break;
		case 16: 
			totCnt = stateCnt3; 
			model.addAttribute("searchTitle", "미 종료 : " + Integer.toString(totCnt) + " 건");
			break;
		case 17: 
			totCnt = stateCnt4; 
			model.addAttribute("searchTitle", "처리 중 : " + Integer.toString(totCnt) + " 건");
			break;
		case 18: 
			totCnt = stateCnt5;
			model.addAttribute("searchTitle", "처리 완료 : " + Integer.toString(totCnt) + " 건");
			break;
		
		case 19: 
			totCnt = jiraCnt; 
			model.addAttribute("searchTitle", "지라 등록 : " + Integer.toString(totCnt) + " 건");
			break;
		case 20: 
			totCnt = jiraCnt2; 
			model.addAttribute("searchTitle", "처리 완료(지라) : " + Integer.toString(totCnt) + " 건");
			break;
		case 21: 
			totCnt = jiraCnt3; 
			model.addAttribute("searchTitle", "미 종료(지라) : " + Integer.toString(totCnt) + " 건");
			break;
		case 22: 
			totCnt = jiraCnt4; 
			model.addAttribute("searchTitle", "총 미종료(지라) : " + Integer.toString(totCnt) + " 건");
			break;
		
		case 23: 
			totCnt = issueCnt; 
			model.addAttribute("searchTitle", "내부이슈 : " + Integer.toString(totCnt) + " 건");
			break;
		case 24: 
			totCnt = issueCnt2; 
			model.addAttribute("searchTitle", "종료(내부이슈) : " + Integer.toString(totCnt) + " 건");
			break;
		case 25: 
			totCnt = issueCnt3; 
			model.addAttribute("searchTitle", "미 종료(내부이슈) : " + Integer.toString(totCnt) + " 건");
			break;
		case 31: 
			totCnt = totCntTemp; 
			model.addAttribute("searchTitle", "삼성화재 : " + Integer.toString(totCnt) + " 건");
			break;			
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("excelSearchVO", param);
		
		commandMap.put("searchRegDtS", searchRegDtS);
		commandMap.put("searchRegDtE", searchRegDtE);
		
		model.addAttribute("searchVO", commandMap);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//검색조건 셀렉트 박스 응용
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		vo.setCodeId("KMS024"); //구분		
		List typeList = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS025");//상담분류		
		List conList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("conList", conList);
		
		vo.setCodeId("KMS027");//장애분류		
		List errorList = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("errorList", errorList);
		
		vo.setCodeId("KMS046");//장애분류		
		List detailList = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("detailList", detailList);
		
		vo.setCodeId("KMS028"); //처리상태		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("stateList", codeResult);
		
		vo.setCodeId("KMS029");//만족도		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("satList", codeResult);
		
		vo.setCodeId("KMS030");//열람여부		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("openList", codeResult);
		
		String filerealname = "상담관리_통계_"+ CalendarUtil.getToday() + ".xls";
			String filedownname = new String(filerealname.getBytes("euc-kr"),"8859_1");
			 
		if (commandMap.get("excel") != null && commandMap.get("excel").toString().equals("Y")) {			
			res.setHeader("Content-Disposition", "attachment; filename=" + filedownname);
				res.setHeader("Content-Description", "JSP Generated Data");
			return "expansion/include/exps_consult_excel";
		}
		else
			return "expansion/exps_consultStatusL";	
	}
	
	@RequestMapping(value={"/cooperation/consultStatusList5.do"})
	public String consultStatusList2(Map<String,Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = commandMap;
		
		/*날짜세팅*/

		Date today = new Date();
		Date weekBefore = new Date();

		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		weekBefore.setTime(today.getTime()-7*(1000*60*60*24));
		
		String curRegDtS = simple.format(weekBefore);
		String curRegDtE = simple.format(today);
		
		model.addAttribute("curRegDtS", curRegDtS);
		model.addAttribute("curRegDtE", curRegDtE);
		if (param.get("searchRegDtS") == null || "".equals(param.get("searchRegDtS"))){
			param.put("searchRegDtS", curRegDtS);
			param.put("searchRegDtE", curRegDtE);
		}
		
		/*지라등록-총미종료건수*/
		String searchRegDtS = param.get("searchRegDtS").toString();
		String searchRegDtE = param.get("searchRegDtE").toString();
		
		commandMap.put("searchRegDtS", searchRegDtS);
		commandMap.put("searchRegDtE", searchRegDtE);
		
		model.addAttribute("searchVO", commandMap);
		
		int userNo = 0;
		if(param.get("searchUserNm") != null && !"".equals(param.get("searchUserNm"))) {
			userNo = memberDAO.selectUserNo(commandMap);
		}
		param.put("userNo", userNo);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		vo.setCodeId("KMS045"); //구분		
		List typeList = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS025");//상담분류		
		List conList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("conList", conList);
		
		vo.setCodeId("KMS027");//장애분류		
		List errorList = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("errorList", errorList);
		
		vo.setCodeId("KMS046");//장애분류		
		List detailList = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("detailList", detailList);
		
		vo.setCodeId("KMS028"); //처리상태		
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("stateList", codeResult);
		
		vo.setCodeId("KMS029");//만족도		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("satList", codeResult);
		
		vo.setCodeId("KMS030");//열람여부		
		codeResult = cmmUseService.selectCmmCodeDetail(vo);	
		model.addAttribute("openList", codeResult);
		
		List<EgovMap> result = consultService.selectConsultStatList(param);
		List conResultList = new ArrayList();
		
		return "expansion/exps_consultStatusL2";
	}
	
	
	
	//상담관리 통계
	@RequestMapping(value={"/cooperation/consultStatusList2.do"})
	public String consultStatusList2(Map<String,Object> commandMap, HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		Map<String, Object> param = commandMap;
		
		/*날짜세팅*/

		Date today = new Date();
		Date weekBefore = new Date();

		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		weekBefore.setTime(today.getTime()-7*(1000*60*60*24));
		
		String curRegDtS = simple.format(weekBefore);
		String curRegDtE = simple.format(today);
		
		model.addAttribute("curRegDtS", curRegDtS);
		model.addAttribute("curRegDtE", curRegDtE);
		if (param.get("searchRegDtS") == null || "".equals(param.get("searchRegDtS"))){
			param.put("searchRegDtS", curRegDtS);
			param.put("searchRegDtE", curRegDtE);
		}
		
		if(param.get("searchUserNm") != null && !"".equals(param.get("searchUserNm"))) {
			int userNo = memberDAO.selectUserNo(commandMap);
			param.put("userNo", userNo);
		}
		
		/*지라등록-총미종료건수*/
		String searchRegDtS = param.get("searchRegDtS").toString();
		String searchRegDtE = param.get("searchRegDtE").toString();
		
		commandMap.put("searchRegDtS", searchRegDtS);
		commandMap.put("searchRegDtE", searchRegDtE);
		
		model.addAttribute("searchVO", commandMap);
		
		
		//검색조건 셀렉트 박스 응용
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
	
		vo.setCodeId("KMS045"); //구분		
		List<CmmnDetailCode> typCodeResult = cmmUseService.selectCmmCodeDetail(vo);		

		vo.setCodeId("KMS027");//장애분류		
		List<CmmnDetailCode> errorTypCodeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		vo.setCodeId("KMS025");//상담분류		
		List<CmmnDetailCode> serviceTypCodeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		vo.setCodeId("KMS028"); //처리상태		
		List<CmmnDetailCode> stateTypCodeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		vo.setCodeId("KMS046"); //세부분류		
		List<CmmnDetailCode> detailTypCodeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("searchRegDtS", param.get("searchRegDtS"));
		m.put("searchRegDtE", param.get("searchRegDtE"));
		if(param.get("userNo") != null && !"".equals(param.get("userNo"))) {
			m.put("userNo", param.get("userNo"));
		}
		String groupTyp1 = "";
		String groupTyp2 = "";
		List<EgovMap> result = new ArrayList<EgovMap>();
		List resultList = new ArrayList();
		
		
		/*
		 * 첫번째 영역, 장애분류 + 구분 
		 */
		groupTyp1 = "errorTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type1");
		resultList = consultService.makeStatisticList(result, errorTypCodeResult, typCodeResult, groupTyp1, groupTyp2, false);
		
		model.addAttribute("resultList1", resultList);
		
		
		/*
		 * 두번째 영역, 장애분류 + 처리상태
		 */
		groupTyp1 = "errorTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type2");
		resultList = consultService.makeStatisticList(result, errorTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, false);
		
		model.addAttribute("resultList2", resultList);
		
		
		/*
		 * 세번째 영역, 상담분류 + 구분
		 */
		groupTyp1 = "serviceTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type3");
		resultList = consultService.makeStatisticList(result, serviceTypCodeResult, typCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList3", resultList);
		
		
		/*
		 * 네번째 영역, 상담분류 + 처리상태
		 */
		groupTyp1 = "serviceTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type4");
		resultList = consultService.makeStatisticList(result, serviceTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList4", resultList);
		
		
		/*
		 * PC, 상담분류 + 처리상태
		 */
		groupTyp1 = "detailTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type5");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, typCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList5", resultList);
		
		groupTyp1 = "detailTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type6");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList6", resultList);
		/*
		 * AOS, 상담분류 + 처리상태
		 */
		groupTyp1 = "detailTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type7");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, typCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList7", resultList);
		
		groupTyp1 = "detailTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type8");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList8", resultList);
		/*
		 * IOS, 상담분류 + 처리상태
		 */
		groupTyp1 = "detailTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type9");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, typCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList9", resultList);
		
		groupTyp1 = "detailTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type10");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList10", resultList);
		/*
		 * MAC, 상담분류 + 처리상태
		 */
		groupTyp1 = "detailTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type11");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, typCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList11", resultList);
		
		groupTyp1 = "detailTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type12");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList12", resultList);
		/*
		 * WEB, 상담분류 + 처리상태
		 */
		groupTyp1 = "detailTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type13");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, typCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList13", resultList);
		
		groupTyp1 = "detailTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type14");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList14", resultList);
		/*
		 * SERVER, 상담분류 + 처리상태
		 */
		groupTyp1 = "detailTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type15");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, typCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList15", resultList);
		
		groupTyp1 = "detailTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type16");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList16", resultList);
		/*
		 * 기타, 상담분류 + 처리상태
		 */
		groupTyp1 = "detailTyp";
		groupTyp2 = "typ";
		result = consultService.selectConsultStatisticsList(m, "type17");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, typCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList17", resultList);
		
		groupTyp1 = "detailTyp";
		groupTyp2 = "state";
		result = consultService.selectConsultStatisticsList(m, "type18");
		resultList = consultService.makeStatisticList(result, detailTypCodeResult, stateTypCodeResult, groupTyp1, groupTyp2, true);
		
		model.addAttribute("resultList18", resultList);
		
		result = consultDAO.selectCompDurationService(m);
		model.addAttribute("compDurationService", result);
		
		result = consultDAO.selectCompDurationError(m);
		model.addAttribute("compDurationError", result);
		
		result = consultDAO.selectCompDurationDetail(m);
		model.addAttribute("compDurationDetail", result);
		
		result = consultDAO.selectCompDurationTotal(m);
		model.addAttribute("compDurationTotal", result);
		
		// type에 소계를 추가하여 rowHeader 셋팅
		CmmnDetailCode sumCDCode = new CmmnDetailCode();
		sumCDCode.setCodeNm("합계");
		serviceTypCodeResult.add(sumCDCode);
		model.addAttribute("typeList", typCodeResult);
		model.addAttribute("errorTypeList", errorTypCodeResult);
		model.addAttribute("serviceTypeList", serviceTypCodeResult);
		model.addAttribute("stateList", stateTypCodeResult);
		model.addAttribute("detailList", detailTypCodeResult);
		
		// 동적으로 열너비 계산(구분 + 장애타입갯수 + 상담타입갯수 + 합계)
		int colWidth = 94 / ( 1 + typCodeResult.size() + stateTypCodeResult.size() + 1 );
		model.addAttribute("colWidth", colWidth);
		
		return "expansion/exps_consultStatusL2";
	}
	
	@RequestMapping("/cooperation/changeConsultRecieve.do")
	public String changeConsultRecieve(@ModelAttribute("searchVO") ConsultManageRecieve consultManageRecieve
			, HttpServletRequest req, HttpServletResponse res
			, ModelMap model, Map<String,Object> commandMap) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		
		String tmp = consultManageRecieve.getConsult_no();
		
		consultService.changeConsultRecieve(consultManageRecieve);
		
		ConsultManage searchVO = new ConsultManage();
		searchVO.setConsult_no(tmp);
		ConsultManage consultManage = (ConsultManage)consultService.selectConsultManage(searchVO);
		
		
		// [2014/05/02 김동우] 상담관리 담당자 변경시, 처리담당자에게 쪽지 보내도록 기능 추가
    	String[] receiverList = consultManageRecieve.getChargedUserIdList();

    	String urlMsg = req.getRequestURL().substring(0, req.getRequestURL().indexOf("/", "http://".length())) 
				+ "/selectConsultManage.do?consult_no=" + consultManage.getConsult_no();
    	String message = "상담관리에 글이 등록되었습니다.\n\n"
    			+ "접수자 : " + consultManage.getUser_nm() + "\n"
    			+ "고객사 : " + consultManage.getCust_nm() + "\n"
    			+ "문의내용 : " + consultManage.getQ_cn() + "\n\n"
    			+ urlMsg;
    	
    	noteService.sendNote(user.getUserNo(), receiverList, message);
		
		
		// [2014/05/02 김동우]  상담관리 담당자 변경시, PUSH 적용
		List<String> recUserMixList = CommonUtil.makeValidIdListArray(consultManageRecieve.getChargedUserIdMix());
		List<String> userMixList = new ArrayList<String>();
		userMixList.addAll(recUserMixList);
	
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("userMixList", userMixList);
			param.put("alarmUserList", 0);
		List<MemberVO> memberList = memberService.selectMemberListById(param);
		
		// 푸쉬 발송대상의 전화번호 추출
		List<String> rPhoneList = new ArrayList<String>();
		for(int i = 0; i < memberList.size(); i++){
			String toPhoneNo = memberList.get(i).getMoblphonNo().replace("-", "");
			if(toPhoneNo != null && !toPhoneNo.equals("")){
				rPhoneList.add(toPhoneNo);
			}
		}

		// 푸쉬 발송 전 파라미터 가공
		String msg = consultManage.getQ_cn();
		int pushMsgMaxLength = Integer.parseInt(propertiesService.getString("pushMsgMaxLength"));
		if (msg.length() > pushMsgMaxLength) msg = msg.substring(0, pushMsgMaxLength);
		
		urlMsg = "\n\n" + urlMsg;
		
		MemberVO senderVO = memberService.selectMemberBasic(user);
		
		PushVO pushVO = new PushVO();
		pushVO.setSenderVO(senderVO);
		pushVO.setrPhoneList(rPhoneList);
		pushVO.setMsg(msg);
		pushVO.setAddMsg(urlMsg);
		
		// 푸쉬 발송
		String type = "consult";
		String pushResult = pushSender.sendMessage(type, pushVO);
		
		
		String redirectUrl = "";
		if (commandMap.get("consultView") != null && "Y".equals(commandMap.get("consultView"))) {
			redirectUrl = "redirect:/cooperation/selectConsultManage.do?consult_no=" + tmp;
		} else {
			redirectUrl = "redirect:/cooperation/selectConsultManageListMine.do";
		}
		
		return redirectUrl;
	}
	
	@RequestMapping("/cooperation/updateIssue.do")
	public String updateIssue(@ModelAttribute("searchVO") ConsultManage consultManage
			, ModelMap model) throws Exception {
		
		String tmp = consultManage.getConsult_no();
		
		consultService.updateIssue(consultManage);
		
		return "redirect:/cooperation/selectConsultManageExpand.do?consult_no=" + tmp;
	}
	
}