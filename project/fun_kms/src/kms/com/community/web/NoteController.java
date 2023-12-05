package kms.com.community.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.admin.score.service.ScoreService;
import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.CommonService;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.Note;
import kms.com.community.service.NoteService;
import kms.com.community.service.NoteVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
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
public class NoteController {

	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "ScoreService")
	private ScoreService scoreService;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;
	
	@Resource(name = "KmsCommonService")
	private CommonService commonService;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;

	@RequestMapping("/community/sendNoteView.do")
	public String addTblNotesendView(
			@ModelAttribute("noteVO") NoteVO noteVO, Model model, Map<String, Object> commandMap)
			throws Exception {
		if(noteVO.getRecieverNo()!=null && !noteVO.getRecieverNo().isEmpty()){
			MemberVO memberVO = new MemberVO();
			memberVO.setNo(Integer.parseInt(noteVO.getRecieverNo()));
			memberVO = memberService.selectMemberBasic(memberVO);
			noteVO.setRecieverId(memberVO.getUserId());
			noteVO.setRecieverNm(memberVO.getUserNm());
		}
		
		if (noteVO.getCurrentUserOnly() != null && !noteVO.getCurrentUserOnly().equals(""))
			model.addAttribute("currentUserOnly", "Y");
		
		// 한마음아침인사 답장쪽지여부 전달
		model.addAttribute("replyType", noteVO.getReplyType());
		
		// [20141117, dwkim] 원본 메세지 전달(업무연락 조회권한 요청 쪽지 등)
		if (noteVO.getNoteCn() != null) {
			noteVO.setNoteCn(URLEncoder.encode(noteVO.getNoteCn(), "UTF-8").replaceAll("\\+", "%20"));
		}
		model.addAttribute("noteVO", noteVO);
		model.addAttribute("sendOriMsgYn", (String)commandMap.get("sendOriMsgYn"));
		
		return "/community/comm_pop_NoteW";
	}
	
	
	
	@RequestMapping("/community/sendNote.do")
	public String addTblNotesend(Note note, @ModelAttribute("searchVO") NoteVO searchVO, HttpServletRequest req) throws Exception {
		//String userAgent = req.getHeader("USER-AGENT");
		
		MemberVO user = SessionUtil.getMember(req);
		
		note.setSenderNo(user.getNo());
		note.setRecieverIdList(CommonUtil.parseIdFromMixs(note.getRecieverList()));
		String recieverIdList[] = note.getRecieverIdList();

		if(note.getMobilePush() == null || note.getMobilePush().equals("N") == false) {
			// 푸쉬 대상의 전화번호 목록 추출
			List<String> rPhoneList = new ArrayList<String>();
			
			//현재 접속자인 경우, 대상자 추출
			if (note.getCurrentUserOnly() != null && note.getCurrentUserOnly().equals("Y")) {
				List<EgovMap> currentUserList = commonService.selectCurrentUserList();
				String recieverIdListTemp[] = (String[]) recieverIdList.clone();
				
				// 현재 접속자 && 선택한 접속자 목록 추출
				int insertCnt = 0;
				for (int i = 0; i < recieverIdList.length; i++ ) {
					recieverIdList[i] = "";
					for (EgovMap map : currentUserList) {
						if (map.get("userId").equals(recieverIdListTemp[i])) {
							//현재접속자의 경우 전송자 명단에 넣음
							recieverIdList[i] = recieverIdListTemp[i];
							insertCnt++;
							break;
						}
					}
				}
				// 대상이 없을 경우, 창 닫고 종료
				if (0 == insertCnt)
					return "/community/comm_closePage";
			}
			
			// 푸쉬 발송대상의 전화번호 추출
			for (int i = 0; i < recieverIdList.length; i++ ) {
				
				if (recieverIdList[i].equals(""))
					continue;
				
				String toPhoneNo = noteService.phoneNo(recieverIdList[i]).replace("-", "");
				if(toPhoneNo != null && !toPhoneNo.equals("")){
					rPhoneList.add(toPhoneNo);
					
					// [20141013, dwkim] 푸쉬 발송시 DB에 로그 남기지 않도록 임의로 수정
					// 지난 8개월간 푸쉬로그를 조회할 일이 없었는데, 쓸데없이 부하만 일으키는 듯.
					// 꼭 필요하면 톰캣 로그를 확인하거나 서버개발팀의 로그를 확인하면 될듯
					//param.put("fromUserId", json.get("fromUserId"));
					//param.put("toUserId", json.get("toUserId"));
					//param.put("noteNo", "");
					//param.put("message", "");
					//param.put("pushKey", json.get("fromUserId").toString() + json.get("sendTime").toString() + json.get("toUserId").toString());
					//param.put("test", req.getSession().getServletContext().getRealPath("/") + "123");
					//param.put("type", json.get("type"));
					//param.put("success", "Y");
					//noteService.insertPushLog(param);
				}
			}
			
			// 푸쉬 발송 전 파라미터 가공
			String msg = note.getNoteCn();
			msg = CommonUtil.deleteAllTag(msg);	// 태그 제거
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			
			// 푸쉬 발송
			String type = "note";
			String result = pushSender.sendMessage(type, pushVO);
		}
		
		// 쪽지 발송대상 셋팅
		note.setRecieverIdList(recieverIdList);
		noteService.sendNote(note);
		
		return "/community/comm_closePage";
	}
	
	/**
	 * 보낸 MAIL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 TblNotesendDefaultVO
	 * @return "/tblNotesend/TblNotesendList"
	 * @exception Exception
	 */
	@RequestMapping(value="/community/selectSendNoteList.do")
	public String selectSendNoteList(@ModelAttribute("searchVO") NoteVO searchVO, 
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		/** EgovPropertyService.sample */
		int pageUnit = propertiesService.getInt("pageUnit");
		String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_note_pageunit");
		if (pageUnitCookie != null) 
			pageUnit = Integer.parseInt(pageUnitCookie);
		
		searchVO.setPageUnit(pageUnit);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		//LIMIT #recordCountPerPage# OFFSET #firstIndex#
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex()); //필요한가
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setUserNo(user.getNo());
		
		List<NoteVO> sendNoteList = noteService.selectSendNoteList(searchVO);
		
		//검색시 페이지 번호 넘어가는 경우 예외처리
		if(sendNoteList.size()<1){ 
			searchVO.setPageIndex(1);
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());    		
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex()); //필요한가
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			sendNoteList = noteService.selectSendNoteList(searchVO);
		}
		
		int totCnt = noteService.selectSendNoteListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", sendNoteList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/community/comm_NoteSendL";
	}
	
	/**
	 * 받은 MAIL 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 TblNotesendDefaultVO
	 * @return "/tblNotesend/TblNotesendList"
	 * @exception Exception
	 */
	@RequestMapping(value="/community/selectRecieveNoteList.do")
	public String selectRecieveNoteList(@ModelAttribute("searchVO") NoteVO searchVO, 
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		/** EgovPropertyService.sample */
		int pageUnit = propertiesService.getInt("pageUnit");
		String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_note_pageunit");
		if (pageUnitCookie != null) 
			pageUnit = Integer.parseInt(pageUnitCookie);
		
		searchVO.setPageUnit(pageUnit);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** Paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setUserNo(user.getNo());
		
		List<NoteVO> recieveNoteList = noteService.selectRecieveNoteList(searchVO);
		
		//검색시 페이지 번호 넘어가는 경우 예외처리
		if(recieveNoteList.size()<1){ 
			searchVO.setPageIndex(1);
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());    		
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex()); //필요한가
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			recieveNoteList = noteService.selectSendNoteList(searchVO);
		}
		
		int totCnt = noteService.selectRecieveNoteListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", recieveNoteList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/community/comm_NoteRecieveL";
	}
	
	@RequestMapping("/community/selectNote.do")
	public String selectNote(@ModelAttribute("searchVO") NoteVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {

		if (!SessionUtil.isLogin(req)) {
			return "fail";
		}
		
		MemberVO user = SessionUtil.getMember(req);
		
		if (searchVO.getRecieveMode().equals("Y")){
			searchVO.setRecieverNo(user.getNo().toString());
		} 
		
		if (searchVO.getReadChk().equals("Y")){
			searchVO.setRecieverNo(user.getNo().toString());
		} else {
			searchVO.setSenderNo(user.getNo());
		}
		
		List<NoteVO> resultList = noteService.selectNote(searchVO);
		
		if(resultList.size()<1){
			model.addAttribute("message", "없는 쪽지번호이거나 조회 권한이 없습니다.");
			return "error/messageError";
		}
			
		NoteVO result = resultList.get(0);
		
		model.addAttribute("result" ,result);
		model.addAttribute("resultList" ,resultList);
		
		
		if (searchVO.getReadChk().equals("Y"))
			return "/community/comm_pop_NoteRecieveV";
		else 
			return "/community/comm_pop_NoteSendV";
	}
	
	@RequestMapping("/community/setNoteReadDt.do")
	public String setNoteReadDt(@ModelAttribute("searchVO") NoteVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);

		searchVO.setRecieverNo(user.getNo().toString());
		
		List<NoteVO> resultList = noteService.selectNote(searchVO);
		
		NoteVO noteVO = resultList.get(0);
		
		noteService.setReadDt(noteVO);
		
		return "success";
	}
	
	@RequestMapping("/community/deleteSendNote.do")
	public String deleteSendNote(@ModelAttribute("searchVO") NoteVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {

		noteService.deleteSendNote(searchVO);
		
		return "/community/comm_closePage";
	}

	@RequestMapping("/community/deleteRecieveNote.do")
	public String deleteRecieveNote(@ModelAttribute("searchVO") NoteVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		searchVO.setRecieverNo(user.getNo().toString());

		noteService.setReadDt(searchVO);
		noteService.deleteRecieveNote(searchVO);
		
		return "/community/comm_closePage";
	}
	
	@RequestMapping("/community/deleteSendNoteList.do")
	public String deleteSendNoteList(@ModelAttribute("searchVO") NoteVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		
		noteService.deleteSendNote(searchVO);
		
		return "redirect:/community/selectSendNoteList.do";
	}
	
	@RequestMapping("/community/deleteRecieveNoteList.do")
	public String deleteRecieveNoteList(@ModelAttribute("searchVO") NoteVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		
		searchVO.setUserNo(user.getNo());
		
		noteService.deleteRecieveNote(searchVO);
		
		return "redirect:/community/selectRecieveNoteList.do";
	}
	

	@RequestMapping("/community/resendNote.do")
	public String resendNote(@ModelAttribute("searchVO") NoteVO searchVO, HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		
		searchVO.setSenderNo(user.getNo());
		
		noteService.resendNote(searchVO);
		
		return "/community/comm_closePage";
	}
	
	@RequestMapping("/community/replyNote.do")
	public String replyNote(@ModelAttribute("noteVO") NoteVO noteVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		noteVO.setRecieverNo(user.getNo().toString());
		noteService.setReadDt(noteVO);
		
		noteVO.setRecieverNm(noteVO.getSenderNm());
		noteVO.setRecieverId(noteVO.getSenderId());
		noteVO.setNoteCn(URLEncoder.encode(noteVO.getNoteCn(), "UTF-8").replaceAll("\\+", "%20"));
		model.addAttribute("noteVO", noteVO);
		return "/community/comm_pop_NoteW";
	}
	
	@RequestMapping("/community/forwardNote.do")
	public String forwardNote(@ModelAttribute("noteVO") NoteVO noteVO, HttpServletRequest req, ModelMap model) throws Exception {
		MemberVO user = SessionUtil.getMember(req);
		noteVO.setRecieverNo(user.getNo().toString());
		noteService.setReadDt(noteVO);
		
		model.addAttribute("forward", "Y");
		
		//쪽지는 1대 1이므로 수신자는 항상 자신 
		noteVO.setRecieverNm(noteVO.getSenderNm());
		noteVO.setRecieverId(noteVO.getSenderId());
		noteVO.setSenderNm(user.getUserNm());
		noteVO.setSenderId(user.getUserId());
		noteVO.setNoteCn(URLEncoder.encode(noteVO.getNoteCn(), "UTF-8").replaceAll("\\+", "%20"));
		model.addAttribute("noteVO", noteVO);
		return "/community/comm_pop_NoteW";
	}
	
	/* 
	@RequestMapping("/mobile/community/replyPush.do")
	public String recievePushMessage2(Note note, @ModelAttribute("searchVO") NoteVO searchVO, 
			HttpServletRequest req, Map<String, Object> commandMap) throws Exception {
		// PUSH 리턴받는부분
		
		String fromUserId = commandMap.get("fromUserId").toString();
		String toUserId = commandMap.get("toUserId").toString().trim();
		String noteCn = commandMap.get("message").toString();
		
		note.setSenderId(fromUserId);
		note.setRecieverIdList(new String[]{toUserId});
		note.setNoteCn(noteCn);
		
		MemberVO memberVO = new MemberVO();
		memberVO.setUserId(fromUserId);
		Map<String, Object> map = new HashMap<String, Object>();
		map = memberService.mobileSelectMember(memberVO);
		memberVO = (MemberVO) map.get("member");
		
		MemberVO memberVO2 = new MemberVO();
		memberVO2.setUserId(toUserId);
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2 = memberService.mobileSelectMember(memberVO2);
		memberVO2 = (MemberVO) map2.get("member");
		
		note.setSenderNo(memberVO.getUserNo()); 
		
		//String userAgent = req.getHeader("USER-AGENT");
		String userAgent = noteService.deviceType(toUserId);
		//String tokenInfo = noteService.tokenInfo(toUserId);
		String toUserNm = noteService.userNm(toUserId);
		String toPhoneNum = noteService.phoneNo(toUserId).replace("-", "");
		
		String fromPhoneNum = memberVO.getMoblphonNo().replace("-", "");
		
		if(toPhoneNum != null && !toPhoneNum.equals("")){
			JSONObject json = new JSONObject();
			//json.put("replyUrl", "http://hm.hanmam.kr/mobile/pushMsgSendView.do?sabun="+user.getNo());
			//json.put("viewUrl", "");
			json.put("sender", memberVO.getUserNm());
			//json.put("sendTime", (Hour < 10 ? "0" + Hour : Hour) + ":" + (minute < 10 ? "0" + minute : minute)+ ":" +(second < 10 ? "0" + second : second));
			json.put("sendTime", System.currentTimeMillis());
			//json.put("message", note.getNoteCn());
			
			json.put("fromUserId", note.getSenderId());
			json.put("toUserId", note.getRecieverIdList()[0]);
			json.put("noteNo", "");
			json.put("messageNo", "");
			json.put("type", "note");
			json.toJSONString();
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("fromUserId", json.get("fromUserId"));
			param.put("toUserId", json.get("toUserId"));
			param.put("noteNo", json.get("noteNo"));
			param.put("message", json.get("message"));
			param.put("pushKey", json.get("fromUserId").toString() + json.get("sendTime").toString() + json.get("toUserId").toString());
			param.put("type", json.get("type"));

			String info = URLEncoder.encode(json.toJSONString(), "UTF-8");
			String msg = note.getNoteCn();
			
			int pushMsgMaxLength = Integer.parseInt(propertiesService.getString("pushMsgMaxLength"));
			if (msg.length() > pushMsgMaxLength) msg = msg.substring(0, pushMsgMaxLength);
			
			//msg = URLEncoder.encode(msg, "UTF-8").replaceAll("\\+", "%20");		// +로 변환된 공백을 공백인코딩으로 치환
			
			String pushURI = propertiesService.getString("pushURI");
			String pushAPI = propertiesService.getString("pushAPI");	
			String pushAuth_Android	= propertiesService.getString("pushAuth_Android");				
			String pushAuth_iOS = propertiesService.getString("pushAuth_iOS");
			
			MemberVO senderVO = memberService.selectMemberBasic(memberVO);
			String result = pushSender.sendMessageByPhoneNo(info,msg, toPhoneNum, false,pushAuth_iOS,"iOS",pushURI,pushAPI,toUserNm,(String) json.get("type"), "", senderVO);
			
			param.put("success", "Y");
			noteService.insertPushLog(param);
		}
		//한동안 확인 안하면 모바일 쪽지 하나 더 오는 부분인것 같음. APK 소스에서 호출하는듯
		noteService.sendNote(note);
		return "/community/comm_closePage";
	}
	 */
	
	@RequestMapping("/mobile/community/pushSuccess.do")
	public String recievePushSuccess(Note note, @ModelAttribute("searchVO") NoteVO searchVO, 
			HttpServletRequest req, Map<String, Object> commandMap) throws Exception {
		
		commandMap.put("pushKey", commandMap.get("fromUserId").toString() + 
				commandMap.get("sendTime").toString() + commandMap.get("toUserId").toString());
		noteService.updateSuccessPushLog(commandMap);
		
		return "/community/comm_closePage";
	}
}
