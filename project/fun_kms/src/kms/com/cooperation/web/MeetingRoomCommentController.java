package kms.com.cooperation.web;

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
import kms.com.cooperation.service.MeetingRoomComment;
import kms.com.cooperation.service.MeetingRoomRecieve;
import kms.com.cooperation.service.MeetingRoomService;
import kms.com.cooperation.service.MeetingRoomVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

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
public class MeetingRoomCommentController {

	@Resource(name = "KmsMeetingRoomService")
	protected MeetingRoomService mTService;
    
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
    
    @Resource(name = "pushSender")
	private PushSender pushSender;
    
    @RequestMapping("/cooperation/selectMeetingRoomCommentList.do")
	public String selectMeetingRoomCommentList(@ModelAttribute("searchVO") MeetingRoomComment meetingRoomComment,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		model.addAttribute("type", meetingRoomComment.getType());
		model.addAttribute("printIncComment", (String)commandMap.get("printIncComment"));
		
		if (meetingRoomComment.getType().equals("head")) {
		    return "cooperation/coop_meetingRoomCommentL";
		}
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			return "forward:/cooperation/updateMeetingRoomCommentView.do";
		}
		
		meetingRoomComment.setNo(null);
		List<MeetingRoomComment> resultList = mTService.selectMeetingRoomCommentList(meetingRoomComment);
		
		model.addAttribute("resultList", resultList);
		
		return "cooperation/coop_meetingRoomCommentL";
	}
    
    @RequestMapping("/cooperation/insertMeetingRoomComment.do")
    public String insertMeetingRoomComment(MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") MeetingRoomComment meetingRoomComment, 
    		Map<String, Object> commandMap, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(multiRequest);
    	
    	meetingRoomComment.setUserNo(user.getNo());
    	
    	List<FileVO> result = null;
	    String atchFileId = "";

	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "MEET", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result);
	    }
		
		meetingRoomComment.setAttachFileId(atchFileId);
		meetingRoomComment.setMtCommentCn(CommonUtil.unscript(meetingRoomComment.getMtCommentCn()));
		
		mTService.insertMeetingRoomComment(meetingRoomComment);
		
		
		//2015.02.03 김동우 PUSH 적용
		if ("Y".equals((String)commandMap.get("push_yn"))) {
			MeetingRoomVO searchVO = new MeetingRoomVO();
			searchVO.setUserNo(user.getNo());
			searchVO.setMtId(meetingRoomComment.getMtId());
			MeetingRoomVO meetingRoomVO = mTService.selectMeetingRoom(searchVO);
			
			List<MeetingRoomRecieve> recList = meetingRoomVO.getRecieveList();
			List<MeetingRoomRecieve> refList = meetingRoomVO.getReferenceList();

			List<String> userMixList = new ArrayList<String>();
			String receiveNmId = "";
			// 작성자 목록 추가
			receiveNmId = meetingRoomVO.getUserNm() + "(" + meetingRoomVO.getUserId() + ")";
			userMixList.add(receiveNmId);
			// 수신자 목록추가
			for (MeetingRoomRecieve tmpVO: recList) {
				receiveNmId = tmpVO.getUserNm() + "(" + tmpVO.getUserId() + ")";
				// 중복 삽입 X
				if (userMixList.indexOf(receiveNmId) < 0)
					userMixList.add(receiveNmId);
			}
			// 참조자 목록추가
			for (MeetingRoomRecieve tmpVO: refList) {
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
			String title = meetingRoomVO.getMtSj();
			String urlMsg = "";
			String msg = "덧글작성자 : " + user.getUserNm() + "\n";
			msg += "덧글내용 : " + meetingRoomComment.getMtCommentCn();
			
			// 내용: Link 추가
			urlMsg = "\n\n" + multiRequest.getRequestURL().substring(0, multiRequest.getRequestURL().indexOf("/", "http://".length()))  
					+ "/cooperation/selectMeetingRoom.do?mtId=" + meetingRoomVO.getMtId();
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			pushVO.setTitle(title);
			pushVO.setAddMsg(urlMsg);
			
			// 푸쉬 발송
			String type = "conf";
			String pushResult = pushSender.sendMessage(type, pushVO);
		}
		
    	return "redirect:/cooperation/selectMeetingRoom.do?mtId=" + meetingRoomComment.getMtId();
    }
	
    @RequestMapping("/cooperation/updateMeetingRoomCommentView.do")
    public String updateMeetingRoomCommentView(@ModelAttribute("searchVO") MeetingRoomComment meetingRoomComment, ModelMap model) throws Exception {

    	MeetingRoomComment mtComment = mTService.selectMeetingRoomComment(meetingRoomComment);
    	meetingRoomComment.setNo(null);
		List<MeetingRoomComment> resultList = mTService.selectMeetingRoomCommentList(meetingRoomComment);
		
		model.addAttribute("type", "body");
		model.addAttribute("resultList", resultList);
		model.addAttribute("mtComment", mtComment);
		
		return "cooperation/coop_meetingRoomCommentL";
    }
    
    @RequestMapping("/cooperation/updateMeetingRoomComment.do")
    public String updateMeetingRoomComment(MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") MeetingRoomComment meetingRoomComment, 
    		Map<String, Object> commandMap, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(multiRequest);
    	
    	meetingRoomComment.setUserNo(user.getNo());
    	List<FileVO> result = null;
	    String atchFileId = "";
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "MEET", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result);
	    }
	
		meetingRoomComment.setAttachFileId(atchFileId);
		meetingRoomComment.setUseAt("Y");
		meetingRoomComment.setMtCommentCn(CommonUtil.unscript(meetingRoomComment.getMtCommentCn()));
	    
    	mTService.updateMeetingRoomComment(meetingRoomComment);
    	
    	//2015.02.03 김동우 PUSH 적용
		if ("Y".equals((String)commandMap.get("push_yn"))) {
			MeetingRoomVO searchVO = new MeetingRoomVO();
			searchVO.setUserNo(user.getNo());
			searchVO.setMtId(meetingRoomComment.getMtId());
			MeetingRoomVO meetingRoomVO = mTService.selectMeetingRoom(searchVO);
			
			List<MeetingRoomRecieve> recList = meetingRoomVO.getRecieveList();
			List<MeetingRoomRecieve> refList = meetingRoomVO.getReferenceList();

			List<String> userMixList = new ArrayList<String>();
			String receiveNmId = "";
			// 작성자 목록 추가
			receiveNmId = meetingRoomVO.getUserNm() + "(" + meetingRoomVO.getUserId() + ")";
			userMixList.add(receiveNmId);
			// 수신자 목록추가
			for (MeetingRoomRecieve tmpVO: recList) {
				receiveNmId = tmpVO.getUserNm() + "(" + tmpVO.getUserId() + ")";
				// 중복 삽입 X
				if (userMixList.indexOf(receiveNmId) < 0)
					userMixList.add(receiveNmId);
			}
			// 참조자 목록추가
			for (MeetingRoomRecieve tmpVO: refList) {
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
			String title = meetingRoomVO.getMtSj();
			String urlMsg = "";
			String msg = "덧글작성자 : " + user.getUserNm() + "\n";
			msg += "덧글내용 : " + meetingRoomComment.getMtCommentCn();
			
			// 내용: Link 추가
			urlMsg = "\n\n" + multiRequest.getRequestURL().substring(0, multiRequest.getRequestURL().indexOf("/", "http://".length()))  
					+ "/cooperation/selectMeetingRoom.do?mtId=" + meetingRoomVO.getMtId();
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			pushVO.setTitle(title);
			pushVO.setAddMsg(urlMsg);
			
			// 푸쉬 발송
			String type = "conf";
			String pushResult = pushSender.sendMessage(type, pushVO);
		}
    	
    	return "redirect:/cooperation/selectMeetingRoom.do?mtId=" + meetingRoomComment.getMtId();
    }
    
    @RequestMapping("/cooperation/deleteMeetingRoomComment.do")
    public String deleteMeetingRoomComment(@ModelAttribute("searchVO") MeetingRoomComment meetingRoomComment, ModelMap model) throws Exception {
    	
    	mTService.updateMeetingRoomComment(meetingRoomComment);
		
    	meetingRoomComment.setNo(null);
		List<MeetingRoomComment> resultList = mTService.selectMeetingRoomCommentList(meetingRoomComment);
		
		model.addAttribute("resultList", resultList);
    	model.addAttribute("type", "body");
    	
		return "cooperation/coop_meetingRoomCommentL";
    }
    
}
