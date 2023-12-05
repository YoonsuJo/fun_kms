package kms.com.member.web;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javapns.Push;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.app.service.KmsApprovalService;
import kms.com.common.config.PathConfig;
import kms.com.common.push.AndroidProvider;
import kms.com.common.push.PushSender;
import kms.com.common.push.PushVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.community.service.Note;
import kms.com.community.service.NoteService;
import kms.com.community.service.impl.NoteDAO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.MobileDeviceVO;
import kms.com.member.service.Msn;
import kms.com.member.service.PositionHistoryVO;
import kms.com.member.service.WorkStateService;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MemberMobileController {
		
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "KmsMemberService")
	private MemberService memberService;

	@Resource(name="KmsWorkStateService")
	WorkStateService workStateService;
	
	@Resource(name="approvalService")
	KmsApprovalService approvalService;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;

	@Resource(name="KmsNoteDAO")
	private NoteDAO noteDAO;
	
	/** ID Generation */
	@Resource(name="kmsNoteIdGnrService")    
	private EgovIdGnrService idGnrService;
	
	@Resource(name = "KmsNoteService")
	private NoteService noteService;
	
	@Resource(name = "pushSender")
	private PushSender pushSender;

	Logger log = Logger.getLogger(this.getClass());
		
		
	/*****모바일******************************************************************************************
	 * 사용자 목록 조회
	 * @author 2012.04.16 표범희 추가 
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************************************************/
	@RequestMapping("/mobile/member/selectMemberList.do")
	public String selectMemberList(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

		memberVO.setSearchOrgIdList(CommonUtil.makeValidIdList(memberVO.getSearchOrgId()));
		memberVO.setWorkStList(memberVO.getWorkStArray());
		memberVO.setOrderBy("name");
		memberVO.setSearchCondition("");
		
		List<MemberVO> resultList = memberService.selectMemberList(memberVO);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
	vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("rankList", rankList);
		model.addAttribute("resultList", resultList);
		
		return "mobile/human_resource/hr_memberL";
	}
	
	/*****모바일******************************************************************************************
	 * 선택된 사용자 세부 조회
 * @author 2012.04.16 표범희 추가 
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************************************************/
	@RequestMapping("/mobile/member/selectMember.do")
	public String selectMember(@ModelAttribute("memberVO") MemberVO memberVO, ModelMap model, Map<String, Object> commandMap) throws Exception {
		Map<String, Object> result = memberService.mobileSelectMember(memberVO);
		model.addAttribute("result", result);
		return "mobile/human_resource/hr_memberV";
	}
	
 
 /*****모바일******************************************************************************************
	* 모바일 디바이스 정보 저장
	* @author 표범희 추가 
	* @param commandMap
	* @throws Exception
	****************************************************************************************************/
	@RequestMapping("/mobile/regist_mobile.do")
	public String saveDeviceInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String userId = request.getParameter("id");
		String password = request.getParameter("password");
		String deviceType = request.getParameter("deviceType");
		String tokenInfo = request.getParameter("tokenInfo");
		String macAddr = request.getParameter("macAddr");
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setUserId(userId);
		memberVO.setPassword(password);
		memberVO.setDeviceType(deviceType);
		memberVO.setTokenInfo(tokenInfo);
		memberVO.setMacAddr(macAddr);
		
		if(!"".equals(tokenInfo) && tokenInfo != null){
			/* 2013.08.19 김대현  TOKEN_INFO 중복 제거*/
		memberService.deleteDeviceInfo(memberVO);
			memberService.updateDeviceInfo(memberVO);
		}
		
		JSONObject json = new JSONObject();
		json.put("result", "saveOk");
		
		model.addAttribute("result", json.toJSONString());
		return "mobile/human_resource/mobileResult";
	}
 

 /*****모바일******************************************************************************************
	* 외근등록여부 가져오기 휴가/외근/파견은 'N' 나머지는 'Y'
	* @author 표범희 추가 
	* @param commandMap
	* @throws Exception
	****************************************************************************************************/
	@RequestMapping("/mobile/workOutSideYn.do")
	public String workOutsideYn (HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String userId = request.getParameter("id");
		String password = request.getParameter("password");
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setUserId(userId);
		memberVO.setPassword(password);
		
		String workOutsideYn = memberService.getWorkOutsideYn(memberVO);
		
			JSONObject json = new JSONObject();
			json.put("result", workOutsideYn);
			json.toJSONString();
			
		model.addAttribute("result", json.toJSONString());
		
		return "mobile/human_resource/mobileResult";
	}  

	
	/*****모바일******************************************************************************************
	 * Push 메세지 전송 폼
	 * @author 표범희 추가 
	 * @param commandMap
	 * @throws Exception
	 ****************************************************************************************************/
	@RequestMapping("/mobile/pushMsgSendView.do")
	public String pushMsgSendView (HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
			
		//System.out.println("/mobile/pushMsgSendView.do - pushMsgSendView sabun = "+ request.getParameter("sabun"));
						 
		MobileDeviceVO device = memberService.getDeviceInfo(request.getParameter("sabun"));  	  	
		model.addAttribute("result", device);
		
		return "mobile/human_resource/pushMsgSendView";
	}  
	

	 /*****모바일******************************************************************************************
		* Push 메세지 전송 폼
		* @author 표범희 추가 
		* @param commandMap
		* @throws Exception
		****************************************************************************************************/
	@RequestMapping("/mobile/pushMsgSend.do")
	public String pushMsgSend (HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String userId = request.getParameter("id");
		String password = request.getParameter("password");
		String msg = request.getParameter("msg");
		String userNo = request.getParameter("userNo");
		
		String toPhoneNo = noteService.phoneNo(userId).replace("-", "");
		
		MemberVO user = SessionUtil.getMember(request);
		
		//System.out.println("/mobile/pushMsgSend.do - pushMsgSend userId = "+ userId);  	  	
		//System.out.println("/mobile/pushMsgSend.do - pushMsgSend user.getNo()= "+ user.getNo());
			
		Note note = new Note();
		note.setSenderNo(user.getNo());
		note.setRecieverId(userId);
		note.setNoteCn(msg);
		noteService.sendNoteMobile(note);
		
		// 푸쉬 발송대상의 전화번호 추출
		List<String> rPhoneList = new ArrayList<String>();
		rPhoneList.add(toPhoneNo);
	
		// 푸쉬 발송 전 파라미터 가공
		MemberVO senderVO = memberService.selectMemberBasic(user);
		
		PushVO pushVO = new PushVO();
		pushVO.setSenderVO(senderVO);
		pushVO.setrPhoneList(rPhoneList);
		pushVO.setMsg(msg);
		
		// 푸쉬 발송
		String type = "note";
		String pushResult = pushSender.sendMessage(type, pushVO);
			
		return "redirect:/mobile/member/selectMemberList.do";
 }  
	 

	/*****모바일******************************************************************************************
	 * 버전 확인
	 * @author 표범희 추가 
	 * @param commandMap
	 * @throws Exception
	 ****************************************************************************************************/
	@RequestMapping("/mobile/versionConfirm.do")
	public String versionConfirm(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		JSONObject json = new JSONObject();
		json.put("result", "1.3");
		json.toJSONString();

		model.addAttribute("result", json.toJSONString());
		
		return "mobile/human_resource/mobileResult";
	}  


 /*****모바일******************************************************************************************
	* 버전 업데이트
	* @author 표범희 추가 
	* @param commandMap
	* @throws Exception
	****************************************************************************************************/
	@RequestMapping("/mobile/versionUpdate.do")
	public String versionUpdate (HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String userId = request.getParameter("id");
		String version = request.getParameter("version");
		
		MemberVO memberVO = new MemberVO();
		memberVO.setUserId(userId);
		memberVO.setVersion(version);
		
		memberService.versionUpdate(memberVO);
		
		JSONObject json = new JSONObject();
		json.put("result", "updateOk");
		json.toJSONString();
			
		model.addAttribute("result", json.toJSONString());
		
		/*
		String userAgent = request.getHeader("USER-AGENT");
		if(userAgent.indexOf("iPhone") > -1 || userAgent.indexOf("iPod") > -1 || userAgent.indexOf("iPad") > -1){
		}else{
		}
		*/
		return "mobile/human_resource/mobileResult";
	}  
}
