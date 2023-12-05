package kms.com.cooperation.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.BBSAttributeManageService;
import kms.com.community.service.BBSManageService;
import kms.com.community.service.Board;
import kms.com.community.service.BoardMaster;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.Schedule;
import kms.com.community.service.ScheduleService;
import kms.com.cooperation.service.DayReportVO;
import kms.com.cooperation.service.BusinessContact;
import kms.com.cooperation.service.BusiCntctService;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.member.service.MemberVO;

import org.apache.log4j.Logger;
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
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class PrjBoardController {
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;

    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
    
    @Resource(name = "KmsBBSManageService")
    private BBSManageService bbsMngService;

    @Resource(name = "KmsBBSAttributeManageService")
    private BBSAttributeManageService bbsAttrbService;
    
    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());

    
    @RequestMapping("/cooperation/selectPrjBoardMain.do")
    public String selectPrjBoardMain(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
    	MemberVO user = SessionUtil.getMember(req);

		boardVO.setBbsId("BBSMSTR_000000000072");
    	boardVO.setFrstRegisterId(user.getStringNo());
    	boardVO.setSearchOrgIdList(CommonUtil.makeValidIdList(boardVO.getSearchOrgId()));
   	
    	Map<String, Object> result = bbsMngService.selectPrjBoardMain(boardVO);
    	
    	model.addAttribute("result", result);
    	//boardVO.setSearchStatList(new String[]{"P","E","S"});
    	return "cooperation/coop_prjBoardMain";
    }
    
    /**
     * 게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cooperation/selectPrjBoardList.do") 
    public String selectBoardArticles(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = (MemberVO)SessionUtil.getMember(req);

		boardVO.setBbsId("BBSMSTR_000000000072");
		boardVO.setFrstRegisterId(user.getStringNo());
		if (boardVO.getSearchCondition().equals("3") && CommonUtil.isMixedId(boardVO.getSearchUserNm())) { // 사용자를 검색했을 경우
			boardVO.setSearchKeyword(CommonUtil.parseIdFromMixs(boardVO.getSearchUserNm())[0]);
		}
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
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
	
		if (masterVo.getBbsTyCode().equals("COOP") && masterVo.getBbsAttrbCode().equals("PRJBBS")) {
			return "cooperation/coop_prjBoardL";
		} else {
			return "cop/bbs/EgovNoticeList";
		}
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
    @RequestMapping("/cooperation/insertPrjBoardView.do")
    public String addBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {

		boardVO.setBbsId("BBSMSTR_000000000072");
		
		BoardMasterVO masterVo = new BoardMasterVO();
	
	    BoardMasterVO vo = new BoardMasterVO();
	    vo.setBbsId(boardVO.getBbsId());

	    masterVo = bbsAttrbService.selectBBSMasterInf(vo);
	    model.addAttribute("bdMstr", masterVo);
	
		if (masterVo.getBbsTyCode().equals("COOP") && masterVo.getBbsAttrbCode().equals("PRJBBS")) {
			return "cooperation/coop_prjBoardW";
		} else {
			return "cop/bbs/EgovNoticeRegist";
		}
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
    @RequestMapping("/cooperation/insertPrjBoard.do")
    public String insertBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(multiRequest);

		boardVO.setBbsId("BBSMSTR_000000000072");
		
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
	    
	    bbsMngService.insertBoardArticle(board);
	    
		//status.setComplete();
		return "redirect:/cooperation/selectPrjBoardList.do?prjId=" + board.getPrjId();
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
    @RequestMapping("/cooperation/selectPrjBoard.do")
    public String selectBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		
		boardVO.setBbsId("BBSMSTR_000000000072");
	
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
	
		if (masterVo.getBbsTyCode().equals("COOP") && masterVo.getBbsAttrbCode().equals("PRJBBS")) {
			return "cooperation/coop_prjBoardV";
		} else {
			return "cop/bbs/EgovNoticeInqire";
		}
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
    @RequestMapping("/cooperation/updatePrjBoardView.do")
    public String selectBoardArticleForUpdt(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO vo,
    		HttpServletRequest req, ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(req);
    	Boolean isAuthenticated = SessionUtil.isLogin(req);
		
		boardVO.setBbsId("BBSMSTR_000000000072");
		
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
		
		if (masterVo.getBbsTyCode().equals("COOP") && masterVo.getBbsAttrbCode().equals("PRJBBS")) {
			return "cooperation/coop_prjBoardM";
		} else {
			return "cop/bbs/EgovNoticeUpdt";
		}
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
    @RequestMapping("/cooperation/updatePrjBoard.do")
    public String updateBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, ModelMap model) throws Exception {

    	MemberVO user = SessionUtil.getMember(multiRequest);
    	Boolean isAuthenticated = SessionUtil.isLogin(multiRequest);
		
		boardVO.setBbsId("BBSMSTR_000000000072");

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
		
		return "forward:/cooperation/selectPrjBoard.do";
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
    @RequestMapping("/cooperation/deletePrjBoard.do")
    public String deleteBoardArticle(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, HttpServletRequest req, ModelMap model) throws Exception {
	
		MemberVO user = SessionUtil.getMember(req);
		Boolean isAuthenticated = SessionUtil.isLogin(req);

		boardVO.setBbsId("BBSMSTR_000000000072");
	
		if (isAuthenticated) {
		    board.setLastUpdusrId(user.getStringNo());
		    
		    bbsMngService.deleteBoardArticle(board);
		}
	
		return "redirect:/cooperation/selectPrjBoardList.do?prjId=" + boardVO.getPrjId();
    }
    
    
}
