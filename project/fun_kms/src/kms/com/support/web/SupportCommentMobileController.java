package kms.com.support.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.BBSAttributeManageService;
import kms.com.community.service.BBSCommentService;
import kms.com.community.service.BBSManageService;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.Comment;
import kms.com.community.service.CommentVO;
import kms.com.member.service.MemberVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 댓글관리 서비스 컨트롤러 클래스
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.06.29
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.06.29  한성곤          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class SupportCommentMobileController {
    
    @Resource(name="KmsBBSCommentService")
    protected BBSCommentService bbsCommentService;
    
    @Resource(name = "KmsBBSManageService")
    private BBSManageService bbsMngService;
    
    @Resource(name = "KmsBBSAttributeManageService")
    private BBSAttributeManageService bbsAttrbService;
    
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;

    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
    
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * 댓글관리 목록 조회를 제공한다.
     * 
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/mobile/support/selectCommentList.do"})
    public String selectCommentList(@ModelAttribute("searchVO") CommentVO commentVO, HttpServletRequest req, ModelMap model) throws Exception {
	
    	MemberVO user = SessionUtil.getMember(req);
    	
		// 수정 처리된 후 댓글 등록 화면으로 처리되기 위한 구현
		if (commentVO.isModified()) {
		    commentVO.setCommentNo("");
		    commentVO.setCommentCn("");
		}
		
		// 수정을 위한 처리
		if (!commentVO.getCommentNo().equals("")) {
		    return "forward:/mobile/support/selectSingleComment.do";
		}
		
		//------------------------------------------
		// JSP의 <head> 부분 처리 (javascript 생성)
		//------------------------------------------
		model.addAttribute("type", commentVO.getType());	// head or body
		
		if (commentVO.getType().equals("head")) {
		    return "mobile/support/CommentList";
		}
		
		commentVO.setWrterNm(user.getStringNo());
		
		commentVO.setSubPageUnit(propertyService.getInt("pageUnit"));
		commentVO.setSubPageSize(propertyService.getInt("pageSize"));
	
		Map<String, Object> map = bbsCommentService.selectCommentList(commentVO);
	
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		
		commentVO.setCommentCn("");	// 등록 후 댓글 내용 처리
	
		return "mobile/support/CommentList";
    }
    
    
    /****모바일*******************************************************************************************
     *  댓글 등록/수정 페이지로 이동한다.
	 * @author 2012.04.10 정은태 추가 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     ***************************************************************************************************/
    @RequestMapping("/mobile/support/goAddReplyComment.do")
    public String mobileSelectBoardArticle(@ModelAttribute("searchVO")CommentVO commentVO, HttpServletRequest req, ModelMap model) throws Exception { 
		
    	MemberVO user = SessionUtil.getMember(req);
		model.addAttribute("sessionUniqId", user.getStringNo());
		
		BoardVO vo = new BoardVO(); 
		
		vo.setLastUpdusrId(user.getStringNo());
		vo.setFrstRegisterId(user.getStringNo());
		vo.setBbsId(commentVO.getBbsId());
		vo.setNttId(commentVO.getNttId());
		vo.setPageIndex(commentVO.getSubPageIndex());
		BoardVO boardVO = bbsMngService.selectBoardArticle(vo);
		model.addAttribute("result", boardVO);
		
		//---------------------------------------
		BoardMasterVO master = new BoardMasterVO();
		master.setBbsId(boardVO.getBbsId());
		BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);

		model.addAttribute("brdMstrVO", masterVo);
		//---------------------------------------
		
		if(commentVO.getCommentNo().length() != 0){
			Comment data = bbsCommentService.selectComment(commentVO);
			commentVO.setCommentNo(data.getCommentNo());
			commentVO.setNttId(data.getNttId());
			commentVO.setBbsId(data.getBbsId());
			commentVO.setWrterId(data.getWrterId());
			commentVO.setWrterNm(data.getWrterNm());
			commentVO.setCommentPassword(data.getCommentPassword());
			commentVO.setCommentCn(data.getCommentCn());
			commentVO.setUseAt(data.getUseAt());
			commentVO.setFrstRegisterPnttm(data.getFrstRegisterPnttm());
			commentVO.setFrstRegisterNm(data.getFrstRegisterNm());
			
			commentVO.setLastUpdusrId(user.getStringNo());
			commentVO.setFrstRegisterId(user.getStringNo());
		}
		commentVO.setSubPageUnit(propertyService.getInt("pageUnit"));
		commentVO.setSubPageSize(propertyService.getInt("pageSize"));
		
		model.addAttribute("resultComment", commentVO);
		if (masterVo.getBbsTyCode().equals("SPRT") && masterVo.getBbsAttrbCode().equals("COMMON")) {
			return "mobile/support/replyCommentW"; 
		}else {
			return "cop/bbs/EgovNoticeInqire"; 
		}
    }    
    
    
    /**
     * 댓글을 등록한다.
     * 
     * @param commentVO
     * @param comment
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mobile/support/insertComment.do")
    public String insertComment(final HttpServletRequest req, @ModelAttribute("searchVO") CommentVO commentVO,
    	@ModelAttribute("comment") Comment comment, BindingResult bindingResult, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		Boolean isAuthenticated = SessionUtil.isLogin(req);
	
		List<FileVO> result = null;
	    String atchFileId = "";
		
		/*
		final Map<String, MultipartFile> files = req.getFileMap();
		if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result);
	    }
		*/
	    
		if (isAuthenticated) {
			comment.setAtchFileId(atchFileId);
		    comment.setFrstRegisterId(user.getStringNo());
		    comment.setWrterNo(user.getNo());
		    comment.setCommentCn(CommonUtil.unscript(comment.getCommentCn()));
		    
		    comment.setCommentPassword("");	// dummy
		    
		    bbsCommentService.insertComment(comment);
		    commentVO.setCommentCn("");
		    commentVO.setCommentNo("");
		}
		return "redirect:/mobile/support/selectBoardArticle.do?bbsId=" + comment.getBbsId() + "&nttId=" + comment.getNttId();
    }
    
    
    
    /**
     * 댓글을 수정한다.
     * 
     * @param commentVO
     * @param comment
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mobile/support/updateComment.do")
    public String updateCommentList(final HttpServletRequest req, @ModelAttribute("searchVO") CommentVO commentVO,
    	@ModelAttribute("comment") Comment comment, BindingResult bindingResult, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		Boolean isAuthenticated = SessionUtil.isLogin(req);

		if (isAuthenticated) {
		    comment.setLastUpdusrId(user.getStringNo());
		    comment.setCommentCn(CommonUtil.unscript(comment.getCommentCn()));
		    
		    comment.setCommentPassword("");	// dummy
		    
		    bbsCommentService.updateComment(comment);
		    
		    commentVO.setCommentCn("");
		    commentVO.setCommentNo("");
		}
		
		return "redirect:/mobile/support/selectBoardArticle.do?bbsId=" + comment.getBbsId() + "&nttId=" + comment.getNttId();
		//return "forward:/mobile/support/selectBoardArticle.do";
    }


    /**
     * 댓글을 삭제한다.
     * 
     * @param commentVO
     * @param comment
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/mobile/support/deleteComment.do")
    public String deleteComment(@ModelAttribute("searchVO") CommentVO commentVO, @ModelAttribute("comment") Comment comment, ModelMap model) throws Exception {
		
		bbsCommentService.deleteComment(commentVO);

		commentVO.setCommentCn("");
		commentVO.setCommentNo("");
		
		return "forward:/mobile/support/selectBoardArticle.do";

    }
    
}
