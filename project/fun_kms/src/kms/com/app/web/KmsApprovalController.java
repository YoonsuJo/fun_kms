
package kms.com.app.web;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.ibm.icu.text.SimpleDateFormat;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kms.com.admin.approval.service.KmsApprovalTyp;
import kms.com.admin.approval.service.KmsApprovalTypService;
import kms.com.admin.approval.service.KmsApprovalTypVO;
import kms.com.admin.authority.service.KmsAdminAuthService;
import kms.com.app.service.*;
import kms.com.common.exception.IdMixInputException;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.*;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.ProjectVO;
import kms.com.management.service.FundService;
import kms.com.member.service.*;
import kms.com.support.service.CardService;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.StockService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/*
 import com.gpki.servlet.GPKIHttpServletRequest;
 import com.gpki.servlet.GPKIHttpServletResponse;
 import com.gpki.io.GPKIJspWriter;
 import com.gpki.secureweb.GPKIKeyInfo;
 import com.dsjdf.jdf.*;

 import com.gpki.gpkiapi.GpkiApi;
 import com.gpki.gpkiapi.cert.X509Certificate;
 import com.gpki.gpkiapi.cms.SignedData;
 import com.gpki.gpkiapi.crypto.PrivateKey;
 import com.gpki.gpkiapi.crypto.Random;
 import com.gpki.gpkiapi.storage.*;
 import com.gpki.gpkiapi.util.*;
 import com.gpki.gpkiapi.exception.GpkiApiException;
 */

/**
 * 전자결제를 처리하는 컨트롤러 클래스
 * 
 * @author 양진환
 * @since 2011.08.24
 * @version 1.0
 * @see <pre>
 * </pre>
 */
@Controller
public class KmsApprovalController {

	/** KmsApprovalService */
	@Resource(name = "approvalService")
	private KmsApprovalService approvalService;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;

	@Resource(name = "kmsApprovalService")
	private EgovIdGnrService idgenService;

	@Resource(name = "kmsApprovalTypService")
	private KmsApprovalTypService kmsApprovalTypService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "kmsEappCommentService")
	private KmsEappCommentService kmsEappCommentService;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	  
	@Resource(name = "KmsWorkStateService")
	private WorkStateService workStateService;
	
	@Resource(name="KmsMemberService")
	MemberService memberService;
	
	@Resource(name="KmsSelfdevService")
	KmsSelfdevService selfdevService;
	
	@Resource(name = "egovFileIdGnrService")
	private EgovIdGnrService fileIdgenService;
	
	@Resource(name = "presetService")
	private KmsPresetService presetService;
		 
	@Resource(name = "accountService")
	protected KmsAccountService accountService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name = "KmsMailService")
	private MailService mailService;
	
	@Resource(name = "projectService")
	private ProjectService projectService;
	
	@Resource(name = "kmsAdminAuthService")
	private KmsAdminAuthService adminAuthService;
	
	@Resource(name="KmsFundService")
	FundService fundService;
	
	@Resource(name = "KmsStockService")
	private StockService stockService;
	
	@Resource(name = "KmsCardService")
	private CardService cardService;
	
	/** 상수 */
	public static final String readerPreFix = "APR";
	public static final String writerC = "APR000";
	public static final String reviewerC = "APR001";
	public static final String cooperatorC = "APR002";
	public static final String deciderC = "APR003";
	public static final String referencerC = "APR004";
	public static final String handlerC = "APR005";
	public static final String rejectConfirmerC = "APR099";//반려 확인...

	public static final String docStatC = "APP";
	public static final String writingC = "APP000";
	public static final String reviewingC = "APP001";
	public static final String cooperatingC = "APP002";
	public static final String decidingC = "APP003";
	public static final String referencingC = "APP004";
	public static final String decidedC = "APP005";
	public static final String rejectC = "APP099";
	public static final String selfdevPresetCode = "S";
	public static final String diningPresetCode = "D";
	public static final String costPresetCode = "C";
	
	
	/** log */
	protected static final Log LOG = LogFactory.getLog(KmsApprovalController.class);

	// 메인화면을 조회한다.
	@RequestMapping(value = "/approval/main.do")
	public String approvalMain(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(6);
		searchVO.setWriterNo(user.getNo());
		searchVO.setReaderNo(user.getNo());
		
		ApprovalVO summaryVO = approvalService.selectApprovalCntSummary(searchVO);
		model.addAttribute("summaryVO", summaryVO);

/*		searchVO.setMode("2");
		Map<String, Object> map = approvalService.selectApprovalList(searchVO);
		model.addAttribute("doApprovalList", map.get("resultList"));*/

/*		searchVO.setMode("13");
		searchVO.setSearchHandleStatL(new String[] {"0"});
		map = approvalService.selectApprovalList(searchVO);
		model.addAttribute("doHandleList", map.get("resultList"));
		model.addAttribute("doHandleCnt", map.get("resultCnt"));*/
		
/*		searchVO.setMode("3");
		searchVO.setSearchHandleStatL(null);
		map = approvalService.selectApprovalList(searchVO);
		model.addAttribute("myApprovalList", map.get("resultList"));*/

//		searchVO.setMode("10");
//		searchVO.setSearchHandleStatL(new String[] {});
//		map = approvalService.selectApprovalList(searchVO);
//		model.addAttribute("myCompApprovalList", map.get("resultList"));
		
		return "approval/appr_Main";
	}
	
	@RequestMapping(value = "/approval/ajax/main.do")
	public void approvalMainAjax(
			HttpServletRequest req, HttpServletResponse res,
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(req);
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(6);
		searchVO.setWriterNo(user.getNo());
		searchVO.setReaderNo(user.getNo());
		int doHandleCnt = 0;
		if("2".equals(searchVO.getMode())){
		}else if("13".equals(searchVO.getMode())){
			doHandleCnt = approvalService.selectApprovalMainAjaxCnt(searchVO);
			searchVO.setSearchHandleStatL(new String[] {"0"});
		}else if("3".equals(searchVO.getMode())){
			searchVO.setSearchHandleStatL(null);
		}else if("10".equals(searchVO.getMode())){
			searchVO.setSearchHandleStatL(new String[] {});
		}
		List<ApprovalVO> apprList = approvalService.selectApprovalMainAjax(searchVO);
		Gson gson = new Gson();
		JsonObject object = new JsonObject();
		object.addProperty("doHandleCnt", doHandleCnt);
		object.addProperty("apprList", gson.toJson(apprList));
		String gsonData = gson.toJson(object);
		
		res.setContentType("charset=UTF-8");
		
		ServletOutputStream out = res.getOutputStream();
		
		out.write(gsonData.getBytes("UTF-8"));
		out.flush();
		out.close();
	}		
	
	@RequestMapping(value = {"/ajax/selectApprovalList.do"})
	public String selectApprovalList(@ModelAttribute("searchVO") ProjectVO projectVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("prjId", commandMap.get("prjId"));		
		// param.put("pageUnit", 5);
		param.put("pageUnit", 999999);		
		param.put("pageSize", propertyService.getInt("pageSize"));
		param.put("includeUnderProject", commandMap.get("includeUnderProject"));
		param.put("searchPrjId", commandMap.get("searchPrjId"));		 
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(projectVO.getPageIndex());
		paginationInfo.setRecordCountPerPage((Integer)param.get("pageUnit"));
		paginationInfo.setPageSize((Integer)param.get("pageSize"));
	
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		param.put("includeInnerSales", "Y");
		
		int totCnt = approvalService.selectApprovalListAjaxTotCnt(param);
		List<ApprovalVO> resultList = approvalService.selectApprovalListAjax(param);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		
		return "/approval/include/approvalList";
	}
	
	// 목록을 조회한다
	@RequestMapping(value = {"/approval/approvalL.do"})
	public String approvalSelectList(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			Integer mode, Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		if(mode == null|| mode==0 ){
			mode = 1;
			searchVO.setMode("1");
		}
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		String pageDesc = "";
		String pageSj = "";
		String pageNavi= "";
		int searchBox = 0;
		int handleCheckBox = 0;
		int handleComplete = 0;
		
		int pageUnit = propertyService.getInt("pageUnit_15");
		if (commandMap.get("pageUnit") != null) 
			pageUnit = Integer.parseInt((String)commandMap.get("pageUnit"));
		else {
			String pageUnitCookie = EgovSessionCookieUtil.getCookie(request, "hanmam_approval_pageunit");
			if (pageUnitCookie != null) 
				pageUnit = Integer.parseInt(pageUnitCookie);
		}
		
		searchVO.setPageUnit(pageUnit);
		searchVO.setPageSize((propertyService.getInt("pageSize")));
		searchVO.setReaderNo(user.getNo());
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		switch (mode) {
		// 기안하기
		case 1: // 저장된 문서
			pageSj = "저장된 문서";
			pageDesc = "내가 저장한 문서 및 기안취소한 문서를 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 기안하기 > 저장된 문서";
			searchBox = 4;
			break;
			
		// 결재하기
		case 2: // 승인할 문서
			pageSj = "승인할 문서";
			pageDesc = "목록에서 결재문서를 선택하여 검토하고 승인합니다.";
			pageNavi = "홈 > 전자결재 > 결재하기 > 승인할 문서";
			searchBox = 3;
			break;
		case 12: // 참조할 문서
			pageSj = "참조할 문서";
			pageDesc = "결재 완료된 문서들 중 내가 참조해야 할 문서들을 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 결재하기 > 참조할 문서";
			searchBox = 3;
			break;
		case 13: // 처리할 문서
			pageSj = "처리할 문서";
			pageDesc = "결재 완료된 문서들 중 내가 처리해야 할 문서들을 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 결재하기 > 처리할 문서";
			searchBox = 3;
			break;

		// 결재현황보기
		case 5: // 반려된 문서
			pageSj = "반려된 문서";
			pageDesc = "내가 기안 또는 승인한 후 상위결재자에 의해 반려된 문서를 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 결재현황보기 > 반려된 문서";
			searchBox = 3;
			break;
		case 3: // 기안한 문서
			pageSj = "기안한 문서";
			pageDesc = "내가 기안한 문서 중 아직 결재가 완료가 되지 않은 문서의 진행 상황을 보여줍니다.";
			pageNavi = "홈 > 전자결재 > 결재현황보기 > 기안한 문서";
			searchBox = 4;
			break;
		case 7: // 결재이전 문서 (이전 결재자가 검토중인 결재진행건)
			pageSj = "결재이전 문서";
			pageDesc = "이전 결재자가 승인한 후 나에게 도착할 문서들을 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 결재현황보기 > 결재이전 문서";
			searchBox = 3;
			break;
		case 4: // 결재이후 문서 (내가 승인한 결재진행건)
			pageSj = "결재이후 문서";
			pageDesc = "내가 승인한 문서 중 아직 결재 완료가 되지 않은 문서의 진행 상황을 보여줍니다.";
			pageNavi = "홈 > 전자결재 > 결재현황보기 > 결재이후  문서";
			searchBox = 3;
			break;
			
		// 완료문서검색
		case 14: // 모든 결재문서
			pageSj = "결재 완료된 문서";
			pageDesc = "모든 결재완료문서를 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 완료문서검색 > 모든 결재문서";
			searchBox = 1;
			break;
		case 10: // 내가 기안한 문서
			pageSj = "내가 기안한 문서";
			pageDesc = "내가 기안한 문서 중 결재가 완료된 문서들을 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 완료문서검색 > 내가 기안한 문서";
			searchBox = 2;
			break;
		case 11: // 내가 결재한 문서
			pageSj = "내가 결재한 문서";
			pageDesc = "내가 승인한 문서 중 결재가 완료된 문서들을 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 완료문서검색 > 내가 결재한 문서";
			searchBox = 1;
			break;

		// 2012.01.26 이후 사용하지 않는 결재함 모드 
		case 6: // 확인완료된 반려문서
			pageSj = "반려문서 보관함";
			pageDesc = "내가 반려한 문서 및 내가 기안 또는 승인한 후 상위결재자에 의해 반려된 문서를 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 보관된 문서 > 반려 문서";
			searchBox = 3;
			break;
		case 8: //내가 참조할 문서
			pageSj = "내가 참조할 결재진행건";
			pageDesc = "결재 진행중인 문서들 중 내가 참조해야 할 문서들을 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 결재현황보기 > 내가 참조할 문서";
			break;
		case 9: // 결재진행중인 모든 문서
			pageSj = "결재 진행중인 문서";
			pageDesc = "결재 진행중인 문서들 중 나와 관련된 모든 문서들을 확인할 수 있습니다.";
			pageNavi = "홈 > 전자결재 > 결재현황보기 > 모든 결재문서";
			break;

		default:
			throw new Exception();
		} // switch end
		
		// [20140703, 김동우] 완료문서일 경우, 기안일 default value 설정
		// if selected mode is complete document, set default value of draft date. (I'm studying English)
		if (mode==14 || mode==10 || mode==11) {
			if (searchVO.getSearchBgnDe().isEmpty() && searchVO.getSearchEndDe().isEmpty()) {
				SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
				String today = simple.format(new Date());
				
				searchVO.setSearchBgnDe(today.substring(0, 4) + "0101");
				searchVO.setSearchEndDe(today);
			}
		}
		
		Map<String, Object> map = approvalService.selectApprovalList(searchVO);

		String[] searchHandleStatL = searchVO.getSearchHandleStatL();
		if(searchHandleStatL!=null) {
			boolean handleChecking = false;
			for(String handleStat :searchHandleStatL) {
				if(Integer.parseInt(handleStat)==1){
					handleChecking =false;
					break;
				} else if(Integer.parseInt(handleStat)==0 
						|| Integer.parseInt(handleStat)==2)
					handleChecking = true;
			}
			if(handleChecking)
				handleCheckBox = 1;

			boolean complete = false;
			for(String handleStat :searchHandleStatL) {
				if(Integer.parseInt(handleStat)==0 || Integer.parseInt(handleStat)==2){
					complete =false;
					break;
				} else if(Integer.parseInt(handleStat)==1)
					complete = true;
			}
			if(complete)
				handleComplete = 1;
		}
		
		model.addAttribute("templtIdMap", templtIdMap(true));
		
		model.addAttribute("companyIdMap", companyIdMap(true));
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(Integer.parseInt((String) map.get("resultCnt")));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchBox", searchBox);
		model.addAttribute("handleCheckBox", handleCheckBox);
		model.addAttribute("handleComplete", handleComplete);
		model.addAttribute("pageSj",pageSj);
		model.addAttribute("pageDesc",pageDesc);
		model.addAttribute("mode",mode);
		model.addAttribute("pageNavi", pageNavi);
		model.addAttribute("queryString", extractQueryString(request));
				
		return "approval/appr_CompDraftL";
	}

	/**
	 * 결재 문서를 보는 method
	 * 
	 * @param searchVO
	 * @param searchCommentVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/approval/approvalV.do")
	public String appView(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			@ModelAttribute("approvalCommentVO") ApprovalCommentVO searchCommentVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		// declare variables
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		Map appTypMap = useAppTypMap();
		
		//setting doc
		ApprovalVO vo = setCommonDoc(searchVO, model);
		
		// setting reader
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(searchVO);
		Map<String, ApprovalReaderVO> readerVOMap = setReaderVOMap(readerVOList);
		boolean check = false;
		
		//PL의 읽을 권한 검사 
		ApprovalVO voL = approvalService.viewApprovalLeader(searchVO);		 
		if(voL != null) {
			String[] leaderNo = voL.getLeaderNo().split(",");		
			for(int i=0; i < leaderNo.length; i++) {
				if(user.getNo() == Integer.parseInt(leaderNo[i])){
					check = true;
				}
			}
		}
		
		if(!(user.isAdmin() || user.isDocAdmin())) {			
			int docStatNo = Integer.parseInt(vo.getDocStat().substring(3));
			if(docStatNo == 4)//참조중일 결우 처리담당자도 읽을 수 있도록
				docStatNo++;
			docStatNo = 5; //상태 상관없이 결재라인 전체 조회하도록 수정 2013-02-25
			
			int startNo = 0;
			while(startNo <= docStatNo){
				String userNoDocStatMix = user.getNo() + "00" + startNo;
				if(readerVOMap.get(userNoDocStatMix)!=null)
					check = true;
				startNo++;
			}
			
			//참조중이면 읽을 수 있도록.
			String userNoDocStatMix = user.getNo() + referencingC.substring(3);
			if(readerVOMap.get(userNoDocStatMix)!=null)
				check = true;
			
			//접근 권한이 없음.
			if(!check) {
				return "error/authError";
			}
		}
		
		setReaders(model, readerVOList);
		setComment(searchCommentVO, model);
		setButton(model, user, vo, readerVOList, readerVOMap);
				
		//효력상실 판단
		if(vo.getNewAt()==0 && (decidedC.equals(vo.getDocStat()) || referencingC.equals(vo.getDocStat()) ) ) {
			ApprovalVO vo2 = new ApprovalVO();
			vo2.setParntId(vo.getDocId());
			vo2.setDocId(vo.getDocId());
			ApprovalVO childDoc = approvalService.getChildDoc(vo2);
			if(childDoc == null) { //기존 취소기안 방식. 전결시 삭제하므로 자식문서가 없으면 취소로 판단
				model.addAttribute("suspensionTyp","2");
			} else {
				if(childDoc.getReWriteTyp() == 1)
					model.addAttribute("suspensionTyp", "1");
				else if(childDoc.getReWriteTyp() == 2) // 2013-03-04 사장님 지시로 취소기안 방식을 삭제에서 수정기안같은 방식으로 변경하면서 추가
					model.addAttribute("suspensionTyp", "2");
				model.addAttribute("childDoc",childDoc);
			}
		}
		
		//수정기안일 경우
		if(vo.getReWriteTyp() !=0) {
			ApprovalVO vo2 = new ApprovalVO();
			vo2.setParntId(vo.getParntId());
			vo2.setDocId(vo.getParntId());
			ApprovalVO parentDoc = approvalService.getParentDoc(vo2);
			model.addAttribute("parentDoc", parentDoc);
		}
		setSpecificDoc(vo, model, Integer.parseInt(vo.getTempltId()), user);
		
		//update read date
		updateSrchDt(searchVO, user);
		
		//코멘트 비활성화 - 저장중인 문서. 
		if(vo.getDocStat().equals(writingC))
			model.addAttribute("commentView","N");
		
		model.addAttribute("appTyp", appTypMap.get(vo.getTempltId()));
		String queryString = extractQueryString(request);
		model.addAttribute("queryString", queryString);

		if(searchVO.getAjaxMode()==0)
			return "approval/appr_FormGeneralV";
		else
			return "approval/include/docContent";
	}

	/**
	 * @param request
	 * @return
	 */
	private String extractQueryString(HttpServletRequest request) {
		
		String queryString = request.getQueryString();
		if(queryString == null)
			return "";
		
		//docId값 없애주기.
		queryString =  queryString.replaceAll("(docId=)(.+?)&", "");
		queryString =  queryString.replaceAll("(ajaxMode=)(.+?)&", "");
		queryString =  queryString.replaceAll("(stat=)(.+?)&", "");

		if (!queryString.contains("&")) { // queryString에 parameter가 1개만 있는 경우는 위에서 삭제되지 않으므로 별도 처리
			queryString =  queryString.replaceAll("(docId=)(.+)", "");
			queryString =  queryString.replaceAll("(ajaxMode=)(.+)", "");
			queryString =  queryString.replaceAll("(stat=)(.+)", "");
		}
		
		return queryString;
	}

	
	/**
	 * 일괄결재하는 페이지로 이동
	 * 
	 * @param searchVO
	 * @param searchCommentVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/approval/AcceptBatch.do")
	public String AcceptBatch(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			@ModelAttribute("approvalCommentVO") ApprovalCommentVO searchCommentVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		// declare variables
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		Map appTypMap = useAppTypMap();
		ApprovalVO vo = null;
		searchVO.setMode("2");
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(1000);
		searchVO.setReaderNo(user.getNo());
		searchVO.setWriterNo(user.getNo());
		Map<String, Object> map = approvalService.selectApprovalList(searchVO);
		List<ApprovalVO> resultList =(List<ApprovalVO>) map.get("resultList");
		int cnt =  Integer.parseInt((String)map.get("resultCnt"));
		JSONArray docIdList = new JSONArray();
		int i = 0 ;
		for(ApprovalVO tempVO : resultList)	{
			docIdList.add(tempVO.getDocId());			
		}
		
		model.addAttribute("docIdList", docIdList.toString());
		model.addAttribute("queryString", extractQueryString(request));
		
		return "approval/appr_AcceptV_All";
	}
	
	@RequestMapping(value = "/approval/acceptBatchSelect.do")
	public String AcceptBatchSelect(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			@ModelAttribute("approvalCommentVO") ApprovalCommentVO searchCommentVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		// declare variables
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		Map appTypMap = useAppTypMap();
		ApprovalVO vo = null;
		searchVO.setMode("2");
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(1000);
		searchVO.setReaderNo(user.getNo());
		searchVO.setWriterNo(user.getNo());		
		
		String[] docIdListTemp = searchVO.getDocIdList();
		JSONArray docIdList = new JSONArray();
		if(docIdListTemp == null) {
			model.addAttribute("message","승인할 문서를 선택해주세요.");
			return "/error/messageError";
		}
		for(String str : docIdListTemp)	{
			docIdList.add(str);			
		}
		//바로 String으로 넣으면 JSP에서 "" 없어서 못받아서 JSONArray로 전달
		model.addAttribute("docIdList", docIdList.toString());
		model.addAttribute("queryString", extractQueryString(request));
		
		return "approval/appr_AcceptV_All";
	}
	
	
	//ajax승인 없이 의견첨부만 할 경우 이리로 이동. fkEappReader = -1 로 세팅됨.
	@RequestMapping(value="/approval/commentAjaxI.do")
	public String addKmsEappCommentAjax(
			HttpServletRequest request,
			ApprovalCommentVO kmsEappCommentVO,
			@ModelAttribute("searchVO") ApprovalCommentVO searchVO, SessionStatus status,
			@ModelAttribute("approvalVO") ApprovalVO approvalVO,
			ModelMap model)
			throws Exception {
		
		MemberVO user = (MemberVO)SessionUtil.getMember(request);
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(approvalVO);
		Iterator<ApprovalReaderVO> it = readerVOList.iterator();
		while(it.hasNext()) {
			ApprovalReaderVO readerVO = it.next();
			if(user.getNo()==readerVO.getReaderNo()) {
				kmsEappCommentVO.setAppTyp(readerVO.getAppTyp());
				break;
			}
		}
		if(kmsEappCommentVO.getAppTyp()==null)
			return "/error/authError";
		kmsEappCommentVO.setWriterNo(user.getNo());
		kmsEappCommentVO.setFkEappReader(-1);
		kmsEappCommentService.insertKmsEappComment(kmsEappCommentVO);
		kmsEappCommentVO.setAppTyp(null);	// 코멘트를 조회하기 전 코멘트 종류 파라메터를 초기화 한다. (의견 첨부만 조회되는 문제 수정)
		setComment(kmsEappCommentVO, model);
		
		ApprovalVO vo = approvalService.viewApprovalDoc(approvalVO);
		
		String[] readerArr = new String[readerVOList.size()];

		for(int i = 0; i < readerVOList.size(); i++) {
			if (!readerVOList.get(i).getReaderId().equals(user.getUserId()))
				readerArr[i] = readerVOList.get(i).getReaderId();
		}
		
		if (kmsEappCommentVO.getEappCt() != null && !"".equals(kmsEappCommentVO.getEappCt())) {
			noteService.sendNote(user.getNo(), readerArr, "[전자결재 의견 알림]\n" +
					"작성자 : " + user.getUserNm() + "\n" +
					"의견 : <b>" + kmsEappCommentVO.getEappCt() + "</b>\n\n" +
					"[문서정보]\n" +
					"제목 : " + vo.getSubject()+ "\n" +
					"기안자 : " + vo.getWriterNm() + "\n" +
					request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", "http://".length())) + "/approval/approvalV.do?docId=" + vo.getDocId());
		}
		
		return "/approval/include/commentView";        
	}
	
	/**
	 * @param searchVO
	 * @param commentVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 * 반려를 취소하는 method
	 * 실효성 의문으로 개발중단
	 */
	@RequestMapping("/approval/appRejectCancle.do")
	public String appRejectCancle(HttpServletRequest req, ModelMap model, 
			String docId)throws Exception {
		
		ApprovalVO approvalVO = new ApprovalVO();
		approvalVO.setDocId(docId);
		approvalVO = approvalService.viewApprovalDoc(approvalVO);
		/*
		 * 그냥 반려하고 재상신하면 업무상 처리가능
		 * 굳이 개발한다면 DOC_STAT 을 READER 테이블 STAT 승인 상태로 검사해서 알아내고
		 * 
		 * UPDATE TBL_EAPP_DOC
		 * SET NEW_AT = 0
		 * , DOC_STAT = #docStat#
		 * WHERE 
		 * DOC_ID = #docId# 
		 * 
		 * UPDATE TBL_EAPP_READER 
		 * SET STAT = 0
		 * WHERE 
		 * DOC_ID = #docId# 
		 * AND READER_NO = USER.GETNO()
		 * 
		 * UPDATE TBL_EAPP_COMMENT
		 * SET EAPP_CT = '시스템 반려취소'
		 * , STAT = 0
		 * WHERE
		 * DOC_ID = #docId#
		 * AND WRITER_NO = #userNo#
		*/
		return "redirect:/approval/approvalV.do?docId=" + docId;		
	}
	
	/**
	 * @param searchVO
	 * @param commentVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 *             승인하는 method
	 * 
	 */
	@RequestMapping(value = "/approval/appAccept.do")
	public String appAccept(@ModelAttribute("approvalVO") ApprovalVO searchVO,
			@ModelAttribute("approvalCommentVO") ApprovalCommentVO commentVO,
			@ModelAttribute("approvalReaderVO") ApprovalReaderVO readerVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		/*
		 * TODO : ㅇ 1)check validate ㅇ 2)update reader state ㅇ 3)if all the reader
		 * in same level accept the app, then update doc state
		 */
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		//Exception 루틴 피하는 negative bypass 부울값
		//반려 오버라이드 체크. 권한있으면 통과 0 권한없으면 예외 1
		boolean bypass = (user.isHmdev() || user.isEappadmin()) == false;  
		Map appTypMap = useAppTypMap();
		ApprovalVO vo = approvalService.viewApprovalDoc(searchVO);

		// 이미 반려난 문서는 상태변경 불가
		if (vo.getDocStat().equals(rejectC) && bypass)
			throw new Exception();
		// 전결난 문서는 상태변경 불가
		if (vo.getDocStat().equals(decidedC) && bypass)
			throw new Exception();
		// 참조중인 문서 반려 불가
		if (vo.getDocStat().equals(referencingC) && readerVO.getStat() == 2 && bypass)
			throw new Exception();
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(searchVO);
		Map<String, ApprovalReaderVO> readerVOMap = setReaderVOMap(readerVOList);

		// userNoDocStatMix example : userNo = 113 , docStat = APP001 -> userNoDocStatMix = 113001
		String userNoDocStatMix = user.getNo() + vo.getDocStat().substring(3);
		ApprovalReaderVO approvalReaderVO = new ApprovalReaderVO();

		// 결재할 라인이 아니거나, 이미 결재했을 경우 승인 할 수 없음.
		ApprovalReaderVO readerAcceptVO = readerVOMap.get(userNoDocStatMix);
		if (readerAcceptVO == null && bypass) //bypass의 경우 readerAcceptVO 객체가 null 일 수 있음
				throw new Exception();
		else if (readerAcceptVO != null && readerAcceptVO.getStat() != 0  && bypass)
			throw new Exception();

		// readerVO setting 후 update 실행
		readerVO.setAppTyp("APR" + vo.getDocStat().substring(3));
		readerVO.setReaderNo(user.getNo());
		approvalService.updateReaderStat(readerVO);

		// comment에 값 삽입
		// 1. update 된 reader table의 no를 불러온 후 삽입한다.
		int readerNo = approvalService.selectReaderNo(readerVO);
		if(readerNo == 0) { //bypass된 상태. 관리자 반려기능의 경우
			commentVO.setWriterNo(user.getNo());
			commentVO.setAppTyp("APR003");
			commentVO.setStat(readerVO.getStat());
		} else {
			commentVO.setFkEappReader(readerNo);
			commentVO.setWriterNo(user.getNo());
			commentVO.setAppTyp("APR" + vo.getDocStat().substring(3));
			commentVO.setStat(readerVO.getStat());
		}		
		kmsEappCommentService.insertKmsEappComment(commentVO);
		
		String[] readerArr = new String[readerVOList.size()];
		for(int i = 0; i < readerVOList.size(); i++) {
			if (!readerVOList.get(i).getReaderId().equals(user.getUserId()))
				readerArr[i] = readerVOList.get(i).getReaderId();
		}
		
		if (commentVO.getEappCt() != null && "".equals(commentVO.getEappCt()) == false) {
			noteService.sendNote(user.getNo(), readerArr, "[전자결재 의견 알림]\n" +
					"작성자 : " + user.getUserNm() + "\n" +
					"의견 : <b>" + commentVO.getEappCt() + "</b>\n\n" +
					"[문서정보]\n" +
					"제목 : " + vo.getSubject()+ "\n" +
					"기안자 : " + vo.getWriterNm() + "\n" +
					request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", "http://".length())) + "/approval/approvalV.do?docId=" + vo.getDocId());
		}

		// docStat 값 변경
		if (readerVO.getStat() == 2) {			
			//DOC_STAT = APP099 반려상태
			vo.setDocStat(rejectC);
			approvalService.updateDocStat(vo);
			//newAt 0으로 복구. 전결 승인시 1로 변경된 경우 관리자 반려 기능을 위함. 
			//newAt 업데이트는 이 기능에서만 함. newAt=0 은 반려와 문서재사용, newAt=1은 승인
			vo.setNewAt(0);
			approvalService.updateDocNewAt(vo);
			
			HashMap<Integer, Integer> userNoMap = new HashMap<Integer, Integer>();
			List<String> rejectors = new ArrayList<String>();
			//반려 확인자들에 값들 넣어줌
			Iterator<ApprovalReaderVO> it = readerVOList.iterator();
			int i= 0;
			while(it.hasNext()) {
				readerVO = (ApprovalReaderVO) it.next();
				//승인을 했거나, 작성자이거나, 반려자 일 경우 넣어줌.(한 번만)
				if( (readerVO.getStat()== 1 || readerVO.getAppTyp().equals(writerC) || readerVO.getReaderNo()==user.getNo() )
						&& userNoMap.get(readerVO.getReaderNo())==null ) {
					rejectors.add(readerVO.getReaderId());
					userNoMap.put(readerVO.getReaderNo(), readerVO.getReaderNo());
					i++;
				}				
			}
			
			approvalService.insertApprovalReaders(searchVO.getDocId(), rejectConfirmerC,rejectors);
			//반려자의 경우 반려확인 상태로 업데이트.
			ApprovalReaderVO rejector = new ApprovalReaderVO ();
			rejector.setStat(1);
			rejector.setAppTyp(rejectConfirmerC);
			rejector.setReaderNo(user.getNo());
			rejector.setDocId(searchVO.getDocId());
			approvalService.updateReaderStat(rejector);
		} //반려 끝		
		else { //승인일 경우
			// approval type 세팅
			readerVO.setAppTyp(readerPreFix + vo.getDocStat().substring(3));
			int unAppReaderByTyp = approvalService.countUnAppReaderByTyp(readerVO);
			// 해당 쿼리 결과가 0일경우
			if (unAppReaderByTyp == 0) {
				String docStat = "";
				// 검토 승인
				if (vo.getDocStat().equals(reviewingC)) {
					readerVO.setAppTyp(cooperatorC);
					//협조자 검사
					if (approvalService.countUnAppReaderByTyp(readerVO) == 0)
						docStat = decidingC; //전결으로 변경
					else
						docStat = cooperatingC; //협조로 변경
				}
				// 전결 승인
				else if (vo.getDocStat().equals(decidingC)) {
					readerVO.setAppTyp(referencerC);
					int unAppReferencerByTyp = approvalService.countUnAppReaderByTyp(readerVO);
					// 전결인 경우 참조자의 숫자에 따라 상태코드 변경
					if (unAppReferencerByTyp == 0)
						docStat = decidedC; //전결승인
					else
						docStat = referencingC; //참조상태로 변경
					
					//메일발송결재는 전결이 나면 메일을 발송
					if(vo.getTempltId().equals("6")) {
						MailVO mailVO = new MailVO();
						mailVO.setRefId(vo.getDocId());
						mailVO.setUserNo(vo.getWriterNo());
						mailVO.setMailSj(vo.getSubject());
						mailVO.setMailCn(vo.getContent());
						mailVO.setAtchFileId(vo.getAtchFileId());
						mailService.sendMailSMTPOut(mailVO);						
					}
					
					boolean isCancelDoc = false;
					// 문서재사용의 경우. 부모 docId != 자기 docId 조건 검사. 
					if (!vo.getDocId().equals(vo.getParntId()) ) {
						ApprovalVO parnt = new ApprovalVO();
						parnt.setDocId(vo.getParntId());
						parnt.setNewAt(0);
						approvalService.updateDocNewAt(parnt); //부모 doc의 newAt 값을 0 으로 바꿔줌
						
						if(vo.getTempltId().equals("2")){ //휴가문서 재사용의 경우 (WORK_STATE 입력은 다음 루틴에서 조건검사)		
							WorkStateVO workStateVO = new WorkStateVO();
							workStateVO.setDocId(vo.getParntId());
							workStateService.deleteWorkStateByDocId(workStateVO); //부모문서 휴가정보 삭제
							approvalService.deleteDocVac(vo.getParntId()); //부모문서 휴가문서정보 삭제
						}
						
						if (vo.getReWriteTyp()==1) { // 수정기안						
							// 수정기안 시 기존 문서의 docId를 갖고 있던 tbl_eapp_exp의 레코드들이 새 문서의 docId를 갖도록 update.
							// 단, 기존 문서가 상품매입인 경우(templtId==13)에 한함.
							ApprovalVO updateDocId = new ApprovalVO();
							updateDocId.setDocId(vo.getDocId());
							updateDocId.setParntId(vo.getParntId());
							approvalService.updateExpDocId(updateDocId);							
						} else { // ReWriteTyp == 2 취소기안
							isCancelDoc = true;
							/* 2013-03-04 사장님 지시로 수정기안 방식, 무삭제 보존 방식으로 변경
							// 취소기안의 문서 내용을 원본 문서 내용으로 업데이트 
							parnt.setContent(vo.getContent());
							approvalService.updateDocContent(parnt);
							// 취소기안 시 해당 문서를 삭제하고 부모 문서를 보여주는 것으로 마무리. 부모 문서를 지우진 않는다.
							approvalService.deleteDoc(vo.getDocId());							
							return "redirect:/approval/approvalV.do?docId=" + vo.getParntId();
							//return "redirect:/approval/approvalL.do?" + extractQueryString(request);							
							//return "redirect:/approval/approvalV.do?docId=" + vo.getDocId();
							*/							
						}
					}
					
					//전결이 났을 경우 처리담당자를 reader에 삽입해 줌.
					KmsApprovalTyp appTyp = new KmsApprovalTyp();
					appTyp.setTempltId(Integer.parseInt(vo.getTempltId()));
					appTyp = kmsApprovalTypService.selectKmsEappDoctyp(appTyp);
					List<String> handlers = CommonUtil.parseIdFromMixs2(appTyp.getHandlerMixs());
					if (handlers != null){
						approvalService.insertApprovalReaders(vo.getDocId(), handlerC,handlers);
						vo.setHandleStat(0);
						approvalService.updateHandleStat(vo);
					} else { //처리할 필요가 없음 -> handles Stat -> 3으로 변경
						vo.setHandleStat(3);
						approvalService.updateHandleStat(vo);
					}
					
					if(isCancelDoc == false){ //취소기안의 경우에는 0으로 유지
						//newAt값을 1로 설정 
						vo.setNewAt(1);
						approvalService.updateDocNewAt(vo);
					}
					
					//각 문서 종류에 따라 처리가 필요한 경우
					int templtId = Integer.parseInt(vo.getTempltId());
					switch (templtId) {
					case 1:	break; //일반결재
					case 2: //휴가신청서
						ApprovalVacVO vacVO = approvalService.viewApprovalVac(vo) ;
						WorkState workState = new WorkState();
						workState.setUserNo(vo.getWriterNo());
						workState.setWriterNo(vo.getWriterNo());
						workState.setWsTyp("V");
						workState.setWsBgnDe(vacVO.getStDt());
						workState.setWsEndDe(vacVO.getEdDt());
						workState.setWsBgnTm(vacVO.getStAmpm() > 1 ? "12" : "09"); //1이 오전 2가 오후부터 휴가
						workState.setWsEndTm(vacVO.getEdAmpm() > 1 ? "18" : "12"); //1이 오전 2가 오후부터 휴가
						workState.setStAmpm(vacVO.getStAmpm()); //1이 오전 2가 오후부터 휴가
						workState.setEdAmpm(vacVO.getEdAmpm()); //1이 오전 2가 오후부터 휴가
						workState.setWsPurpose(vo.getContent());
						
						MemberVO memberVO = new MemberVO();
						memberVO.setNo(vo.getWriterNo());
						memberVO = memberService.selectMemberBasic(memberVO);
						workState.setUserTelno(memberVO.getHomeTelno());
						workState.setUserMoblphonNo(memberVO.getMoblphonNo());
						workState.setWsPlace(vacVO.getWsPlace()); // 휴가장소 입력
						workState.setDocId(vacVO.getDocId()); // 휴가문서 번호 입력
						
						if (vo.getDocId().equals(vo.getParntId()) || //처음 상신문서 이거나
							(!vo.getDocId().equals(vo.getParntId()) && vo.getReWriteTyp()==1) ) { //문서재사용 수정기안인 경우에
							workStateService.insertWorkState(workState); //휴가정보 입력
						}
						break;
					case 3: //공문발송승인요청서
						approvalService.updateOfficialId(vo);
					/* 재고출고 관련 로직
					break;
					case 13 :
						JSONArray expenseArrayJ = (JSONArray)approvalService.selectExpenseList(searchVO);
						Iterator it = expenseArrayJ.iterator();
						while(it.hasNext())
						{
							JSONObject ob = (JSONObject)it.next();
							
							// 재고 출고
							Map<String, Object> stockParam = new HashMap<String, Object>();
							stockParam.put("status", 1);
							stockParam.put("tempSaverNo", -1);
							stockParam.put("tmpSaveStockList", ob.get("stockList").toString().split(","));
							
							String[] stockNoList = ob.get("stockList").toString().split(",");
							
							stockParam.put("userNo", user.getUserNo());
							stockParam.put("sDate", ob.get("expDt"));
							stockParam.put("reseller", "");
							stockParam.put("enduser", ob.get("companyNm"));
							stockParam.put("installPlace", "");
							stockParam.put("prjId", ob.get("prjId"));
							stockParam.put("note", "");
							
							stockService.updateStock(stockParam);
							
							for (int i = 0; i < stockNoList.length; i++) {
								stockParam.put("stockNo", stockNoList[i]);
								stockService.updateStockHistory(stockParam);
								stockService.insertStockHistory(stockParam);
							}
						}
					break;
					 */
					}					
				}//전결 승인 끝
				else { //검토, 전결 외 협조, 참조, 처리
					docStat = docStatC + "00" + (Integer.parseInt(vo.getDocStat().substring(3)) + 1);
				}
				vo.setDocStat(docStat);
				approvalService.updateDocStat(vo);
			}
		} //승인 끝
		if(searchVO.getAjaxMode() == 0) {
			return "redirect:/approval/approvalL.do?" + extractQueryString(request);
		} else
			return "/success";
	}	
	
	/**
	 * @param searchVO
	 * @param commentVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value = "/approval/updateSaveDocStat.do")
	public String updateSaveDocStat(@ModelAttribute("approvalVO") ApprovalVO searchVO,
			@ModelAttribute("approvalReaderVO") ApprovalReaderVO readerVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		ApprovalVO vo = approvalService.viewApprovalDoc(searchVO);
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(searchVO);
		// 저장된 문서가 아니면 오류 처리
		if (!vo.getDocStat().equals(writingC) || vo.getWriterNo() != user.getNo())
			throw new Exception();
		readerVO.setAppTyp(reviewerC);
		String docStat = reviewingC;
		int unAppReaderByTyp = approvalService.countUnAppReaderByTyp(readerVO);		
		// 해당 쿼리 결과가 0일경우
		if (unAppReaderByTyp == 0) {
			readerVO.setAppTyp(cooperatorC);
				if (approvalService.countUnAppReaderByTyp(readerVO) == 0)
					docStat = decidingC;// 전결중으로 변경
				else
					docStat = cooperatingC;
		}	
		searchVO.setDocStat(docStat);
		
		switch (Integer.parseInt(vo.getTempltId())) {
			case 10: case 11: case 12: case 13:{
				
				/* 프로젝트 미투입, 지결서 옵션 관련 체크 Start */
				JSONArray expenseArrayJ = (JSONArray)approvalService.selectExpenseList(searchVO);
				//저장문서 13상품매입 외 10업무경비 11자기개발비 경우 - 판관비 초과, 기간초과 검사하고 수정 
				if(vo.getTempltId().equals("13") == false) {
					approvalService.varifySaveDocApprovalExpense(expenseArrayJ);
				}
				
				Iterator it = expenseArrayJ.iterator();
				while(it.hasNext()) {
					JSONObject ob = (JSONObject)it.next();		        	
					String prjId = (String) ob.get("prjId");					
					ProjectVO searchProjectVO = new ProjectVO();
					searchProjectVO.setPrjId(prjId);
					ProjectVO projectVO = projectService.selectProjectView(searchProjectVO);
			
					if (projectVO.getManageCostRule().equals("Y")) {
						ProjectInputVO projectInputVO = new ProjectInputVO();
						projectInputVO.setPrjId(prjId);
						projectInputVO.setYear(Integer.toString(CalendarUtil.getYear()));
						List<EgovMap> prjInputList = projectService.selectProjectInput(projectInputVO);
						
						boolean isInputMember = false;
						for (int i = 0; i < prjInputList.size(); i++) {
							if (prjInputList.get(i) == null)
								continue;
							EgovMap egovMap = (EgovMap) prjInputList.get(i);
							
							if (egovMap.get("userNo").equals(vo.getWriterNo()) ) {
								int input = 0;
								input = Integer.parseInt(egovMap.get("month" + CalendarUtil.getMonth() + "List").toString());
								
								if (input == 1) {
									isInputMember = true;
									i = prjInputList.size();
									break;
								}
							}
						}						
						// 투입되지 않은 프로젝트에 지출결의서를 상신할 수 있는 권한 확인
						boolean isExpAuthUser = false;
						Map<String, Object> commandMap = new HashMap<String, Object>();
						commandMap.put("userNo", vo.getWriterNo());
						List<String> authList = adminAuthService.selectUserAuthList(commandMap);
						for(int j = 0; j < authList.size(); j++) {
							if ("expauth".equals(authList.get(j)) ) {
								isExpAuthUser = true;
								break;
							}
						}

						if (!isInputMember && !isExpAuthUser) {
							// 해당 프로젝트는 지출결의서 상신 옵션이 Y
							// (해당 프로젝트 투입 인력이 아니므로 지결서 상신 불가)
							model.addAttribute("message","프로젝트에 투입되지 않아 지출결의서를 상신할 수 없습니다.");
							return "/error/messageError";
						}
					} else if (projectVO.getManageCostRule().equals("N")) {
						// 해당 프로젝트는 지출결의서 상신 옵션이 N
						// (지결서 상신 불가)
						model.addAttribute("message","지출결의서 상신이 불가능한 프로젝트입니다.");
						return "/error/messageError";
					}
				}
				/* 프로젝트 미투입, 지결서 옵션 관련 체크 End */
				
				// 저장문서 외 모든 상태 문서는 반려난거 있어도 무조건 실패처리
				/* 법인카드 사용내역 중복 Start */
				int duplicateCardSpendCnt = approvalService.selectDuplicateCardSpendCnt(searchVO);
				if (duplicateCardSpendCnt > 0) {
					model.addAttribute("message", "같은 법인카드 사용내역으로 이미 상신된 문서가 있습니다.");
					return "/error/messageError";
				}
				/* 법인카드 사용내역 중복 End */
			}
		}
		
		switch (Integer.parseInt(vo.getTempltId())) {
			case 10: case 11: case 12: case 13: {
				JSONArray expenseArrayJ = (JSONArray)approvalService.selectExpenseList(searchVO);
				Iterator it = expenseArrayJ.iterator();
				while(it.hasNext()) {
					JSONObject ob = (JSONObject)it.next();
					// 회사결재(CP)이고 선지급이 아닐 경우 자금보고 건 INSERT
					if (ob.get("expSpendTyp").toString().equals("CP") && ob.get("payingDueDate") != null) {
						Map<String, Object> m = new HashMap<String, Object>();
						m.put("docId", ob.get("docId").toString());
						m.put("prjId", ob.get("prjId").toString());
						m.put("date", ob.get("payingDueDate").toString());
						m.put("expense", Long.parseLong(ob.get("expSpend").toString()));
						m.put("note", ob.get("expCt"));
						m.put("companyCd", ob.get("companyCd").toString());
						m.put("plan", "Y");
						m.put("type", "W");
						m.put("bankBook", "");
						m.put("account", "");		            	
						fundService.deleteFundByDocId(m); //기존 입력 삭제
						fundService.insertFund(m);
					}
					
					/* 재고출고 관련 로직
					if (ob.get("stockList") != null) {
						// 출고목록 임시 저장 (전결 시점에서 실제로 출고됨)
						Map<String, Object> stockParam = new HashMap<String, Object>();
						stockParam.put("status", 0);
						stockParam.put("tempSaverNo", searchVO.getWriterNo());
						stockParam.put("expId", ob.get("expId"));
						stockParam.put("tmpSaveStockList", ob.get("stockList").toString().split(","));
						stockService.updateStock(stockParam);
					}
					 */
				}
			}
		}
		
		approvalService.updateDocStat(searchVO);		
		//작성자의 조회 날짜를 변경.
		readerVO.setReaderNo(user.getNo());
		readerVO.setAppTyp(writerC);
		approvalService.updateReaderSrchDt(readerVO);
		return "redirect:/approval/approvalV.do?docId=" + readerVO.getDocId();
	}	
	
	/**
	 * @param searchVO
	 * @param commentVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 *  batch 처리하는 method
	 * 
	 */
	@RequestMapping(value = {"/approval/batchHandle.do","/approval/updateHandle.do","/support/updateHandle.do"})
	public String appBatchHandle(@ModelAttribute("approvalVO") ApprovalVO searchVO,
			@ModelAttribute("approvalCommentVO") ApprovalCommentVO commentVO,
			@ModelAttribute("approvalReaderVO") ApprovalReaderVO readerVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		/*
		 * TODO : 1)check validate ㅇ 2)update reader state ㅇ 3)if all the reader
		 * in same level accept the app, then update doc state
		 */
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		String handleDt = searchVO.getHandleDt();
		if(handleDt == null || handleDt.length() < 8) {
			handleDt = CalendarUtil.getToday();
		}
		String[] docIdList = searchVO.getDocIdList();
		//개별 업데이트일 경우. 
		if(docIdList == null) {
			docIdList = new String[] {searchVO.getDocId()};
		}
		
		for(String docId : docIdList) {
			if(docId == null || docId.length() < 5)
				break;

			ApprovalVO checkVO = new ApprovalVO ();
			checkVO.setDocId(docId);

			checkVO = approvalService.viewApprovalDoc(checkVO);
			if(checkVO.getHandleStat()==readerVO.getStat()) {
				String message;
				if(checkVO.getHandleStat()==1)
					message = "처리완료된 문서를 중복 처리완료 할 수 없습니다. 문서번호 : " + docId;
				else
					message = "처리취소된 문서를 중복 처리취소 할 수 없습니다. 문서번호 : " + docId;
				model.addAttribute("message",message);
				return "error/messageError";
			}

			List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(checkVO);
			boolean isHandler = false;
			for (int i = 0; i < readerVOList.size(); i++) {
				if (readerVOList.get(i).getReaderNo() == user.getNo() && "APR005".equals(readerVOList.get(i).getAppTyp())) {
					isHandler = true;
					break;
				}
			}
			if (!isHandler) {
				model.addAttribute("message", "본인이 처리담당자인 문서만 완료/취소 할 수 있습니다.");
				return "error/messageError";
			}
		}
			
		for(String docId : docIdList) {
			if(docId==null || docId.length()<5)
				break;
			ApprovalVO targetVO = new ApprovalVO ();
			targetVO.setDocId(docId);
			targetVO = approvalService.viewApprovalDoc(targetVO);
			/*
			if(targetVO.getHandleStat()==readerVO.getStat()) {
				String message;
				if(targetVO.getHandleStat()==1)
					message = "처리완료된 문서를 중복 처리완료 할 수 없습니다. 문서번호 : "+ docId;
				else
					message = "처리취소된 문서를 중복 처리취소 할 수 없습니다. 문서번호 : "+ docId;
				model.addAttribute("message",message);
				return "error/messageError";
			}
			*/
			targetVO.setHandleStat(readerVO.getStat());
			targetVO.setHandleDt(handleDt);
			approvalService.updateHandleStat(targetVO);
			
			readerVO.setDocId(docId);
			readerVO.setAppTyp(handlerC);
			readerVO.setReaderNo(user.getNo());
			approvalService.updateReaderStat(readerVO);
			
			int readerNo = approvalService.selectReaderNo(readerVO);
			commentVO.setDocId(docId);
			commentVO.setFkEappReader(readerNo);
			commentVO.setWriterNo(user.getNo());
			commentVO.setAppTyp(handlerC);
			commentVO.setStat(readerVO.getStat());
			kmsEappCommentService.insertKmsEappComment(commentVO);
		}
		String docId = docIdList[0]; 
		searchVO.setDocIdList(null);
		if("/approval/batchHandle.do".equals(request.getRequestURI()))
			return "redirect:/approval/approvalL.do?" + extractQueryString(request);
		else if("/approval/updateHandle.do".equals(request.getRequestURI()))
			//return "redirect:/approval/approvalV.do?docId=" + docId;
			return "redirect:/approval/approvalL.do?" + extractQueryString(request);
		else
			return "redirect:/support/selectRecruitArticle.do?docId=" + docId;
	}
	
	@RequestMapping(value = "/approval/cancleDraft.do")
	public String appCancleDraft(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		MemberVO user = (MemberVO) SessionUtil.getMember(request);

		ApprovalVO vo = approvalService.viewApprovalDoc(searchVO);
		List<ApprovalReaderVO> readerVOList = approvalService
				.viewApprovalReader(searchVO);
		if (user.getNo() != vo.getWriterNo())
			throw new Exception();
		int cancleDraft = 1;
		for (ApprovalReaderVO checkReaderVO : readerVOList) {
			if (checkReaderVO.getStat() != 0)
				cancleDraft = 0;
			else
				;
		}
		if (cancleDraft == 0)
			throw new Exception();

		// 권한 확인 종료. 기안 취소
		searchVO.setDocStat(writingC);
		approvalService.updateDocStat(searchVO);

		return "redirect:/approval/approvalV.do?docId=" + searchVO.getDocId();

	}
	
	@RequestMapping(value = "/approval/confirmReject.do")
	public String appConfirmReject(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			@ModelAttribute("approvalCommentVO") ApprovalCommentVO commentVO,
			@ModelAttribute("approvalReaderVO") ApprovalReaderVO readerVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		ApprovalVO vo = approvalService.viewApprovalDoc(searchVO);
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(searchVO);
		Map<String,ApprovalReaderVO> readerVoMap = setReaderVOMap(readerVOList);
		String userNoMix = user.getNo() + "099";
		//반려문서확인 대상자가 아니거나, 문서가 반려상태가 아니면 반려확인 할 수 없음.
		if (readerVoMap.get(userNoMix)==null || !vo.getDocStat().equals(rejectC))
			return "error/authError";
		
		//이미 반려확인을 한 경우 반려를 할 수 없음
		if(readerVoMap.get(userNoMix).getStat() != 0)
			throw new Exception();
		
		//반려
		readerVO.setReaderNo(user.getNo());
		readerVO.setStat(1);
		readerVO.setAppTyp(rejectConfirmerC);
		approvalService.updateReaderStat(readerVO);
		
		// comment에 값 삽입
		// 1. update 된 reader table의 no를 불러온 후
		// 삽입한다.
		int readerNo = approvalService.selectReaderNo(readerVO);
		commentVO.setFkEappReader(readerNo);
		commentVO.setWriterNo(user.getNo());
		commentVO.setAppTyp(rejectConfirmerC);
		commentVO.setStat(1);
		kmsEappCommentService.insertKmsEappComment(commentVO);
		
		if (vo.getWriterNo() == user.getNo()) {
			return "redirect:/approval/approvalV.do?docId=" + searchVO.getDocId();
		}		
		return "redirect:/approval/approvalL.do?" + extractQueryString(request);
	}
	
	// 새로 작성하는 문서 양식을 보여줌
	@RequestMapping(value = "/approval/appr_NewDraft.do")
	public String appNewDraft(
			@ModelAttribute("approvalVO") ApprovalVO searchVO, ModelMap model)
			throws Exception {

		List<KmsApprovalTypVO> appTypList = useAppTypList();
		model.addAttribute("appTypList", appTypList);
		return "approval/appr_NewDraft";
	}

	@RequestMapping(value = "/approval/approvalW.do")
	public String appWrite(@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			int templtId,
			ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		//인건비로 연봉 유추가 가능한 기능은 연봉관리자나 기능한정 특수 권한 부여자만 허용
		boolean auth = true;		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		
		switch (templtId) {
		case 1:{ //일반결재
			break;
		}
		case 2:{ //휴가신청서
			model.addAttribute("specificVO", new ApprovalVacVO()) ;
			break;
		}
		case 3:{ //공문발송 승인요청서
			model.addAttribute("specificVO", new ApprovalOfficialVO()) ;
			vo.setCodeId("KMS007");
			model.addAttribute("companyList", cmmUseService.selectCmmCodeDetail(vo));
			break;
		}
		case 4:{ //채용품의서
			model.addAttribute("specificVO", new ApprovalJobgVO()) ;
			vo.setCodeId("KMS002");
			List codeResult = cmmUseService.selectCmmCodeDetail(vo);
			model.addAttribute("educationList", codeResult);
			vo.setCodeId("KMS003");
			vo.setColumn1("Y");
			List rankList = cmmUseService.selectCmmCodeDetail(vo);
			model.addAttribute("rankList", rankList);
			vo.setCodeId("COM014");
			vo.setColumn1(null);
			codeResult = cmmUseService.selectCmmCodeDetail(vo);
			model.addAttribute("gendList", codeResult);
			break;
		}
		case 5:{ //휴일근무보고서
			model.addAttribute("specificVO", new ApprovalHolVO()) ;
			break;
		}
		case 10: case 11: case 12: case 13:{ //지결서 10 업무경비 11 자기개발비 12 부서운영비(사용안함) 13 상품매입
			
			String[] checkList = searchVO.getCheckList();
			JSONObject js = new JSONObject ();
			if(checkList == null || checkList.length == 0) {
				//세부내용 write10.jsp 에 들어가는 specificVOList 초기화			
				js.put("expSpend",0);
				js.put("expSpendTyp", "PP");
				if(templtId==12) { //12번 회식비 템플릿 사용안함
					JSONObject js2 = new JSONObject ();
					js2.put("expDiningSpend", 0);
					ArrayList al2 = new ArrayList<JSONObject>();
					al2.add(js2);
					js.put("expDiningList", al2);
				}
				ArrayList al = new ArrayList<JSONObject>();
				al.add(js);
				model.addAttribute("specificVOList", al);
			} else {//일단 서버 올리기 위해 복붙 // 작업중
				CardSpendVO cardSpendVO = new CardSpendVO();
				cardSpendVO.setCheckList(checkList);
				model.addAttribute("specificVOList", cardService.selectCardSpendForExp(cardSpendVO)) ;
			}
			
			vo.setCodeId("KMS007");
			List companyList = cmmUseService.selectCmmCodeDetail(vo);
			
			if(templtId==11) { //자기개발비
				SelfdevVO selfdevVO= new SelfdevVO();
				selfdevVO.setUserNo(user.getNo());
				selfdevVO.setIsSumOfBeforeApproved(1);
				selfdevVO.setYear(Integer.toString(CalendarUtil.getYear()) );
				model.addAttribute("selfdevVO",selfdevService.selectSelfdevUsrInfo(selfdevVO));
				ApprovalPresetVO searchPresetVO = new ApprovalPresetVO();
				searchPresetVO.setPresetTyp(selfdevPresetCode);
				model.addAttribute("presetPrjList", presetService.selectSpeicalPresetPrjList(searchPresetVO));
				model.addAttribute("presetPrjCnt", presetService.selectSpeicalPresetPrjCnt(searchPresetVO));
			} else if(templtId==12) {
				ApprovalPresetVO searchPresetVO = new ApprovalPresetVO();
				searchPresetVO.setPresetTyp(diningPresetCode);
				model.addAttribute("presetPrjList", presetService.selectSpeicalPresetPrjList(searchPresetVO));
				model.addAttribute("presetPrjCnt", presetService.selectSpeicalPresetPrjCnt(searchPresetVO));
			} else if(templtId==13) {
				model.addAttribute("presetPrjList", new JSONObject());
				model.addAttribute("presetPrjCnt", new JSONObject());
			} else {
				ApprovalPresetVO presetVO = new ApprovalPresetVO();
				presetVO.setUseAt("Y");
				presetVO.setPresetTyp("G");
				List presetList = presetService.selectPresetList(presetVO);
				model.addAttribute("presetList", presetList);
				model.addAttribute("presetPrjList", new JSONObject());
				model.addAttribute("presetPrjCnt", new JSONObject());
			}
			
			model.addAttribute("companyList", companyList);
			model.addAttribute("specificVO", new ApprovalExpenseVO());
			break; // 왜 break 없었는지 확인 필요
		}
		case 20:{ //종합매출보고서 
			if (templtId == 20 && user.isEapp20() == false && user.isSalaryadmin() == false) {
				auth = false;
			}
			model.addAttribute("specificVO", new JSONObject()) ;
			break;
		}
		case 21:{ //일반매출보고서
			model.addAttribute("specificVO", new JSONObject()) ;
			break;
		}
		case 22:{ //사업계획보고서
			List<ApprovalBusinessPlanVO> list = new ArrayList<ApprovalBusinessPlanVO>();
			for(int i =0; i<12;i++) {
				ApprovalBusinessPlanVO temp = new ApprovalBusinessPlanVO();
				temp.setYear(CalendarUtil.getYear());
				list.add(temp);
			}
			model.addAttribute("specificVOList", list) ;
			model.addAttribute("specificVO", new ApprovalBusinessPlanVO()) ;
			List<Integer> yearList = new ArrayList<Integer>();
			int year = CalendarUtil.getYear() - 5;
			for(int i = 0; i < 10 ; i++) {
				year++;
				yearList.add(year);
			}
			model.addAttribute("yearList",yearList);
			break;
		}
		case 23:{ //기초영업비신청서
			JSONObject js = new JSONObject();
			js.put("year", CalendarUtil.getYear());
			List<Integer> yearList = new ArrayList<Integer>();
			int year = CalendarUtil.getYear() - 5;
			for(int i = 0; i < 10 ; i++) {
				year++;
				yearList.add(year);
			}
			model.addAttribute("specificVO", js);
			model.addAttribute("yearList",yearList);
			break; // 왜 break 없었는지 확인 필요
		}
		case 24:{ //예산승인요청서
			if (templtId == 24 && user.isEapp24() == false && user.isSalaryadmin() == false) {
				auth = false;
			}
			model.addAttribute("specificVO", new JSONObject());
			break;
		}
		case 25:{ //사내매출보고서
			if (templtId == 25 && user.isEapp25() == false && user.isSalaryadmin() == false) {
				auth = false;
			}
			model.addAttribute("specificVO", new JSONObject());
			break;
		}
		case 26: case 27:{ //팀장경비신청서 //영업경비신청서
			JSONObject js = new JSONObject ();
			ArrayList al = new ArrayList<JSONObject>();
			js.put("expSpend",0);
			al.add(js);
			model.addAttribute("specificVOList", al);	
			model.addAttribute("specificVO", new ApprovalExpenseVO()); //10번
			model.addAttribute("specificVO", new JSONObject()); //25번
			break;
		}
		case 28:{ //매출이관보고서
			if (templtId == 28 && user.isEapp28() == false && user.isSalaryadmin() == false) {
				auth = false;
			}
			model.addAttribute("specificVO", new JSONObject());
			break;
		}
		
		}//switch end
		
		if(auth == false){
			model.addAttribute("message", "작성 권한이 없습니다.");
			return "error/messageError";
		}
		
		Map appTypMap = useAppTypMap();
		KmsApprovalTyp appTyp = (KmsApprovalTyp) appTypMap.get(searchVO.getTempltId());
		searchVO.setReferencerMixs(appTyp.getReferMixs());
		searchVO.setCooperatorMixs(appTyp.getCoopMixs());
		searchVO.setDeciderMix(appTyp.getDeciderMix()); //전결자 야근식대처럼 정해두려다가 오래걸려서 중단. 진행한다면 doctyp 테이블 수정, 관리자 수정기능 수정, VO 객체 수정, xml 쿼리 수정 
		model.addAttribute("appTyp", appTyp);
		model.addAttribute("mode", "W");
		return "approval/appr_FormGeneralW";
	}

	//양식 재사용 method : ReUse 
	@RequestMapping(value = "/approval/approvalRU.do")
	public String appReUse(@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		searchVO = approvalService.viewApprovalDoc(searchVO);				
		int tempttNo = Integer.parseInt(searchVO.getTempltId());
		
		// 문서재사용인 경우, model에 모드 부여
		searchVO.setMode("RU");
		setSpecificDoc(searchVO, model, tempttNo, user);

		// setting reader
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(searchVO);
		Map<String, ApprovalReaderVO> readerVOMap = setReaderVOMap(readerVOList);
		setReadersMix(searchVO, readerVOList);
		//searchVO.setReAppYn(1);
		//searchVO.setParntId(searchVO.getDocId());

		Map appTypMap = useAppTypMap();
		model.addAttribute("appTyp", appTypMap.get(searchVO.getTempltId()));
		model.addAttribute("approvalVO", searchVO);
		model.addAttribute("mode", "RU");
		return "approval/appr_FormGeneralW";
	}
	
	@RequestMapping(value = "/approval/modifySaveDoc.do")
	public String modifySaveDoc(@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		searchVO = approvalService.viewApprovalDoc(searchVO);

		/* 첨부파일 삭제 시 searchVO == null Start */
		if (searchVO == null) {
			searchVO = new ApprovalVO();
			searchVO.setTempltId(request.getParameter("templtId").toString());
			searchVO.setDocId(request.getParameter("docId").toString());
		}
		/* 첨부파일 삭제 시 searchVO == null End */
		
		int tempttNo = Integer.parseInt(searchVO.getTempltId());
		
		setSpecificDoc(searchVO, model, tempttNo, user);
				
		// setting reader
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(searchVO);
		Map<String, ApprovalReaderVO> readerVOMap = setReaderVOMap(readerVOList);
		setReadersMix(searchVO, readerVOList);
		//searchVO.setReAppYn(1);
		//searchVO.setParntId(searchVO.getDocId());
		if(searchVO.getReWriteTyp()>0) {
			searchVO.setReWriteYn(1);
			ApprovalVO vo2 = new ApprovalVO();
			vo2.setParntId(searchVO.getParntId());
			vo2.setDocId(searchVO.getParntId());
			ApprovalVO parentDoc = approvalService.getParentDoc(vo2);
			model.addAttribute("parentDoc", parentDoc);
		}
		
		Map appTypMap = useAppTypMap();
		model.addAttribute("appTyp", appTypMap.get(searchVO.getTempltId()));
		model.addAttribute("approvalVO", searchVO);
		model.addAttribute("mode", "M");
		return "approval/appr_FormGeneralW";
	}
		
	//재기안 method
	@RequestMapping(value = "/approval/approvalRW.do")
	public String appReWrite(@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		int reWriteTyp = searchVO.getReWriteTyp();
		if(reWriteTyp==0)
			reWriteTyp = 1;
		searchVO = approvalService.viewApprovalDoc(searchVO);
		//전결나지 않은 문서는 재기안할 수 없음.
		if(!referencingC.equals(searchVO.getDocStat()) && !decidedC.equals(searchVO.getDocStat()) ) {
			model.addAttribute("message", "전결이 나지 않은 문서는 수정기안할 수 없습니다.");
			return "error/messageError";
		}
		//효력상실 문서는 수정기안할 수 없음.
		else if(searchVO.getNewAt()==0) {
			model.addAttribute("message", "전결이 나지 않은 문서는 수정기안할 수 없습니다.");
			return "error/messageError";
		}
		// 매출이관 보고서의 수정기안인 경우, 전결 승인 완료일의 다음날부터 수정기안을 상신할 수 없도록.
		if ("28".equals(searchVO.getTempltId())) {
			ApprovalCommentVO tmpCommentVO = new ApprovalCommentVO();
			
			// 전결자의 댓글 정보 가져오기
			tmpCommentVO.setDocId(searchVO.getDocId());
			tmpCommentVO.setAppTyp(deciderC);
			List<ApprovalCommentVO> kmsEappCommentList = kmsEappCommentService.selectKmsEappCommentList(tmpCommentVO);
			if (kmsEappCommentList.size() > 0) {
				tmpCommentVO = kmsEappCommentList.get(0);
				
				SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
				String decideDate = tmpCommentVO.getWtDt().replace(".", "").substring(0, 8);
				String today = simple.format(new Date());
				
				// 전결일자가 오늘인 경우
				if (decideDate.equals(today)) {
					model.addAttribute("message", "매출이관보고서 수정기안은 전결 승인 완료일 다음날 부터 가능합니다.\\n"
												+ "선택하신 매출이관보고서는 금일 전결 승인 완료되어\\n" 
												+ "금일은 수정기안이 불가하므로 명일 수정기안 올려주시기 바랍니다.\\n"
												+ "(이유 : 전결 승인 완료일 다음날 비용집계가 되기 때문)");
					return "error/messageError";
				}
			} else {
				model.addAttribute("message", "전결이 나지 않은 문서는 수정기안할 수 없습니다.");
				return "error/messageError";
			}
			
		}
		searchVO.setReWriteTyp(reWriteTyp);
				
		int templtNo = Integer.parseInt(searchVO.getTempltId());
		// 문서재사용인 경우, model에 모드 부여
		searchVO.setMode("RW");
		setSpecificDoc(searchVO, model, templtNo, user);

		// setting reader
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(searchVO);
		Map<String, ApprovalReaderVO> readerVOMap = setReaderVOMap(readerVOList);
		setReadersMix(searchVO, readerVOList);
		searchVO.setReWriteYn(1);
		searchVO.setParntId(searchVO.getDocId());

		Map appTypMap = useAppTypMap();
		model.addAttribute("appTyp", appTypMap.get(searchVO.getTempltId()));
		model.addAttribute("approvalVO", searchVO);
		model.addAttribute("mode", "RW");
		model.addAttribute("commentView", "N");
		return "approval/appr_FormGeneralW";
	}
	
	
	
	/**
	 * @param multiRequest
	 * @param readerVO
	 * @param approvalVO
	 * @param kmsEappCommentVO
	 * @param approvalVacVO
	 * @param approvalOfficialVO
	 * @param approvalJobgVO
	 * @param approvalExpenseVO
	 * @param approvalHolVO
	 * @param approvalBusinnesPlanVO
	 * @param jsonInputString
	 * @param request
	 * @param response
	 * @param model
	 * @param save
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/approval/approvalI.do")
	public String appInsert(final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("approvalReaderVO") ApprovalReaderVO readerVO,
			@ModelAttribute("approvalVO") ApprovalVO approvalVO,
			ApprovalComment kmsEappCommentVO,
			ApprovalVacVO approvalVacVO,
			ApprovalOfficialVO approvalOfficialVO,
			ApprovalJobgVO approvalJobgVO,
			ApprovalExpenseVO approvalExpenseVO,
			ApprovalHolVO approvalHolVO,
			ApprovalBusinessPlanVO approvalBusinnesPlanVO,
			String jsonInputString,
			HttpServletRequest request,
			HttpServletResponse response, ModelMap model, int save)
			throws Exception {

		// TODO: verifying the contents and receiver

		/*
		 * TODO: insert common page 
		 * 1) parse the receiver 2) insert doc 3) insert receiver 
		 */
		Boolean insertFail = false;
		Boolean changeDecider = false;		
		String checkDeciderCode = "FF";
		String checkDeciderCode2 = "F"; //법인카드 상신 오류코드
		String checkTeamExpCode = "F"; //팀장경비 신청서 오류코드
		String checkDeciderCode3 = "F"; //매출액 1,000만원 이상 점검코드

		MemberVO user = SessionUtil.getMember(multiRequest);
		approvalVO.setWriterId(user.getUserId());
		// TODO : check validate id
		List<String> writer = CommonUtil.makeValidIdListArray(approvalVO.getWriterId());
		List<String> reviewers = CommonUtil.makeValidIdListArray(approvalVO.getReviewerMixs());
		List<String> cooperators = CommonUtil.makeValidIdListArray(approvalVO.getCooperatorMixs());
		List<String> decider = CommonUtil.makeValidIdListArray(approvalVO.getDeciderMix());
		List<String> referencers = CommonUtil.makeValidIdListArray(approvalVO.getReferencerMixs());
				
		//양식 재사용 시 파일 핸들링
		/*
		if(approvalVO.getReWriteFileInfo()!=null  && !"".equals(approvalVO.getReWriteFileInfo()) ) {
			String[] fileSnList =approvalVO.getReWriteFileInfo().split(",");
			for(String fileSn : fileSnList){
				FileVO searchFile = new FileVO();
				String originalfileId = approvalVO.getAtchFileId();
				searchFile.setAtchFileId(originalfileId);
				searchFile.setFileSn(fileSn);
				searchFile = fileMngService.selectFileInf(searchFile);
				//새로 첨부한 파일이 없을경우, master정보를 삽입하는 method를 콜해준다.
				if(atchFileId == null || "".equals(atchFileId) ) {
					 
					atchFileId = fileIdgenService.getNextStringId();
					searchFile.setAtchFileId(atchFileId);
					fileMngService.insertFileInf(searchFile);
				} else {
					FileVO searchFile2 = new FileVO();
					searchFile2.setAtchFileId(atchFileId);
					int nextSn = fileMngService.getMaxFileSN(searchFile2);
					searchFile.setAtchFileId(atchFileId);
					searchFile.setFileSn(Integer.toString(nextSn));
					fileMngService.insertFileInf(searchFile);
					
				}
			}
		}
		*/
		
		String docId = "";
		//save==0 상신 save==1 문서 저장 (최초상신)
		//save==2 저장문서 업데이트 save==3 저장 문서 업데이트 & 상신 (저장문서 수정)
		if(save==2 || save==3) { //수정이므로 기존문서 삭제
			docId = approvalVO.getDocId();
			approvalService.deleteDoc(docId);
		} else //최초상신
			docId = idgenService.getNextStringId();
		
		//외부 메일 전송시 외부메일주소 입력
		String emailMixs = approvalVO.getEmailMixs();
		if(emailMixs != null && emailMixs.equals("") == false){
			Mail mail = new Mail();
			mail.setRefId(docId);
			mail.setEmailAddr(emailMixs);			
			mailService.insertMailOut(mail);
		}
		
		String atchFileId;
		
		if(save == 2 || save == 3) { //save==2 저장문서 업데이트 save==3 저장 문서 업데이트 & 상신
			atchFileId = approvalVO.getAtchFileId();
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				if (atchFileId == null || "".equals(atchFileId) ) {
					List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					approvalVO.setAtchFileId(atchFileId);
				} else {
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileMngService.getMaxFileSN(fvo);
					List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
					fileMngService.updateFileInfs(_result);
				}
			}
		} else { //save==0 상신  save==1 문서 저장
			List<FileVO> result = null;
			atchFileId = "";
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "APP_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
		}
		approvalVO.setDocId(docId);
		approvalVO.setAtchFileId(atchFileId);
		
		//공통문서 삽입.
		if (save == 1 || save == 2)
			approvalVO.setDocStat(writingC);
		else if (!reviewers.isEmpty()) 
			approvalVO.setDocStat(reviewingC);
		else if (!cooperators.isEmpty()) 
			approvalVO.setDocStat(cooperatingC);
		else
			approvalVO.setDocStat(decidingC);

		// 전결자까지 작성이 안되어 있을 경우 오류
		if (decider.isEmpty())
			throw new Exception();

		// 재기안이 on되있지 않을 경우 docId를 parntId에 넣어줌
		if (approvalVO.getReWriteYn() != 1)
			approvalVO.setParntId(approvalVO.getDocId());
		
		int templtId = Integer.parseInt(approvalVO.getTempltId());

		String resultCode = "";
		String redirectUrl = "";

		switch (templtId) {
		case 5:
			approvalHolVO.setDocId(docId);
			approvalHolVO.setUserNo(user.getUserNo());
			resultCode = approvalService.checkApprovalHol(approvalHolVO);

			redirectUrl = "/approval/approvalW.do?templtId=" + templtId;
			if (resultCode.equals("Y")) {
				model.addAttribute("message2", "프로젝트에 투입되지 않아 휴일근무보고서를 상신할 수 없습니다. (작성하신 문서는 저장됩니다.)");
				approvalVO.setDocStat(writingC);
				insertFail = true;
			} else if (resultCode.equals("N")) {
				model.addAttribute("message2", "휴일근무보고서 상신이 불가능한 프로젝트입니다. (작성하신 문서는 저장됩니다.)");
				approvalVO.setDocStat(writingC);
				insertFail = true;
			}
			break;
			
		case 10: case 11: case 12: case 13 :
			approvalExpenseVO.setTempltId(templtId);
			approvalExpenseVO.setDocId(docId);
			approvalExpenseVO.setExpenseArrayJ(jsonInputString);
			approvalExpenseVO.setWriterNo(user.getUserNo());
			resultCode = approvalService.checkApprovalExpense(approvalExpenseVO);
			
			redirectUrl = "/approval/approvalW.do?templtId=" + templtId;
			if (resultCode.equals("Y")) {
				model.addAttribute("message2", "프로젝트에 투입되지 않아 지출결의서를 상신할 수 없습니다. (작성하신 문서는 저장됩니다.)");
				approvalVO.setDocStat(writingC);
				insertFail = true;
			} else if (resultCode.equals("N")) {
				model.addAttribute("message2", "지출결의서 상신이 불가능한 프로젝트입니다. (작성하신 문서는 저장됩니다.)");
				approvalVO.setDocStat(writingC);
				insertFail = true;
			}
			break;					
		}
		
		//문서재사용의 경우 재사용회수 증가
		approvalService.incrementReUseCnt(approvalVO.getDocId()); 
		//TBL_EAPP_DOC에 입력
		approvalService.insertApprovalCmm(approvalVO); 
		//기안자 정보 삽입
		approvalService.insertApprovalReaders(docId, writerC, writer);
		//입력시 입력자에 대한 읽은 시간 업데이트.
		updateSrchDt(approvalVO, user);
		
		switch (templtId) {
		case 1: //일반결재
			break;
		case 2: //휴가신청서
			approvalVacVO.setDocId(docId);
			approvalVacVO.setWriterNo(user.getStringNo());
			approvalService.insertApprovalVac(approvalVacVO);
			break;
		case 3: //공문발송 승인요청서
			approvalOfficialVO.setDocId(docId);
			approvalService.insertApprovalOfficial(approvalOfficialVO);
			break;
		case 4: //채용품의서
			approvalJobgVO.setDocId(docId);
			approvalService.insertApprovalJobg(approvalJobgVO);
			break;
		case 5: //휴일근무 보고서
			approvalHolVO.setDocId(docId);
			approvalHolVO.setUserNo(user.getUserNo());
			checkDeciderCode = approvalService.insertApprovalHol(approvalHolVO);
//			if (!checkDeciderCode.equals("FF")) {
//				String exceedDecider =approvalService.getExceedDecider(null);
//				reviewers.remove(exceedDecider);
//				cooperators.remove(exceedDecider);
//				referencers.remove(exceedDecider);
//				//기전결자가 판관비 초과 전결자와 일치할 시
//				if(decider.get(0).equals(exceedDecider))
//					;
//				else {
//					reviewers.add(decider.get(0));
//					if (!insertFail)
//						approvalVO.setDocStat(reviewingC);
//					approvalService.updateDocStat(approvalVO);
//					decider.set(0, exceedDecider);
//				}
//			}
			break;
		case 10: case 11: case 12: case 13 : //지출결의서 10업무경비 11자기개발비 12부서운영비(미사용) 13상품매입
			approvalExpenseVO.setTempltId(templtId);
			approvalExpenseVO.setDocId(docId);
			approvalExpenseVO.setExpenseArrayJ(jsonInputString);
			approvalExpenseVO.setSave(save);
			checkDeciderCode = approvalService.insertApprovalExpense(approvalExpenseVO);
			checkDeciderCode2 = checkDeciderCode.substring(2,3);
			checkDeciderCode = checkDeciderCode.substring(0,2);
//			if(!checkDeciderCode.equals("FF")) {
//				String exceedDecider = approvalService.getExceedDecider(null);
//				reviewers.remove(exceedDecider);
//				cooperators.remove(exceedDecider);
//				referencers.remove(exceedDecider);
//				//기전결자가 판관비 초과 전결자와 일치할 시
//				if(decider.get(0).equals(exceedDecider))
//					;
//				else {
//					reviewers.add(decider.get(0));
//					if (!insertFail)
//						if (save == 0 || save == 2)
//							approvalVO.setDocStat(reviewingC);
//						else if (save == 1 || save == 3)
//							approvalVO.setDocStat(writingC);
//					
//					approvalService.updateDocStat(approvalVO);
//					decider.set(0, exceedDecider);
//				}
//			}
			break;
		case 20: //종합매출보고서
			JSONObject totalSalesJ = (JSONObject) JSONValue.parseWithException(CommonUtil.unescape(jsonInputString));
			totalSalesJ.put("templtId", templtId);
			totalSalesJ.put("docId", docId);
			checkDeciderCode3 = approvalService.insertApprovalTotalSales(totalSalesJ);
			// 20140731, 매출액 1,000만원 이상인 경우 전결자 변경 로직 적용.
			if(!checkDeciderCode3.equals("F")) {
				String exceedDecider = approvalService.getExceedDecider(null);
				reviewers.remove(exceedDecider);
				cooperators.remove(exceedDecider);
				referencers.remove(exceedDecider);
				//기전결자가 대표이사와 일치할 시
				if(decider.get(0).equals(exceedDecider))
					checkDeciderCode3 = "F";
				else {
					reviewers.add(decider.get(0));
					if (!insertFail)
						if (save == 0 || save == 2)
							approvalVO.setDocStat(reviewingC);
						else if (save == 1 || save == 3)
							approvalVO.setDocStat(writingC);
					
					approvalService.updateDocStat(approvalVO);
					decider.set(0, exceedDecider);
				}
			}
			
			break;		
		case 21: //일반매출보고서
			if (!insertFail){
				JSONObject generalSalesJ = (JSONObject) JSONValue.parseWithException(CommonUtil.unescape(jsonInputString));
				generalSalesJ.put("templtId", templtId);
				generalSalesJ.put("docId", docId);
				checkDeciderCode3 = approvalService.insertApprovalGeneralSales(generalSalesJ);
				// 20140731, 매출액 1,000만원 이상인 경우 전결자 변경 로직 적용.
				if(!checkDeciderCode3.equals("F")) {
					String exceedDecider = approvalService.getExceedDecider(null);
					reviewers.remove(exceedDecider);
					cooperators.remove(exceedDecider);
					referencers.remove(exceedDecider);
					//기전결자가 대표이사와 일치할 시
					if(decider.get(0).equals(exceedDecider))
						checkDeciderCode3 = "F";
					else {
						reviewers.add(decider.get(0));
						if (!insertFail)
							if (save == 0 || save == 2)
								approvalVO.setDocStat(reviewingC);
							else if (save == 1 || save == 3)
								approvalVO.setDocStat(writingC);
						
						approvalService.updateDocStat(approvalVO);
						decider.set(0, exceedDecider);
					}
				}
			}
			break;
		case 22: //사업계획보고서
			approvalBusinnesPlanVO.setDocId(docId);
			approvalService.insertApprovalBusinessPlan(approvalBusinnesPlanVO);
			break;
		case 23: { //기초영업비신청서
			JSONObject budgetAllocateJ = (JSONObject) JSONValue.parseWithException(CommonUtil.unescape(jsonInputString));
			budgetAllocateJ.put("docId",docId);
			approvalService.insertBudgetAllocate(budgetAllocateJ);
			break;
		}
		case 24: { //예산승인요청서 
			JSONObject budgetAllocateJ = (JSONObject) JSONValue.parseWithException(CommonUtil.unescape(jsonInputString));
			budgetAllocateJ.put("templtId", templtId);
			budgetAllocateJ.put("docId", docId);
			approvalService.insertBudgetAllocate2(budgetAllocateJ);
			break;
		}
		case 25: { //사내매출 보고서
			JSONObject salesInJ = (JSONObject) JSONValue.parseWithException(CommonUtil.unescape(jsonInputString));
			salesInJ.put("templtId", templtId);
			salesInJ.put("docId", docId);
			approvalService.insertApprovalSalesIn(salesInJ);
			break;
		}
		case 26: { //팀장경비 신청서
			approvalExpenseVO.setDocId(docId);
			approvalExpenseVO.setExpenseArrayJ(jsonInputString);			
			checkTeamExpCode = approvalService.insertApprovalTeamExp(approvalExpenseVO);
			break;
		}
		case 27: { //영업경비 신청서
			approvalExpenseVO.setDocId(docId);
			approvalExpenseVO.setExpenseArrayJ(jsonInputString);			
			approvalService.insertApprovalSalesExp(approvalExpenseVO);
			//approvalService.insertApprovalSalesExp(salesInJ);
			break;
		}
		case 28: { //매출이관 보고서
			JSONObject salesTransJ = (JSONObject) JSONValue.parseWithException(CommonUtil.unescape(jsonInputString));
			salesTransJ.put("templtId", templtId);
			salesTransJ.put("docId", docId);
			approvalService.insertApprovalSalesTrans(salesTransJ);
			break;
		}
		}
		
		// 결재자 정보 삽입	
		if (reviewers!=null)
			approvalService.insertApprovalReaders(docId, reviewerC,reviewers);
		if (cooperators!=null)
			approvalService.insertApprovalReaders(docId, cooperatorC,cooperators);
			approvalService.insertApprovalReaders(docId, deciderC, decider);
		if (referencers!=null)
			approvalService.insertApprovalReaders(docId, referencerC,referencers);
		//기안 댓글 삽입
		readerVO.setAppTyp(writerC);
		readerVO.setReaderNo(user.getNo());
		readerVO.setDocId(docId);
		int readerNo = approvalService.selectReaderNo(readerVO);
		kmsEappCommentVO.setWriterNo(user.getNo());
		kmsEappCommentVO.setFkEappReader(readerNo);
		kmsEappCommentVO.setStat(1);
		kmsEappCommentVO.setDocId(docId);
		kmsEappCommentVO.setAppTyp(writerC);
		kmsEappCommentService.insertKmsEappComment(kmsEappCommentVO);
		
		redirectUrl = "/approval/approvalV.do?docId=" + docId + "&mode=3";
		model.addAttribute("redirectUrl", redirectUrl); 
		
		//팀장경비 신청서 입력 오류
		if(templtId == 26 && checkTeamExpCode.equals("T") == false){        	
			approvalService.deleteDoc(docId); //먼저 저장된 공통문서 삭제
			model.addAttribute("message", checkTeamExpCode);
			return "error/messageError";
		}
		//에러 메세지 작성 후 모델에 삽입
		String message = "";
//		if (checkDeciderCode.equals("TT"))
//			message = "판관비 초과 및 지출일자 지연(지출일로부터 일주일 초과)으로 전결자가 자동으로 변경됩니다.";
//		else if (checkDeciderCode.equals("TF"))
//			message = "판관비가 초과되었습니다. 전결자가 자동으로 변경됩니다.";
//		else if (checkDeciderCode.equals("FT"))
//			message = "지출일로부터 일주일이 초과되었습니다. 전결자가 자동으로 변경됩니다.";
		if(checkDeciderCode2.equals("T")) //법인카드 상신 오류코드
			message = message + " 이미 상신된 법인카드 사용내역은 제외됩니다.";
		if(!checkDeciderCode3.equals("F"))
			message = "매출액 1,000만원 이상인 경우 전결자가 대표이사로 변경됩니다.";
		model.addAttribute("message", message);
		
		if (insertFail || message.length() > 0) {        	
			return "error/messageRedirect";
		} else { //정상인 경우
			//return redirect: 로 넘기면 model 에 붙은 값이 url 에 다 붙어서 url이 엄청 길어지는 문제로 인해 제거처리
			model.addAttribute("redirectUrl", null);
			return "redirect:"+ redirectUrl;
		}
	}
		
	
	@RequestMapping(value = "/approval/deleteSaveDoc.do")
	public String appDelete(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request,
			HttpServletResponse response, ModelMap model)
			throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);
		ApprovalVO vo = approvalService.viewApprovalDoc(searchVO);
		//작성자나 관리자가 아니거나, 작성중 || 반려중이 아니면 지울 수 없음.
		if(!(user.isAdmin() || vo.getWriterNo()==user.getNo()) || !(vo.getDocStat().equals(writingC) || vo.getDocStat().equals(rejectC)))
			throw new Exception();
		int templtId = Integer.parseInt(vo.getTempltId());
		approvalService.deleteDoc(searchVO.getDocId());
		String queryString = extractQueryString(request);
		return "redirect:/approval/approvalL.do?" + queryString;
	}
	
	
	
	@RequestMapping(value = "/approval/deleteSaveDocs.do")
	public String appDeleteDocs(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request,
			HttpServletResponse response, ModelMap model)
			throws Exception {
		
		MemberVO user = SessionUtil.getMember(request);

		if (searchVO.getCheckList() != null)
		{
			for (String docId : searchVO.getCheckList()) {
				ApprovalVO vo = new ApprovalVO();
				vo.setDocId(docId);
				vo = approvalService.viewApprovalDoc(vo);
				
				//작성자나 관리자가 아니거나, 작성중 || 반려중이 아니면 지울 수 없음.
				if(!(user.isAdmin() || vo.getWriterNo()==user.getNo()) || !(vo.getDocStat().equals(writingC) || vo.getDocStat().equals(rejectC)))
					continue;
				
				approvalService.deleteDoc(docId);
			}
		}
		
		String queryString = extractQueryString(request);
		return "redirect:/approval/approvalL.do?" + queryString;
	}
	
	

	/*
	 * controller 내부에서 사용하는 함수들.ㄹ
	 */

	/**
	 * 사용중인 전자결재의 유형별로 id를 키값으로 하는 맵 반환.
	 * 
	 * @return
	 * @throws Exception
	 */

	private Map useAppTypMap() throws Exception {

		KmsApprovalTypVO searchVO = new KmsApprovalTypVO();
		searchVO.setUseYn(1);
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(1000);
		List<KmsApprovalTypVO> voList = kmsApprovalTypService.selectKmsEappDoctypList(searchVO);
		Map<String, KmsApprovalTypVO> result = new HashMap();
		for (KmsApprovalTypVO vo : voList) {
			result.put(vo.getTempltId().toString(), vo);
		}
		return result;
	}

	/**
	 * 사용중인 approval type의 id를 키값으로 하는 맵 반환.
	 * 
	 * @return
	 * @throws Exception
	 */

	private Map<String, String> templtIdMap(boolean includeAll) throws Exception {

		KmsApprovalTypVO searchVO = new KmsApprovalTypVO();
		searchVO.setUseYn(1);
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(1000);
		List<KmsApprovalTypVO> voList = kmsApprovalTypService.selectKmsEappDoctypList(searchVO);
		Map<String, String> result = new TreeMap<String, String>();
		if(includeAll)
			result.put("","모든 결재양식");
		for (KmsApprovalTypVO vo : voList) {
			result.put(vo.getTempltId().toString(), vo.getDocSj());
		}
		return result;
	}
	
	
	
	/**
	 *  회사구분의 id를 키값으로 하는 맵 반환.
	 * 
	 * @return
	 * @throws Exception
	 */

	private Map<String, String> companyIdMap(boolean includeAll) throws Exception {

		KmsApprovalTypVO searchVO = new KmsApprovalTypVO();
		List<KmsApprovalTypVO> voList = kmsApprovalTypService.selectKmsCompanyList(searchVO);
		Map<String, String> result = new TreeMap<String, String>();
		if(includeAll)
			result.put("","회사 전체");
		for (KmsApprovalTypVO vo : voList) {
			result.put(vo.getCompanyId(), vo.getCompanyNm());
		}
		return result;
	}
	
	
	private List<KmsApprovalTypVO> useAppTypList() throws Exception {

		KmsApprovalTypVO searchVO = new KmsApprovalTypVO();
		searchVO.setUseYn(1);
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(1000);
		List<KmsApprovalTypVO> voList = kmsApprovalTypService.selectKmsEappDoctypList(searchVO);
		return voList;
	}

	/**
	 * readerVOList를 받아, 각 readerList를 model에 add 시켜주는 method writerList
	 * reviewerList cooperatorList deciderList referencerList 를 add 해줌.
	 * 
	 * @param model
	 * @param readerVOList
	 */
	private void setReaders(ModelMap model, List<ApprovalReaderVO> readerVOList) {
		List<ApprovalReaderVO> writerList = new ArrayList<ApprovalReaderVO>();
		List<ApprovalReaderVO> reviewerList = new ArrayList<ApprovalReaderVO>();
		List<ApprovalReaderVO> cooperatorList = new ArrayList<ApprovalReaderVO>();
		List<ApprovalReaderVO> deciderList = new ArrayList<ApprovalReaderVO>();
		List<ApprovalReaderVO> referencerList = new ArrayList<ApprovalReaderVO>();
		List<ApprovalReaderVO> handlerList = new ArrayList<ApprovalReaderVO>();
		for (ApprovalReaderVO readerVO : readerVOList) {
			if (writerC.equals(readerVO.getAppTyp()))
				writerList.add(readerVO);

			else if (reviewerC.equals(readerVO.getAppTyp()))
				reviewerList.add(readerVO);

			else if (cooperatorC.equals(readerVO.getAppTyp()))
				cooperatorList.add(readerVO);

			else if (deciderC.equals(readerVO.getAppTyp()))
				deciderList.add(readerVO);

			else if (referencerC.equals(readerVO.getAppTyp()))
				referencerList.add(readerVO);
			
			else if (handlerC.equals(readerVO.getAppTyp()))
				handlerList.add(readerVO);

		}
		model.addAttribute("writerList", writerList);
		model.addAttribute("reviewerList", reviewerList);
		model.addAttribute("cooperatorList", cooperatorList);
		model.addAttribute("deciderList", deciderList);
		model.addAttribute("referencerList", referencerList);
		model.addAttribute("handlerList", handlerList);
	}

	/**
	 * readerVOList를 받아 approvalVO 에 각 readerMix값을 설정해줌
	 * 
	 * @param approvalVO
	 * @param readerVOList
	 * @throws IdMixInputException
	 */
	private void setReadersMix(ApprovalVO approvalVO,
			List<ApprovalReaderVO> readerVOList) throws IdMixInputException {

		for (ApprovalReaderVO readerVO : readerVOList) {
			if (writerC.equals(readerVO.getAppTyp())) {
				;
			} else if (reviewerC.equals(readerVO.getAppTyp())) {
				String idMix = CommonUtil.makeIdMixs(readerVO.getReaderNm(),
						readerVO.getReaderId());
				if (approvalVO.getReviewerMixs().equals(""))
					approvalVO.setReviewerMixs(idMix);
				else
					approvalVO.setReviewerMixs(approvalVO.getReviewerMixs()
							+ "," + idMix);
			}

			else if (cooperatorC.equals(readerVO.getAppTyp())) {
				String idMix = CommonUtil.makeIdMixs(readerVO.getReaderNm(),
						readerVO.getReaderId());
				if (approvalVO.getCooperatorMixs().equals(""))
					approvalVO.setCooperatorMixs(idMix);
				else
					approvalVO.setCooperatorMixs(approvalVO.getCooperatorMixs()
							+ "," + idMix);

			} else if (deciderC.equals(readerVO.getAppTyp())) {
				String idMix = CommonUtil.makeIdMixs(readerVO.getReaderNm(),
						readerVO.getReaderId());
				if (approvalVO.getDeciderMix().equals(""))
					approvalVO.setDeciderMix(idMix);
				else
					approvalVO.setDeciderMix(approvalVO.getDeciderMix() + ","
							+ idMix);
			} else if (referencerC.equals(readerVO.getAppTyp())) {
				String idMix = CommonUtil.makeIdMixs(readerVO.getReaderNm(),
						readerVO.getReaderId());
				if (approvalVO.getReferencerMixs().equals(""))
					approvalVO.setReferencerMixs(idMix);
				else
					approvalVO.setReferencerMixs(approvalVO.getReferencerMixs()
							+ "," + idMix);

			}
		}

	}

	/**
	 * readerVOList, map을 받아 userNo + approval type뒤 3글자를 키 값으로, value를 readerVO
	 * 로 하는 맵 생성.
	 * 
	 * @param readerVOList
	 * @param readerVOMap
	 */
	private Map<String, ApprovalReaderVO> setReaderVOMap(
			List<ApprovalReaderVO> readerVOList) {

		Map<String, ApprovalReaderVO> readerVOMap = new HashMap<String, ApprovalReaderVO>();
		for (ApprovalReaderVO readerVO : readerVOList) {
			readerVOMap.put(readerVO.getReaderNo()
					+ readerVO.getAppTyp().substring(3), readerVO);
		}
		return readerVOMap;
	}
	
	
	/**
	 * commondoc 을 result에 set하면서 vo를 리턴한다.
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	private ApprovalVO setCommonDoc(ApprovalVO searchVO, ModelMap model)
			throws Exception {
		ApprovalVO vo = approvalService.viewApprovalDoc(searchVO);
		model.addAttribute("commonDoc", vo);
		return vo;
	}

	/**
	 * @param searchVO
	 * @param user
	 */
	private void updateSrchDt(ApprovalVO searchVO, MemberVO user) {
		// update srchDt 조회일자 갱신
		ApprovalReaderVO readerVO = new ApprovalReaderVO();
		readerVO.setReaderNo(user.getNo());
		readerVO.setDocId(searchVO.getDocId());
		approvalService.updateReaderSrchDt(readerVO);
	}

	/**
	 * @param searchCommentVO
	 * @param model
	 * @throws Exception
	 */
	private void setComment(ApprovalCommentVO searchCommentVO, ModelMap model)
			throws Exception {
		searchCommentVO.setMode("0");
		List<ApprovalCommentVO> kmsEappCommentList = kmsEappCommentService.selectKmsEappCommentList(searchCommentVO);
		model.addAttribute("commentList", kmsEappCommentList);
	}

	/**
	 * @param model
	 * @param user
	 * @param vo
	 * @param readerVO
	 * @param readerVOList
	 * @param readerVOMap
	 */
	private void setButton(ModelMap model, MemberVO user, ApprovalVO vo,
			List<ApprovalReaderVO> readerVOList,
			Map<String, ApprovalReaderVO> readerVOMap) {
		
		String userNoDocStatMix = user.getNo() + vo.getDocStat().substring(3);
		ApprovalReaderVO readerVO = readerVOMap.get(userNoDocStatMix);
		// button control
		ApprovalButton button = new ApprovalButton();
		// vo가 null이 아닌 경우 해당 결재라인을 타고 있는 중임
		if (readerVO != null && !vo.getDocStat().equals(rejectC)) {
			//처리담당자의 경우 승인버튼 비활성화 
			if (readerVO.getStat() == 0 && !readerVO.getAppTyp().equals(handlerC))
				button.setAccept(1);

			// 참조자, 처리담당자가 아닌 경우 reject버튼 활성화
			if (readerVO.getStat() == 0 && !readerVO.getAppTyp().equals(referencerC) && !readerVO.getAppTyp().equals(handlerC))
				button.setReject(1);
		}

		// 기안취소 활성화
		int cancleDraft = 1;
		for (ApprovalReaderVO checkReaderVO : readerVOList) {
			if (checkReaderVO.getStat() != 0)
				cancleDraft = 0;
			else
				;
		}

		if (vo.getWriterNo() != user.getNo())
			button.setCancle(0);
		else
			button.setCancle(cancleDraft);

		// 양식재사용 활성화
		if (vo.getWriterNo() == user.getNo()
				&& (vo.getDocStat().equals(decidedC) || vo.getDocStat().equals(referencingC)||vo.getDocStat().equals(rejectC))
				&& vo.getReWriteTyp() == 0)
			button.setReUse(1);

		// 수정기안 활성화
		if (vo.getWriterNo() == user.getNo()
				&& (vo.getDocStat().equals(decidedC) || vo.getDocStat().equals(referencingC))
				&& (!vo.getTempltId().equals("5") && !vo.getTempltId().equals("10") && !vo.getTempltId().equals("11") 
						&& !vo.getTempltId().equals("12") && !vo.getTempltId().equals("13"))
				&& vo.getNewAt() == 1)
			button.setReApproval(1);

		//반려 확인 활성화
		userNoDocStatMix = user.getNo() + "099";
		readerVO = readerVOMap.get(userNoDocStatMix);
		if (vo.getDocStat().equals(rejectC)&& readerVO!= null && readerVO.getStat()==0 )
			button.setConfirmReject(1);
		
		//처리버튼 활성화
		if(vo.getDocStat().equals(referencingC)|| vo.getDocStat().equals(decidedC)){
			userNoDocStatMix = user.getNo() + handlerC.substring(3);
			readerVO = readerVOMap.get(userNoDocStatMix);
			if(readerVO != null) {
				if(vo.getHandleStat()==0) {
					button.setHandleAccept(1);
					button.setHandleReject(1);
				}
				if(vo.getHandleStat()==1)
					button.setHandleReject(1);
				else
					button.setHandleAccept(1);
			}
		}		
		//반려상태이고, 보는이가 작성자이고, 반려확인이 끝맞쳐졌을 경우 삭제버튼 활성화
		userNoDocStatMix = user.getNo() + writingC.substring(3);
		readerVO = readerVOMap.get(userNoDocStatMix);
		if(vo.getDocStat().equals(rejectC) && readerVO !=null) {
			userNoDocStatMix = user.getNo() + rejectConfirmerC.substring(3);
			readerVO = readerVOMap.get(userNoDocStatMix);
			if(readerVO!=null && readerVO.getStat()==1)
				button.setDelete(1);
		}
		//저장 상태일 경우
		if(vo.getDocStat().equals(writingC)) {
			button.setAccept(0);
			button.setReject(0);
			button.setCancle(0);
			button.setReApproval(0);
			button.setUpdate(1);
			button.setModify(1);
			button.setDelete(1);
			button.setPrint(0);
			button.setReUse(1);
		}	
		
		model.addAttribute("button", button);
	}

	/**
	 * @param searchVO
	 * @param model
	 * @param templtId
	 * @param user 
	 * @throws Exception
	 */
	private void setSpecificDoc(ApprovalVO searchVO, ModelMap model, int templtId, MemberVO user)
			throws Exception {
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		switch (templtId) {
		case 1: //일반결재
			break;
		case 2: //휴가신청서
			model.addAttribute("specificVO", approvalService.viewApprovalVac(searchVO)) ;
			break;
		case 3: //공문발송 승인요청서
			model.addAttribute("specificVO", approvalService.viewApprovalOfficial(searchVO)) ;
			break;
		case 4: //채용품의서
			model.addAttribute("specificVO", approvalService.viewApprovalJobg(searchVO)) ;
			
			vo.setCodeId("KMS002");
			List codeResult = cmmUseService.selectCmmCodeDetail(vo);
			model.addAttribute("educationList", codeResult);
			vo.setCodeId("KMS003");
			vo.setColumn1("Y");
			List rankList = cmmUseService.selectCmmCodeDetail(vo);
			model.addAttribute("rankList", rankList);
			vo.setCodeId("COM014");
			vo.setColumn1(null);
			codeResult = cmmUseService.selectCmmCodeDetail(vo);
			model.addAttribute("gendList", codeResult);
			break;
		case 5: //휴일근무보고서
			model.addAttribute("specificVO", approvalService.viewApprovalHol(searchVO)) ;
			model.addAttribute("writerNo", searchVO.getWriterNo()) ;
			break;
		case 10: case 11: case 12: case 13: //지출결의서 10업무경비 11자기개발비 12부서운영비(미사용) 13상품매입
			
			vo.setCodeId("KMS007"); //회사이름 코드
			List companyList = cmmUseService.selectCmmCodeDetail(vo);
			model.addAttribute("companyList", companyList);
			if(templtId==11) { //자기개발비
				SelfdevVO selfdevVO = new SelfdevVO();
				selfdevVO.setUserNo(searchVO.getWriterNo());
				//해당 문서에서 작성된 자기개발비는 미포함.
				selfdevVO.setSearchDocId(searchVO.getDocId());
				selfdevVO.setYear(searchVO.getWriteDt().substring(0,4) );
				model.addAttribute("selfdevVO", selfdevService.selectSelfdevUsrInfo(selfdevVO));
			}
			
			if(templtId==11) { //자기개발비
				ApprovalPresetVO searchPresetVO = new ApprovalPresetVO();
				searchPresetVO.setPresetTyp(selfdevPresetCode);
				model.addAttribute("presetPrjList", presetService.selectSpeicalPresetPrjList(searchPresetVO));
				model.addAttribute("presetPrjCnt", presetService.selectSpeicalPresetPrjCnt(searchPresetVO));
			} else if(templtId==12) { //부서운영비(미사용)
				ApprovalPresetVO searchPresetVO = new ApprovalPresetVO();
				searchPresetVO.setPresetTyp(diningPresetCode);
				model.addAttribute("presetPrjList", presetService.selectSpeicalPresetPrjList(searchPresetVO));
				model.addAttribute("presetPrjCnt", presetService.selectSpeicalPresetPrjCnt(searchPresetVO));
			} else if(templtId==13) { //상품매입
				ApprovalPresetVO searchPresetVO = new ApprovalPresetVO();
				searchPresetVO.setPresetTyp(costPresetCode);
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
			searchVO.setTempltId(Integer.toString(templtId));
			model.addAttribute("specificVOList", approvalService.selectExpenseList(searchVO));
			model.addAttribute("specificVOCnt", approvalService.selectExpenseCnt(searchVO));
			model.addAttribute("specificVOSum", approvalService.selectExpenseSum(searchVO));
			break;
		case 20: //종합매출보고서
			model.addAttribute("specificVO", approvalService.selectTotalSales(searchVO)) ;
			break;
		case 21: //일반매출보고서
			model.addAttribute("specificVO", approvalService.selectGeneneralSales(searchVO)) ;
			break;
		case 22: { //사업계획보고서
			model.addAttribute("specificVO", new ApprovalBusinessPlanVO()) ;
			List<ApprovalBusinessPlanVO> specificVOList = approvalService.selectBusinessPlan(searchVO);
			ApprovalBusinessPlanVO specificVOSum = approvalService.selectBusinessPlanSum(searchVO);
			model.addAttribute("specificVOList",specificVOList) ;
			model.addAttribute("specificVOSum",specificVOSum) ;
			List<Integer> yearList = new ArrayList<Integer>();
			if(specificVOList.size()>0){
				int year = specificVOList.get(0).getYear() - 5;
				for(int i = 0; i < 10 ; i++){
					yearList.add(year);
					year++;
				}
			}
			model.addAttribute("yearList",yearList);
			break;
		}
		case 23: { //기초영업비신청서
			JSONObject js = approvalService.selectBudgetAllocateDoc(searchVO);
			List<Integer> yearList = new ArrayList<Integer>();
			int year = (Integer) js.get("year") -5;
			for(int i = 0; i < 10 ; i++) {
				yearList.add(year);
				year++;
			}
			model.addAttribute("specificVO",js ) ;
			model.addAttribute("expenseList", approvalService.selectBudgetAllocateExpenseList(searchVO)) ;
			/*model.addAttribute("laborList", approvalService.selectBudgetAllocateLaborList(searchVO)) ;*/
			model.addAttribute("yearList",yearList);
			
			break;
		}
		case 24:{ //예산승인요청서
			model.addAttribute("specificVO", approvalService.selectBudgetAllocate2(searchVO)) ;
			break;
		}
		case 25:{ //사내매출보고서
			model.addAttribute("specificVO", approvalService.selectApprovalSalesIn(searchVO));
			break;
		}
		case 26:{ //팀장경비신청서
			model.addAttribute("salesPrj", approvalService.selectApprovalTeamSalesIn(searchVO));
			model.addAttribute("specificVOList", approvalService.selectApprovalTeamExp(searchVO));
			model.addAttribute("specificVOCnt", approvalService.selectApprovalTeamExpCnt(searchVO)); //case 10에서 참고해서 만들고 보니 사용안함..
			break;
		}
		case 27:{ //영업경비신청서			
			model.addAttribute("specificVOList", approvalService.selectApprovalTeamExp(searchVO)); //docId로 조회
			//model.addAttribute("specificVOCnt", approvalService.selectApprovalSalesExpCnt(searchVO)); // 역시 필요없음
			break;
		}
		case 28:{ //매출이관보고서
			model.addAttribute("specificVO", approvalService.selectApprovalSalesTrans(searchVO));
			break;
		}
		
		}
	}

	/* for ajax data handling */
	
	
	@RequestMapping(value = "/ajax/approval/laborForm.do")
	public String salaryForm(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		if("28".equals(searchVO.getTempltId()))
			return "/approval/include/laborExpenseForm";
		else 
			return "/approval/include/laborForm";
	}
	
	@RequestMapping(value = "/ajax/approval/expenseForm.do")
	public String expenseForm(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		return "/approval/include/expenseForm";
	}
	
	@RequestMapping(value = "/ajax/approval/totalSummingUpForm.do")
	public String totalSummingUpForm(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		if("24".equals(searchVO.getTempltId()))
			return "/approval/include/totalSummingUpForm24";
		else if("25".equals(searchVO.getTempltId()))
			return "/approval/include/totalSummingUpForm25";
		else if("28".equals(searchVO.getTempltId()))
			return "/approval/include/totalSummingUpForm28";
		else
			return "/approval/include/totalSummingUpForm";
	}
	
	@RequestMapping(value = "/ajax/accountTree.do")
	public String accountTree(
			@ModelAttribute("approvalVO") AccountVO searchVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		model.addAttribute("accountListTree", accountService.selectAccountListTree(searchVO));
		return "/ajax/accountTree";
	}
	
	@RequestMapping(value = "/ajax/approval/selectHolDateSum.do")
	public void selectHolDateSum(
			ApprovalVacVO searchVO,
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		double sumDate =  approvalService.selectVacDateSum(searchVO);
		res.setContentType("charset=UTF-8");
		ServletOutputStream out=res.getOutputStream();
		out.write(Double.toString(sumDate).getBytes());
		out.flush();
		out.close();
	}
	
	
	@RequestMapping(value = "/ajax/approval/selectSaelsPurchaseOutList.do")
	public void selectSaelsPurchaseOutList(
			String prjId,
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {
		JSONObject searchVO = new JSONObject();
		searchVO.put("prjId", prjId);
		List salesList = approvalService.selectSaelsPurchaseOutList(searchVO);
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		out.write(salesList.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
	
	//팀장경비 신청서 잔액조회
	@RequestMapping(value = "/ajax/approval/selectApprovalTeamExpBudget.do")
	public void selectApprovalTeamExpBudget(String prjId, String expDt,
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		if(expDt != null && expDt.length()>6){
			expDt = expDt.substring(0,6);
		}		
		
		JSONObject searchVO = new JSONObject();
		searchVO.put("prjId", prjId);
		searchVO.put("expDt", expDt);
		List salesList = approvalService.selectApprovalTeamExpBudgetAjax(searchVO);
		
		//팀장경비 최상위 프로젝트 코드 가져오기
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS040");
		List<CmmnDetailCode> rootPrjIdList = cmmUseService.selectCmmCodeDetail(codeVO);    	
		CmmnDetailCode rootPrjIdCode = new CmmnDetailCode();
		if(rootPrjIdList.size() > 0)
			rootPrjIdCode = (CmmnDetailCode)rootPrjIdList.get(0);
		String rootPrjId = rootPrjIdCode.getCodeDc();
		
		if(prjId.equals(rootPrjId)){
			JSONObject json = new JSONObject();
			json.put("budget", 1000000000);
			json.put("spend", 0);
			json.put("remain", 1000000000);
			//[{"budget":450000,"prjId":"PRJ_0000000000002782","remain":313420,"expDt":20130101,"spend":136580}]
			salesList.clear();
			salesList.add(json);    		
		}
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		if(salesList != null)
			out.write(salesList.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
	
	// 프로젝트별 매출내역 조회
	@RequestMapping(value = "/ajax/approval/selectProjectPlan.do")
	public void selectProjectPlan(String prjId, String stDt, String edDt, String templtId,
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		JSONObject searchVO = new JSONObject();
		searchVO.put("prjId", prjId);
		searchVO.put("stDt", stDt);
		searchVO.put("edDt", edDt);
		searchVO.put("templtId", templtId);
		
		JSONObject result = approvalService.selectProjectPlan(searchVO);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		/*
		if(salesList != null)
			out.write(salesList.toString().getBytes("UTF-8"));
		*/
		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();

	}
	
	@RequestMapping(value = "/approval/printDoc.do")
	public String printDoc(
			@ModelAttribute("approvalVO") ApprovalVO searchVO,
			@ModelAttribute("approvalCommentVO") ApprovalCommentVO searchCommentVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO) SessionUtil.getMember(request);
		//setting doc
		ApprovalVO vo = setCommonDoc(searchVO, model);
		
		//효력상실 판단
		if(vo.getNewAt()==0 && (decidedC.equals(vo.getDocStat())||referencingC.equals(vo.getDocStat()) ) ) {
			ApprovalVO vo2 = new ApprovalVO();
			vo2.setParntId(vo.getDocId());
			vo2.setDocId(vo.getDocId());
			ApprovalVO childDoc = approvalService.getChildDoc(vo2);
			if(childDoc == null) {
				model.addAttribute("suspensionTyp","2");
			} else {
				model.addAttribute("suspensionTyp","1");
				model.addAttribute("childDoc",childDoc);
			}
		}
		
		//수정기안일 경우
		if(vo.getReWriteTyp()!=0) {
			ApprovalVO vo2 = new ApprovalVO();
			vo2.setParntId(vo.getParntId());
			vo2.setDocId(vo.getParntId());
			ApprovalVO parentDoc = approvalService.getParentDoc(vo2);
			model.addAttribute("parentDoc",parentDoc);
		}
		
		setSpecificDoc(vo, model, Integer.parseInt(vo.getTempltId()), user);
		// setting reader
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(searchVO);
		setReaders(model, readerVOList);
		Map appTypMap = useAppTypMap();
		model.addAttribute("appTyp", appTypMap.get(vo.getTempltId()));
		model.addAttribute("printYn", "Y");
		return "/approval/appr_pop_print";
	}
	
	@RequestMapping("/approval/insertReferencer.do")
	public String insertReferencer(Map<String, String> commandMap) throws Exception{
		try {		
			String docId = commandMap.get("docId");
			String mode = commandMap.get("mode");
			
			approvalService.insertReferencer(commandMap);		
			return "redirect:/approval/approvalV.do?docId="+docId+"&mode="+mode;
		}
		catch(Exception e){
			return "forward:/approval/approvalV.do";
		}
	}
	
	@RequestMapping("/approval/updateWriterNo.do")
	public String updateWriterNo(Map<String, Object> commandMap) throws Exception{
		
		String docId = (String) commandMap.get("docId");
		String mode = (String) commandMap.get("mode");
		String deciderMix = (String) commandMap.get("deciderMix");
		
		MemberVO memberVO = new MemberVO();
		memberVO.setUserId(CommonUtil.parseIdFromMix(deciderMix));
		memberVO = memberService.selectMemberByIdNew(memberVO);	
		
		commandMap.put("writerNo", memberVO.getNo());			
		approvalService.updateWriterNo(commandMap);		
		return "redirect:/approval/approvalV.do?docId=" + docId + "&mode=" + mode;		
	}
	
	// ajax로 문서 정보(템플릿ID, 매출일, 최종수금예정일) 가져오기
	@RequestMapping(value = "/ajax/approval/selectDocStDt.do")
	public void selectProjectInfo(String docId, 
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		JSONObject result = approvalService.selectDocStDt(docId);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
	
	@RequestMapping(value = "/ajax/approval/selectReusedDoc.do")
	public void selectReusedDoc(String parntId,
			HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		
		String result = approvalService.selectReusedDoc(parntId);
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
}