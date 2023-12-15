package kms.com.cooperation.web;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.*;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BusinessContactMobileController {

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
	
	@RequestMapping("/mobile/cooperation/selectBusinessContactList.do")
	public String selectBusinessContactList(@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			Map<String,Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		businessContactVO.setUserNo(user.getNo());
		businessContactVO.setPageUnit(propertyService.getInt("pageUnit_15"));
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

		int totPage = (int) Math.round(totCnt / businessContactVO.getPageSize() + 0.5); 
		
		model.addAttribute("totPage", totPage);
		model.addAttribute("searchVO", businessContactVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "mobile/cooperation/coop_busiContactL";
	}
	
	
	@RequestMapping("/mobile/cooperation/selectBusinessContact.do")
	public String selectBusinessContact(@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			@ModelAttribute("comment") BusinessContactComment businessContactComment,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {

		MemberVO user = SessionUtil.getMember(req);

		
		if(businessContactVO.getBcId() == null || "".equals(businessContactVO.getBcId())){
			String bcId = req.getParameter("bcId");
			businessContactVO.setBcId(bcId);
		}
		
		businessContactVO.setUserNo(user.getNo());
		BusinessContactVO result = bCService.selectBusinessContact(businessContactVO);
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			businessContactComment.setNo(Integer.parseInt((String)commandMap.get("commentNo")));
		}
		
		List<BusinessContactComment> commentList = bCService.selectBusinessContactCommentList(businessContactComment);
		
		model.addAttribute("commentList", commentList);
		model.addAttribute("result", result);
		
		return "mobile/cooperation/coop_busiContactV";
	}
	
	
	@RequestMapping("/mobile/cooperation/goCommentWritePage.do")
	public String goCommentWritePage(@ModelAttribute("searchVO") BusinessContactVO businessContactVO, Map<String, Object> commandMap,ModelMap model) throws Exception {
		model.addAttribute("bcId", commandMap.get("bcId"));
		return "mobile/cooperation/commentW";
	}
	
	@RequestMapping("/mobile/cooperation/insertBusinessContactView.do")
	public String insertBusinessContactView(@ModelAttribute("searchVO") BusinessContactVO businessContactVO, ModelMap model) throws Exception {
		return "mobile/cooperation/coop_busiContactW";
	}
	
	@RequestMapping("/mobile/cooperation/updateBusinessContactInterest.do")
	public String updateBusinessContactInterest(@ModelAttribute("searchVO") BusinessContactVO businessContactVO,
			BusinessContactRecieve businessContactRecieve, Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		MemberVO user = SessionUtil.getMember(req);
		
		businessContactRecieve.setUserNo(user.getNo()); 
		
		bCService.updateBusinessContactRecieve(businessContactRecieve);
		
		String returnList = (String)commandMap.get("returnList");
		
		return "redirect:/mobile/cooperation/selectBusinessContactList.do?pageIndex="+commandMap.get("pageIndex");
	}
	
	
	@RequestMapping("/mobile/cooperation/insertBusinessContact.do")
	public String insertBusinessContact(MultipartHttpServletRequest multiRequest,
			BusinessContact businessContact, BusinessContactRecieve bcRecieve, ModelMap model) throws Exception {
		
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
	    
	    String bcId = bCService.insertBusinessContact(businessContact, bcRecieve);
	    
		if ("Y".equals(businessContact.getSmsYn())) {

			List<String> recUserMixList = CommonUtil.makeValidIdListArray(bcRecieve.getRecUserMixes());
			List<String> refUserMixList = CommonUtil.makeValidIdListArray(bcRecieve.getRefUserMixes());
			
			List<String> userMixList = new ArrayList<String>();
			userMixList.addAll(recUserMixList);
			userMixList.addAll(refUserMixList);
			
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("userMixList", userMixList);
	    	//<!-- 2013.08.13 업무연락 알람 ON/OFF -->
	    	param.put("alarmUserList", 0);
			List<MemberVO> memberList = memberService.selectMemberListById(param);
			
			try{
				CommonUtil.smsSend("[업무연락]" + businessContact.getBcSj(), user, memberList);
			}catch(Exception e){
				// 문자나라 서버 연결안되는 경우 문자전송 실패 무시
			}
		}
	    
		return "redirect:/mobile/cooperation/selectBusinessContact.do?bcId=" + bcId;
	}	
}
