package kms.com.community.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.Mail;
import kms.com.community.service.MailService;
import kms.com.community.service.MailVO;
import kms.com.community.service.NoteService;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : TblMailsendController.java
 * @Description : TblMailsend Controller class
 * @Modification Information
 *
 * @author 이병주
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class MailController {

	@Resource(name = "KmsMailService")
	private MailService mailService;

	@Resource(name="KmsMemberService")
	MemberService memberService;
	
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;
	
	/**
	 * 메일 발송페이지로 이동
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/sendMailView.do")
	public String addTblMailsendView(@ModelAttribute("searchVO") MailVO mailVO, Model model) throws Exception {
		if(mailVO.getRecieverNo()!=null && !"".equals(mailVO.getRecieverNo())) {
			MemberVO memberVO = new MemberVO();
			memberVO.setNo(Integer.parseInt(mailVO.getRecieverNo()));
			memberVO = (MemberVO) memberService.selectMember(memberVO).get("member");
			mailVO.setRecieverNm(memberVO.getUserNm());
			mailVO.setRecieverId(memberVO.getUserId());
			model.addAttribute("searchVO", mailVO);
		}
		return "/community/comm_MailW";
	}
	
	/**
	 * 메일 발송
	 * @param multiRequest
	 * @param mail
	 * @param searchVO
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/sendMail.do")
	public String addTblMailsend(final MultipartHttpServletRequest multiRequest, Mail mail,
			@ModelAttribute("searchVO") MailVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);    	
		String atchFileId = mail.getAtchFileId();

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
				List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				mail.setAtchFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}
		
		mail.setSenderNo(user.getNo());
		mail.setRecieverIdList(CommonUtil.parseIdFromMixs(mail.getRecieverList()));
		
		// redirect 메세지 변수 초기화
		model.addAttribute("message", "");
		model.addAttribute("message2", ""); 
		if("Y".equals(mail.getIsSend()))
			model.addAttribute("redirectUrl", "/community/selectSendMailList.do");
		else
			model.addAttribute("redirectUrl", "/community/selectSaveMailList.do");		
			
		if ("Y".equals(mail.getSmsSend()) && "Y".equals(mail.getIsSend())) {
			
			List<String> userMixList = CommonUtil.makeValidIdListArray(mail.getRecieverList());
			
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
			//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
			param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
			
			try{
				CommonUtil.smsSend("[사내메일]" + mail.getMailSj(), user, memberList);
			}catch(Exception e){
				// 2013-04-29 문자 전송 실패시 메세지 보여주고 이동
				mail.setSmsSend("F");
				model.addAttribute("message", "SMS 서버가 응답이 없습니다.\\n사내메일은 전송되며 SMS 전송 실패 상태로 변경됩니다.");
			}			
		}
		
		
		//2013.08.20 김대현 PUSH 적용
		if ("Y".equals(mail.getPushSend()) && "Y".equals(mail.getIsSend())) {
			List<String> userMixList = CommonUtil.makeValidIdListArray(mail.getRecieverList());
			
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
			//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
			param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
			
			// 푸쉬 발송대상의 전화번호 추출
			List<String> rPhoneList = new ArrayList<String>();
			for(int i = 0; i < memberList.size(); i++){
				String toPhoneNo = memberList.get(i).getMoblphonNo().replace("-", "");
				if(toPhoneNo != null && !toPhoneNo.equals("")){
					rPhoneList.add(toPhoneNo);
				}
			}
			
			// 푸쉬 발송 전 파라미터 가공
			String title = mail.getMailSj();
			String msg = CommonUtil.deleteAllTag(mail.getMailCn());
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			pushVO.setTitle(title);
			
			// 푸쉬 발송
			String type = "mail";
			String pushResult = pushSender.sendMessage(type, pushVO);
		}
		
		//2012-10-29  문자부터 보내고 사내메일 전송하도록 변경 - 문자나라 서버가 응답하지 않는경우 예외 발생하고 메일만 여러번 발송되는 경우가 발생하였기 때문 
		mailService.sendMail(mail);				
		return "/error/messageRedirect";
		
		/*
		if("Y".equals(mail.getIsSend()))
			return "redirect:/community/selectSendMailList.do";
		else
			return "redirect:/community/selectSaveMailList.do";
		*/
	}
		
	@RequestMapping("/community/sendMailSMTPTest.do")
	public String sendMailSMTP (HttpServletRequest req, ModelMap model, String refId)throws Exception {
		
		//메일발송결재 테스트용도
		
		MailVO mailVO = new MailVO();
		mailVO.setRefId(refId);
		mailVO.setUserNo(178);
		mailVO.setMailSj("SMTP with file test Title");
		mailVO.setMailCn("SMTP with file testing");
		mailVO.setAtchFileId("FILE_000000000113831");
		mailService.sendMailSMTPOut(mailVO);
		return "redirect:/approval/approvalV.do?docId=" + refId;		
	}
		
	
	/**
	 * 보낸 MAIL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 TblMailsendDefaultVO
	 * @return "/tblMailsend/TblMailsendList"
	 * @exception Exception
	 */
	@RequestMapping(value="/community/selectSendMailList.do")
	public String selectSendMailList(@ModelAttribute("searchVO") MailVO searchVO, 
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		/** EgovPropertyService.sample */
		int pageUnit = propertiesService.getInt("pageUnit");
		String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_mail_pageunit");
		if (pageUnitCookie != null) 
			pageUnit = Integer.parseInt(pageUnitCookie);
		
		searchVO.setPageUnit(pageUnit);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setUserNo(user.getNo());
		searchVO.setIsSend("Y"); // 발송한 메일
		
		List<MailVO> sendMailList = mailService.selectSendMailList(searchVO);
		
		int totCnt = mailService.selectSendMailListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", sendMailList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/community/comm_MailSendL";
	}
	
	/**
	 * 받은 MAIL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 TblMailsendDefaultVO
	 * @return "/tblMailsend/TblMailsendList"
	 * @exception Exception
	 */
	@RequestMapping(value="/community/selectRecieveMailList.do")
	public String selectRecieveMailList(@ModelAttribute("searchVO") MailVO searchVO, 
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		/** EgovPropertyService.sample */
		int pageUnit = propertiesService.getInt("pageUnit");
		String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_mail_pageunit");
		if (pageUnitCookie != null) 
			pageUnit = Integer.parseInt(pageUnitCookie);
		
		searchVO.setPageUnit(pageUnit);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setUserNo(user.getNo());
		
		List<MailVO> recieveMailList = mailService.selectRecieveMailList(searchVO);
		
		int totCnt = mailService.selectRecieveMailListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", recieveMailList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/community/comm_MailRecieveL";
	}
	
	/**
	 * 메일읽기(받은메일/보낸메일)
	 * @param searchVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/selectMail.do")
	public String selectMail(@ModelAttribute("searchVO") MailVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		searchVO.setUserNo(user.getNo());
						
		List<MailVO> resultList = mailService.readMail(searchVO);
		
		if(resultList.size()<1){
			model.addAttribute("message", "없는 메일번호입니다.");
			return "error/messageError";
		}
			 
		MailVO result = resultList.get(0);
		boolean auth = false;
		
		/* 전체회신용 수신자No 리스트 S -------------------------- */
		String recieverList = "";
		for (int i=0; i<resultList.size(); i++) {
			if (user.getStringNo().equals(resultList.get(i).getRecieverNo()) == false) {
				recieverList += resultList.get(i).getRecieverNm() + "(" + resultList.get(i).getRecieverId() + ")";
				recieverList += ",";
			} else { //수신자 조회 허용
				auth = true;
			}
			if(user.getNo() == resultList.get(i).getSenderNo()) {
				//발신자 조회 허용
				auth = true;        		
			}
		}
		if(recieverList.length()>0)
			recieverList = recieverList.substring(0, recieverList.length() - 1);
		result.setRecieverList(recieverList);
		/* 전체회신용 수신자No 리스트 E -------------------------- */
		
		if(auth == false && user.isAdmin() == false){
			model.addAttribute("message", "조회 권한이 없습니다.");
			return "error/messageError";
		}
		
		model.addAttribute("result" ,result);
		model.addAttribute("resultList" ,resultList);
		
		if (searchVO.getReadChk().equals("Y"))
			return "/community/comm_MailRecieveV";
		else 
			return "/community/comm_MailSendV";
	}
	
	/**
	 * 회신/전체회신
	 * @param mailVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/replyMail.do")
	public String replyMail(@ModelAttribute("searchVO") MailVO mailVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		model.addAttribute("result", mailVO);
		model.addAttribute("reply", "Y");
		
		List<MailVO> resultList = mailService.readMail(mailVO);
		if (resultList.size() > 0) {
			MailVO orgMail = resultList.get(0);
			
			String recieverList = "";
			for (int i=0; i<resultList.size(); i++) {
				if (recieverList.equals("") == false) {
					recieverList += ", ";
				}
				recieverList += resultList.get(i).getRecieverNm() + "(" + resultList.get(i).getRecieverId() + ")";
			}
	
			model.addAttribute("orgMailSj", orgMail.getMailSj());
			model.addAttribute("orgMailCn", orgMail.getMailCn());
			model.addAttribute("orgSendDt", orgMail.getSendDt());
			model.addAttribute("orgSenderId", orgMail.getSenderId());
			model.addAttribute("orgSenderNm", orgMail.getSenderNm());
			model.addAttribute("orgReceiverList", recieverList);
		}

		return "/community/comm_MailW";
	}

	/**
	 * 전달
	 * @param mailVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/forwardMail.do")
	public String forwardMail(@ModelAttribute("searchVO") MailVO mailVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		model.addAttribute("result", mailVO);
		model.addAttribute("forward", "Y");
		
		List<MailVO> resultList = mailService.readMail(mailVO);
		if (resultList.size() > 0) {
			MailVO orgMail = resultList.get(0);
			
			String recieverList = "";
			for (int i=0; i<resultList.size(); i++) {
				if (recieverList.equals("") == false) {
					recieverList += ", ";
				}
				recieverList += resultList.get(i).getRecieverNm() + "(" + resultList.get(i).getRecieverId() + ")";
			}
			
			model.addAttribute("forwardMail", "true");
			model.addAttribute("orgMailSj", orgMail.getMailSj());
			model.addAttribute("orgMailCn", orgMail.getMailCn());
			model.addAttribute("orgSendDt", orgMail.getSendDt());
			model.addAttribute("orgSenderId", orgMail.getSenderId());
			model.addAttribute("orgSenderNm", orgMail.getSenderNm());
			model.addAttribute("orgReceiverList", recieverList);
		}

		return "/community/comm_MailW";
	}

	/**
	 * 재발송
	 * @param mailVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/resendMail.do")
	public String resendMail(@ModelAttribute("searchVO") MailVO mailVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		mailService.resendMail(mailVO);    	
		return "redirect:/community/selectSendMailList.do";
	}

	/**
	 * 보낸메일 삭제
	 * @param mailVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/deleteSendMailList.do")
	public String deleteSendNoteList(@ModelAttribute("searchVO") MailVO mailVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		mailService.deleteSendMail(mailVO);
		
		if ("Y".equals(mailVO.getIsSend()))
			return "redirect:/community/selectSendMailList.do";
		else
			return "redirect:/community/selectSaveMailList.do";
	}
	
	/**
	 * 보낸메일 발송취소
	 * @param mailVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/cancelSendMailList.do")
	public String cancelSendNoteList(@ModelAttribute("searchVO") MailVO mailVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		mailService.cancelSendMail(mailVO);
		mailService.deleteSendMail(mailVO);    	
		return "redirect:/community/selectSendMailList.do";    	
	}
	
	/**
	 * 받은메일 삭제
	 * @param mailVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/deleteRecieveMailList.do")
	public String deleteRecieveNoteList(@ModelAttribute("searchVO") MailVO mailVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		
		mailVO.setUserNo(user.getNo());
		
		mailService.deleteRecieveMail(mailVO);
		
		return "redirect:/community/selectRecieveMailList.do";
	}
	
	/**
	 * 저장된 메일 목록 불러오기
	 * @param searchVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/selectSaveMailList.do")
	public String selectSaveMailList(@ModelAttribute("searchVO") MailVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setUserNo(user.getNo());
		searchVO.setIsSend("N"); // 저장된 메일
		
		List<MailVO> sendMailList = mailService.selectSendMailList(searchVO);
		
		int totCnt = mailService.selectSendMailListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", sendMailList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "community/comm_WriteboxL";
	}
	
	/**
	 * 저장된 메일을 불러와 사내메일발송페이지에 내용을 채움
	 * @param mailVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/selectSaveMail.do")
	public String selectSaveMail(@ModelAttribute("searchVO") MailVO mailVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);

		mailVO.setUserNo(user.getNo());
		
		List<MailVO> resultList = mailService.readMail(mailVO);
		
		MailVO result = resultList.get(0);
		
		/* 전체회신용 수신자No 리스트 S -------------------------- */
		String recieverList = "";
		for (int i=0; i<resultList.size(); i++) {
			if (recieverList.equals("") == false) {
				recieverList += ",";
			}
			if (user.getStringNo().equals(resultList.get(i).getRecieverNo()) == false) {
				recieverList += resultList.get(i).getRecieverNm() + "(" + resultList.get(i).getRecieverId() + ")";
			}
		}
		result.setRecieverList(recieverList);
		/* 전체회신용 수신자No 리스트 E -------------------------- */
		
		model.addAttribute("boolSavedMail" , "true");
		model.addAttribute("result" ,result);
		model.addAttribute("resultList" ,resultList);
		
		return "/community/comm_MailW";
	}
	
	/**
	 * 메일 열람상태
	 * @param searchVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/community/selectSendMailState.do")
	public String selectSendMailState(@ModelAttribute("searchVO") MailVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<MailVO> sendMailState = mailService.selectSendMailState(searchVO);
		
		int totCnt = mailService.selectSendMailStateTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", sendMailState);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "community/comm_pop_MailReadL";
	}
	
	@RequestMapping("/community/printMail.do")
	public String printMail(MailVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		searchVO.setUserNo(user.getNo());
		
		List<MailVO> resultList = mailService.readMail(searchVO);
		
		model.addAttribute("result", resultList.get(0));
		model.addAttribute("resultList", resultList);
		
		return "community/comm_pop_MailPrint";
	}
}
