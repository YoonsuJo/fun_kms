package kms.com.community.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import kms.com.admin.score.service.ScoreService;
import kms.com.admin.score.service.ScoreVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.BBSAttributeManageService;
import kms.com.community.service.BBSManageService;
import kms.com.community.service.Board;
import kms.com.community.service.BoardMaster;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.MailService;
import kms.com.community.service.MailVO;
import kms.com.community.service.Mail;
import kms.com.community.service.Schedule;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

/**
 * @Class Name : TblMailsendController.java
 * @Description : TblMailsend Controller class
 * @Modification Information
 *
 * @author 장기호
 * @since 2012.07.09
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class EventController {
    
	@Resource(name = "KmsBBSManageService")
    private BBSManageService bbsMngService;
	
	@Resource(name = "KmsBBSAttributeManageService")
    private BBSAttributeManageService bbsAttrbService;
	
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
	
    @RequestMapping("/community/event.do")
    public String eventMain(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = (MemberVO)SessionUtil.getMember(req);
    	
    	boardVO.setBbsId("BBSMSTR_000000000028");
		boardVO.setBbsNm(boardVO.getBbsNm());
		boardVO.setFrstRegisterId(user.getStringNo());
    	
		boardVO.setPageUnit(4);
		boardVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "");

		model.addAttribute("resultList", map.get("resultList"));
    	
    	return "/community/comm_event_main";
    }
    
    @RequestMapping("/community/imageL.do")
    public String selectImageList(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = (MemberVO)SessionUtil.getMember(req);
    	
    	boardVO.setBbsId("BBSMSTR_000000000028");
		boardVO.setBbsNm(boardVO.getBbsNm());
		boardVO.setFrstRegisterId(user.getStringNo());
    	
		boardVO.setPageUnit(8);
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
    	
    	return "/community/comm_event_imageL";
    }
    
    @RequestMapping("/community/imageW.do")
    public String writeImage(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	BoardMasterVO masterVo = new BoardMasterVO();
    	
	    BoardMasterVO vo = new BoardMasterVO();
	    vo.setBbsId("BBSMSTR_000000000028");

	    masterVo = bbsAttrbService.selectBBSMasterInf(vo);
	    model.addAttribute("bdMstr", masterVo);
    	
    	return "/community/comm_event_imageW";
    }
    
    @RequestMapping("/community/imageI.do")
    public String insertImage(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, @ModelAttribute("board") Board board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model) throws Exception {

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
	    }
		//status.setComplete();
	    
	    return "/community/comm_event_imageW";
    }
    
    @RequestMapping("/community/imageV.do")
    public String selectImage(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
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
		
		return "community/comm_event_imageV";
    }
    
    @RequestMapping("/community/imageM.do")
    public String selectImageForUpdt(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO vo,
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
		
		return "community/comm_event_imageM";
    }

    @RequestMapping("/community/imageU.do")
    public String updateImage(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO,
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
		
		return "redirect:/community/imageL.do";
    }

    @RequestMapping("/community/imageD.do")
    public String deleteImage(@ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") Board board,
	    @ModelAttribute("bdMstr") BoardMaster bdMstr, HttpServletRequest req, ModelMap model) throws Exception {
	
		MemberVO user = SessionUtil.getMember(req);
		Boolean isAuthenticated = SessionUtil.isLogin(req);
	
		if (isAuthenticated) {
		    board.setLastUpdusrId(user.getStringNo());
		    
		    bbsMngService.deleteBoardArticle(board);
		}
	
		return "redirect:/community/imageL.do";
    }
}
