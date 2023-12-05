package kms.com.cooperation.web;

import java.net.URLEncoder;
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
import kms.com.community.service.NoteService;
import kms.com.community.service.NoteVO;
import kms.com.cooperation.service.BusiCntctService;
import kms.com.cooperation.service.BusinessContact;
import kms.com.cooperation.service.BusinessContactComment;
import kms.com.cooperation.service.BusinessContactRecieve;
import kms.com.cooperation.service.BusinessContactVO;
import kms.com.cooperation.service.impl.BusiCntctDAO;
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
import egovframework.com.utl.cas.service.EgovSessionCookieUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BusinessContactController {

	@Resource(name = "KmsBusinessContactService")
	protected BusiCntctService bCService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;

	@Resource(name = "KmsMemberService")
	private MemberService memberService;

	@Resource(name = "KmsBusinessContactDAO")
	private BusiCntctDAO bcDAO;

	@Resource(name = "KmsNoteService")
	private NoteService noteService;

	@Resource(name = "pushSender")
	private PushSender pushSender;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@RequestMapping(value = { "/cooperation/selectBusinessContactList.do",
			"/ajax/selectBusinessContactList.do" })
	public String selectBusinessContactList(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {

		// System.out.println(CalendarUtil.getThisTime() + " 업무연락 로딩 분석 1 ");
		MemberVO user = SessionUtil.getMember(req);
		businessContactVO.setUserNo(user.getNo());

		int pageUnit = propertyService.getInt("pageUnit_15");
		if ("Y".equals(commandMap.get("ajax"))) {
			businessContactVO.setAjax("Y");
			pageUnit = propertyService.getInt("pageUnit");
			//businessContactVO.setPageUnit(propertyService.getInt("pageUnit"));
		} else {
			//businessContactVO.setPageUnit(propertyService.getInt("pageUnit_15"));
			// 설정된 쿠키값이 있을 경우.
			String pageUnitCookie = EgovSessionCookieUtil.getCookie(req, "hanmam_business_contact_pageunit");
			if (pageUnitCookie != null) 
				pageUnit = Integer.parseInt(pageUnitCookie);
		}
		businessContactVO.setPageUnit(pageUnit);
		businessContactVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(businessContactVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(businessContactVO.getPageUnit());
		paginationInfo.setPageSize(businessContactVO.getPageSize());

		businessContactVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		businessContactVO.setLastIndex(paginationInfo.getLastRecordIndex());
		businessContactVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<BusinessContactVO> resultList = bCService.selectBusinessContactList(businessContactVO);
		int totCnt = bCService.selectBusinessContactListTotCnt(businessContactVO);
		paginationInfo.setTotalRecordCount(totCnt);

		model.addAttribute("searchVO", businessContactVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);

		if ("Y".equals(commandMap.get("ajax"))) {
			return "cooperation/include/projectBusiContact";
		}

		return "cooperation/coop_busiContactL";
	}

	@RequestMapping("/cooperation/selectBusinessContact.do")
	public String selectBusinessContact(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			@ModelAttribute("comment") BusinessContactComment businessContactComment,
			Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);

		businessContactVO.setUserNo(user.getNo());
		BusinessContactVO result = bCService
				.selectBusinessContact(businessContactVO);

		if (commandMap.get("commentNo") != null
				&& commandMap.get("commentNo").equals("") == false) {
			businessContactComment.setNo(Integer.parseInt((String) commandMap
					.get("commentNo")));
		}

		// 업무연락 조회권한
		Boolean auth = false;
		String userId = user.getUserId();
		if (user.isAdmin() || user.isLeader() || user.isBoard()
				|| user.isConferenceadmin() || user.isDocAdmin()
				|| user.getNo() == result.getLeaderNo())
			auth = true;
		if (result.getUserId().equals(userId))
			auth = true;

		List<BusinessContactRecieve> recList = result.getRecieveList();
		List<BusinessContactRecieve> refList = result.getReferenceList();
		for (int i = 0; i < recList.size(); i++) {
			if (recList.get(i).getUserId().equals(userId))
				auth = true;
		}
		for (int i = 0; i < refList.size(); i++) {
			if (refList.get(i).getUserId().equals(userId))
				auth = true;
		}

		// S: 미열람 BushnessContactVO 리스트 조회
		businessContactVO.setReadYn("N"); // 읽지 않은 업무연락만
		List<BusinessContactVO> resultList = bCService
				.selectBusinessContactList(businessContactVO);

		model.addAttribute("resultList", resultList);
		// E: 미열람 BushnessContactVO 리스트 조회

		model.addAttribute("result", result);
		
		businessContactComment.setNo(null);
		int commentsCnt = bCService.selectBusinessContactCommentListCnt(businessContactComment);
		model.addAttribute("commentsCnt", commentsCnt);
		
		if (auth) {
			if ("print".equals(commandMap.get("viewType"))) {
				model.addAttribute("printIncComment", (String)commandMap.get("printIncComment"));
				return "cooperation/coop_pop_busiContactPrint";
			}
			model.addAttribute("linkCmmtCn", (String)commandMap.get("linkCmmtCn"));
			model.addAttribute("linkCmmtUserNm", (String)commandMap.get("linkCmmtUserNm"));
			return "cooperation/coop_busiContactV";
		} else {

			NoteVO noteVO = new NoteVO();
			MemberVO senderVO = new MemberVO();
			senderVO = memberService.selectMemberBasic(user);
			
			String msg = "";
			
			msg += "○ 업무연락 제목 : " + result.getBcSj() + "\n\n";
			msg += "○ 업무연락 URL : "
					+ req.getRequestURL().substring(0, req.getRequestURL().indexOf("/", "http://".length()))
					+ "/cooperation/selectBusinessContact.do?bcId=" + result.getBcId() + "\n\n";
			msg += "=================================================\n\n";
			msg += "위 업무연락에 " + senderVO.getUserNm() + " " + senderVO.getRankNm() + "을(를) 수신자로 추가요청드립니다.";
			
			noteVO.setNoteCn(URLEncoder.encode(msg, "UTF-8"));
			//noteVO.setNoteCn(msg);
			noteVO.setRecieverNo(result.getUserNo().toString());
			
			model.addAttribute("noteVO", noteVO);
			
			return "/community/comm_pop_NoteW_fw";
			
			//model.addAttribute("message", "업무연락 조회권한이 없습니다");
			//return "error/messageError";
			// return "error/authError";
		}
	}

	@RequestMapping("/cooperation/selectBusinessContactRecieveList.do")
	public String selectBusinessContactRecieveList(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			HttpServletRequest req, ModelMap model) throws Exception {

		List<BusinessContactRecieve> resultList = bCService
				.selectBusinessContactRecieve(businessContactVO);

		model.addAttribute("resultList", resultList);

		return "cooperation/coop_pop_busiContactReadL";
	}

	@RequestMapping("/cooperation/insertBusinessContactView.do")
	public String insertBusinessContactView(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			ModelMap model) throws Exception {
		return "cooperation/coop_busiContactW";
	}

	@RequestMapping("/cooperation/insertBusinessContact.do")
	public String insertBusinessContact(
			MultipartHttpServletRequest multiRequest,
			BusinessContact businessContact, BusinessContactRecieve bcRecieve,
			ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(multiRequest);

		List<FileVO> result = null;
		String atchFileId = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BC_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		businessContact.setAttachFileId(atchFileId);
		bcRecieve.setUserNo(user.getNo());

		// redirect 메세지 변수 초기화
		model.addAttribute("message", "");
		model.addAttribute("message2", "");

		if ("Y".equals(businessContact.getSmsYn())) {

			List<String> recUserMixList = CommonUtil
					.makeValidIdListArray(bcRecieve.getRecUserMixes());
			List<String> refUserMixList = CommonUtil
					.makeValidIdListArray(bcRecieve.getRefUserMixes());

			List<String> userMixList = new ArrayList<String>();
			userMixList.addAll(recUserMixList);
			userMixList.addAll(refUserMixList);

			Map<String, Object> param = new HashMap<String, Object>();
			param.put("userMixList", userMixList);
			// <!-- 2013.08.13 업무연락 알람 ON/OFF -->
			param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService
					.selectMemberListById(param);

			try {
				CommonUtil.smsSend("[업무연락]" + businessContact.getBcSj(), user,
						memberList);
			} catch (Exception e) {
				// 2013-04-29 문자 전송 실패시 메세지 보여주고 이동
				businessContact.setSmsYn("F");
				model.addAttribute("message",
						"SMS 서버가 응답이 없습니다.\\n업무연락은 정상 작성되며 SMS는 전송되지 않습니다.");
			}
		}

		String bcId = bCService.insertBusinessContact(businessContact,
				bcRecieve);

		// 2013.08.20 김대현 PUSH 적용
		if ("Y".equals(businessContact.getPushYn())) {
			List<String> recUserMixList = CommonUtil
					.makeValidIdListArray(bcRecieve.getRecUserMixes());
			List<String> refUserMixList = CommonUtil
					.makeValidIdListArray(bcRecieve.getRefUserMixes());
			List<String> userMixList = new ArrayList<String>();
			userMixList.addAll(recUserMixList);
			userMixList.addAll(refUserMixList);

			Map<String, Object> param = new HashMap<String, Object>();
			param.put("userMixList", userMixList);
			param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService
					.selectMemberListById(param);

			// 푸쉬 발송대상의 전화번호 추출
			List<String> rPhoneList = new ArrayList<String>();
			for (int i = 0; i < memberList.size(); i++) {
				String toPhoneNo = memberList.get(i).getMoblphonNo()
						.replace("-", "");
				if (toPhoneNo != null && !toPhoneNo.equals("")) {
					rPhoneList.add(toPhoneNo);
				}
			}

			// 푸쉬 발송 전 파라미터 가공
			String title = businessContact.getBcSj();
			String urlMsg = "";
			String msg = "\n\n"
					+ CommonUtil.deleteAllTag(businessContact.getBcCn());

			int pushMsgMaxLength = Integer.parseInt(propertiesService
					.getString("pushMsgMaxLength"));
			if (msg.length() > pushMsgMaxLength)
				msg = msg.substring(0, pushMsgMaxLength);

			// 내용: Link 추가
			urlMsg =  "\n\n"
					+ multiRequest.getRequestURL().substring(
							0,
							multiRequest.getRequestURL().indexOf("/",
									"http://".length()))
					+ "/cooperation/selectBusinessContact.do?bcId=" + bcId;
			// msg = URLEncoder.encode(msg, "UTF-8").replaceAll("\\+", "%20");
			// // +로 변환된 공백을 공백인코딩으로 치환

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

		model.addAttribute("redirectUrl",
				"/cooperation/selectBusinessContact.do?bcId=" + bcId);
		return "/error/messageRedirect";
		// return "redirect:/cooperation/selectBusinessContact.do?bcId=" + bcId;
	}

	@RequestMapping("/cooperation/updateBusinessContactView.do")
	public String updateBusinessContactView(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			HttpServletRequest req, HttpServletResponse res, ModelMap model)
			throws Exception {

		MemberVO user = SessionUtil.getMember(req);

		businessContactVO.setUserNo(user.getNo());
		BusinessContactVO result = bCService
				.selectBusinessContact(businessContactVO);

		model.addAttribute("result", result);

		return "cooperation/coop_busiContactM";
	}

	@RequestMapping("/cooperation/updateBusinessContact.do")
	public String updateBusinessContact(
			MultipartHttpServletRequest multiRequest,
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			BusinessContact businessContact,
			BusinessContactRecieve businessContactRecieve, ModelMap model)
			throws Exception {

		MemberVO user = SessionUtil.getMember(multiRequest);

		String atchFileId = businessContact.getAttachFileId();

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId)) {
				List<FileVO> result = fileUtil.parseFileInf(files, "BC_", 0,
						atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				businessContact.setAttachFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "BC_", cnt,
						atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}

		MemberVO memberVO = new MemberVO();
		memberVO.setUserId(CommonUtil.parseIdFromMix(businessContactRecieve
				.getWriterMix()));
		memberVO = memberService.selectMemberByIdNew(memberVO);
		businessContactRecieve.setUserNo(memberVO.getNo());

		// redirect 메세지 변수 초기화
		model.addAttribute("message", "");
		model.addAttribute("message2", "");
		model.addAttribute("redirectUrl",
				"/cooperation/selectBusinessContactList.do");

		if ("Y".equals(businessContact.getSmsYn())) {

			List<String> recUserMixList = CommonUtil
					.makeValidIdListArray(businessContactRecieve
							.getRecUserMixes());
			List<String> refUserMixList = CommonUtil
					.makeValidIdListArray(businessContactRecieve
							.getRefUserMixes());

			List<String> userMixList = new ArrayList<String>();
			userMixList.addAll(recUserMixList);
			userMixList.addAll(refUserMixList);

			// <!-- 2013.08.13 업무연락 알람 ON/OFF -->
			List<Integer> alarmUserList = bcDAO
					.selectAlarmUserNoList(businessContactRecieve);

			Map<String, Object> param = new HashMap<String, Object>();
			param.put("userMixList", userMixList);

			// <!-- 2013.08.13 업무연락 알람 ON/OFF -->
			param.put("alarmUserList", alarmUserList);
			List<MemberVO> memberList = memberService
					.selectMemberListById(param);

			try {
				CommonUtil.smsSend("[업무연락]" + businessContact.getBcSj(), user,
						memberList);
			} catch (Exception e) {
				// 문자나라 서버 연결안되는 경우 문자전송 실패 무시
				businessContact.setSmsYn("F");
				model.addAttribute("message",
						"SMS 서버가 응답이 없습니다.\\n업무연락은 정상 작성되며 SMS는 전송되지 않습니다.");
			}
		}

		// 2013.08.20 김대현 PUSH 적용
		if ("Y".equals(businessContact.getPushYn())) {
			List<String> recUserMixList = CommonUtil
					.makeValidIdListArray(businessContactRecieve
							.getRecUserMixes());
			List<String> refUserMixList = CommonUtil
					.makeValidIdListArray(businessContactRecieve
							.getRefUserMixes());

			List<String> userMixList = new ArrayList<String>();
			userMixList.addAll(recUserMixList);
			userMixList.addAll(refUserMixList);

			// <!-- 2013.08.13 업무연락 알람 ON/OFF -->
			List<Integer> alarmUserList = bcDAO
					.selectAlarmUserNoList(businessContactRecieve);

			Map<String, Object> param = new HashMap<String, Object>();
			param.put("userMixList", userMixList);

			// <!-- 2013.08.13 업무연락 알람 ON/OFF -->
			param.put("alarmUserList", alarmUserList);
			List<MemberVO> memberList = memberService
					.selectMemberListById(param);

			// 푸쉬 발송대상의 전화번호 추출
			List<String> rPhoneList = new ArrayList<String>();
			for (int i = 0; i < memberList.size(); i++) {
				String toPhoneNo = memberList.get(i).getMoblphonNo()
						.replace("-", "");
				if (toPhoneNo != null && !toPhoneNo.equals("")) {
					rPhoneList.add(toPhoneNo);
				}
			}

			// 푸쉬 발송 전 파라미터 가공
			String title = businessContact.getBcSj();
			String urlMsg = "";
			String msg = "\n\n"
					+ CommonUtil.deleteAllTag(businessContact.getBcCn());

			int pushMsgMaxLength = Integer.parseInt(propertiesService
					.getString("pushMsgMaxLength"));
			if (msg.length() > pushMsgMaxLength)
				msg = msg.substring(0, pushMsgMaxLength);

			// 내용: Link 추가
			urlMsg =  "\n\n"
					+ multiRequest.getRequestURL().substring(
							0,
							multiRequest.getRequestURL().indexOf("/",
									"http://".length()))
					+ "/cooperation/selectBusinessContact.do?bcId="
					+ businessContactVO.getBcId();
			// msg = URLEncoder.encode(msg, "UTF-8").replaceAll("\\+", "%20");
			// // +로 변환된 공백을 공백인코딩으로 치환

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

		bCService
				.updateBusinessContact(businessContact, businessContactRecieve);

		return "/error/messageRedirect";
		// return "redirect:/cooperation/selectBusinessContactList.do";
	}

	@RequestMapping("/cooperation/changeBusinessContactRecieve.do")
	public String changeBusinessContactRecieve(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			BusinessContactRecieve businessContactRecieve, ModelMap model)
			throws Exception {

		// 업무연락 수신자변경 기능
		bCService.changeBusinessContactRecieve(businessContactRecieve);
		return "forward:/cooperation/selectBusinessContact.do";
	}

	@RequestMapping("/cooperation/updateBusinessContactInterest.do")
	public String updateBusinessContactInterest(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			BusinessContactRecieve businessContactRecieve,
			Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);

		businessContactRecieve.setUserNo(user.getNo());

		bCService.updateBusinessContactRecieve(businessContactRecieve);

		String returnList = (String) commandMap.get("returnList");

		if (returnList != null && returnList.equals("Y"))
			return "forward:/cooperation/selectBusinessContactList.do";
		else
			return "forward:/cooperation/selectBusinessContact.do";
	}
	
	@RequestMapping("/cooperation/updateBusinessContactInterestAjax.do")
	public String updateBusinessContactInterestAjax(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			BusinessContactRecieve businessContactRecieve,
			Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		businessContactRecieve.setUserNo(user.getNo());
		bCService.updateBusinessContactRecieve(businessContactRecieve);
		
    	return "success";
	}

	@RequestMapping("/cooperation/deleteBusinessContact.do")
	public String deleteBusinessContact(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			BusinessContact businessContact, ModelMap model) throws Exception {

		bCService.updateBusinessContact(businessContact);

		return "forward:/cooperation/selectBusinessContactList.do";
	}

	// 2013.08.13 업무연락 알람 ON/OFF
	@RequestMapping("/cooperation/updateBusinessContactAlarm.do")
	public String updateBusinessContactAlarm(
			@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			BusinessContactRecieve businessContactRecieve,
			Map<String, Object> commandMap, HttpServletRequest req,
			ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);
		businessContactRecieve.setUserNo(user.getNo());

		bCService.updateBusinessContactAlarm(businessContactRecieve);

		return "forward:/cooperation/selectBusinessContact.do";
	}
}
