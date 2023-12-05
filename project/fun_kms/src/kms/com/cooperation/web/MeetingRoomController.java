package kms.com.cooperation.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.Note;
import kms.com.community.service.NoteService;
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.cooperation.service.MeetingRoom;
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

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MeetingRoomController {

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
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@RequestMapping(value={"/cooperation/selectMeetingRoomList.do", "/ajax/selectMeetingRoomList.do"})
	public String selectMeetingRoomList(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		meetingRoomVO.setUserNo(user.getNo());
		
		int pageUnit = propertyService.getInt("pageUnit_15");
		if ("Y".equals(commandMap.get("ajax")) ) {
			meetingRoomVO.setAjax("Y");
			pageUnit = propertyService.getInt("pageUnit");
		}
		else {
			String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_meeting_room_pageunit");
			if (pageUnitCookie != null) 
				pageUnit = Integer.parseInt(pageUnitCookie);
		}
			
		meetingRoomVO.setPageUnit(pageUnit);
		meetingRoomVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(meetingRoomVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(meetingRoomVO.getPageUnit());
		paginationInfo.setPageSize(meetingRoomVO.getPageSize());
	
		meetingRoomVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		meetingRoomVO.setLastIndex(paginationInfo.getLastRecordIndex());
		meetingRoomVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<MeetingRoomVO> resultList = mTService.selectMeetingRoomList(meetingRoomVO);
		int totCnt = mTService.selectMeetingRoomListTotCnt(meetingRoomVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("searchVO", meetingRoomVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//셀렉트박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
				
		vo.setCodeId("KMS044"); //회의실 구분
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("mtPlaceTypList", codeResult);
		
		
		if ("Y".equals(commandMap.get("ajax"))) {
			return "cooperation/include/projectMeeting";
		}
		/* [2015/02/26, dwkim] 모든 회의실 목록보기, 임시로 추가(김태연 부장님, 박현준과장님) */
		if ("all".equals(meetingRoomVO.getInputType())) {
			return "cooperation/coop_meetingRoomL_temp";
		}
		return "cooperation/coop_meetingRoomL";
	}
	
	@RequestMapping("/cooperation/selectMeetingRoom.do")
	public String selectMeetingRoom(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			@ModelAttribute("comment") MeetingRoomComment meetingRoomComment,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		
		meetingRoomVO.setUserNo(user.getNo());
		MeetingRoomVO result = mTService.selectMeetingRoom(meetingRoomVO);
		
		// 미열람 MeetingRoomVO 리스트 조회
		meetingRoomVO.setReadYn("N"); // 읽지 않은 회의목록만
		List<MeetingRoomVO> resultList = mTService.selectMeetingRoomList(meetingRoomVO);
		model.addAttribute("resultList", resultList);
		
		//회의실 조회 권한
		Boolean auth = false;
		String userId = user.getUserId();
		if(user.isAdmin() || user.isLeader() || user.isBoard() 
				|| user.isConferenceadmin() || user.isDocAdmin() || user.getNo() == result.getLeaderNo())
			auth = true;
		if(result.getUserId().equals(userId))
			auth = true;		
		
		/* [2015/02/26, dwkim] 모든 회의실 목록보기, 임시로 추가(김태연 부장님, 박현준과장님) */
		if ("all".equals(meetingRoomVO.getInputType())) {
			auth = true;
		}
		
		List<MeetingRoomRecieve> recList = result.getRecieveList();
		List<MeetingRoomRecieve> refList = result.getReferenceList();
		
		for(int i=0; i<recList.size(); i++){
			if(recList.get(i).getUserId().equals(userId))
				auth = true;
		}
		for(int i=0; i<refList.size(); i++){
			if(refList.get(i).getUserId().equals(userId))
				auth = true;
		}
				
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			meetingRoomComment.setNo(Integer.parseInt((String)commandMap.get("commentNo")));
		}
		
		model.addAttribute("result", result);
		
		//셀렉트박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
				
		vo.setCodeId("KMS044"); //회의실 구분
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("mtPlaceTypList", codeResult);
		
		
		if (auth){
			if ("print".equals(commandMap.get("viewType"))) {
				model.addAttribute("printIncResult", (String)commandMap.get("printIncResult"));
				model.addAttribute("printIncComment", (String)commandMap.get("printIncComment"));
				return "cooperation/coop_pop_meetingRoomPrint";
			}			
			return "cooperation/coop_meetingRoomV";
		} else
			return "error/authError";
	}
	
	@RequestMapping("/cooperation/selectMeetingRoomRecieveList.do")
	public String selectMeetingRoomRecieveList(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		List<MeetingRoomRecieve> resultList = mTService.selectMeetingRoomRecieve(meetingRoomVO);
		
		model.addAttribute("resultList", resultList);
		
		return "cooperation/coop_pop_meetingRoomReadL";
	}
	
	
	@RequestMapping("/cooperation/insertMeetingRoomView.do")
	public String insertMeetingRoomView(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO, ModelMap model) throws Exception {
		
		//셀렉트박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
				
		vo.setCodeId("KMS044"); //회의실 구분
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("mtPlaceTypList", codeResult);
				
		return "cooperation/coop_meetingRoomW";
	}
	
	@RequestMapping("/cooperation/insertMeetingRoom.do")
	public String insertMeetingRoom(MultipartHttpServletRequest multiRequest,
			MeetingRoom meetingRoom, MeetingRoomRecieve mtRecieve, ModelMap model,HttpServletRequest request) throws Exception {
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		List<FileVO> result = null;
		String atchFileId = "";
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "MT_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		meetingRoom.setAttachFileId(atchFileId);
		mtRecieve.setUserNo(user.getNo());
		
		String mtId = mTService.insertMeetingRoom(meetingRoom, mtRecieve);
		
		if ("Y".equals(meetingRoom.getPushYn1())) {

			List<String> recUserMixList = CommonUtil.makeValidIdListArray(mtRecieve.getRecUserMixes());
			List<String> refUserMixList = CommonUtil.makeValidIdListArray(mtRecieve.getRefUserMixes());
			
			List<String> userMixList = new ArrayList<String>();
			userMixList.addAll(recUserMixList);
			userMixList.addAll(refUserMixList);
			
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
			//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
			param.put("alarmUserList", 0);
			List<MemberVO> recieverList = memberService.selectMemberListById(param);
			
			
			String msg = "회의명 : " + meetingRoom.getMtSj()
						+"\r\n장소 : " + meetingRoom.getMtPlace()
						+ "\r\n일시 : " + meetingRoom.getMtDate().substring(0,4)+"-"+meetingRoom.getMtDate().substring(4,6)+"-"
						+ meetingRoom.getMtDate().substring(6,8)+" "+meetingRoom.getMtFrTm()+"시~"+meetingRoom.getMtToTm()+"시";
			String title = meetingRoom.getMtSj();
			
			// 푸쉬 발송대상의 전화번호 추출
			List<String> rPhoneList = new ArrayList<String>();
			for (int i=0; i<recieverList.size(); i++) {
				MemberVO reciever = recieverList.get(i);
				
				//쪽지 발송하기
				Note note = new Note();
				note.setSenderNo(user.getNo());
				note.setRecieverId(reciever.getUserId());
				note.setNoteCn(msg);
				noteService.sendNoteMobile(note);
				
				// 푸쉬 발송대상의 전화번호 추출
				String toPhoneNo = noteService.phoneNo(reciever.getUserId()).replace("-", "");
				
				if(!toPhoneNo.equals("") && toPhoneNo != null){
					rPhoneList.add(toPhoneNo);
				}
			}
			
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			pushVO.setTitle(title);
			
			// 푸쉬 발송
			String type = "conf";
			String pushResult = pushSender.sendMessage(type, pushVO);
		}
		
		return "redirect:/cooperation/selectMeetingRoom.do?mtId=" + mtId;
	}
		
	@RequestMapping("/cooperation/updateMeetingRoomView.do")
	public String updateMeetingRoomView(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			HttpServletRequest req, HttpServletResponse res, ModelMap model) throws Exception {

		//셀렉트박스
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
				
		vo.setCodeId("KMS044"); //회의실 구분
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);		
		model.addAttribute("mtPlaceTypList", codeResult);
		
		MemberVO user = SessionUtil.getMember(req);
		meetingRoomVO.setUserNo(user.getNo());
		MeetingRoomVO result = mTService.selectMeetingRoom(meetingRoomVO);
		model.addAttribute("result", result);
		
		return "cooperation/coop_meetingRoomM";
	}
	
	@RequestMapping("/cooperation/updateMeetingRoom.do")
	public String updateMeetingRoom(MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			MeetingRoom meetingRoom, MeetingRoomRecieve meetingRoomRecieve, ModelMap model,HttpServletRequest request) throws Exception {
		
		MemberVO user = SessionUtil.getMember(multiRequest);
		
		String atchFileId = meetingRoom.getAttachFileId();
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
				List<FileVO> result = fileUtil.parseFileInf(files, "MT_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				meetingRoom.setAttachFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "MT_", cnt, atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}
		
		//meetingRoomRecieve.setUserNo(user.getNo());
		
		if ("Y".equals(meetingRoom.getPushYn1())) {
			
			List<String> recUserMixList = CommonUtil.makeValidIdListArray(meetingRoomRecieve.getRecUserMixes());
			List<String> refUserMixList = CommonUtil.makeValidIdListArray(meetingRoomRecieve.getRefUserMixes());
			
			List<String> userMixList = new ArrayList<String>();
			userMixList.addAll(recUserMixList);
			userMixList.addAll(refUserMixList);
			
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
			//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
			param.put("alarmUserList", 0);
			List<MemberVO> recieverList = memberService.selectMemberListById(param);
			
			String msg = "회의명 : " + meetingRoom.getMtSj()
					+"\r\n장소 : " + meetingRoom.getMtPlace()
					+ "\r\n일시 : " + meetingRoom.getMtDate().substring(0,4)+"-"+meetingRoom.getMtDate().substring(4,6)+"-"
					+ meetingRoom.getMtDate().substring(6,8)+" "+meetingRoom.getMtFrTm()+"시~"+meetingRoom.getMtToTm()+"시";
			String title = meetingRoom.getMtSj();
			
			// 푸쉬 발송대상의 전화번호 추출
			List<String> rPhoneList = new ArrayList<String>();
			for (int i=0; i<recieverList.size(); i++) {
				MemberVO reciever = recieverList.get(i);
				
				//쪽지 발송하기
				Note note = new Note();
				note.setSenderNo(user.getNo());
				note.setRecieverId(reciever.getUserId());
				note.setNoteCn(msg);
				noteService.sendNoteMobile(note);
				
				// 푸쉬 발송대상의 전화번호 추출
				String toPhoneNo = noteService.phoneNo(reciever.getUserId()).replace("-", "");
				
				if(!toPhoneNo.equals("") && toPhoneNo != null){
					rPhoneList.add(toPhoneNo);
				}
			}
			
			MemberVO senderVO = memberService.selectMemberBasic(user);
			
			PushVO pushVO = new PushVO();
			pushVO.setSenderVO(senderVO);
			pushVO.setrPhoneList(rPhoneList);
			pushVO.setMsg(msg);
			pushVO.setTitle(title);
			
			// 푸쉬 발송
			String type = "conf";
			String pushResult = pushSender.sendMessage(type, pushVO);			
			
		}	    
		mTService.updateMeetingRoom(meetingRoom, meetingRoomRecieve);
				
		return "redirect:/cooperation/selectMeetingRoom.do?mtId=" + meetingRoom.getMtId();
	}
	
	@RequestMapping("/cooperation/changeMeetingRoomRecieve.do")
	public String changeMeetingRoomRecieve(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			MeetingRoomRecieve meetingRoomRecieve, ModelMap model) throws Exception {

		mTService.changeMeetingRoomRecieve(meetingRoomRecieve);		
		return "forward:/cooperation/selectMeetingRoom.do";
	}
	
	@RequestMapping("/cooperation/changeMeetingRoomWriter.do")
	public String changeMeetingRoomWriter(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			MeetingRoomRecieve meetingRoomRecieve, ModelMap model) throws Exception {
		
		mTService.changeMeetingRoomWriter(meetingRoomRecieve);		
		return "forward:/cooperation/selectMeetingRoom.do";
	}
	
	@RequestMapping("/cooperation/updateMeetingRoomInterestAjax.do")
	public String updateMeetingRoomInterestAjax(
			@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			MeetingRoomRecieve meetingRoomRecieve,
			Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		meetingRoomRecieve.setUserNo(user.getNo());
		mTService.updateMeetingRoomRecieve(meetingRoomRecieve);
		
		return "success";
	}

	@RequestMapping("/cooperation/updateMeetingRoomInterest.do")
	public String updateMeetingRoomInterest(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			MeetingRoomRecieve meetingRoomRecieve, Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		meetingRoomRecieve.setUserNo(user.getNo());
		
		mTService.updateMeetingRoomRecieve(meetingRoomRecieve);
		
		String returnList = (String)commandMap.get("returnList");
		
		if (returnList != null && returnList.equals("Y"))
			return "forward:/cooperation/selectMeetingRoomList.do";
		else
			return "forward:/cooperation/selectMeetingRoom.do";
	}
	@RequestMapping("/cooperation/deleteMeetingRoom.do")
	public String deleteMeetingRoom(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO,
			MeetingRoom meetingRoom, ModelMap model) throws Exception {
		
		mTService.updateMeetingRoom(meetingRoom);
		
		return "forward:/cooperation/selectMeetingRoomList.do";
	}
	


	@RequestMapping("/cooperation/updateMeetingResultView.do")
	public String insertMeetingResultView(@ModelAttribute("searchVO") MeetingRoomVO meetingRoomVO, ModelMap model) throws Exception {
		
		MeetingRoomVO mtResult = mTService.selectMeetingRoom(meetingRoomVO);
		model.addAttribute("inputType", meetingRoomVO.getInputType());
		model.addAttribute("result", mtResult);
		return "cooperation/coop_meetingResult";
	}
	
	@RequestMapping("/cooperation/updateMeetingResult.do")
	public String updateMeetingResult(@ModelAttribute("searchVO") MeetingRoom meetingRoom, 
			MeetingRoomRecieve meetingRoomRecieve, ModelMap model, 
			Map<String, Object> commandMap, HttpServletRequest req) throws Exception {
		
		String result = meetingRoom.getMtResult();
		
		result = result.replaceAll("&lt;", "<");
		result = result.replaceAll("&gt;", ">");
		result = result.replaceAll("&quot;", "\\\"");
		result = result.replaceAll("&nbsp;", " ");
		result = result.replaceAll("&#033;", "!");
		result = result.replaceAll("&amp;", "&");
		result = result.replaceAll("&middot;", "·");
		
		MemberVO user = SessionUtil.getMember(req);
		
		meetingRoom.setMtResult(result);
		meetingRoom.setMtResultWrNo(user.getNo());
		
		mTService.updateMeetingResult(meetingRoom);
		
		model.addAttribute("mtId", meetingRoom.getMtId());
		model.addAttribute("mtResultSaveOk", "mtResultSaveOk");
		return "cooperation/coop_meetingResult";
	}	
}
