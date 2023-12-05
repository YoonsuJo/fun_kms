package kms.com.community.web;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.admin.score.service.ScoreService;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.service.impl.CommonDAO;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CalendarUtil;

import kms.com.community.service.BBSAttributeManageService;
import kms.com.community.service.BBSManageService;
import kms.com.community.service.Board;
import kms.com.community.service.BoardMaster;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.Schedule;
import kms.com.community.service.ScheduleService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *   2009.06.29	한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@Controller
public class BBSManageController {

	@Resource(name = "KmsBBSManageService")
	private BBSManageService bbsMngService;

	@Resource(name = "KmsBBSAttributeManageService")
	private BBSAttributeManageService bbsAttrbService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsScheduleService")
	private ScheduleService scheduleService;
	
	@Resource(name = "ScoreService")
	private ScoreService scoreService;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Resource(name = "KmsCommonDAO")
	private CommonDAO commonDAO;
	
	@Autowired
	private DefaultBeanValidator beanValidator;

	Logger log = Logger.getLogger(this.getClass());

	/**
	 * 게시물에 대한 목록을 조회한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/community/selectBoardList.do", "/support/selectBoardList.do", "/admin/selectBoardList.do", "/expansion/selectBoardList.do"}) 
	public String selectBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
	
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setBbsNm(boardVO.getBbsNm());
		boardVO.setFrstRegisterId(user.getStringNo());
	
		int pageUnit = propertyService.getInt("pageUnit_15");
		String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_board_pageunit");
		if (pageUnitCookie != null) 
			pageUnit = Integer.parseInt(pageUnitCookie);
		
		boardVO.setPageUnit(pageUnit);
		boardVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "");
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));		
		paginationInfo.setTotalRecordCount(totCnt);
	
		BoardMasterVO master = new BoardMasterVO();		
		master.setBbsId(boardVO.getBbsId());		
		BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("bdMstr", masterVo);
		model.addAttribute("paginationInfo", paginationInfo);
	
		if (masterVo.getBbsTyCode().equals("COMM")){
			if(masterVo.getBbsAttrbCode().equals("GOODMO"))  // 82:첫출근 인사말
				return "community/comm_GoodmorningL";
			else if(masterVo.getBbsAttrbCode().equals("SOLBBS"))  // 85:솔루션 게시판,  
				return "community/comm_SolutionL";
			else if(masterVo.getBbsAttrbCode().equals("COMMON"))  // 1:자유게시판, 34:개발TIP, 73:테스트, 81:상품정보, 83:제안게시판
				return "community/comm_FreeL";
			else if(masterVo.getBbsAttrbCode().equals("DISCUS"))  // 29:토론,  
				return "community/comm_DiscussL";
			else if(masterVo.getBbsAttrbCode().equals("SCHDL"))  // 30:경조사
				return "community/comm_FamilyeventL";
		} else if(masterVo.getBbsTyCode().equals("SPRT")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000031")) // 공지사항
				return "community/sprt_noticeL";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000033")) // 알림공지
				return "community/sprt_noticeL";
			else if (masterVo.getBbsId().equals("BBSMSTR_000000000050")) // 회사자료
				return "support/sprt_processInfoL";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000061")) // 한마음 개선요청
				return "community/sprt_kmsSuggestL";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000062"))  // 건의/제안
				return "community/sprt_suggestL";
			else 
				return "support/sprt_noticeL";  // 51:솔루션자료, 52:각종양식, 53:업무처리절차
		} else if(masterVo.getBbsTyCode().equals("ADMN")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000002"))
				return "admin/bbs/adminL";
		} else if (masterVo.getBbsTyCode().equals("EXPS")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000080"))
				return "expansion/exps_suggestL";
		}
		return "cop/bbs/EgovNoticeList";
	}

	@RequestMapping("/community/selectUnreadBoardList.do")
	public String selectUnreadBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
	
		boardVO.setBbsTyCode(null);
		boardVO.setBbsTyCodeArray("COMM,SPRT".split(","));		
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardVO.setPageSize(propertyService.getInt("pageSize"));
		boardVO.setFrstRegisterId(user.getStringNo());
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = bbsMngService.selectUnreadBoardArticles(boardVO, "");
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
	
		BoardMasterVO master = new BoardMasterVO();
		
		BoardMasterVO masterVO = bbsAttrbService.selectBBSMasterInf(master);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("bdMstr", masterVO);
		model.addAttribute("paginationInfo", paginationInfo);
	
		return "community/comm_UnreadL";
	}
	
	@RequestMapping("/community/selectUnreadBoardBatch.do")
	public String selectUnreadBoardArticlesBatch(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
	
		boardVO.setBbsTyCode(null);
		boardVO.setBbsTyCodeArray("COMM,SPRT".split(","));
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardVO.setPageSize(propertyService.getInt("pageSize"));
		boardVO.setRecordCountPerPage(1000);
		boardVO.setFrstRegisterId(user.getStringNo());
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = bbsMngService.selectUnreadBoardArticles(boardVO, "");
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
	
		BoardMasterVO master = new BoardMasterVO();
		
		BoardMasterVO masterVO = bbsAttrbService.selectBBSMasterInf(master);
		
		JSONArray docIdList = new JSONArray();
		JSONArray bbsIdList = new JSONArray();
		List<BoardVO> resultList =(List<BoardVO>) map.get("resultList");
		for(BoardVO tempVO : resultList)
		{
			docIdList.add(tempVO.getNttId());
			bbsIdList.add(tempVO.getBbsId());
		}

		model.addAttribute("docIdList", docIdList.toString());
		model.addAttribute("bbsIdList", bbsIdList.toString());
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("bdMstr", masterVO);
		model.addAttribute("paginationInfo", paginationInfo);
	
		return "community/comm_UnreadV_All";
	}

	
	
	/**
	 * 게시물 등록을 위한 등록페이지로 이동한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/community/addBoardArticle.do", "/support/addBoardArticle.do", "/admin/addBoardArticle.do", "/expansion/addBoardArticle.do"})
	public String addBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	
		BoardMasterVO masterVo = new BoardMasterVO();
	
		BoardMasterVO vo = new BoardMasterVO();
		vo.setBbsId(boardVO.getBbsId());

		masterVo = bbsAttrbService.selectBBSMasterInf(vo);
		model.addAttribute("bdMstr", masterVo);
		model.addAttribute("param_returnUrl", boardVO.getParam_returnUrl());
		
		if (masterVo.getBbsTyCode().equals("COMM")){
			if(masterVo.getBbsAttrbCode().equals("GOODMO"))  // 82:첫출근 인사말
				return "community/comm_GoodmorningW";
			else if(masterVo.getBbsAttrbCode().equals("SOLBBS"))  // 85:솔루션 게시판,  
				return "community/comm_SolutionW";
			else if(masterVo.getBbsAttrbCode().equals("COMMON"))  // 1:자유게시판, 34:개발TIP, 73:테스트, 81:상품정보, 83:제안게시판
				return "community/comm_FreeW";
			else if(masterVo.getBbsAttrbCode().equals("DISCUS"))  // 29:토론,  
				return "community/comm_DiscussW";
			else if(masterVo.getBbsAttrbCode().equals("SCHDL"))  // 30:경조사
				return "community/comm_FamilyeventW";
		} else if(masterVo.getBbsTyCode().equals("SPRT")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000031")) // 공지사항
				return "community/sprt_noticeW";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000033")) // 알림공지
				return "community/sprt_noticeW";
			else if (masterVo.getBbsId().equals("BBSMSTR_000000000050")) // 회사자료
				return "support/sprt_processInfoW";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000061")) // 한마음 개선요청
				return "community/sprt_kmsSuggestW";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000062"))  // 건의/제안
				return "community/sprt_suggestW";
			else 
				return "support/sprt_noticeW";  // 51:솔루션자료, 52:각종양식, 53:업무처리절차
		} else if(masterVo.getBbsTyCode().equals("ADMN")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000002"))
				return "admin/bbs/adminW";
		} else if (masterVo.getBbsTyCode().equals("EXPS")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000080"))
				return "expansion/exps_suggestW";
		}
		return "cop/bbs/EgovNoticeRegist";
	}

	/**
	 * 게시물을 등록한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/community/insertBoardArticle.do", "/support/insertBoardArticle.do", "/admin/insertBoardArticle.do", "/expansion/insertBoardArticle.do"})
	public String insertBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
		@ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
		ModelMap model) throws Exception {

		
		String param_returnUrl = multiRequest.getParameter("param_returnUrl");
		model.addAttribute("param_returnUrl", param_returnUrl);
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		List<FileVO> result = null;
		String atchFileId = "";
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		board.setAtchFileId(atchFileId);
		board.setFrstRegisterId(user.getStringNo());
		board.setBbsId(board.getBbsId());
		
		board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		
		long nttId = bbsMngService.insertBoardArticle(board);
		
		if (board.getExChk().equals("Y")) {
			Schedule schedule = new Schedule();
			
			schedule.setScheSj(board.getNttSj());
			schedule.setScheTyp("C");
			schedule.setUserNo(user.getNo());
			schedule.setScheYear(board.getExDt().substring(0,4));
			schedule.setScheMonth(board.getExDt().substring(4,6));
			schedule.setScheDate(board.getExDt().substring(6,8));
			schedule.setScheTmTyp(board.getExHm().equals("") ? "0" : "1");
			schedule.setScheTmFrom(board.getExHm() + ":00");
			schedule.setScheCn(board.getNttCn());
			
			scheduleService.addSchedule(schedule);
		}
		//status.setComplete();
		
		if (bdMstr.getBbsId().equals("BBSMSTR_000000000061")) {
			return "redirect:selectBoardList.do?bbsId=" + boardVO.getBbsId();
		}else if (bdMstr.getBbsId().equals("BBSMSTR_000000000082")) { //첫 출근 게시판		
			return "cooperation/closePage";
		} else {
			return "redirect:selectBoardArticle.do?bbsId=" + boardVO.getBbsId() + "&nttId=" + nttId;
		}
	}
	
	/**
	 * 게시물에 대한 상세 정보를 조회한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/community/selectBoardArticle.do", "/support/selectBoardArticle.do", 
			"/admin/selectBoardArticle.do", "/expansion/selectBoardArticle.do", "/mypage/selectBoardArticle.do"})
	public String selectBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		//nttId, bbsId, readBool
		boardVO.setPlusCount(true);
	
		boardVO.setLastUpdusrId(user.getStringNo());
		boardVO.setFrstRegisterId(user.getStringNo());
		BoardVO vo = bbsMngService.selectBoardArticle(boardVO);
	
		model.addAttribute("result", vo);
		//이미 jsp 단에서 어떻게인가 user 객체를 사용하고 있음
		//model.addAttribute("user", user);
	
		model.addAttribute("sessionUniqId", user.getStringNo());
	
		BoardMasterVO master = new BoardMasterVO();
		
		master.setBbsId(boardVO.getBbsId());
		
		BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);
	
		model.addAttribute("brdMstrVO", masterVo);
		
		if (boardVO.getAjaxMode() == 1) {
			if (masterVo.getBbsTyCode().equals("COMM") ){
				if(masterVo.getBbsAttrbCode().equals("COMMON")) {
					return "community/comm_FreeV_Content";
				} else if(masterVo.getBbsAttrbCode().equals("DISCUS")) {
					return "community/comm_DiscussV_Content";
				} else if(masterVo.getBbsAttrbCode().equals("SCHDL")) {
					return "community/comm_FamilyeventV_Content";
				}
			}
		}
		
		if (masterVo.getBbsTyCode().equals("COMM") ){
			if(masterVo.getBbsAttrbCode().equals("SOLBBS")) { // 85:솔루션 게시판,  
				return "community/comm_SolutionV";
			} else if(masterVo.getBbsAttrbCode().equals("COMMON")) {
				return "community/comm_FreeV";
			} else if(masterVo.getBbsAttrbCode().equals("DISCUS")) {
				return "community/comm_DiscussV";
			} else if(masterVo.getBbsAttrbCode().equals("SCHDL")) {
				return "community/comm_FamilyeventV";
			} else if(masterVo.getBbsAttrbCode().equals("GOODMO")) {
				MemberVO writerVO = new MemberVO();
				writerVO.setNo(Integer.parseInt(vo.getFrstRegisterId()));
				
				//writerVO 세팅
				writerVO = memberService.selectMemberBasic(writerVO);
				model.addAttribute("writerVO", writerVO);

				//기존 근무현황 정보
				EgovMap state = memberService.selectMemberState(writerVO); //selectMemberState 전체 코드에서 여기서만 호출
				model.addAttribute("state", state);
				
				MemberVO memberVO = new MemberVO();
				memberVO.setNo(user.getNo()); //체크리스트는 현제 로그인 사용자 정보를 가져옴
				List<EgovMap> list = commonDAO.getCheckList(memberVO);
				EgovMap checkList = new EgovMap();
				
				for (int i=0; i<list.size(); i++) {
					EgovMap t = list.get(i);
					checkList.put(t.get("id"), t.get("cnt"));
				}
				model.addAttribute("checkList", checkList);			
				
				return "community/comm_GoodmorningV";		
			}
		} else if(masterVo.getBbsTyCode().equals("SPRT")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000031")) // 공지사항
				return "community/sprt_noticeV";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000033")) // 알림공지
				return "community/sprt_noticeV";
			else if (masterVo.getBbsId().equals("BBSMSTR_000000000050")) // 회사자료
				return "support/sprt_processInfoV";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000061")) // 한마음 개선요청
				return "community/sprt_kmsSuggestV";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000062"))  // 건의/제안
				return "community/sprt_suggestV";
			else 
				return "support/sprt_noticeV";  // 51:솔루션자료, 52:각종양식, 53:업무처리절차
		} else if(masterVo.getBbsTyCode().equals("ADMN")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000002"))
				return "admin/bbs/adminV";
		} else if (masterVo.getBbsTyCode().equals("EXPS")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000080"))
				return "expansion/exps_suggestV";
		}
		return "cop/bbs/EgovNoticeInqire";
	}

	
	/**
	 * 게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/community/addReplyBoardArticle.do", "/support/addReplyBoardArticle.do", "/admin/addReplyBoardArticle.do", "/expansion/addReplyBoardArticle.do"})
	public String addReplyBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
	
		BoardMasterVO masterVo = new BoardMasterVO();
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		vo.setUniqId(user.getStringNo());
	
		masterVo = bbsAttrbService.selectBBSMasterInf(vo);
		
		model.addAttribute("result", boardVO);
		model.addAttribute("bdMstr", masterVo);
		model.addAttribute("isReply", "Y");
	
		if (masterVo.getBbsTyCode().equals("COMM")){
			if(masterVo.getBbsAttrbCode().equals("GOODMO"))  // 82:첫출근 인사말
				return "community/comm_GoodmorningW";
			else if(masterVo.getBbsAttrbCode().equals("SOLBBS"))  // 85:솔루션 게시판,  
				return "community/comm_SolutionW";
			else if(masterVo.getBbsAttrbCode().equals("COMMON"))  // 1:자유게시판, 34:개발TIP, 73:테스트, 81:상품정보, 83:제안게시판
				return "community/comm_FreeW";
			else if(masterVo.getBbsAttrbCode().equals("DISCUS"))  // 29:토론,  
				return "community/comm_DiscussW";
			else if(masterVo.getBbsAttrbCode().equals("SCHDL"))  // 30:경조사
				return "community/comm_FamilyeventW";
		} else if(masterVo.getBbsTyCode().equals("SPRT")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000031")) // 공지사항
				return "community/sprt_noticeW";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000033")) // 알림공지
				return "community/sprt_noticeW";
			else if (masterVo.getBbsId().equals("BBSMSTR_000000000050")) // 회사자료
				return "support/sprt_processInfoW";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000061")) // 한마음 개선요청
				return "community/sprt_kmsSuggestW";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000062"))  // 건의/제안
				return "community/sprt_suggestW";
			else 
				return "support/sprt_noticeW";  // 51:솔루션자료, 52:각종양식, 53:업무처리절차
		} else if(masterVo.getBbsTyCode().equals("ADMN")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000002"))
				return "admin/bbs/adminW";
		} else if (masterVo.getBbsTyCode().equals("EXPS")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000080"))
				return "expansion/exps_suggestW";
		}
		return "cop/bbs/EgovNoticeReply";
	}

	/**
	 * 게시물에 대한 답변을 등록한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/community/replyBoardArticle.do", "/support/replyBoardArticle.do", "/admin/replyBoardArticle.do", "/expansion/replyBoardArticle.do"})
	public String replyBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
		@ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model,
		SessionStatus status) throws Exception {

		MemberVO user = SessionUtil.getMember(multiRequest);
		Boolean isAuthenticated = SessionUtil.isLogin(multiRequest);
		
		if (isAuthenticated) {
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			String atchFileId = "";
	
			if (!files.isEmpty()) {
				List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
	
			board.setAtchFileId(atchFileId);
			board.setReplyAt("Y");
			board.setFrstRegisterId(user.getStringNo());
			board.setBbsId(board.getBbsId());
			board.setParnts(Long.toString(boardVO.getNttId()));
			board.setSortOrdr(boardVO.getSortOrdr());
			board.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));
			
			board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			
			bbsMngService.insertBoardArticle(board);
		}
		
		return "redirect:selectBoardList.do?bbsId=" + boardVO.getBbsId();
	}

	/**
	 * 게시물 수정을 위한 수정페이지로 이동한다.
	 * 
	 * @param boardVO
	 * @param vo
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/community/forUpdateBoardArticle.do", "/support/forUpdateBoardArticle.do", "/admin/forUpdateBoardArticle.do", "/expansion/forUpdateBoardArticle.do"})
	public String selectBoardArticleForUpdt(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO vo,
			HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		Boolean isAuthenticated = SessionUtil.isLogin(req);
		
		boardVO.setFrstRegisterId(user.getStringNo());
		
		BoardMaster master = new BoardMaster();
		BoardMasterVO masterVo = new BoardMasterVO();
		BoardVO bdvo = new BoardVO();
		
		vo.setBbsId(boardVO.getBbsId());
		
		master.setBbsId(boardVO.getBbsId());
		master.setUniqId(user.getStringNo());
	
		if (isAuthenticated) {
			masterVo = bbsAttrbService.selectBBSMasterInf(master);
			bdvo = bbsMngService.selectBoardArticle(boardVO);
		}
	
		//if(bdvo.getNttSj().indexOf("<br>") > 0 ) {
		//	bdvo.setNttSj(bdvo.getNttSj().replace("<br>","\n"));
		//}
			
		model.addAttribute("result", bdvo);
		model.addAttribute("brdMstrVO", masterVo);
		model.addAttribute("bdMstr", masterVo);
		
		if (masterVo.getBbsTyCode().equals("COMM")){
			if(masterVo.getBbsAttrbCode().equals("GOODMO"))  // 82:첫출근 인사말
				return "community/comm_GoodmorningM";
			else if(masterVo.getBbsAttrbCode().equals("SOLBBS"))  // 85:솔루션 게시판,  
				return "community/comm_SolutionM";
			else if(masterVo.getBbsAttrbCode().equals("COMMON"))  // 1:자유게시판, 34:개발TIP, 73:테스트, 81:상품정보, 83:제안게시판
				return "community/comm_FreeM";
			else if(masterVo.getBbsAttrbCode().equals("DISCUS"))  // 29:토론,  
				return "community/comm_DiscussM";
			else if(masterVo.getBbsAttrbCode().equals("SCHDL"))  // 30:경조사
				return "community/comm_FamilyeventM";
		} else if(masterVo.getBbsTyCode().equals("SPRT")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000031")) // 공지사항
				return "community/sprt_noticeM";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000033")) // 알림공지
				return "community/sprt_noticeM";
			else if (masterVo.getBbsId().equals("BBSMSTR_000000000050")) // 회사자료
				return "support/sprt_processInfoM";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000061")) // 한마음 개선요청
				return "community/sprt_kmsSuggestM";
			else if(masterVo.getBbsId().equals("BBSMSTR_000000000062"))  // 건의/제안
				return "community/sprt_suggestM";
			else 
				return "support/sprt_noticeM";  // 51:솔루션자료, 52:각종양식, 53:업무처리절차
		} else if(masterVo.getBbsTyCode().equals("ADMN")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000002"))
				return "admin/bbs/adminM";
		} else if (masterVo.getBbsTyCode().equals("EXPS")){
			if(masterVo.getBbsId().equals("BBSMSTR_000000000080"))
				return "expansion/exps_suggestM";
		}
		return "cop/bbs/EgovNoticeUpdt";
	}

	/**
	 * 게시물에 대한 내용을 수정한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/community/updateBoardArticle.do", "/support/updateBoardArticle.do", "/admin/updateBoardArticle.do", "/expansion/updateBoardArticle.do"})
	public String updateBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
		@ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(multiRequest);
		Boolean isAuthenticated = SessionUtil.isLogin(multiRequest);

		String atchFileId = boardVO.getAtchFileId();
	
		if (isAuthenticated) {
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				if (atchFileId == null || "".equals(atchFileId) ) {
					List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					board.setAtchFileId(atchFileId);
				} else {
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileMngService.getMaxFileSN(fvo);
					List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
					fileMngService.updateFileInfs(_result);
				}
			}
	
			board.setLastUpdusrId(user.getStringNo());
			
			board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			
			bbsMngService.updateBoardArticle(board);
		}
		
		if (bdMstr.getBbsId().equals("BBSMSTR_000000000082")) { //첫 출근 게시판		
			model.addAttribute("param_returnUrl", "selectBoardList.do?bbsId=" + boardVO.getBbsId());
			return "cooperation/closePage";
		}else{
			return "redirect:selectBoardList.do?bbsId=" + boardVO.getBbsId();
		}
	}

	/**
	 * 게시물에 대한 내용을 삭제한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/community/deleteBoardArticle.do", "/support/deleteBoardArticle.do", "/admin/deleteBoardArticle.do", "/expansion/deleteBoardArticle.do"})
	public String deleteBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
		@ModelAttribute("bdMstr") BoardMaster bdMstr, HttpServletRequest req, ModelMap model) throws Exception {
	
		MemberVO user = SessionUtil.getMember(req);
		Boolean isAuthenticated = SessionUtil.isLogin(req);
	
		if (isAuthenticated) {
			board.setLastUpdusrId(user.getStringNo());
			
			bbsMngService.deleteBoardArticle(board);
		}
	
		return "redirect:selectBoardList.do?bbsId=" + boardVO.getBbsId();
	}
	
	@RequestMapping(value={"/community/deleteMultiBoardArticle.do", "/support/deleteMultiBoardArticle.do", "/admin/deleteMultiBoardArticle.do", "/expansion/deleteMultiBoardArticle.do"})
	public String deleteMultiBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
		@ModelAttribute("bdMstr") BoardMaster bdMstr, HttpServletRequest req, ModelMap model) throws Exception {
	
		MemberVO user = SessionUtil.getMember(req);
		Boolean isAuthenticated = SessionUtil.isLogin(req);
	
		if (isAuthenticated) {			
			String[] nttIdArray = board.getNttIdArray().split(",");
			for(int i=0;i < nttIdArray.length;i++){
				board.setLastUpdusrId(user.getStringNo());
				board.setNttId(Long.parseLong(nttIdArray[i]));
				bbsMngService.deleteBoardArticle(board);				
			}			
		}
	
		return "redirect:selectBoardList.do?bbsId=" + boardVO.getBbsId();
	}
	
	
	
	@RequestMapping("/community/selectAllBoardList.do")
	public String selectAllBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
	
		Map<String, Object> map = bbsMngService.selectAllBoardArticles(user);
		
		model.addAttribute("resultMap", map);
	
		return "community/comm_AllL";
	}
	
	
	@RequestMapping("/community/setDiscussState.do")
	public String setDiscussState(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		bbsMngService.setDiscussState(boardVO);
		
		return "redirect:/community/selectBoardList.do?bbsId=" + boardVO.getBbsId();
	}
	
	
	
	@RequestMapping("/community/selectBBSMasterInfs")
	public String selectBBSMasterInfs(@ModelAttribute("searchVO") BoardMasterVO searchVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		searchVO.setUseAt("Y");
		searchVO.setBbsAttrbCode("COMMON");
		
		List<BoardMasterVO> resultList = bbsAttrbService.selectBoardMasterList(searchVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("bbsIdFrom", commandMap.get("bbsIdFrom"));
		
		return "community/comm_bbsMoveLayer";
	}
	
	@RequestMapping("/admin/selectBBSMasterInfs")
	public String selectAdminBBSMasterInfs(@ModelAttribute("searchVO") BoardMasterVO searchVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		searchVO.setUseAt("Y");
		searchVO.setBbsAttrbCode("ADMIN");
		
		List<BoardMasterVO> resultList = bbsAttrbService.selectBoardMasterList(searchVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("bbsIdFrom", commandMap.get("bbsIdFrom"));
		
		return "admin/bbs/admin_bbsMoveLayer";
	}
	
	@RequestMapping("/community/moveBoard.do")
	public String moveBoard(@ModelAttribute("searchVO") BoardVO boardVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		bbsMngService.updateBbsId(commandMap);
		bbsMngService.updateBbsIdComment(commandMap);

		String bbsId = (String)commandMap.get("bbsIdTo");
		Long nttId = Long.valueOf((String)commandMap.get("nttId"));
		
		boardVO.setBbsId(bbsId);
		boardVO.setNttId(nttId);
		
		return "redirect:/community/selectBoardArticle.do?bbsId=" + bbsId + "&nttId=" + nttId;
	}
	
	@RequestMapping("/admin/moveBoard.do")
	public String moveAdminBoard(@ModelAttribute("searchVO") BoardVO boardVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		bbsMngService.updateBbsId(commandMap);

		String bbsId = (String)commandMap.get("bbsIdTo");
		Long nttId = Long.valueOf((String)commandMap.get("nttId"));
		
		boardVO.setBbsId(bbsId);
		boardVO.setNttId(nttId);
		
		return "redirect:/admin/selectBoardArticle.do?bbsId=" + bbsId + "&nttId=" + nttId;
	}
	
	/**
	 * 도움말 툴팁 게시판의 내용을 가져온다. 
	 */
	/*
	@RequestMapping(value="/ajax/admin/selectBoardArticle.do")
	public String selectBoardArticleAjax(BoardVO boardVO, HttpServletRequest req, ModelMap model) {
		
		String result = "";
		
		boardVO.setReadBool("Y");
		BoardVO vo = new BoardVO();
		try {
			vo = bbsMngService.selectBoardArticle(boardVO);
			result = URLEncoder.encode(vo.getNttCn(), "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		//return "success";
	}
	*/
	
	@RequestMapping(value="/ajax/admin/selectBoardArticle.do")
	public void selectBoardArticleAjax(BoardVO boardVO, HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {
		
		boardVO.setReadBool("Y");
		BoardVO vo = new BoardVO();
		
		vo = bbsMngService.selectBoardArticle(boardVO);

		JSONObject result = new JSONObject();
		result.put("content", (String)vo.getNttCn());
		
		res.setContentType("charset=UTF-8");
		ServletOutputStream out = res.getOutputStream();

		out.write(result.toString().getBytes("UTF-8"));
		out.flush();
		out.close();
	}
}
