package kms.com.community.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.admin.score.service.ScoreService;
import kms.com.admin.score.service.ScoreVO;
import kms.com.app.service.ApprovalVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.Board;
import kms.com.community.service.BoardMaster;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.BBSAttributeManageService;
import kms.com.community.service.BBSManageService;
import kms.com.community.service.Schedule;
import kms.com.community.service.ScheduleService;
import kms.com.member.service.MemberVO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
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
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
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
public class BBSManageMobileController {

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
    
    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());

    
    /*****모바일******************************************************************************************
     * 게시물(공지사항 등)에 대한 목록을 조회한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     ****************************************************************************************************/
    @RequestMapping(value={"/mobile/community/selectBoardList.do", "/mobile/support/selectBoardList.do"}) 
    public String mobileSelectBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
    	
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
	
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setBbsNm(boardVO.getBbsNm());
		boardVO.setFrstRegisterId(user.getStringNo());
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit_15"));
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
		int totPage = (int) Math.round(totCnt / boardVO.getPageSize() + 0.5); 
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("bdMstr", masterVo);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totPage", totPage);

		
		
		if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/community/comm_FreeL";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			//공지사항 목록으로 이동
			return "mobile/support/sprt_noticeL";
		} else {
			return "cop/bbs/EgovNoticeList";
		}
    }

    /*****모바일******************************************************************************************
     * 게시물(공지사항 등)에 대한 목록을 조회한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     ****************************************************************************************************/
    @RequestMapping(value={"/mobile/support/selectBoardList2.do"}) 
    public String mobileSelectBoardArticles2(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
    	
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
	
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setBbsNm(boardVO.getBbsNm());
		boardVO.setFrstRegisterId(user.getStringNo());
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit_15"));
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
		int totPage = (int) Math.round(totCnt / boardVO.getPageSize() + 0.5); 
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("bdMstr", masterVo);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totPage", totPage);

		if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/community/comm_FreeL";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			//공지사항 목록으로 이동
			return "mobile/support/sprt_noticeL2";
		} else {
			return "cop/bbs/EgovNoticeList";
		}
    }
    
    
    /****모바일*******************************************************************************************
     * 게시물(공지사항 등)에 대한 내용을 조회한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     *****************************************************************************************************/
    @RequestMapping(value={"/mobile/community/selectBoardArticle.do", "/mobile/support/selectBoardArticle.do"})
    public String mobileSelectBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
	
		boardVO.setPlusCount(true);

		boardVO.setLastUpdusrId(user.getStringNo());
		boardVO.setFrstRegisterId(user.getStringNo());
		BoardVO vo = bbsMngService.selectBoardArticle(boardVO);
	
		model.addAttribute("result", vo);

		model.addAttribute("sessionUniqId", user.getStringNo());

		BoardMasterVO master = new BoardMasterVO();
		
		master.setBbsId(boardVO.getBbsId());
		
		BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);
	
		model.addAttribute("brdMstrVO", masterVo);
		
		if (boardVO.getAjaxMode() == 1) {
			if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("COMMON")) {
				return "mobile/community/comm_FreeV_Content";
			} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("DISCUS")) {
				return "mobile/community/comm_DiscussV_Content";
			} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("SCHDL")) {
				return "mobile/community/comm_FamilyeventV_Content";
			}
		}
		
		if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/community/comm_FreeV";
		} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("DISCUS")) {
			return "mobile/community/comm_DiscussV";
		} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("SCHDL")) {
			return "mobile/community/comm_FamilyeventV";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/support/sprt_noticeV";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("SGST")) {
			if (masterVo.getBbsId().equals("BBSMSTR_000000000061"))
				return "mobile/support/sprt_kmsSuggestV";
			else
				return "mobile/support/sprt_suggestV";
		} else {
			return "cop/bbs/EgovNoticeInqire";
		}
    }

    /**** 모바일 ********************************************************************
     * 게시물 (공지사항 등) 등록을 위한 등록페이지로 이동한다.
     * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     *******************************************************************************/
    @RequestMapping(value={"/mobile/community/addBoardArticle.do", "/mobile/support/addBoardArticle.do"})
    public String mobileAddBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
	
		BoardMasterVO masterVo = new BoardMasterVO();
		
	    BoardMasterVO vo = new BoardMasterVO();

	    vo.setBbsId(boardVO.getBbsId());

	    masterVo = bbsAttrbService.selectBBSMasterInf(vo);
	    model.addAttribute("bdMstr", masterVo);
	    
	
		if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/community/comm_FreeW";
		} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("DISCUS")) {
			return "mobile/community/comm_DiscussW";
		} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("SCHDL")) {
			return "mobile/community/comm_FamilyeventW";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/support/sprt_noticeW";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("SGST")) {
			if (masterVo.getBbsId().equals("BBSMSTR_000000000061"))
				return "mobile/support/sprt_kmsSuggestW";
			else
				return "mobile/support/sprt_suggestW";
		} else {
			return "cop/bbs/EgovNoticeRegist";
		}
    }
    /**** 모바일 ********************************************************************
     * 게시물(공지사항 등)을 등록한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     **********************************************************************************/
    @SuppressWarnings("unchecked")
    @RequestMapping(value={"/mobile/community/insertBoardArticle.do", "/mobile/support/insertBoardArticle.do"})
    public String mobileInsertBoardArticle(final HttpServletRequest req, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(req);
    	
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
	    /*
	    if (bdMstr.getBbsId().equals("BBSMSTR_000000000061")) {
			return "redirect:selectBoardList.do?bbsId=" + boardVO.getBbsId();
		} else {
			return "redirect:selectBoardArticle.do?bbsId=" + boardVO.getBbsId() + "&nttId=" + nttId;
		}
		*/
	    return "redirect:selectBoardArticle.do?bbsId=" + boardVO.getBbsId() + "&nttId=" + nttId;
    }
    

    /**** 모바일 ********************************************************************
     * 게시물 수정을 위한 수정페이지로 이동한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param vo
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     ********************************************************************************/
    @RequestMapping(value={"/mobile/community/forUpdateBoardArticle.do", "/mobile/support/forUpdateBoardArticle.do"})
    public String mobileSelectBoardArticleForUpdt(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO vo,
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
	
		model.addAttribute("result", bdvo);
		model.addAttribute("brdMstrVO", masterVo);
		model.addAttribute("bdMstr", masterVo);
		
		if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/community/comm_FreeM";
		} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("DISCUS")) {
			return "mobile/community/comm_DiscussM";
		} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("SCHDL")) {
			return "mobile/community/comm_FamilyeventM";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/support/sprt_noticeM";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("SGST")) {
			if (masterVo.getBbsId().equals("BBSMSTR_000000000061"))
				return "mobile/support/sprt_kmsSuggestM";
			else
				return "mobile/support/sprt_suggestM";
		} else {
			return "cop/bbs/EgovNoticeUpdt";
		}
    }

    /**** 모바일 ********************************************************************
     * 게시물에 대한 내용을 수정한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     *************************************************************************************/
    @SuppressWarnings("unchecked")
    @RequestMapping(value={"/mobile/community/updateBoardArticle.do", "/mobile/support/updateBoardArticle.do"})
    public String mobileUpdateBoardArticle(final HttpServletRequest req, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(req);
		Boolean isAuthenticated = SessionUtil.isLogin(req);

		String atchFileId = boardVO.getAtchFileId();
	
		if (isAuthenticated) {

		    board.setLastUpdusrId(user.getStringNo());
		    
		    board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    bbsMngService.updateBoardArticle(board);
		}
		
		return "redirect:selectBoardList.do?bbsId=" + boardVO.getBbsId();
    }
    

    /**** 모바일 ********************************************************************
     * 게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/mobile/community/addReplyBoardArticle.do", "/mobile/support/addReplyBoardArticle.do"})
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
	
		if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "community/comm_FreeW";
		} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("DISCUS")) {
			return "community/comm_DiscussW";
		} else if (masterVo.getBbsTyCode().equals("COMM") && masterVo.getBbsAttrbCode().equals("SCHDL")) {
			return "community/comm_FamilyeventW";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			if (masterVo.getBbsId().equals("BBSMSTR_000000000050"))
				return "support/sprt_processInfoW";
			else if (masterVo.getBbsId().equals("BBSMSTR_000000000031") ||
					masterVo.getBbsId().equals("BBSMSTR_000000000033"))
				return "community/sprt_noticeW";
			else
				return "support/sprt_noticeW";
		} else if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("SGST")) {
			if (masterVo.getBbsId().equals("BBSMSTR_000000000061"))
				return "support/sprt_kmsSuggestW";
			else
				return "support/sprt_suggestW";
		} else {
			return "cop/bbs/EgovNoticeReply";
		}
    }

    /**** 모바일 ********************************************************************
     * 게시물에 대한 답변을 등록한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value={"/mobile/community/replyBoardArticle.do", "/mobile/support/replyBoardArticle.do"})
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
    
    /****모바일****************************************************************************************
     * 게시물에 대한 신규 목록을 조회한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     ****************************************************************************************************/    
    @RequestMapping("/mobile/community/selectUnreadBoardList.do")
    public String mobileSelectUnreadBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = (MemberVO)SessionUtil.getMember(req);
	
		boardVO.setBbsTyCode("COMM");
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

		return "mobile/community/comm_UnreadL";
    }
}
