package kms.com.cooperation.web;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.NoteService;
import kms.com.cooperation.service.BusiCntctService;
import kms.com.cooperation.service.BusinessContactComment;
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BusinessContactCommentController {

	@Resource(name = "KmsBusinessContactService")
	protected BusiCntctService bCService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;

	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;
	
	@RequestMapping("/cooperation/selectBusinessContactCommentList.do")
	public String selectBusinessContactCommentList(@ModelAttribute("searchVO") BusinessContactComment businessContactComment,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		model.addAttribute("type", businessContactComment.getType());
		model.addAttribute("printIncComment", (String)commandMap.get("printIncComment"));
		
		if (businessContactComment.getType().equals("head")) {
			return "cooperation/coop_busiContactCommentL";
		}
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			return "forward:/cooperation/updateBusinessContactCommentView.do";
		}
		
		businessContactComment.setNo(null);
		List<BusinessContactComment> resultList = bCService.selectBusinessContactCommentList(businessContactComment);
		
		model.addAttribute("resultList", resultList);
		
		return "cooperation/coop_busiContactCommentL";
	}
	
	@RequestMapping("/cooperation/insertBusinessContactComment.do")
	public String insertBusinessContactComment(MultipartHttpServletRequest multiRequest, Map<String,Object> commandMap,
			@ModelAttribute("searchVO") BusinessContactComment businessContactComment, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		businessContactComment.setUserNo(user.getNo());
		
		List<FileVO> result = null;
		String atchFileId = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BCC_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		
		businessContactComment.setAttachFileId(atchFileId);
		String BcCommentCn = businessContactComment.getBcCommentCn();
		businessContactComment.setBcCommentCn(CommonUtil.unscript(businessContactComment.getBcCommentCn()));
		
		bCService.insertBusinessContactComment(businessContactComment);
		
		//2014.06.30 김동우 PUSH 적용
		if ("Y".equals((String)commandMap.get("push_yn"))) {
			BusinessContactVO searchVO = new BusinessContactVO();
			searchVO.setUserNo(user.getNo());
			searchVO.setBcId(businessContactComment.getBcId());
			BusinessContactVO businessContactVO = bCService.selectBusinessContact(searchVO);
			
			List<BusinessContactRecieve> recList = businessContactVO.getRecieveList();
			List<BusinessContactRecieve> refList = businessContactVO.getReferenceList();

			List<String> userMixList = new ArrayList<String>();
			String receiveNmId = "";
			// 작성자 목록 추가
			receiveNmId = businessContactVO.getUserNm() + "(" + businessContactVO.getUserId() + ")";
			userMixList.add(receiveNmId);
			// 수신자 목록추가
			for (BusinessContactRecieve tmpVO: recList) {
				receiveNmId = tmpVO.getUserNm() + "(" + tmpVO.getUserId() + ")";
				// 중복 삽입 X
				if (userMixList.indexOf(receiveNmId) < 0)
					userMixList.add(receiveNmId);
			}
			// 참조자 목록추가
			for (BusinessContactRecieve tmpVO: refList) {
				receiveNmId = tmpVO.getUserNm() + "(" + tmpVO.getUserId() + ")";
				// 중복 삽입 X
				if (userMixList.indexOf(receiveNmId) < 0)
				userMixList.add(receiveNmId);
			}
		
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
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
			String title = businessContactVO.getBcSj();
			String urlMsg = "";
			String msg = "덧글작성자 : " + user.getUserNm() + "\n";
			msg += "덧글내용 : " + BcCommentCn;
			/*
			 *  msg 절삭(알림톡 전송가능한 최대 바이트는 4096이다.)
			 *  한글을 utf-8로 인코딩 했을 때 바이트수가 비약적으로 늘어나는데,
			 *  테스트 결과 512자로 절삭했을 때 기타정보 등 최종적으로 약 4100byte로 안정적으로 전송가능.
			*/
			int pushMsgMaxLength = Integer.parseInt(propertyService.getString("pushMsgMaxLength"));
			if (msg.length() > pushMsgMaxLength) msg = msg.substring(0, pushMsgMaxLength);
			
			// 내용: Link 추가
			urlMsg = "\n\n" + multiRequest.getRequestURL().substring(0, multiRequest.getRequestURL().indexOf("/", "http://".length()))  
					+ "/cooperation/selectBusinessContact.do?bcId=" + businessContactVO.getBcId();
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			pushVO.setTitle(title);
			pushVO.setAddMsg(urlMsg);
			
			// 푸쉬 발송
			String type = "work";
			String pushResult = pushSender.sendMessage(type, pushVO);
		}
		
		return "redirect:/cooperation/selectBusinessContact.do?bcId=" + businessContactComment.getBcId();
	}
	
	@RequestMapping("/cooperation/updateBusinessContactCommentView.do")
	public String updateBusinessContactCommentView(@ModelAttribute("searchVO") BusinessContactComment businessContactComment, ModelMap model) throws Exception {

		BusinessContactComment bcComment = bCService.selectBusinessContactComment(businessContactComment);
		businessContactComment.setNo(null);
		List<BusinessContactComment> resultList = bCService.selectBusinessContactCommentList(businessContactComment);
		
		model.addAttribute("type", "body");
		model.addAttribute("resultList", resultList);
		model.addAttribute("bcComment", bcComment);
		
		return "cooperation/coop_busiContactCommentL";
	}
	
	@RequestMapping("/cooperation/updateBusinessContactComment.do")
	public String updateBusinessContactComment(MultipartHttpServletRequest multiRequest, Map<String,Object> commandMap,
			@ModelAttribute("searchVO") BusinessContactComment businessContactComment, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		businessContactComment.setUserNo(user.getNo());
		List<FileVO> result = null;
		String atchFileId = "";
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BCC_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
	
		businessContactComment.setAttachFileId(atchFileId);
		businessContactComment.setUseAt("Y");
		String BcCommentCn = businessContactComment.getBcCommentCn();
		businessContactComment.setBcCommentCn(CommonUtil.unscript(businessContactComment.getBcCommentCn()));
		
		//bCService.updateBusinessContactComment(businessContactComment);
		bCService.updateBusinessContactCommentWithoutDeleteReadTime(businessContactComment);
		
		
		//2014.06.30 김동우 PUSH 적용
		if ("Y".equals((String)commandMap.get("push_yn"))) {
			BusinessContactVO searchVO = new BusinessContactVO();
			searchVO.setUserNo(user.getNo());
			searchVO.setBcId(businessContactComment.getBcId());
			BusinessContactVO businessContactVO = bCService.selectBusinessContact(searchVO);
			
			List<BusinessContactRecieve> recList = businessContactVO.getRecieveList();
			List<BusinessContactRecieve> refList = businessContactVO.getReferenceList();

			List<String> userMixList = new ArrayList<String>();
			String receiveNmId = "";
			// 작성자 목록 추가
			receiveNmId = businessContactVO.getUserNm() + "(" + businessContactVO.getUserId() + ")";
			userMixList.add(receiveNmId);
			// 수신자 목록추가
			for (BusinessContactRecieve tmpVO: recList) {
				receiveNmId = tmpVO.getUserNm() + "(" + tmpVO.getUserId() + ")";
				// 중복 삽입 X
				if (userMixList.indexOf(receiveNmId) < 0)
					userMixList.add(receiveNmId);
			}
			// 참조자 목록추가
			for (BusinessContactRecieve tmpVO: refList) {
				receiveNmId = tmpVO.getUserNm() + "(" + tmpVO.getUserId() + ")";
				// 중복 삽입 X
				if (userMixList.indexOf(receiveNmId) < 0)
				userMixList.add(receiveNmId);
			}
		
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
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
			String title = businessContactVO.getBcSj();
			String urlMsg = "";
			String msg = "덧글작성자 : " + user.getUserNm() + "\n";
			msg += "덧글내용 : " + BcCommentCn;
			/*
			 *  msg 절삭(알림톡 전송가능한 최대 바이트는 4096이다.)
			 *  한글을 utf-8로 인코딩 했을 때 바이트수가 비약적으로 늘어나는데,
			 *  테스트 결과 512자로 절삭했을 때 기타정보 등 최종적으로 약 4100byte로 안정적으로 전송가능.
			*/
			int pushMsgMaxLength = Integer.parseInt(propertyService.getString("pushMsgMaxLength"));
			if (msg.length() > pushMsgMaxLength) msg = msg.substring(0, pushMsgMaxLength);
			
			// 내용: Link 추가
			urlMsg = "\n\n" + multiRequest.getRequestURL().substring(0, multiRequest.getRequestURL().indexOf("/", "http://".length()))  
					+ "/cooperation/selectBusinessContact.do?bcId=" + businessContactVO.getBcId();
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			pushVO.setTitle(title);
			pushVO.setAddMsg(urlMsg);
			
			// 푸쉬 발송
			String type = "work";
			String pushResult = pushSender.sendMessage(type, pushVO);
		}
		
		return "redirect:/cooperation/selectBusinessContact.do?bcId=" + businessContactComment.getBcId();
	}
	
	@RequestMapping("/cooperation/deleteBusinessContactComment.do")
	public String deleteBusinessContactComment(@ModelAttribute("searchVO") BusinessContactComment businessContactComment, ModelMap model) throws Exception {
		
		//bCService.updateBusinessContactComment(businessContactComment);
		bCService.updateBusinessContactCommentWithoutDeleteReadTime(businessContactComment);
		
		businessContactComment.setNo(null);
		List<BusinessContactComment> resultList = bCService.selectBusinessContactCommentList(businessContactComment);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("type", "body");
		
		return "cooperation/coop_busiContactCommentL";
	}
	
	
	
	@RequestMapping("/cooperation/ajax/selectBusinessContactCommentList.do")
	public String selectBusinessContactCommentListAjax(@ModelAttribute("searchVO") BusinessContactComment businessContactComment,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		businessContactComment.setNo(null);
		List<BusinessContactComment> resultList = bCService.selectBusinessContactCommentList(businessContactComment);
		
		model.addAttribute("resultList", resultList);
		
		return "cooperation/include/coop_busiContactCommentL_ajax";
	}
	
}
