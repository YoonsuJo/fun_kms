package kms.com.admin.member.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.common.config.PathConfig;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.member.service.PositionHistoryVO;

import org.apache.log4j.Logger;
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
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *   2009.06.29	한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@Controller
public class AdminMemberController {
	
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
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;
	
	@Autowired
	private DefaultBeanValidator beanValidator;

	Logger log = Logger.getLogger(this.getClass());

	
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/selectMemberList.do")
	public String selectMemberList(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

		memberVO.setSearchOrgIdList(CommonUtil.makeValidIdList(memberVO.getSearchOrgId()));
		memberVO.setWorkStList(memberVO.getWorkStArray());
		String[] sWorkStList = memberVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			memberVO.setOrderBy("RetireDate");    	
		
		List<MemberVO> resultList = memberService.selectMemberList(memberVO);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("rankList", rankList);
		model.addAttribute("resultList", resultList);
		
		return "admin/member/memberL";
	}
	
	@RequestMapping("/admin/member/selectMemberList2.do")
	public String selectMemberList2(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

		memberVO.setSearchOrgIdList(CommonUtil.makeValidIdList(memberVO.getSearchOrgId()));
		memberVO.setWorkStList(memberVO.getWorkStArray());
		String[] sWorkStList = memberVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			memberVO.setOrderBy("RetireDate");
		
		
		List<MemberVO> resultList = memberService.selectMemberList(memberVO);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("rankList", rankList);
		model.addAttribute("resultList", resultList);
		
		return "admin/member/memberL2";
	}
	
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/selectMemberListExcel.do")
	public String selectMemberListExcel(@ModelAttribute("searchVO") MemberVO memberVO, HttpServletResponse res, ModelMap model) throws Exception {

		memberVO.setSearchOrgIdList(CommonUtil.makeValidIdList(memberVO.getSearchOrgId()));
		memberVO.setWorkStList(memberVO.getWorkStArray());
		String[] sWorkStList = memberVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			memberVO.setOrderBy("RetireDate");
		
		List<MemberVO> resultList = memberService.selectMemberList(memberVO);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("rankList", rankList);
		model.addAttribute("resultList", resultList);
		
		res.setHeader("Content-Disposition", "attachment; filename=userList.xls"); 
		res.setHeader("Content-Description", "JSP Generated Data");
		return "admin/member/memberL_excel";
	}
	
	@RequestMapping("/admin/member/selectMemberListSecOrg.do")
	public String selectMemberListSecOrg(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

		memberVO.setSearchOrgIdList(CommonUtil.makeValidIdList(memberVO.getSearchOrgId()));
		memberVO.setWorkStList(memberVO.getWorkStArray());
		String[] sWorkStList = memberVO.getWorkStList();    		
		if(sWorkStList[0].equals("R") == true)
			memberVO.setOrderBy("RetireDate");    	
		
		List<MemberVO> resultList = memberService.selectMemberList(memberVO);
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("rankList", rankList);
		model.addAttribute("resultList", resultList);
		
		return "admin/member/memberOrgL";
	}
	
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/selectMember.do")
	public String selectMember(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		Map<String, Object> result = memberService.selectMember(memberVO);    	
		model.addAttribute("result", result);    	
		return "admin/member/memberV";
	}
	
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/selectMemberFilesV.do")
	public String selectMemberPhotoV(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		Map<String, Object> result = memberService.selectMember(memberVO);    	
		model.addAttribute("result", result);    	
		return "admin/member/filesV";
	}
	
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/updtMemberView.do")
	public String updtMemberView(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("KMS005");
		List<CmmnDetailCode> offmCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
		codeVO.setCodeId("KMS007");
		List<CmmnDetailCode> compnyCode = cmmUseService.selectCmmCodeDetail(codeVO);    	
		codeVO.setCodeId("KMS033");
		List<CmmnDetailCode> degreeCode = cmmUseService.selectCmmCodeDetail(codeVO);
		
		Map<String, Object> result = memberService.selectMember(memberVO);    	    	
		model.addAttribute("result", result);
		model.addAttribute("offmCode", offmCode);
		model.addAttribute("compnyCode", compnyCode);
		model.addAttribute("degreeCode", degreeCode);
		
		//목록으로 돌아갈 검색조건들
		model.addAttribute("searchCondition", memberVO.getSearchCondition());    	
		model.addAttribute("searchKeyword", memberVO.getSearchKeyword());    	
		model.addAttribute("rankId", memberVO.getRankId());
		model.addAttribute("workSt", memberVO.getWorkSt());
		return "admin/member/memberM";
	}
	
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/updtMember.do")
	public String updtMember(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		memberService.updtMember(memberVO);
		
		String searchCondition = memberVO.getSearchCondition();
		String searchKeyword = memberVO.getSearchKeyword();
		String searchUserNm = URLEncoder.encode(memberVO.getSearchUserNm(), "UTF-8");
		String searchOrgNm = URLEncoder.encode(memberVO.getSearchOrgNm(), "UTF-8");	    
		String searchOrgId = memberVO.getSearchOrgId();
		String rankId = memberVO.getRankId();
		String workSt = memberVO.getWorkSt();
		return "redirect:/admin/member/selectMember.do?no=" + memberVO.getNo() + "&searchCondition=" + searchCondition 	+ "&searchKeyword=" + searchKeyword 
			+ "&searchUserNm=" + searchUserNm + "&searchOrgNm=" + searchOrgNm + "&searchOrgId=" + searchOrgId  + "&rankId=" + rankId  + "&workSt=" + workSt;
	}
	
	@RequestMapping("/admin/member/updtMember2.do")
	public String updtMember2(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		memberService.updtMember(memberVO);
		
		String searchCondition = memberVO.getSearchCondition();
		String searchKeyword = memberVO.getSearchKeyword();
		String searchUserNm = URLEncoder.encode(memberVO.getSearchUserNm(), "UTF-8");
		String searchOrgNm = URLEncoder.encode(memberVO.getSearchOrgNm(), "UTF-8");	    
		String searchOrgId = memberVO.getSearchOrgId();
		String rankId = memberVO.getRankId();
		String workSt = memberVO.getWorkSt();
		return "redirect:/admin/member/selectMemberList.do?no=" + memberVO.getNo() + "&searchCondition=" + searchCondition 	+ "&searchKeyword=" + searchKeyword
			+ "&searchUserNm=" + searchUserNm + "&searchOrgNm=" + searchOrgNm + "&searchOrgId=" + searchOrgId  + "&rankId=" + rankId  + "&workSt=" + workSt;
	}
	
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/insertMemberView.do")
	public String insertMemberView(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		return "admin/member/memberW";
	}
	
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/insertMember.do")
	public String insertMember(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		memberVO.setOrgnztId(propertyService.getString("standOrgId"));
		memberVO.setRankId("10");
		
		memberService.insertMember(memberVO); 	    
		return "redirect:/admin/member/selectMemberList.do";
	}
		
	/**
	 * @param memberVO
	 * @param res
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/chkUserId.do")
	public void chkUserId(@ModelAttribute("searchVO") MemberVO memberVO, HttpServletResponse res, ModelMap model) throws Exception {
		
		int cnt = memberService.memberIdChk(memberVO);
		res.setContentType("text/xml;charset=UTF-8");
		String out = "<result>";
		
		if (cnt > 0) {
			out += "fail";
		} else {
			out += "success";
		}		
		out += "</result>";		
		res.getWriter().println( CommonUtil.getXMLStr(out) );		
	}
		
	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/popPhoto.do")
	public String popPhoto(Map<String, Object> commandMap, ModelMap model) throws Exception {
		
		String picTyp = (String)commandMap.get("picTyp");
		
		if (picTyp.equals("picFileId")) {
			commandMap.put("title", "소개사진");
		} else if (picTyp.equals("picFileId2")) {
			commandMap.put("title", "증명사진");
		}
		
		model.addAttribute("commandMap", commandMap);
		
		return "admin/member/member_pop_photoW";
	}
	/**
	 * @param multiRequest
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/uploadPhoto.do")
	public String uploadPhoto(final MultipartHttpServletRequest multiRequest, Map<String, Object> map, ModelMap model) throws Exception {
		/* 임시 */
		String no = ((String[])multiRequest.getParameterMap().get("no"))[0];
		String picTyp = ((String[])multiRequest.getParameterMap().get("picTyp"))[0];
		
		String atchFileId = "";
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			List<FileVO> result = fileUtil.parseFileInf(files, "PIC_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		map.put("no", no);
		map.put(picTyp, atchFileId);
		
		memberService.uploadPhoto(map);
		
		return "admin/member/closePage";
	}
	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/popInsa.do")
	public String popInsa(Map<String, Object> commandMap, ModelMap model) throws Exception {

		model.addAttribute("commandMap", commandMap);
		
		return "admin/member/member_pop_insaW";
	}
	/**
	 * @param multiRequest
	 * @param map
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/uploadInsa.do")
	public String uploadInsa(final MultipartHttpServletRequest multiRequest, Map<String, Object> map, ModelMap model) throws Exception {
		/* 임시 */
		String userNo = ((String[])multiRequest.getParameterMap().get("userNo"))[0];
		String fileTyp = ((String[])multiRequest.getParameterMap().get("fileTyp"))[0];
		String note = ((String[])multiRequest.getParameterMap().get("note"))[0];
		
		String atchFileId = "";
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			List<FileVO> result = fileUtil.parseFileInf(files, "INS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		map.put("userNo", userNo);
		map.put("fileTyp", fileTyp);
		map.put("atchFileId", atchFileId);
		map.put("note", note);
		
		memberService.uploadInsa(map);
		
		return "admin/member/closePage";
	}
	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/deleteInsa.do")
	public String deleteInsa(Map<String, Object> commandMap, ModelMap model) throws Exception {
		/* 임시 */
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", commandMap.get("userNo"));
		memberService.deleteInsa(map);
		
		return "forward:/admin/member/selectMemberFilesV.do";
	}
	
	/**
	 * @param msn
	 * @param res
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/updtMemberMsn.do")
	public void updtMemberMsn(Msn msn, HttpServletResponse res, ModelMap model) throws Exception {
		
		String command = msn.getCommand();
		
		if (command.equals("delete")) {
			memberService.deleteMemberMsn(msn);
		} else if (command.equals("insert")){
			memberService.insertMemberMsn(msn);
		}
		MemberVO memberVO = new MemberVO();
		memberVO.setNo(msn.getUserNo());
		List<Msn> msnList = memberService.getMemberMsnList(memberVO);
		
		res.setContentType("text/xml;charset=UTF-8");
		String out = "<data><![CDATA[";
		
		for (int i=0; i<msnList.size(); i++) {
			Msn t = msnList.get(i);
			out += "<div class=\"msn_data_input1\">" + t.getMsnTyp() + "</div>";
			out += "<div class=\"msn_data_input2\">" + t.getMsnAdres() + "</div>";
			out += "<div class=\"msn_data_btn\"><a href=\"javascript:msnDelete('" + t.getStringNo() + "');\">";
			out += "<img src=\"" + PathConfig.imagePath + "/admin/btn/btn_delete03.gif\"/></a></div>";
		}
		
		out += "<div class=\"msn_data_input1\"><input type=\"text\" class=\"span_6\" name=\"msnTyp\"/></div>";
		out += "<div class=\"msn_data_input2\"><input type=\"text\" class=\"span_11\" name=\"msnAdres\"/></div>";
		out += "<div class=\"msn_data_btn\"><a href=\"javascript:msnInsert();\">";
		out += "<img src=\"" + PathConfig.imagePath + "/admin/btn/btn_add03.gif\"/></a></div>";		
		out += "]]></data>";		
		res.getWriter().println( CommonUtil.getXMLStr(out) );		
	}
		
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/selectPositionHistoryList.do")
	public String selectPositionHistoryList(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		Map<String, Object> memberResult = memberService.selectMember(memberVO);
		List<PositionHistoryVO> positionHistoryList = memberService.selectPositionHistoryList(memberVO);
		PositionHistoryVO positionHistory = memberService.selectPositionHistory(memberVO);
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);

		model.addAttribute("new", positionHistory);
		model.addAttribute("resultList", positionHistoryList);
		model.addAttribute("result", memberResult);
		model.addAttribute("rankList", rankList);
		model.addAttribute("today", CalendarUtil.getToday());
		
		return "admin/member/member_positionHistoryL";
	}
	/**
	 * @param memberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/admin/member/chngPositionHistoryView.do")
	public String chngPositionHistoryView(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
		
		Map<String, Object> memberResult = memberService.selectMember(memberVO);
		PositionHistoryVO positionHistory = memberService.selectPositionHistory(memberVO);
		if( positionHistory == null) {
			positionHistory = new PositionHistoryVO();
		}
		
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("KMS003");
		List rankList = cmmUseService.selectCmmCodeDetail(vo);
		vo.setCodeId("KMS007");
		List compList = cmmUseService.selectCmmCodeDetail(vo);
		
		model.addAttribute("cresult", memberResult);
		model.addAttribute("cnew", positionHistory);
		model.addAttribute("crankList", rankList);
		model.addAttribute("ccompList", compList);
		
		return "admin/member/member_positionHistoryW";
	}
	/**
	 * @param memberVO
	 * @param phVO
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 * 인사발령 기능
	 */
	@RequestMapping("/admin/member/insertPositionHistory.do")
	public String insertPositionHistory(@ModelAttribute("searchVO") MemberVO memberVO, @ModelAttribute("map") PositionHistoryVO phVO,
			HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);    	
		phVO.setAdminNo(user.getNo());    	
		memberService.insertPositionHistory(phVO, memberVO);
		
		return "redirect:/admin/member/selectPositionHistoryList.do?no=" + memberVO.getNo();
	}

	@RequestMapping("/admin/member/deleteLastPositionHistory.do")
	public String deleteLastPositionHistory(@ModelAttribute("searchVO") MemberVO memberVO,
			HttpServletRequest req, ModelMap model) throws Exception {

		PositionHistoryVO recentHistory = memberService.selectPositionHistory(memberVO);
		if (recentHistory == null) {
			return "redirect:/admin/member/selectPositionHistoryList.do?no=" + memberVO.getNo();
		}
		memberService.deletePositionHistory(recentHistory);
		memberService.revertMemberPosition(recentHistory);
		
		return "redirect:/admin/member/selectPositionHistoryList.do?no=" + memberVO.getNo();
	}

	@RequestMapping("/admin/member/updateSecondOrg.do")
	public String updateSecondOrg(HttpServletRequest req, ModelMap model, Map<String, Object> commandMap) throws Exception {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userNo", (String)commandMap.get("userNo"));
		param.put("orgId", (String)commandMap.get("orgId"));
		memberService.updateSecondOrg(param); 
    	return "success";
	}
}
