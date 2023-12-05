package kms.com.cooperation.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.BBSCommentService;
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
public class CooperationCommentController {
    @Resource(name="KmsBBSCommentService")
    protected BBSCommentService bbsCommentService;
    
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
    @RequestMapping("/cooperation/selectCommentList.do")
    public String selectCommentList(@ModelAttribute("searchVO") CommentVO commentVO, HttpServletRequest req, ModelMap model) throws Exception {
	
    	MemberVO user = SessionUtil.getMember(req);
    	
		// 수정 처리된 후 댓글 등록 화면으로 처리되기 위한 구현
		if (commentVO.isModified()) {
		    commentVO.setCommentNo("");
		    commentVO.setCommentCn("");
		}
		
		// 수정을 위한 처리
		if (!commentVO.getCommentNo().equals("")) {
		    return "forward:/cooperation/selectSingleComment.do";
		}
		
		//------------------------------------------
		// JSP의 <head> 부분 처리 (javascript 생성)
		//------------------------------------------
		model.addAttribute("type", commentVO.getType());	// head or body
		
		if (commentVO.getType().equals("head")) {
		    return "cooperation/CommentList";
		}
		
		commentVO.setWrterNm(user.getStringNo());
		
		commentVO.setSubPageUnit(propertyService.getInt("pageUnit"));
		commentVO.setSubPageSize(propertyService.getInt("pageSize"));
	
		Map<String, Object> map = bbsCommentService.selectCommentList(commentVO);
	
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		
		commentVO.setCommentCn("");	// 등록 후 댓글 내용 처리
	
		return "cooperation/CommentList";
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
    @RequestMapping("/cooperation/insertComment.do")
    public String insertComment(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") CommentVO commentVO,
    	@ModelAttribute("comment") Comment comment, BindingResult bindingResult, ModelMap model) throws Exception {
    	
		MemberVO user = SessionUtil.getMember(multiRequest);
		Boolean isAuthenticated = SessionUtil.isLogin(multiRequest);
	
		List<FileVO> result = null;
	    String atchFileId = "";
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result);
	    }
	
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
	
		if (commentVO.getBbsId().equals("BBSMSTR_000000000071"))
			return "redirect:/cooperation/selectWeekReport.do?bbsId=" + comment.getBbsId() + "&nttId=" + comment.getNttId();
		else if (commentVO.getBbsId().equals("BBSMSTR_000000000072")) 
			return "redirect:/cooperation/selectPrjBoard.do?bbsId=" + comment.getBbsId() + "&nttId=" + comment.getNttId();
		else
			return "redirect:/cooperation/selectBoardArticle.do?bbsId=" + comment.getBbsId() + "&nttId=" + comment.getNttId();
		
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
    @RequestMapping("/cooperation/deleteComment.do")
    public String deleteComment(@ModelAttribute("searchVO") CommentVO commentVO, @ModelAttribute("comment") Comment comment, ModelMap model) throws Exception {
		
		bbsCommentService.deleteComment(commentVO);

		commentVO.setCommentCn("");
		commentVO.setCommentNo("");
		
		if (commentVO.getBbsId().equals("BBSMSTR_000000000071"))
			return "forward:/cooperation/selectWeekReport.do";
		else if (commentVO.getBbsId().equals("BBSMSTR_000000000072")) 
			return "forward:/cooperation/selectPrjBoard.do";
		else
			return "forward:/cooperation/selectBoardArticle.do";

    }
    
    /**
     * 댓글 수정 페이지로 이동한다.
     * 
     * @param commentVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cooperation/selectSingleComment.do")
    public String selectSingleComment(@ModelAttribute("searchVO") CommentVO commentVO,
    	HttpServletRequest req, ModelMap model) throws Exception {
	
    	MemberVO user = SessionUtil.getMember(req);

    	model.addAttribute("type", commentVO.getType());	// head or body
		
		if (commentVO.getType().equals("head")) {
		    return "cooperation/CommentList";
		}
		////----------------------------------------
		
		//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		//commentVO.setWrterNm(user.getName());
	
		commentVO.setSubPageUnit(propertyService.getInt("pageUnit"));
		commentVO.setSubPageSize(propertyService.getInt("pageSize"));
	
		Map<String, Object> map = bbsCommentService.selectCommentList(commentVO);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		
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
		
		return "cooperation/CommentList";
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
    @RequestMapping("/cooperation/updateComment.do")
    public String updateCommentList(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") CommentVO commentVO,
    	@ModelAttribute("comment") Comment comment, BindingResult bindingResult, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(multiRequest);
		Boolean isAuthenticated = SessionUtil.isLogin(multiRequest);
	
		List<FileVO> result = null;
	    String atchFileId = "";
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result);
	    }
	
		if (isAuthenticated) {
			comment.setAtchFileId(atchFileId);
		    comment.setLastUpdusrId(user.getStringNo());
		    comment.setCommentCn(CommonUtil.unscript(comment.getCommentCn()));
		    
		    comment.setCommentPassword("");	// dummy
		    
		    bbsCommentService.updateComment(comment);
		    
		    commentVO.setCommentCn("");
		    commentVO.setCommentNo("");
		}
	
		if (commentVO.getBbsId().equals("BBSMSTR_000000000071"))
			return "forward:/cooperation/selectWeekReport.do";
		else if (commentVO.getBbsId().equals("BBSMSTR_000000000072")) 
			return "forward:/cooperation/selectPrjBoard.do";
		else
			return "forward:/cooperation/selectBoardArticle.do";
    }
}
