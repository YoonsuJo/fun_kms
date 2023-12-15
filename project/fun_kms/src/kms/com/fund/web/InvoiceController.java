package kms.com.fund.web;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.ProjectInputVO;
import kms.com.cooperation.service.ProjectService;
import kms.com.cooperation.service.ProjectVO;
import kms.com.fund.dao.InvoiceDAO;
import kms.com.fund.fm.BondCheckFm;
import kms.com.fund.fm.CollectFm;
import kms.com.fund.service.InvoiceService;
import kms.com.fund.vo.*;
import kms.com.management.service.FundService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



/**
 * @author 서장열 
 * @date : 2017-02-28
 */
@Controller
public class InvoiceController {

	Logger logT = Logger.getLogger("TENY");

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;
	
	@Resource(name="KmsMemberService")
	private MemberService memberService;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;
	
	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsInvoiceService")
	private InvoiceService invoiceService;

	@Resource(name="KmsInvoiceDAO")
	private InvoiceDAO invoiceDAO;

	@Resource(name = "projectService")
	private ProjectService projectService;

	@Resource(name="KmsFundService")
	private FundService fundService;

	/* TENY_170206 테스트 화면을 만드는 Controll 메소드 */
	@RequestMapping("/fund/test.do")
	public String invoiceTest(@ModelAttribute("invcStatVO") InvcStatVO invcStatVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		return "fund/fund_Test";
	}


	/* TENY_170206 한개의 세금계산서 내용을 조회하는 화면을 만드는 Controll 메소드 */
	@RequestMapping("/fund/invoiceTest.do")
	public String invoiceTest(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		return "fund/sppt_InvoiceTest";
	}

/***************    Mapping    **************/
/* TENY_170206 검색조건에 따라 세금계산서 목록을 조회하는 화면을 만드는 Controll 메소드 */
	@RequestMapping("/fund/invoiceList.do")
	public String invoiceList(@ModelAttribute("InvoiceVO") InvoiceVO invioceVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		/* 검색 조건 관련 내용 Start */
		/* 최초 검색 조건없이 목록요청이 있을시 기본 검색조건을 설정한다 */
		if( invioceVO.getSearchCondition().equals("N")) {
			MemberVO user = SessionUtil.getMember(request);
			switch (invioceVO.getSearchMode())
			{
				case 1 :   // 세금계산서 발행요청자 모드 (내가 발행요청했던 계산서 목록)
					invioceVO.setSearchStatus(invioceVO.ALL);  				// 모든 세금계산서 목록을 가져온다
					invioceVO.setSearchWriterMixes(user.getUserNm() + "(" + user.getUserId() + ")" );
					break;
				case 2 : 		// 세금계산서 발행 담당자 모드 ( 발행예정일이 오늘까지이면서 아직 요청상태인 계산서 목록)
					invioceVO.setSearchStatus(invioceVO.REQUEST);  				// 아직 발행되지 않는 세금계산서 목록을 가져온다
					invioceVO.setSearchDateTo(CalendarUtil.getToday());			// 발행예정일이 오늘까지이면서 아직 요청상태인 계산서 목록
					break;
				case 3 : 		// 수금 담당자 모드 (발행되었으나 아직 수금완료가 되지 않는 계산서 목록)
					invioceVO.setSearchStatus(invioceVO.PUBLISH + invioceVO.COLLECTLESS);  	// 발행상태와 일부수금상태
					break;
				default :	// 취소된것 뺀 모든 세금계산서 목록을 가져온다
					invioceVO.setSearchStatus(invioceVO.ALL );
					break;
			} 
		}
		/* 검색 조건 관련 내용 End */
			
		logT.debug("searchCondition : " + invioceVO.getSearchCondition());		
		logT.debug("searchStatus : " + invioceVO.getSearchStatus());		
		logT.debug("searchTitle : " + invioceVO.getSearchTitle());		
		logT.debug("searchWriterName : " + invioceVO.getSearchWriterName());		
		logT.debug("searchCompanyName : " + invioceVO.getSearchCompanyName());		

		// 페이징 처리를 위한 절차
		// 위 조건으로 가져올 전체 리스트의 갯수를 구한다.
		int totCnt = invoiceService.selectInvoiceListCount(invioceVO);
		logT.debug("selectInvoiceListCount : " + totCnt);		

		/* 페이징 관련 내용 Start */
		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setTotalRecordCount( totCnt);
		pageInfo.setRecordCountPerPage( propertyService.getInt("pageUnit"));
		pageInfo.setPageSize( propertyService.getInt("pageSize") );
		pageInfo.setCurrentPageNo(invioceVO.getPageIndex());

		invioceVO.setFirstIndex(pageInfo.getFirstRecordIndex());  // 첫번째로 가져와야 하는 계산서의 index
		invioceVO.setRecordCountPerPage(pageInfo.getRecordCountPerPage());  // 가져와야하는 갯수
		/* 페이징 관련 내용 End */

		List<InvoiceVO> resultList = invoiceService.selectInvoiceList(invioceVO);

		/* 회사구분을 위한 회사 목록을 가져온다 */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List compList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("paginationInfo", pageInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("compList", compList);
		model.addAttribute("invoiceVO", invioceVO);
		model.addAttribute("today", CalendarUtil.getToday());
/*		
		String returnStr;
		
		switch (invioceVO.getSearchMode())
		{
			case 1 : 
			case 2 : 
				returnStr = "fund/sppt_InvoiceList";
				break;
			default :
				returnStr = "fund/sppt_InvoiceListBiz";
		} 
		logT.debug("END returnStr : " + returnStr);
*/
		return "fund/sppt_InvoiceList";
	}

/* TENY_170206 한개의 세금계산서 내용을 조회하는 화면을 만드는 Controll 메소드 */
	@RequestMapping("/fund/invoiceView.do")
	public String invoiceView(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		logT.debug("[invoiceId] : " + invoiceVO.getInvoiceId());

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("invoiceId", commandMap.get("invoiceId"));

		InvoiceVO rstInvoiceVO = invoiceService.selectInvoiceView(param);
		if(rstInvoiceVO == null) {
			logT.error("rstInvoiceVO is NULL");
			return "error/messageError";
		}
		List<InvoiceContentsVO> rstContentsList = invoiceService.selectInvoiceContentsList(param);
		List<InvoiceProjectVO> rstProjectList = invoiceService.selectInvoiceProjectList(param);

		model.addAttribute("invoiceVO", rstInvoiceVO);
		model.addAttribute("rstContentsList", rstContentsList);
		model.addAttribute("rstProjectList", rstProjectList);
		
		logT.debug("END");
		return "fund/sppt_InvoiceViewPop";
	}

/* TENY_170209 세금계산서 발행요청서를 작성하는 화면을 만드는 Controll 메소드 */
	@RequestMapping("/fund/invoiceWrite.do")
	public String invoiceWrite(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		
		/* 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		MemberVO user = SessionUtil.getMember(request);
		user = memberService.selectMemberByIdNew(user);

		InvoiceVO rstInvoiceVO = new InvoiceVO();

		rstInvoiceVO.setPublishCoAcronym(user.getCompnyNmShort()); 	// 접속 사용자가 작성한 세금계산서를 가져오도록 한다.
		model.addAttribute("rstInvoiceVO", rstInvoiceVO);

		return "fund/sppt_InvoiceWPop";
	}
	
	/* TENY_170209 세금계산서 작성시 기작성된 세금계산서에서 회사정보를 가져와 정보를 채우기 위해 정보목록을 조회하는  메소드 */
	@RequestMapping("/fund/invoiceCustInfoListAjax.do")
	public String invoiceCustInfoListAjax(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			HttpServletRequest request, HttpServletResponse response,
				ModelMap model) throws Exception {

		logT.debug("START");
		logT.debug("[searchCompanyName] " + invoiceVO.getSearchCompanyName());
		

		List<InvoiceVO> resultList = invoiceService.selectInvoiceCustInfoList(invoiceVO);
		logT.debug("[selectInvoiceCustInfoList result Count :] " + resultList.size());

		model.addAttribute("resultList", resultList);
		
		return "fund/sppt_InvoiceCustInfoListAjax";
	}
	
	/* TENY_170209 세금계산서 작성 페이지에서 입력된 값을 DB에 입력하기 위해 부르는  메소드 */
	@RequestMapping("/fund/invoiceInsert.do")
	public String invoiceInsert(@ModelAttribute("invoiceVOFm") InvoiceVO invoiceVO,
			MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			String jsonContentsString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{

		logT.debug("START");

		MemberVO user = SessionUtil.getMember(multiRequest);
		invoiceVO.setWriteUserNo(user.getNo());
//		invoiceVO.setJsonContentsString(jsonContentsString);
//		invoiceVO.setJsonProjectString(jsonProjectString);
		//  TENY_170220  taxZero check 버튼에 check되지 않으면 ""이 넘어온다
		if(invoiceVO.getTaxZero().length() <= 0){
			invoiceVO.setTaxZero("N");
		}
		
		/* 파일 첨부 Start */
		List<FileVO> result = null;
		String atchFileId = "";
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
			invoiceVO.setAttachFileId(atchFileId);
		}

		invoiceService.insertInvoice(invoiceVO);

		return "/common/returnPage/windowReloadNClose";
	}
	
	/* TENY_170206 한개의 세금계산서 내용을 수정하기 위하여 조회하는 화면을 만드는 Controll 메소드 */
	@RequestMapping("/fund/invoiceModify.do")
	public String invoiceModify(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			String jsonContentsString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		logT.debug("MODIFY [invoiceId] : " + commandMap.get("invoiceId"));

		/* 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		//  TENY_170218  작성자 정보기 필요할때 사용하기 위해서 필요
		// MemberVO user = SessionUtil.getMember(request);
		// user = memberService.selectMemberByIdNew(user);

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("invoiceId", invoiceVO.getInvoiceId());

		InvoiceVO rstInvoiceVO = invoiceService.selectInvoiceView(param);
		if(rstInvoiceVO == null) {
			logT.error("rstInvoiceVO is NULL");
			return "error/messageError";
		}

		List<InvoiceContentsVO> rstContentsList = invoiceService.selectInvoiceContentsList(param);
		List<InvoiceProjectVO> rstProjectList = invoiceService.selectInvoiceProjectList(param);

		if(null != rstInvoiceVO){
			model.addAttribute("invoiceVO", rstInvoiceVO);
		}
		if((null != rstContentsList) && (rstContentsList.size() > 0)){
			model.addAttribute("rstContentsList", rstContentsList);
		}
		if((null != rstContentsList) && (rstContentsList.size() > 0)){
			model.addAttribute("rstProjectList", rstProjectList);
		}
		
		logT.debug("END");
		return "fund/sppt_InvoiceMPop";
	}

	
	/* TENY_170209 세금계산서 작성 페이지에서 입력된 값을 DB에 입력하기 위해 부르는  메소드 */
	@RequestMapping("/fund/invoiceUpdate.do")
	public String invoiceUpdate(@ModelAttribute("invoiceVOFm") InvoiceVO invoiceVO,
			MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			String jsonContentsString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{

		logT.debug("START");

//		invoiceVO.setJsonContentsString(jsonContentsString);
//		invoiceVO.setJsonProjectString(jsonProjectString);
		//  TENY_170220  taxZero check 버튼에 check되지 않으면 ""이 넘어온다
		if(invoiceVO.getTaxZero().length() <= 0){
			invoiceVO.setTaxZero("N");
		}
		
		/* 파일 첨부 Start */
		if(invoiceVO.getAttachFileId().equals( "MODIFY" )) { 
			// TENY_170218  첨부파일에 수정이 된경우 새로 첨부된 파일로 저장한다  * 기존의 파일은 그냥둔다. 삭제기능은 다음에... 
			List<FileVO> result = null;
			String atchFileId = "";
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
				invoiceVO.setAttachFileId(atchFileId);
			}
		}

		invoiceService.updateInvoice(invoiceVO);

		// 계산서 정보 수정이 완료되면 팝업창을 닫고 원 윈도우를 재로드 한다.
		return "/common/returnPage/windowReloadNClose";
	}

	/* TENY_170206 한개의 세금계산서의 상태를 바꾸는 메소드 끝나면 변경된 화면을 보여준다 */
	// 바꾸려고 하는 상태가 비발행(N) -> 발행(Y)인경우
	@RequestMapping("/fund/invoiceStatus.do")
	public String invoiceUpdateStatus(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		if(invoiceVO.getStatus() == 4){
			//바꾸려는 상태가 "N"(계산서 미발행)에서 "Y"(계산서 발행)상태인 경우 발행자 정보를 현접속 사용자로 한다. 
			MemberVO user = SessionUtil.getMember(request);
			invoiceVO.setPublishUserNo(user.getNo());
			
			invoiceService.PublishInvoice(invoiceVO);
			if(invoiceVO.getOpenPop().equals("Y")) {  // 사용자가 Popup을 띄운경우 창을 닫아준다 
				return "fund/windowClose";
			}
			else {
				return "redirect:/fund/invoiceList.do?searchMode=1";				
			}
		} else if(invoiceVO.getStatus() == 1){
			//바꾸려는 상태가 "N"(계산서 미발행)에서 "C"(계산서 발행취소)상태인 경우 본인만이 취소할수 있으므로 상태값만 바꾼다.
			invoiceService.CancelInvoice(invoiceVO);
		} else {
			logT.warn("바꾸려는 상태가 적절하지 않습니다 [ " + invoiceVO.getStatus() + " ]");
			model.addAttribute("message", "바꾸려는 상태가 적절하지 않습니다 [ " + invoiceVO.getStatus() + " ]");
			return "error/messageError";
		}
		
		logT.debug("END");
		
		// 계산서 상태 수정이 완료되면 팝업창을 닫고 원 윈도우를 재로드 한다.
		return "/common/returnPage/windowReloadNClose";	
	}

	
	/* TENY_170209 세금계산서를 삭제하기 위해 부르는  메소드 */
	@RequestMapping("/fund/invoiceDelete.do")
	public String invoiceDelete(@ModelAttribute("invoiceVOFm") InvoiceVO invoiceVO,
			MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			String jsonContentsString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{

		logT.debug("START");
		logT.debug("[invoiceId] : " + commandMap.get("invoiceId"));

		Map<String, Object> param = new HashMap<String, Object>();
		MemberVO user = SessionUtil.getMember(multiRequest);
		param.put("deleteUserNo", user.getNo());
		param.put("invoiceId", commandMap.get("invoiceId"));
		
		invoiceService.deleteInvoice(param);
		logT.debug("START");

		// 계산서를 삭제하면 팝업창을 닫고 원 윈도우를 재로드 한다.
		return "/common/returnPage/windowReloadNClose";	
	}
	
	/* TENY_170220  세금계산서 내용을 재사용하기 위하여 조회하는 화면을 만드는 Controll 메소드 */
	@RequestMapping("/fund/invoiceReuse.do")
	public String invoiceReuse(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			String jsonContentsString, String jsonProjectString,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		logT.debug("MODIFY [invoiceId] : " + commandMap.get("invoiceId"));

		/* 회사구분을 불러옵니다. Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */
		
		//  TENY_170218  작성자 정보기 필요할때 사용하기 위해서 필요
		// MemberVO user = SessionUtil.getMember(request);
		// user = memberService.selectMemberByIdNew(user);

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("invoiceId", invoiceVO.getInvoiceId());

		InvoiceVO rstInvoiceVO = invoiceService.selectInvoiceView(param);
		if(rstInvoiceVO == null) {
			logT.error("rstInvoiceVO is NULL");
			model.addAttribute("message", "계산서 정보가 정확하지 않습니다.");
			return "error/messageError";
		}

		List<InvoiceContentsVO> rstContentsList = invoiceService.selectInvoiceContentsList(param);
		List<InvoiceProjectVO> rstProjectList = invoiceService.selectInvoiceProjectList(param);

		model.addAttribute("invoiceVO", rstInvoiceVO);
		model.addAttribute("rstContentsList", rstContentsList);
		model.addAttribute("rstProjectList", rstProjectList);
		
		logT.debug("END");
		return "fund/sppt_InvoiceRPop";
	}

	/* TENY_170220  세금계산서의 수금을 조회하기 위해 POPUP창을 띄울때 쓰이는 함수 */
	@RequestMapping("/fund/invoiceCollectView.do")
	public String invoiceCollectView(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("invoiceId", invoiceVO.getInvoiceId());

		InvoiceVO rstInvoiceVO = invoiceService.selectInvoiceView(param);
		model.addAttribute("invoiceVO", rstInvoiceVO);

		List<InvoiceProjectVO> rstProjectList = invoiceService.selectInvoiceProjectList(param);
		model.addAttribute("rstProjectList", rstProjectList);
		
		List<InvoiceCollectVO> rstCollectList = invoiceService.selectInvoiceCollectList(param);
		model.addAttribute("rstCollectList", rstCollectList);

		logT.debug("END");
		return "fund/sppt_InvoiceCollectView";
	}

	/* TENY_170220  수금을 등록하기 위해 POPUP창을 띄울때 쓰이는 함수 */
	@RequestMapping("/fund/invoiceCollectWrite.do")
	public String invoiceCollectWrite(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		logT.debug("[invoiceId] : " + commandMap.get("invoiceId"));

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("invoiceId", invoiceVO.getInvoiceId());

		InvoiceVO rstInvoiceVO = invoiceService.selectInvoiceView(param);
		if(rstInvoiceVO == null) {
			logT.error("rstInvoiceVO is NULL");
			return "error/messageError";
		}

		List<InvoiceProjectVO> rstProjectList = invoiceService.selectInvoiceProjectList(param);
		List<InvoiceCollectVO> rstCollectList = invoiceService.selectInvoiceCollectList(param);

		model.addAttribute("invoiceVO", rstInvoiceVO);
		model.addAttribute("rstProjectList", rstProjectList);
		model.addAttribute("rstCollectList", rstCollectList);
		
		/* 상세코드 불러오기 Start */
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS021");
		List typeList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", typeList);
		
		vo.setCodeId("KMS022");
		List accountList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("accountList", accountList);
		
		vo.setCodeId("KMS023");
		List bankBookList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("bankBookList", bankBookList);
		/* 상세코드 불러오기 End */
		
		// 회사구분을 불러옵니다. Start */
		vo.setCodeId("KMS007");
		List companyList = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("companyList", companyList);
		/* 회사구분을 불러옵니다. End */

		logT.debug("END");
		return "fund/sppt_InvoiceCollectWrite";
	}

	/* TENY_170220  수금정보를 등록할때 호출되는 함수 */
	@RequestMapping("/fund/invoiceCollectInsert.do")
	public String invoiceCollectInsert(@ModelAttribute("CollectFm") CollectFm collectFm,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		logT.debug("COLLECTINSERT [invoiceId] : " + collectFm.getInvoiceId());

		MemberVO user = SessionUtil.getMember(request);
		collectFm.setCollectUserNo(user.getNo());  // 수금자 UserNO를 넘기기위해 WriteUserNo를 빌러씀
		logT.debug("getCollectUserNo : " + collectFm.getCollectUserNo());

		if(!invoiceService.RegistCollect(collectFm)) {
			logT.warn("수금 등록 실패");
		}

		logT.debug("END");
		return "redirect:/fund/invoiceCollectView.do?invoiceId=" + collectFm.getInvoiceId();
	}

	/* TENY_170220  수금정보를 수금이 완료되지 않고 등록할때 호출되는 함수 */
	@RequestMapping("/fund/invoiceCollectEnd.do")
	public String invoiceCollectEnd(@ModelAttribute("CollectFm") CollectFm collectFm,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		logT.debug("COLLECT END [invoiceId] : " + collectFm.getInvoiceId());

		MemberVO user = SessionUtil.getMember(request);
		collectFm.setCollectUserNo(user.getNo());  // 수금자 UserNO를 넘기기위해 WriteUserNo를 빌러씀
		logT.debug("getCollectUserNo : " + collectFm.getCollectUserNo());

		if(!invoiceService.RegistCollectEnd(collectFm)) {
			logT.warn("수금 등록 실패");
		}

		logT.debug("END");
		return "redirect:/fund/invoiceCollectView.do?invoiceId=" + collectFm.getInvoiceId();
	}

	/* TENY_170301 부서별 매출, 계산서 발행, 미발행 수금 현황을 보는 Controll 메소드 */
	@RequestMapping("/fund/bondStatOrgList.do")
	public String bondStatOrgList(@ModelAttribute("InvcStatVOFm") InvcStatVO invcStatVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");
		/* 검색 조건 관련 내용 Start */
		/* 최초 검색 조건없이 목록요청이 있을시 기본 검색조건을 설정한다 */
		if( invcStatVO.getSearchCondition().equals("N")) {
			MemberVO user = SessionUtil.getMember(request);
		}

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("invoiceId", "TEST");
		List<InvcStatVO> resultList = invoiceService.selectInvcStatByOrg(param);
		
		InvcStatVO invcStatVOSum = new InvcStatVO();		
		for (InvcStatVO vo : resultList) {
			invcStatVOSum.setTotalSales(invcStatVOSum.getTotalSales() + vo.getTotalSales());
			invcStatVOSum.setTotalInvoice(invcStatVOSum.getTotalInvoice() + vo.getTotalInvoice());
			invcStatVOSum.setTotalCollect(invcStatVOSum.getTotalCollect() + vo.getTotalCollect());
		}
		model.addAttribute("rstInvcStatVOList", resultList);
		model.addAttribute("rstInvcStatVOSum", invcStatVOSum);
		
		logT.debug("END");		
		return "fund/bond_StatOrgList";
	}

	/* TENY_170301 프로젝트별 매출, 계산서 발행, 미발행 수금 현황을 보는 Controll 메소드 */
	@RequestMapping("/fund/bondStatPrjList.do")
	public String bondStatPrjList(@ModelAttribute("InvcStatVOFm") InvcStatVO invcStatVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		// 검색조건이 될 OrgnztId 목록을 먼저 가져온다.
		Map<String, Object> param = new HashMap<String, Object>();
		List<InvcStatVO> rstOrgnztList = invoiceService.selectBondOrgnztList(param);
		model.addAttribute("rstOrgnztList", rstOrgnztList);
		
		/* 최초 검색 조건없이 목록요청이 있을시 기본 검색조건을 설정한다 */
		if( invcStatVO.getSearchCondition().equals("N")) {
			invcStatVO.setRecordCountPerPage(propertyService.getInt("pageUnit"));
			invcStatVO.setPageIndex(1);
			
			MemberVO user = SessionUtil.getMember(request);
			for (InvcStatVO vo : rstOrgnztList) {
				if(vo.getOrgnztId() == user.getOrgnztId()){
					invcStatVO.setOrgnztId(user.getOrgnztId());
				}
			}
		}

		/* 페이징 관련 내용 Start */
		param.put("orgnztId", invcStatVO.getOrgnztId());
		int totCnt = invoiceService.selectInvcStatByPrjCount(param);

		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setTotalRecordCount( totCnt);
		if(invcStatVO.getRecordCountPerPage() == propertyService.getInt("pageUnit")) {
			pageInfo.setRecordCountPerPage( propertyService.getInt("pageUnit"));				
		}
		else {
			pageInfo.setRecordCountPerPage(invcStatVO.getRecordCountPerPage());
		}
		
		pageInfo.setPageSize( propertyService.getInt("pageSize") );
		pageInfo.setCurrentPageNo(invcStatVO.getPageIndex());

		invcStatVO.setFirstIndex(pageInfo.getFirstRecordIndex());  // 첫번째로 가져와야 하는 계산서의 index
		invcStatVO.setRecordCountPerPage(pageInfo.getRecordCountPerPage());  // 가져와야하는 갯수
		model.addAttribute("paginationInfo", pageInfo);
		model.addAttribute("invcStatVO", invcStatVO);  // 어떤검색조건으로 찾은건지 UI에 표시하기위한 정보와 페이지 정보를  넘겨줌
		/* 페이징 관련 내용 End */


		param.put("firstIndex", pageInfo.getFirstRecordIndex());
		param.put("recordCountPerPage", pageInfo.getRecordCountPerPage());

		List<InvcStatVO> resultList = invoiceService.selectInvcStatByPrj(param);
		InvcStatVO invcStatVOSum = new InvcStatVO();		
		for (InvcStatVO vo : resultList) {
			invcStatVOSum.setTotalSales(invcStatVOSum.getTotalSales() + vo.getTotalSales());
			invcStatVOSum.setTotalInvoice(invcStatVOSum.getTotalInvoice() + vo.getTotalInvoice());
			invcStatVOSum.setTotalCollect(invcStatVOSum.getTotalCollect() + vo.getTotalCollect());
		}

		model.addAttribute("rstInvcStatVOList", resultList);
		model.addAttribute("rstInvcStatVOSum", invcStatVOSum);
		

		logT.debug("END");		
		return "fund/bond_StatPrjList";
	}
		
	@RequestMapping(value = "/fund/selectProjectPopV.do")
	public String selectPopProjectV(
			@ModelAttribute("searchVO") ProjectVO searchVO,
			@ModelAttribute("searchProjectChildVO") ProjectVO searchProjectChildVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		
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
		return "/fund/proj_ProjectPopView";
	}
		
/* TENY_170303 부서별 매출 대비 계산서 발행현황 미발행현황을 알려주는 기능(화면) */
	@RequestMapping("/fund/chckOrgSalesList.do")
	public String chckOrgSalesList(@ModelAttribute("InvcStatVOFm") InvcStatVO invcStatVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 검색 조건 관련 내용 Start */
		/* 최초 검색 조건없이 목록요청이 있을시 기본 검색조건을 설정한다 */
		if( invcStatVO.getSearchCondition().equals("N")) {
			MemberVO user = SessionUtil.getMember(request);
			invcStatVO.setBondYn("Y");
			invcStatVO.setStat("E");
			String str = CalendarUtil.getToday();
			invcStatVO.setToDate(Integer.parseInt(str));
		}

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bondYn", invcStatVO.getBondYn());
		param.put("stat", invcStatVO.getStat());
		param.put("toDate", invcStatVO.getToDate());
		List<InvcStatVO> resultList = invoiceService.selectCheckOrgSalesList(param);
		
		InvcStatVO invcStatVOSum = new InvcStatVO();		
		for (InvcStatVO vo : resultList) {
			invcStatVOSum.setContractSales(invcStatVOSum.getContractSales() + vo.getContractSales());
			invcStatVOSum.setProgressiveSales(invcStatVOSum.getProgressiveSales() + vo.getProgressiveSales());
			invcStatVOSum.setInvPrjPrice(invcStatVOSum.getInvPrjPrice() + vo.getInvPrjPrice());
			invcStatVOSum.setInvPrjSum(invcStatVOSum.getInvPrjSum() + vo.getInvPrjSum());
			invcStatVOSum.setInvPrjCollect(invcStatVOSum.getInvPrjCollect() + vo.getInvPrjCollect());
		}
		model.addAttribute("rstInvcStatVOList", resultList);
		model.addAttribute("rstInvcStatVOSum", invcStatVOSum);
		model.addAttribute("invcStatVO", invcStatVO);  // 어떤검색조건으로 찾은건지 UI에 표시하기위한 정보와 페이지 정보를  넘겨줌
		
		logT.debug("END");		
		return "fund/chck_OrgSalesList";
	}

	/* TENY_170301 프로젝트별로 세금계산서를 발행하지 않은 매출을 찾기 위한 기능 */
	@RequestMapping("/fund/chckProjectSalesCheckList.do")
	public String chckProjectSalesCheckList(@ModelAttribute("InvcStatVOFm") InvcStatVO invcStatVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		if(invcStatVO.getToDate() == 0){
			String str = CalendarUtil.getToday();
			invcStatVO.setToDate(Integer.parseInt(str));
		}
		// 검색조건이 될 OrgnztId 목록을 먼저 가져온다.
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orgnztId", invcStatVO.getOrgnztId());
		param.put("toDate", invcStatVO.getToDate());
		
		List<InvcStatVO> rstOrgnztList = invoiceService.selectBondOrgnztList(param);
		model.addAttribute("rstOrgnztList", rstOrgnztList);
		
		/* 최초 검색 조건없이 목록요청이 있을시 기본 검색조건을 설정한다 */
		if( invcStatVO.getSearchCondition().equals("N")) {
			invcStatVO.setRecordCountPerPage(propertyService.getInt("pageUnit"));
			invcStatVO.setPageIndex(1);
			
			MemberVO user = SessionUtil.getMember(request);
			for (InvcStatVO vo : rstOrgnztList) {
				if(vo.getOrgnztId() == user.getOrgnztId()){
					invcStatVO.setOrgnztId(user.getOrgnztId());
				}
			}
		}

		/* 페이징 관련 내용 Start */
		int totCnt = invoiceService.selectCheckProjectSalesCount(param);

		PaginationInfo pageInfo = new PaginationInfo();
		pageInfo.setTotalRecordCount( totCnt);
		if(invcStatVO.getRecordCountPerPage() == propertyService.getInt("pageUnit")) {
			pageInfo.setRecordCountPerPage( propertyService.getInt("pageUnit"));				
		}
		else {
			pageInfo.setRecordCountPerPage(invcStatVO.getRecordCountPerPage());
		}
		
		pageInfo.setPageSize( propertyService.getInt("pageSize") );
		pageInfo.setCurrentPageNo(invcStatVO.getPageIndex());

		invcStatVO.setFirstIndex(pageInfo.getFirstRecordIndex());  // 첫번째로 가져와야 하는 계산서의 index
		invcStatVO.setRecordCountPerPage(pageInfo.getRecordCountPerPage());  // 가져와야하는 갯수
		model.addAttribute("paginationInfo", pageInfo);
		model.addAttribute("invcStatVO", invcStatVO);  // 어떤검색조건으로 찾은건지 UI에 표시하기위한 정보와 페이지 정보를  넘겨줌
		/* 페이징 관련 내용 End */


		param.put("firstIndex", pageInfo.getFirstRecordIndex());
		param.put("recordCountPerPage", pageInfo.getRecordCountPerPage());

		List<InvcStatVO> resultList = invoiceService.selectProjectSalesCheckList(param);
		InvcStatVO invcStatVOSum = new InvcStatVO();		
		for (InvcStatVO vo : resultList) {
			invcStatVOSum.setContractSales(invcStatVOSum.getContractSales() + vo.getContractSales());
			invcStatVOSum.setProgressiveSales(invcStatVOSum.getProgressiveSales() + vo.getProgressiveSales());
			invcStatVOSum.setInvPrjPrice(invcStatVOSum.getInvPrjPrice() + vo.getInvPrjPrice());
			invcStatVOSum.setInvPrjSum(invcStatVOSum.getInvPrjSum() + vo.getInvPrjSum());
			invcStatVOSum.setInvPrjCollect(invcStatVOSum.getInvPrjCollect() + vo.getInvPrjCollect());
		}

		model.addAttribute("rstInvcStatVOList", resultList);
		model.addAttribute("rstInvcStatVOSum", invcStatVOSum);
		

		logT.debug("END");		
		return "fund/chck_ProjectSalesCheckList";
	}

	/* TENY_170323 프로젝트별 채권관리를 위해 전월이월, 당월발생, 당월수금, 미수금 현황을 보는 Controll 메소드 */
	@RequestMapping("/fund/chckProjectBondCheckList.do")
	public String chckProjectBondCheckList(@ModelAttribute("BondCheckFm") BondCheckFm bcFm,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		/* 최초 검색 조건없이 목록요청이 있을시 기본 검색조건을 설정한다 */
		if( bcFm.getSearchCondition().equals("N")) {
			bcFm.setFromDate(CalendarUtil.getToday());
			bcFm.setFromDate(bcFm.getFromDate().substring(0, 6) + "01");
			
			if(bcFm.getOrgnztId().length() == 0 ) {
				MemberVO user = SessionUtil.getMember(request);
				if(!user.getOrgnztId().equals("ORGAN_TOP_ORGAN_CODE")) {
					bcFm.setOrgnztId(user.getOrgnztId());
				}
			}
			bcFm.setInclBondZero("N");
		}
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("fromDate", bcFm.getFromDate());
		if(bcFm.getFromDate().length() >= 6) {
			param.put("fromDateDash", bcFm.getFromDate().substring(0, 4) + "-" + bcFm.getFromDate().substring(4, 6) );			
		}
		else {
			logT.error("fromDateDash is not Good");
			return "error/messageError";
		}
		param.put("orgnztId", bcFm.getOrgnztId());
		if((bcFm.getInclBondZero().length() <= 0) || !bcFm.getInclBondZero().equals("Y")) {
			bcFm.setInclBondZero("N");
		}
		param.put("inclBondZero", bcFm.getInclBondZero());

		logT.debug("orgnztId : " + bcFm.getOrgnztId());
		logT.debug("inclBondZero : " + bcFm.getInclBondZero());
		
		List<InvcStatVO> rstOrgnztList = invoiceService.selectBondOrgnztList(param);
		model.addAttribute("rstOrgnztList", rstOrgnztList);

		List<BondCheckVO> bcVOList = invoiceDAO.selectProjectBondCheckList(param);
		BondCheckVO bcVOSum = new BondCheckVO();
		for (BondCheckVO vo : bcVOList) {
			bcVOSum.setTotalPrjSum(bcVOSum.getTotalPrjSum() + vo.getTotalPrjSum());
			bcVOSum.setTotalPrjCollect(bcVOSum.getTotalPrjCollect() + vo.getTotalPrjCollect());
			bcVOSum.setMonthPrjSum(bcVOSum.getMonthPrjSum() + vo.getMonthPrjSum());
			bcVOSum.setMonthPrjCollect(bcVOSum.getMonthPrjCollect() + vo.getMonthPrjCollect());
		}

		model.addAttribute("bcFm", bcFm);
		model.addAttribute("bcVOList", bcVOList);
		model.addAttribute("bcVOSum", bcVOSum);
		
		logT.debug("END");
		return "fund/chck_ProjectBondCheckList";
	}

	/* TENY_170301 각 프로젝트별 매출, 계산서 발행, 미발행 수금 현황을 보는 Controll 메소드 */
	@RequestMapping("/fund/chckProjectBondCheckView.do")
	public String chckProjectBondCheckView(@ModelAttribute("InvcStatVOFm") InvcStatVO invcStatVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		// 검색조건이 될 OrgnztId 목록을 먼저 가져온다.
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("prjId", invcStatVO.getPrjId());

		// 종합매출보고에서 매출을 추출한다.
		List<InvcStatVO> totSalesList = invoiceService.selectCheckTotSalesList(param);
		InvcStatVO totSalesSum = new InvcStatVO();		
		for (InvcStatVO vo : totSalesList) {
			totSalesSum.setSalesWholeSales(totSalesSum.getSalesWholeSales() + vo.getSalesWholeSales());
			totSalesSum.setSalesSales(totSalesSum.getSalesSales() + vo.getSalesSales());
			totSalesSum.setSalesMaintSales(totSalesSum.getSalesMaintSales() + vo.getSalesMaintSales());
		}

		model.addAttribute("invcStatVO", invcStatVO);  // 어떤검색조건으로 찾은건지 UI에 표시하기위한 정보와 페이지 정보를  넘겨줌
		model.addAttribute("totSalesList", totSalesList);
		model.addAttribute("totSalesSum", totSalesSum);
		
		// 일반매출보고에서 매출을 추출한다.
		List<InvcStatVO> genSalesList = invoiceService.selectCheckGenSalesList(param);
		InvcStatVO genSalesSum = new InvcStatVO();		
		for (InvcStatVO vo : genSalesList) {
			genSalesSum.setSalesWholeSales(genSalesSum.getSalesWholeSales() + vo.getSalesWholeSales());
			genSalesSum.setSalesSales(genSalesSum.getSalesSales() + vo.getSalesSales());
			genSalesSum.setSalesMaintSales(genSalesSum.getSalesMaintSales() + vo.getSalesMaintSales());
		}

		model.addAttribute("genSalesList", genSalesList);
		model.addAttribute("genSalesSum", genSalesSum);
		
		// 계산서발행요청서의 프로젝트별 매출 에서 계산서발행금액 및 수금금액을 추출한다.
		List<ProjectCollectVO> pcVOList = invoiceService.selectProjectCollectList(invcStatVO.getPrjId());

		model.addAttribute("pcVOList", pcVOList);

		logT.debug("END");		
		return "fund/chck_ProjectBondCheckView";
	}

	/* TENY_170511 해당 프로젝트의 계산서 발행, 수금, 잔금 현황을 일자별로 보는 기능 */
	@RequestMapping("/fund/chckProjectCollectPop.do")
	public String chckProjectCollectPop(@ModelAttribute("InvcStatVOFm") InvcStatVO invcStatVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		// 해당 프로젝트의 계산서 발행, 수금, 잔금 현황을 일자별로 조회
		List<ProjectCollectVO> icmVOList = invoiceService.selectProjectCollectList(invcStatVO.getPrjId());

		model.addAttribute("icmVOList", icmVOList);  // 어떤검색조건으로 찾은건지 UI에 표시하기위한 정보와 페이지 정보를  넘겨줌
//		model.addAttribute("InvcStatVO", InvcStatVO);
		
		logT.debug("END");		
		return "fund/chck_ProjectCollectPop";
	}

	/* TENY_170327 최근 수금 목록을 중심으로 프로젝트의 전월이월, 당월발생, 당월수금, 미수금 현황을 보는 Controll 메소드 */
	@RequestMapping("/fund/bizCollectList.do")
	public String bizCollectList(@ModelAttribute("BondCheckFm") BondCheckFm bcFm,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		/* 최초 검색 조건없이 목록요청이 있을시 기본 검색조건을 설정한다 */
		if( bcFm.getSearchCondition().equals("N")) {
			bcFm.setFromDate(CalendarUtil.getToday());
			bcFm.setFromDate(bcFm.getFromDate().substring(0, 6) + "01");
			
			MemberVO user = SessionUtil.getMember(request);
			if(!user.getOrgnztId().equals("ORGAN_TOP_ORGAN_CODE")) {
				bcFm.setOrgnztId(user.getOrgnztId());
			}
		}
		Map<String, Object> param = new HashMap<String, Object>();
		String date = bcFm.getFromDate();
		
		logT.debug("fromDate ~ toDate : " + bcFm.getFromDate() + " ~ " + bcFm.getToDate());
		logT.debug("orgnztId : " + bcFm.getOrgnztId());
		logT.debug("inclBondZero", bcFm.getInclBondZero());

		param.put("fromDate", bcFm.getFromDate());
		param.put("toDate", bcFm.getToDate());
		param.put("orgnztId", bcFm.getOrgnztId());
		param.put("inclBondZero", bcFm.getInclBondZero());

		List<InvcStatVO> rstOrgnztList = invoiceService.selectBondOrgnztList(param);
		model.addAttribute("rstOrgnztList", rstOrgnztList);

		List<CollectListVO> clVOList = invoiceDAO.selectProjectBondCheckList2(param);
		CollectListVO clVOSum = new CollectListVO();		
		for (CollectListVO vo : clVOList) {
			clVOSum.setPrjUncollect(clVOSum.getPrjUncollect() + vo.getPrjUncollect());
			clVOSum.setCollect(clVOSum.getCollect() + vo.getCollect());
		}

		model.addAttribute("bcFm", bcFm);
		model.addAttribute("clVOList", clVOList);
		model.addAttribute("clVOSum", clVOSum);
		

		logT.debug("END");		
		return "fund/biz_CollectList";
	}

	
	@RequestMapping("/fund/deleteInvoiceList.do")
	public String deleteInvoiceList(@ModelAttribute("invoiceVO") InvoiceVO invoiceVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{

		logT.debug("START");
		
		Map<String, Object> param = new HashMap<String, Object>();
		MemberVO user = SessionUtil.getMember(request);
		param.put("deleteUserNo", user.getNo());
		param.put("invoiceId", commandMap.get("invoiceId"));

		String noteIds = invoiceVO.getInvoiceId();
		invoiceVO.setInvoiceIdList(noteIds.split(","));
		invoiceVO.setWriteUserNo(user.getNo());
		
		invoiceService.deleteInvoiceList(invoiceVO);
		
		logT.debug("END");
		return "redirect:/fund/invoiceList.do?";
	}

	@RequestMapping("/fund/closeBondMng.do")
	public String closeBondMng(@ModelAttribute("invcStatVOFm") InvcStatVO invcStatVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{

		logT.debug("START");
		
		Map<String, Object> param = new HashMap<String, Object>();
		MemberVO user = SessionUtil.getMember(request);
		param.put("deleteUserNo", user.getNo());

		String salesDocIds = invcStatVO.getSalesDocIds();
		invcStatVO.setSalesDocIdList(salesDocIds.split(","));
		if(invcStatVO.getSalesType() == "T") {
			invoiceService.updateTotSalesBondMngStatus(invcStatVO);
		}
		else {
			invoiceService.updateGenSalesBondMngStatus(invcStatVO);
		}
		
		String invPrjNos = invcStatVO.getInvPrjNos();
		invcStatVO.setInvPrjNoList(invPrjNos.split(","));
		invoiceService.updateInvPrjBondMngStatus(invcStatVO);

		model.addAttribute("invcStatVO", invcStatVO);  // 어떤검색조건으로 찾은건지 UI에 표시하기위한 정보와 페이지 정보를  넘겨줌

		logT.debug("END");
		return "redirect:/fund/chckGenSalesList.do?prjId="+invcStatVO.getPrjId() + "&prjName=" + invcStatVO.getPrjName() ;
	}
	
	// ajax로 수금정보 삭제하기
	@RequestMapping(value = "/fund/deleteCollectAjax.do")
	public void deleteCollectAjax(String invoiceId, 
			HttpServletRequest request, HttpServletResponse res,
			ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(request);
		if(user.getUserNo() != 2) {
			
		}
		JSONObject result = new JSONObject();
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		if(user.getUserNo() != 2) {
			result.put("RETURN", "NG");
			out.write(result.toString().getBytes("UTF-8"));
			out.flush();
			out.close();
			return;
		}

		if(invoiceService.deleteCollect(invoiceId)){
				result.put("RETURN", "OK");
				out.write(result.toString().getBytes("UTF-8"));
		 } else {
				result.put("RETURN", "NG");
				out.write(result.toString().getBytes("UTF-8"));
		}
		out.flush();
		out.close();
	}

}
