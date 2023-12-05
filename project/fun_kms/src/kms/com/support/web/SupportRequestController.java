package kms.com.support.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.app.service.ApprovalCommentVO;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.app.service.KmsEappCommentService;
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

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 업무지원 각종신청
 * @author 양진환
 * @since 2011.09.16
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.09.16 양진환          최초 생성
 *
 * Copyright (C) 2011 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class SupportRequestController {
	@Resource(name = "approvalService")
	private KmsApprovalService approvalService;
	
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "kmsEappCommentService")
	private KmsEappCommentService kmsEappCommentService;
    
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	  
    
    
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    Logger log = Logger.getLogger(this.getClass());
    

    @RequestMapping("/support/selectRecruitList.do")
    public String selectRecruitList(@ModelAttribute("approvalVO") ApprovalVO searchVO, 
    		HttpServletRequest req, ModelMap model) throws Exception {
	
    	MemberVO user = SessionUtil.getMember(req);
    	//권한 조회
    	
    	searchVO.setPageUnit(propertyService.getInt("pageUnit"));
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		searchVO.setReaderNo(user.getNo());
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setMode("50");
		searchVO.setTempltId("4");
		Map<String, Object> map = approvalService.selectApprovalList(searchVO);
    	
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(Integer.parseInt((String) map
				.get("resultCnt")));
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/support/sprt_recruitL";
    }
    
    
    
    @RequestMapping("/support/selectRecruitArticle.do")
    public String selectCommentList(@ModelAttribute("approvalVO") ApprovalVO searchVO, 
    		@ModelAttribute("approvalCommentVO") ApprovalCommentVO searchCommentVO,
    		HttpServletRequest req, ModelMap model) throws Exception {
	
    	MemberVO user = SessionUtil.getMember(req);
    	//권한 조회
    	//setting doc, comment
    	ApprovalVO vo = approvalService.viewApprovalDoc(searchVO);
    	ComDefaultCodeVO vo2 = new ComDefaultCodeVO();
		vo2.setCodeId("KMS002");
		List codeResult = cmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("educationList", codeResult);
		vo2.setCodeId("KMS003");
		vo2.setColumn1("Y");
		List rankList = cmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("rankList", rankList);
		vo2.setCodeId("COM014");
		vo2.setColumn1(null);
		codeResult = cmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("gendList", codeResult);
    	
    //	searchCommentVO.setMode("1");
    //	List<ApprovalCommentVO> kmsEappCommentList = kmsEappCommentService.selectKmsEappCommentList(searchCommentVO);
	//	model.addAttribute("commentList", kmsEappCommentList);

		model.addAttribute("result", vo);
    	model.addAttribute("specificVO", approvalService.viewApprovalJobg(searchVO)) ;
    	
    	
		return "/support/sprt_recruitV";
    }
    
   }
