package kms.com.app.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import kms.com.app.service.*;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.ApprovalButton;
import kms.com.community.service.NoteService;
import kms.com.member.service.MemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Iterator;
import java.util.List;

/**
 * @Class Name : KmsEappCommentController.java
 * @Description : KmsEappComment Controller class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class KmsEappCommentController {

	@Resource(name = "kmsEappCommentService")
	private KmsEappCommentService kmsEappCommentService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/** KmsApprovalService */
	@Resource(name = "approvalService")
	private KmsApprovalService approvalService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	/**
	 * KMS_EAPP_COMMENT 목록을 조회한다. 
	 * @param searchVO - 조회할 정보가 담긴 KmsEappCommentDefaultVO
	 * @return "/kmsEappComment/KmsEappCommentList"
	 * @exception Exception
	 */
	@RequestMapping(value="/approval/selectCommentList.do")
	public String selectKmsEappCommentList(@ModelAttribute("searchVO") ApprovalCommentVO searchVO, 
			@ModelAttribute("button") ApprovalButton button,
			ModelMap model)
			throws Exception {
		
		List<ApprovalCommentVO> kmsEappCommentList = kmsEappCommentService.selectKmsEappCommentList(searchVO);
		model.addAttribute("resultList", kmsEappCommentList);
		return "/approval/include/commentV";
	} 
	  
	
	//승인 없이 의견첨부만 할 경우 이리로 이동. fkEappReader = -1 로 세팅됨.
	@RequestMapping(value="/kmsEappComment/commentI.do")
	public String addKmsEappComment(
			HttpServletRequest request,
			ApprovalComment kmsEappCommentVO,
			@ModelAttribute("searchVO") ApprovalCommentVO searchVO,
			@ModelAttribute("approvalVO") ApprovalVO approvalVO,
			SessionStatus status)
			throws Exception {
		
		MemberVO user = (MemberVO)SessionUtil.getMember(request);
		List<ApprovalReaderVO> readerVOList = approvalService.viewApprovalReader(approvalVO);
		Iterator<ApprovalReaderVO> it = readerVOList.iterator();
		while(it.hasNext()) {
			ApprovalReaderVO readerVO = it.next();
			if(user.getNo()==readerVO.getReaderNo() || user.isAdmin()) {
				kmsEappCommentVO.setAppTyp(readerVO.getAppTyp());
				break;
			}
		}
		if(kmsEappCommentVO.getAppTyp()==null)
			return "/error/authError";
		kmsEappCommentVO.setWriterNo(user.getNo());
		kmsEappCommentVO.setFkEappReader(-1);
		kmsEappCommentService.insertKmsEappComment(kmsEappCommentVO);
		
		
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
		
		status.setComplete();
		//return "forward:/approval/approvalV.do";
		return "redirect:/approval/approvalV.do?docId=" + vo.getDocId();
	}
	
	   
	@RequestMapping("/kmsEappComment/selectKmsEappComment.do")
	public @ModelAttribute("kmsEappCommentVO")
	ApprovalComment selectKmsEappComment(
			ApprovalComment kmsEappCommentVO,
			@ModelAttribute("searchVO") ApprovalCommentVO searchVO) throws Exception {
		return kmsEappCommentService.selectKmsEappComment(kmsEappCommentVO);
	}


}
