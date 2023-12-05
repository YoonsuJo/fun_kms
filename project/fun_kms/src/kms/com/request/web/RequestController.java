package kms.com.request.web;

import java.util.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.member.service.MemberVO;
import kms.com.member.service.impl.MemberDAO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;

import kms.com.request.service.RequestService;
import kms.com.request.dao.RequestDAO;
import kms.com.request.fm.*;
import kms.com.request.vo.*;

@Controller
public class RequestController {
	Logger logT = Logger.getLogger("TENY");

	@Resource(name="KmsRequestDAO")
	private RequestDAO requestDAO;

	@Resource(name="KmsRequestService")
	private RequestService requestService;
	
	@Resource(name="KmsMemberDAO")
	private MemberDAO memberDAO;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	
	
	
	/* JangyeulS 2021_0928 : 요구사항 목록보기 */
	@RequestMapping("/request/RequestList.do")
	public String RequestList(
			@ModelAttribute("fm") RequestFm fm,
			Map<String,Object> commandMap,
			HttpServletRequest req,
			ModelMap model
			) throws Exception {
	
		logT.debug("START");

		// 검색 조건
		// 1. 기본 검색조건 : 특정기간동안 개인별의 요구사항 처리실적을 확인한다. 
		// 		요구사항 신규 발생건수, 처리건수, 미처리건수  
		// 2. 검색조건 : 담당자, 시작일, 마지막일 
		MemberVO user = SessionUtil.getMember(req);
		//LYS_로그인된 사용자의 요구사항 클릭 정보를 가져온다 (mode = 1(미처리) mode = 3(금주잔여) mode = 5(금월잔여) mode = 18 (14일 이내) mode = 19 (30일 이내)
		String mode = String.valueOf(commandMap.get("mode"));
		String today = CalendarUtil.getToday();
		if(today.length() != 8) {
			logT.error("Error in CalendarUtil.getToday()");
			return "";
		}
		//EgovMap ReqStat = requestDAO.selectRequestProcessStat(today);
		EgovMap ReqPlan = null;
		if("null".equals(mode) || "".equals(mode)){
			MemberVO notUser = new MemberVO();
			ReqPlan = requestDAO.selectRequestProcessPlan(today,notUser,0);
		}else{
			ReqPlan = requestDAO.selectRequestProcessPlan(today,user,0);
		}

		//model.addAttribute("ReqStat", ReqStat);
		model.addAttribute("ReqPlan", ReqPlan);

		// 검색조건 요구사항을 조회한다.
		if(fm.getSearchUseYn().equals("Y")) {
			logT.debug("equals");
			if(!"null".equals(mode)){
				fm.setSearchManagerMixes(user.getUserNm() + "(" + user.getUserId() + ")" );
			}
		} else { // 검색조건이 없을 경우
//			fm.setPageUnit(	propertyService.getInt("pageUnit"));
//			fm.setPageSize(propertyService.getInt("pageSize"));
			
			//LYS_미처리 요구사항
			if("1".equals(mode)){
				fm.setSearchManagerMixes(user.getUserNm() + "(" + user.getUserId() + ")" );
				fm.setSearchProcessMode(1);
			}
			/**
			 * 왼쪽 메뉴 요구사항 버튼 클릭 (2주 이내 내 요구사항 목록)
			 * @author 이유수
			 */
			else if("18".equals(mode)){
				fm.setSearchManagerMixes(user.getUserNm() + "(" + user.getUserId() + ")" );
				fm.setSearchProcessMode(18);
				fm.setWeekChk(1);
			/**
			 * 왼쪽 메뉴 요구사항 버튼 클릭 (한달 이내 요구사항 목록)
			 * @author 이유수
			 */				
			}else if("19".equals(mode)){
				fm.setSearchManagerMixes(user.getUserNm() + "(" + user.getUserId() + ")" );
				fm.setSearchProcessMode(19);
				fm.setMonthChk(1);
			}
		}
		String weekStart 				= CalendarUtil.getFirstDateOfThisWeek2(today);
		String weekEnd 					= CalendarUtil.getLastDateOfThisWeek2(today);
		String thisMonthStart 			= CalendarUtil.getFirstDayOfMonth(today);
		String thisMonthEnd 			= CalendarUtil.getLastDayOfMonth(today);
		String nextOneMonth 			= CalendarUtil.getDate(today, "MONTH", 1);
		String nextOneMonthStart 		= CalendarUtil.getFirstDayOfMonth(nextOneMonth);
		String nextOneMonthEnd 			= CalendarUtil.getLastDayOfMonth(nextOneMonth);
		String nextTwoMonth 			= CalendarUtil.getDate(today, "MONTH", 2);
		String nextTwoMonthStart 		= CalendarUtil.getFirstDayOfMonth(nextTwoMonth);
		String nextTwoMonthEnd 			= "20991231";
		String pastStart 				= "20170101";
		String pastEnd 					= CalendarUtil.getDate(weekStart, "DATE", -1);

		logT.debug("pastStart : " + pastStart);
		logT.debug("pastEnd : " + pastEnd);
		logT.debug("weekStart : " + weekStart);
		logT.debug("weekEnd : " + weekEnd);
		logT.debug("thisMonthStart : " + thisMonthStart);
		logT.debug("thisMonthEnd : " + thisMonthEnd);
		logT.debug("nextOneMonth : " + nextOneMonth);
		logT.debug("nextOneMonthStart : " + nextOneMonthStart);
		logT.debug("nextOneMonthEnd : " + nextOneMonthEnd);
		logT.debug("nextTwoMonth : " + nextTwoMonth);
		logT.debug("nextTwoMonthStart : " + nextTwoMonthStart);
		logT.debug("nextTwoMonthEnd : " + nextTwoMonthEnd);

		logT.debug("getSearchProcessMode : " + fm.getSearchProcessMode());
		fm.setSearchReqType(15);
		switch(fm.getSearchProcessMode()) {
		case 0: // 요구사항 클릭 시
			fm.setFirstOpen(1);
			
			/**
			 * @author 이유수
			 * 완료예정 기준일 추가 (전체 검색 시)
			 */
			// 작성기준일이 없는 경우 오늘을 검색조건의 작성기준일로 한다.
			
			if("N".equals(fm.getDueDateAll())) {
				if((fm.getAtDate() == null) || (fm.getAtDate().length() == 0) ) { // 검색조건(작성기준일)이 없는 경우
					fm.setAtDate(CalendarUtil.getToday());
					fm.setDateMove(0);
				}
				// 검색조건에 이종일이 있는 경우 검색조건(작성기준일)을 수정한다.
				if(fm.getDateMove() != 0) {
					fm.setAtDate(CalendarUtil.getDate(fm.getAtDate(), fm.getDateMove()));
				}
				//조건 날짜의 월요일
				fm.setSearchDueDateFrom(CalendarUtil.getFirstDateOfThisWeek2(fm.getAtDate()));
				//조건 날짜의 일요일
				fm.setSearchDueDateTo(CalendarUtil.getLastDateOfThisWeek2(fm.getAtDate()));
				model.addAttribute("searchAtDate", fm.getAtDate());
				model.addAttribute("searchDueDateStart", fm.getSearchDueDateFrom());
				model.addAttribute("searchDueDateEnd", fm.getSearchDueDateTo());
			}
			model.addAttribute("dueDateAll", fm.getDueDateAll());
			break;
		case 1:  // 미처리
			fm.setSearchStatus(15);
			fm.setUntreated(1);
			model.addAttribute("status", "1");
			break;
		case 2:  // 금주 완료
			fm.setSearchStatus(16);
			fm.setSearchDueDateFrom(weekStart);
			fm.setSearchDueDateTo(weekEnd);
			model.addAttribute("status", "2");
			break;
		case 3:  // 금주 잔여
			fm.setSearchStatus(15);
			fm.setSearchDueDateFrom(weekStart);
			fm.setSearchDueDateTo(weekEnd);
			model.addAttribute("status", "3");
			break;
		case 4:  // 금월 완료
			fm.setSearchStatus(16);
			fm.setSearchDueDateFrom(thisMonthStart);
			fm.setSearchDueDateTo(thisMonthEnd);
			model.addAttribute("status", "4");
			break;
		case 5:  // 금월 잔여
			fm.setSearchStatus(15);
			fm.setSearchDueDateFrom(thisMonthStart);
			fm.setSearchDueDateTo(thisMonthEnd);
			model.addAttribute("status", "5");
			break;
		case 6:  // 다음달
			fm.setSearchStatus(15);
			fm.setSearchDueDateFrom(nextOneMonthStart);
			fm.setSearchDueDateTo(nextOneMonthEnd);
			model.addAttribute("status", "6");
			break;
		case 7:  // 추후개발
			fm.setSearchStatus(32);
			fm.setLastCreate(1);
//			fm.setSearchDueDateFrom(nextTwoMonthStart);
//			fm.setSearchDueDateTo(nextTwoMonthEnd);
			model.addAttribute("status", "7");
			break;
		case 8:  // 미정
			fm.setSearchStatus(15);
			fm.setSearchDueNULL("NULL");
			model.addAttribute("status", "8");
			break;
		case 11:  // 접수
			fm.setSearchStatus(1);
			model.addAttribute("status", "11");
			break;
		case 12:  // 검토중
			fm.setSearchStatus(2);
			model.addAttribute("status", "12");
			break;
		case 13:  // 처리중
			fm.setSearchStatus(12);
			model.addAttribute("status", "13");
			break;
		case 14:  // 완료
			fm.setSearchStatus(16);
			model.addAttribute("status", "14");
			break;
		case 15:  // 보류
			fm.setSearchStatus(32);
			model.addAttribute("status", "15");
			break;
		case 16:  // 삭제
			fm.setSearchStatus(64);
			model.addAttribute("status", "16");
			break;
		case 17:  // 개발완료
			fm.setSearchStatus(8);
			model.addAttribute("status", "17");
			break;
		case 18:  // 14일 이내 요구사항
			fm.setSearchStatus(15);
			model.addAttribute("status", "18");
			break;
		case 19:  // 30일 이내 요구사항
			fm.setSearchStatus(15);
			model.addAttribute("status", "19");
			break;
		}
		
		// TENY_170625 요구사항 페이지 처리
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(fm.getPageIndex());
		paginationInfo.setRecordCountPerPage(fm.getPageUnit());
		paginationInfo.setPageSize(fm.getPageSize());

		fm.setFirstIndex(paginationInfo.getFirstRecordIndex());
		fm.setLastIndex(paginationInfo.getLastRecordIndex());
		fm.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		fm.setToday(today);
		fm.setThisMonth(today.substring(0, 6));
		fm.setNextMonth(nextOneMonth.substring(0, 6));
		fm.setThisMonthStart(thisMonthStart);
		fm.setThisMonthEnd(thisMonthEnd);
		fm.setNextMonthEnd(nextOneMonthEnd);
		
		
		List <RequestVO> rVOList = requestDAO.selectRequestList(fm);
		for(RequestVO rvo : rVOList) {
			/**
			 * 처리예정 색 지정
			 */
			if(StringUtils.isNotEmpty(rvo.getRegDatetime())) {
				int dayCheck = CalendarUtil.getRequestCalCheckNowDate(rvo.getRegDatetime());
				rvo.setDayCheck(dayCheck);
			}
			/**
			 * 완료예정 색 지정
			 */
			if(StringUtils.isNotEmpty(rvo.getDueDate())) {
				int dueDayCheck = CalendarUtil.getRequestCalCheckNowDate(rvo.getDueDate());
				rvo.setDueDayCheck(dueDayCheck);
			}
		}
		logT.debug("rVOList : " + rVOList.size());

		int totCnt = requestDAO.selectRequestListTotCnt(fm);

		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("rVOList", rVOList);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("user", user);
		model.addAttribute("mode", mode);

		
		
		logT.debug("END");
		return "request/RequestList";
	}
	
	// TENY_170514 새로운 요구사항을 작성한는 화면을 띄우는 기능
	@RequestMapping("/request/RequestWritePop.do")
	public String RequestWritePop(
			@ModelAttribute("fm") RequestFm requestFm,
			Map<String,Object> commandMap,
			HttpServletRequest req, 
			ModelMap model) throws Exception {
	
		logT.debug("START");
		
		RequestVO rVO = new RequestVO();
		rVO.setRegDatetime(CalendarUtil.getToday());
		
		model.addAttribute("rVO", rVO);
		model.addAttribute("edit", true);
		
		logT.debug("END request/RequestWritePop");
		return "request/RequestEditorPop";
	}
	
	// TENY_170514 요구사항을 수정하는 화면을 띄우는 기능
	@RequestMapping("/request/modifyRequestPop.do")
	public String modifyRequestPop(
			@ModelAttribute("fm") RequestFm fm,
			RequestVO reqVO,
			RequestReceiveVO receiveVo,
			Map<String,Object> commandMap,
			HttpServletRequest req,
			ModelMap model) throws Exception {
	
		logT.debug("START");
		
		RequestVO rVO = (RequestVO) requestDAO.getRequest(reqVO.getNo());
		
		//수정준인 사용자가 있는지 검색
		MemberVO user = SessionUtil.getMember(req);
		
		if(rVO.getModifyerNo() != 0) {
//			if(rVO.getModifyerNo() !=  user.getNo()) {
//				model.addAttribute("message", rVO.getModifyerName()+" 님이 수정중입니다.");
//				return("error/messageModifyError");
//			}
		} else {
			rVO.setModifyerNo(user.getNo());
			rVO.setModifyerName(user.getUserNm());
			requestDAO.updateRequestModifyer(rVO);
		}
		
		model.addAttribute("rVO", rVO);
		model.addAttribute("user", user);
		
		//요구사항 복수 담당자를 조회한다.
		receiveVo.setReqId(rVO.getReqId());
		List<RequestReceiveVO> reqUserList = requestDAO.getRequestReceive(receiveVo);
		model.addAttribute("reqUserList", reqUserList);			

		model.addAttribute("edit", true);
		
		logT.debug("END");
		return "request/RequestEditorPop";
	}

	// TENY_170514 작성된 요구사항을 저장하는 기능
	@RequestMapping("/request/saveRequest.do")
	public String saveRequest(
			@ModelAttribute("fm") RequestFm fm,
			RequestVO reqVO,
			RequestReceiveVO reqReceiveVO,
			Map<String,Object> commandMap, 
			MultipartHttpServletRequest multiRequest,
			ModelMap model) throws Exception {
	
		logT.debug("START");
		
		// 요구사항의 세부내용에 쓸데없는 정보를 제거한다.
		String contents = reqVO.getContents();
		reqVO.setContents(reqVO.getContents());

		// 새로 작성된 글은 작성자를 접속사용자로 한다.
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		// 수정시 첨부파일 처리방식
		// 		1. 삭제는 ajax로 화면에서 처리
		// 		2. 새로 업로드 된 파일만 처리
		// 기존의 file ID를 얻는다.
		String atchFileId = reqVO.getAtchFileId();
		
		//기존 file ID가 
		if("empty".equals(atchFileId)){
			atchFileId = "";
		}
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId)) {
				List<FileVO> result = fileUtil.parseFileInf(files, "REQ_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				reqVO.setAtchFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "REQ_", cnt, atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}	 
		
		// 파일 ID를 DB에 넣을 준비를 한다.
		if("".equals(atchFileId) || atchFileId == null) 
			atchFileId = "empty";
		reqVO.setAtchFileId(atchFileId);

		
		if(reqVO.getNo() == 0){ // 새로 등록되는 글
			logT.debug("insert");
			//req_id 를 불러온다.
			String req_id = requestDAO.selectRequestReqId();		
			reqReceiveVO.setReqId(req_id);
			//LYS_20180712_요구사항 담당자를 추가한다.
			reqReceiveVO.setReqUserIdList(CommonUtil.parseIdFromMixs(reqVO.getManagerMixes()));					
			reqVO.setWriterNo(user.getNo());
			reqVO.setReqId(req_id);
			
			requestDAO.insertRequest(reqVO);
			if(reqReceiveVO.getReqUserIdList() != null){
				requestDAO.insertRequestReceive(reqReceiveVO);
			}
			logT.debug("END");
			return "/common/returnPage/windowReloadNClose";
		} 
		else {
			logT.debug("update");
			reqVO.setModifyerNo(0);
			reqVO.setModifyerName("");
			requestDAO.updateRequest(reqVO);
			//요구사항 담당자를 삭제 후 재 등록한다.
			reqReceiveVO.setReqId(reqVO.getReqId());
			//LYS_20180712_요구사항 담당자를 추가한다.
			List<RequestReceiveVO> reqUserList = requestDAO.getRequestReceive(reqReceiveVO);
			reqReceiveVO.setReqUserIdList(CommonUtil.parseIdFromMixs(reqVO.getManagerMixes()));
			requestDAO.deleteRequestReceive(reqReceiveVO);
			if(reqReceiveVO.getReqUserIdList() != null){
				requestDAO.insertRequestReceive(reqReceiveVO);
			}
			List<RequestReceiveVO> reqUserListNew = requestDAO.getRequestReceive(reqReceiveVO);
			//요구사항 담당자 Complete 값 update
			for(RequestReceiveVO rU : reqUserList){
				for(RequestReceiveVO rUnew : reqUserListNew){
					if((rU.getUserNm()+rU.getUserId()).equals(rUnew.getUserNm()+rUnew.getUserId())){
						RequestReceiveVO newReceiveVo = new RequestReceiveVO();
						newReceiveVo.setNo(rUnew.getNo());
						newReceiveVo.setCompleteStatus(rU.getCompleteStatus());
						newReceiveVo.setCompleteDateTime(rU.getCompleteDateTime());
						requestDAO.updateRequestReceiveComplete(newReceiveVo);
					}
				}
				
			}
			
			model.addAttribute("no", reqVO.getNo());

			logT.debug("END");
			return "/common/returnPage/windowReloadNClose";
		}
	}

	/* TENY_170514 요구사항 관리의 목록 조회 */
	@RequestMapping("/request/RequestL.do")
	public String RequestL(@ModelAttribute("fm") RequestFm fm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");

		// 검색 조건
		// 1. 기본 검색조건 : 나에게 요청된 현재 처리되지 않은 요구사항 목록을 조회한다. 
		// 		우선순위 미열람, 긴급사항, 최신  
		// 2. 검색조건 : 담당자, 작성자, 긴급도, 상태, 요구사항 제목, 
		MemberVO user = SessionUtil.getMember(req);		
		
		// 검색조건 요구사항을 조회한다.
		if(fm.getSearchUseYn().equals("Y")) {
			
		} else { // 검색조건이 없을 경우
//			fm.setPageUnit(	propertyService.getInt("pageUnit_15"));
//			fm.setPageUnit(	propertyService.getInt("pageUnit"));
//			fm.setPageSize(propertyService.getInt("pageSize"));

			fm.setReqType1(1);
			fm.setReqType2(2);
			fm.setReqType3(4);
			fm.setReqType4(8);
			fm.setStatus1(1);
			fm.setStatus2(2);
			fm.setStatus3(4);
			fm.setStatus4(8);
			fm.setStatus5(16);
			fm.setStatus6(0);
			fm.setStatus7(0);
		}
		fm.setSearchReqType(fm.getReqType1() + fm.getReqType2() + fm.getReqType3() + fm.getReqType4());
		fm.setSearchStatus(fm.getStatus1() + fm.getStatus2() + fm.getStatus3() + fm.getStatus4() + fm.getStatus5() + fm.getStatus6()  + fm.getStatus7());
		
		// TENY_170625 요구사항 페이지 처리
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(fm.getPageIndex());
		paginationInfo.setRecordCountPerPage(fm.getPageUnit());
		paginationInfo.setPageSize(fm.getPageSize());

		fm.setFirstIndex(paginationInfo.getFirstRecordIndex());
		fm.setLastIndex(paginationInfo.getLastRecordIndex());
		fm.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		fm.setModeChk(1);
		
		List <RequestVO> rVOList = requestDAO.selectRequestList(fm);
		for(RequestVO rvo : rVOList) {
			/**
			 * 처리예정 색 지정
			 */
			if(StringUtils.isNotEmpty(rvo.getRegDatetime())) {
				int dayCheck = CalendarUtil.getRequestCalCheckNowDate(rvo.getRegDatetime());
				rvo.setDayCheck(dayCheck);
			}
			/**
			 * 완료예정 색 지정
			 */
			if(StringUtils.isNotEmpty(rvo.getDueDate())) {
				int dueDayCheck = CalendarUtil.getRequestCalCheckNowDate(rvo.getDueDate());
				rvo.setDueDayCheck(dueDayCheck);
			}
		}
		int totCnt = requestDAO.selectRequestListTotCnt(fm);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("rVOList", rVOList);
		model.addAttribute("paginationInfo", paginationInfo);

		logT.debug("END");
		return "request/RequestL";
	}
	
	// TENY_170516 요구사항을 조회하는 화면을 띄우는 기능
	@RequestMapping("/request/RequestV.do")
	public String RequestV(@ModelAttribute("fm") RequestFm fm, RequestVO vo, RequestReceiveVO receiveVo,
			Map<String,Object> commandMap,
			ModelMap model) throws Exception {
	
		logT.debug("START");
		RequestVO rVO = (RequestVO) requestDAO.getRequest(vo.getNo());
		model.addAttribute("rVO", rVO);
		

		
		//요구사항 복수 담당자를 조회한다.
		receiveVo.setReqId(rVO.getReqId());
		List<RequestReceiveVO> reqUserList = requestDAO.getRequestReceive(receiveVo);
		model.addAttribute("reqUserList", reqUserList);

		// 요구사항번호(ReqNo)를 기준으로 검토목록을 조회한다.
		 List<ReviewVO> rvVOList = requestDAO.selectReviewList(vo.getNo());
		model.addAttribute("rvVOList", rvVOList);

		// 요구사항번호(ReqNo)를 기준으로 작업목록을 조회한다.
		 List<ReqTaskVO> rtVOList = requestDAO.selectReqTaskList(vo.getNo());
		model.addAttribute("rtVOList", rtVOList);

		logT.debug("END");
		return "request/RequestEditorPop";
	}

	/* TENY_170611 요구사항 관리의 요구사항 처리 통계 조회 */
	@RequestMapping("/request/RequestStat.do")
	public String RequestStat(@ModelAttribute("fm") RequestFm fm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		//LYS_20180717_구분 데이터 가져오기
		String today = CalendarUtil.getToday();
		if(today.length() != 8) {
			logT.error("Error in CalendarUtil.getToday()");
			return "";
		}
		
		// 검색 조건
		// 1. 기본 검색조건 : 특정기간동안 개인별의 요구사항 처리실적을 확인한다. 
		// 		요구사항 신규 발생건수, 처리건수, 미처리건수  
		// 2. 검색조건 : 담당자, 시작일, 마지막일 
		/**
		 * LYS_20181227_처음은 이번주로 검색 되도록 추가
		 */
		if("".equals(fm.getSearchDueDateFrom()) && "".equals(fm.getSearchDueDateTo())){
			fm.setSearchDueDateFrom(CalendarUtil.getFirstDateOfThisWeek2(today));
			fm.setSearchDueDateTo(CalendarUtil.getLastDateOfThisWeek2(today));
		}
		
		EgovMap ReqStat = requestDAO.selectRequestProcessStat(today,fm);
		model.addAttribute("ReqStat", ReqStat);
		
		List <RequestVO> rVOList = requestDAO.selectRequestStat(fm);

		model.addAttribute("rVOList", rVOList);
//		model.addAttribute("rVO", rVO);  // atDate(찾고자하는 일자), writerNo, writerName을 보낸다.
		
		logT.debug("END");
		return "request/RequestStat";
	}


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 요구사항 작업관리 관련 함수들
	// TENY_170517 요구사항의 작업을 등록하는 화면을 띄우는 기능
	@RequestMapping("/request/ReqTaskW.do")
	public String ReqTaskW(@ModelAttribute("fm") ReqTaskFm fm, ReqTaskVO rtVO
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		MemberVO user = SessionUtil.getMember(req);
		rtVO.setWorkerNo(user.getNo());
		rtVO.setWorkerId(user.getUserId());
		rtVO.setWorkerName(user.getUserNm());
		rtVO.setWorkerMixes(user.getUserNm() + "(" + user.getUserId() + ")" );
		rtVO.setPriority(4);
		rtVO.setTaskType(4);
		rtVO.setStatus(1);
		rtVO.setWriterName(user.getUserNm());
		model.addAttribute("rtVO", rtVO);

		logT.debug("END");
		return "request/ReqTaskWMPop";
	}

	// TENY_170514 작성된 요구사항작업을 저장하는 기능
	@RequestMapping("/request/saveReqTask.do")
	public String saveReqTask(@ModelAttribute("fm") ReqTaskFm fm, ReqTaskVO vo
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		MemberVO user = SessionUtil.getMember(req);
		if(vo.getNo() == 0){ // 새로 등록되는 글
			logT.debug("insert");
			vo.setWriterNo(user.getNo());
			requestDAO.insertReqTask(vo);
			logT.debug("END");
			return "/common/returnPage/windowReloadNClose";
		}
		else {
			logT.debug("update");
			requestDAO.updateReqTask(vo);
			model.addAttribute("no", vo.getNo());

			logT.debug("END");
			if("Y".equals(fm.getSearchReload()) == true) {
				return "/common/returnPage/windowReloadNClose";
			} else {
				return "redirect:/request/ReqTaskV.do";
			}
				
		}

	}
	
	// TENY_170517 요구사항의 작업을 조회하는 화면을 띄우는 기능
	@RequestMapping("/request/ReqTaskV.do")
	public String ReqTaskV(@ModelAttribute("fm") ReqTaskFm fm, ReqTaskVO vo
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		// TENY_170518 요구사항 작업내용을 조회
		ReqTaskVO rtVO = (ReqTaskVO) requestDAO.getReqTask(vo.getNo());
		model.addAttribute("rtVO", rtVO);
	
		fm.setSearchReload("N");
		
		logT.debug("END");
		return "request/ReqTaskVPop";
	}

	// TENY_170517 요구사항의 작업을 수정하는 화면을 띄우는 기능
	@RequestMapping("/request/ReqTaskM.do")
	public String ReqTaskM(@ModelAttribute("fm") ReqTaskFm fm, ReqTaskVO vo
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		// TENY_170518 요구사항 작업내용을 조회
		ReqTaskVO rtVO = (ReqTaskVO) requestDAO.getReqTask(vo.getNo());
		model.addAttribute("rtVO", rtVO);

		// TENY_170518 요구사항 정보를 조회
		if(rtVO != null) {
			RequestVO rVO = (RequestVO) requestDAO.getRequest(rtVO.getReqNo());
			if(rVO != null) {
				model.addAttribute("reqId", rVO.getReqId());
				model.addAttribute("reqTitle", rVO.getTitle());
			}
		}

		logT.debug("END");
		return "request/ReqTaskWMPop";
	}

	/* TENY_170514 요구사항 작업목록 조회 */
	@RequestMapping("/request/ReqTaskL.do")
	public String ReqTaskL(@ModelAttribute("fm") ReqTaskFm fm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");

		// 검색 조건
		// 1. 기본 검색조건 : 나에게 지정된 현재 처리되지 않은 작업목록을 조회한다. 
		// 		우선순위 미열람, 긴급사항, 최신  
		// 2. 검색조건 : 담당자, 작성자, 긴급도, 상태, 요구사항 제목, 
		MemberVO user = SessionUtil.getMember(req);

		// 검색조건 요구사항을 조회한다.
		if(fm.getSearchUseYn().equals("Y")) {
			
		} else { // 검색조건이 없을 경우
			fm.setPageUnit(	propertyService.getInt("pageUnit"));
			fm.setPageSize(propertyService.getInt("pageSize"));

			fm.setTaskType1(1);
			fm.setTaskType2(2);
			fm.setTaskType3(4);
			fm.setTaskType4(8);
			fm.setTaskType5(16);
			fm.setTaskType6(32);
			fm.setTaskType7(64);

			fm.setStatus1(1);
			fm.setStatus2(2);
			fm.setStatus3(4);

			fm.setPriority1(1);
			fm.setPriority2(2);
			fm.setPriority3(4);
			fm.setPriority4(8);

			fm.setSearchWorkerMixes(user.getUserNm() + "(" + user.getUserId() + ")" );
		}
		fm.setSearchTaskType(fm.getTaskType1() + fm.getTaskType2() + fm.getTaskType3() + fm.getTaskType4() + fm.getTaskType5() + fm.getTaskType6() + fm.getTaskType7());
		fm.setSearchStatus(fm.getStatus1() + fm.getStatus2() + fm.getStatus3());
		fm.setSearchPriority(fm.getPriority1() + fm.getPriority2() + fm.getPriority3() + fm.getPriority4());
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(fm.getPageIndex());
		paginationInfo.setRecordCountPerPage(fm.getPageUnit());
		paginationInfo.setPageSize(fm.getPageSize());

		fm.setFirstIndex(paginationInfo.getFirstRecordIndex());
		fm.setLastIndex(paginationInfo.getLastRecordIndex());
		fm.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List <ReqTaskVO> rtVOList = requestDAO.selectReqTaskList(fm);
		int totCnt = requestDAO.selectReqTaskListTotCnt(fm);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("rtVOList", rtVOList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		logT.debug("END");
		return "request/ReqTaskL";
	}

	/* TENY_170611 요구사항 관리의 요구사항 처리 통계 조회 */
	@RequestMapping("/request/ReqTaskStat.do")
	public String ReqTaskStat(@ModelAttribute("fm") ReqTaskFm fm
			, Map<String,Object> commandMap
			, HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");

		// 검색 조건
		// 1. 기본 검색조건 : 특정기간동안 개인별의 작업 처리실적을 확인한다. 
		// 		작업 신규 발생건수, 처리건수, 미처리건수  
		// 2. 검색조건 : 담당자, 시작일, 마지막일 

		List <ReqTaskVO> rtVOList = requestDAO.selectReqTaskStat(fm);

		model.addAttribute("rtVOList", rtVOList);
		
		logT.debug("END");
		return "request/ReqTaskStat";
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 요구사항 검토내용 관련 함수들
	// TENY_170517 요구사항의 검토내용을 등록하는 화면을 띄우는 기능
	@RequestMapping("/request/ReviewW.do")
	public String ReviewW(@ModelAttribute("fm") ReviewVO vo,
			Map<String,Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
/*		RequestVO rVO = (RequestVO) requestDAO.getRequest(vo.getReqNo());

//		ReviewVO rtVO = (ReviewVO) requestDAO.getReview(vo.getNo());
//		model.addAttribute("rtVO", rtVO);

		if(rVO != null) {
			model.addAttribute("reqNo", rVO.getNo());
			model.addAttribute("reqId", rVO.getReqId());
			model.addAttribute("reqTitle", rVO.getTitle());
		}
*/
		model.addAttribute("reqNo", vo.getReqNo());
		model.addAttribute("mode", "C");
		
		logT.debug("END");
		return "/request/ReviewWMPop";
	}

	// TENY_170514 작성된 요구사항 검토내용을 저장하는 기능
	@RequestMapping("/request/saveReview.do")
	public String saveReview(@ModelAttribute("fm") ReviewVO vo,
			Map<String,Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		MemberVO user = SessionUtil.getMember(req);
		if(vo.getNo() == 0){ // 새로 등록되는 글
			logT.debug("insert");
			vo.setWriterNo(user.getNo());
			requestDAO.insertReview(vo);
		}
		else {
			logT.debug("update");
			requestDAO.updateReview(vo);
			model.addAttribute("no", vo.getNo());
		}
		logT.debug("END");
		return "/common/returnPage/windowReloadNClose";
	}
	
	// TENY_170517 요구사항의 검토내용을 수정하는 화면을 띄우는 기능
	@RequestMapping("/request/ReviewM.do")
	public String ReviewM(@ModelAttribute("fm") ReviewVO vo,
			Map<String,Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		MemberVO user = SessionUtil.getMember(req);
		// TENY_170518 요구사항 검토내용을 조회
		ReviewVO rvVO = (ReviewVO) requestDAO.getReview(vo.getNo());
		model.addAttribute("rvVO", rvVO);

		// TENY_170518 요구사항 정보를 조회
		if(rvVO != null) {
			RequestVO rVO = (RequestVO) requestDAO.getRequest(rvVO.getReqNo());
			if(rVO != null) {
				model.addAttribute("reqNo", rvVO.getNo());
			}
		}

		model.addAttribute("mode", "M");
		model.addAttribute("user", user);
		logT.debug("END");
		return "/request/ReviewWMPop";
	}
	
	@RequestMapping(value = "/request/updateTaskStatusAjax.do")
	public void updateTaskStatusAjax(@ModelAttribute("searchVO") ReqTaskVO vo,
			HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		logT.debug("START");

		JSONObject result = new JSONObject();
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		requestDAO.updateReqTaskStatus(vo);
		result.put("RETURN", "OK");
		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
		logT.debug("END");
	}
	
	@RequestMapping("/request/deleteReview.do")
	public String deleteReview(@ModelAttribute("fm") ReviewVO vo,
			Map<String,Object> commandMap,
			HttpServletRequest req, ModelMap model) throws Exception {
	
		logT.debug("START");
		
		requestDAO.deleteReview(vo.getNo());
		
		logT.debug("END");
		return "/common/returnPage/windowReloadNClose";
	}	
	
	@RequestMapping(value = "/request/completeStatusAjax.do")
	public void completeStatusAjax(@ModelAttribute("fm") RequestReceiveVO reqReceiveVO,
			HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		logT.debug("START");

		JSONObject result = new JSONObject();
		
		String getThisTime = CalendarUtil.getThisTime();
		if(reqReceiveVO.getCompleteStatus() == 1){
			reqReceiveVO.setCompleteDateTime(getThisTime);
		}else{
			reqReceiveVO.setCompleteDateTime("");
			getThisTime = "";
		}		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		requestDAO.updateRequestReceiveComplete(reqReceiveVO);
		
		result.put("RETURN", "OK");
		result.put("UPDATETIME", getThisTime);
		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
		logT.debug("END");
	}	
	
	
	@RequestMapping(value = "/request/modifyerCloseAjax.do")
	public void requestModifyerCloseAjax(@ModelAttribute("fm") RequestVO reqVO,
			HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception {
		logT.debug("START");
		
		JSONObject result = new JSONObject();
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		reqVO.setModifyerNo(0);
		reqVO.setModifyerName("");
		requestDAO.updateRequestModifyer(reqVO);
		
		result.put("RETURN", "OK");
		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
		logT.debug("END");
	}	
	
	@RequestMapping(value = "/request/isModifyUserAjax.do")
	public void isModifyUserAjax(@ModelAttribute("fm") RequestVO reqVO,
			HttpServletRequest req, HttpServletResponse res,
			ModelMap model) throws Exception{
		logT.debug("START");
		
		JSONObject result = new JSONObject();
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();
		
		if(reqVO.getNo() != 0) {
			RequestVO rVO = requestDAO.getRequest(reqVO.getNo());
			MemberVO user = SessionUtil.getMember(req);
			
			if(rVO.getModifyerNo() != 0) {
				if(rVO.getModifyerNo() != user.getNo()) {
					result.put("RETURN", "NO");
					result.put("MODIFYER", rVO.getModifyerName());
				}else {
					result.put("RETURN", "OK");
				}
			}else {
				result.put("RETURN", "OK");
			}
		}else{
			result.put("RETURN", "OK");
		}

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
		
		logT.debug("END");
	}
}
