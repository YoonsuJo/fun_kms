package kms.com.cooperation.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.BusiCntctService;
import kms.com.cooperation.service.BusinessContactComment;
import kms.com.cooperation.service.BusinessContactVO;
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
public class BusinessContactCommentMobileController {

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

    
    @RequestMapping("/mobile/cooperation/selectBusinessContactCommentList.do")
	public String selectBusinessContactCommentList(@ModelAttribute("searchVO") BusinessContactComment businessContactComment,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		model.addAttribute("type", businessContactComment.getType());
		
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
    
    @RequestMapping("/mobile/cooperation/insertBusinessContactComment.do")
    public String insertBusinessContactComment(HttpServletRequest req,
    		@ModelAttribute("searchVO") BusinessContactComment businessContactComment, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	
    	businessContactComment.setUserNo(user.getNo());
    	
    	List<FileVO> result = null;
	    String atchFileId = "";
		
		businessContactComment.setAttachFileId(atchFileId);
    	
		businessContactComment.setBcCommentCn(CommonUtil.unscript(businessContactComment.getBcCommentCn()));
		
		bCService.insertBusinessContactComment(businessContactComment);
		
    	return "redirect:/mobile/cooperation/selectBusinessContact.do?bcId=" + businessContactComment.getBcId();
    }
	
    @RequestMapping("/mobile/cooperation/updateBusinessContactCommentView.do")
    public String updateBusinessContactCommentView(@ModelAttribute("searchVO") BusinessContactComment businessContactComment, ModelMap model) throws Exception {

		BusinessContactComment bcComment = bCService.selectBusinessContactComment(businessContactComment);
		businessContactComment.setNo(null);
		List<BusinessContactComment> resultList = bCService.selectBusinessContactCommentList(businessContactComment);
		
		model.addAttribute("type", "body");
		model.addAttribute("resultList", resultList);
		model.addAttribute("bcComment", bcComment);
		
		return "mobile/cooperation/commentM";
    }
    
    @RequestMapping("/mobile/cooperation/updateBusinessContactComment.do")
    public String updateBusinessContactComment(HttpServletRequest req,
    		@ModelAttribute("searchVO") BusinessContactComment businessContactComment, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	
    	businessContactComment.setUserNo(user.getNo());
    	List<FileVO> result = null;
	    String atchFileId = "";
	
		businessContactComment.setAttachFileId(atchFileId);
		businessContactComment.setUseAt("Y");
		businessContactComment.setBcCommentCn(CommonUtil.unscript(businessContactComment.getBcCommentCn()));
	    
    	//bCService.updateBusinessContactComment(businessContactComment);
    	bCService.updateBusinessContactCommentWithoutDeleteReadTime(businessContactComment);
    	
    	return "redirect:/mobile/cooperation/selectBusinessContact.do?bcId=" + businessContactComment.getBcId();
    }
    
    @RequestMapping("/mobile/cooperation/deleteBusinessContactComment.do")
    public String deleteBusinessContactComment(@ModelAttribute("searchVO") BusinessContactComment businessContactComment, ModelMap model) throws Exception {
    	
    	//bCService.updateBusinessContactComment(businessContactComment);
    	bCService.updateBusinessContactCommentWithoutDeleteReadTime(businessContactComment);    	
		
		businessContactComment.setNo(null);
		List<BusinessContactComment> resultList = bCService.selectBusinessContactCommentList(businessContactComment);
		
		model.addAttribute("resultList", resultList);
    	model.addAttribute("type", "body");
    	
		return "redirect:/mobile/cooperation/selectBusinessContact.do?bcId=" + businessContactComment.getBcId();
    }
    
}
