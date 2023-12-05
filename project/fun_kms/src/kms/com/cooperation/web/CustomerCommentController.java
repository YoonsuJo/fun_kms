package kms.com.cooperation.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.CustomerComment;
import kms.com.cooperation.service.CustomerService;
import kms.com.member.service.MemberVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class CustomerCommentController {

	@Resource(name = "KmsCustomerService")
	protected CustomerService custService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;

    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;

    
    @RequestMapping("/cooperation/selectCustomerCommentList.do")
	public String selectCustomerCommentList(@ModelAttribute("searchVO") CustomerComment customerComment,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		model.addAttribute("type", customerComment.getType());
		
		if (customerComment.getType().equals("head")) {
		    return "cooperation/coop_customerCommentL";
		}
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			return "forward:/cooperation/updateCustomerCommentView.do";
		}
		
		customerComment.setNo(null);
		List<CustomerComment> resultList = custService.selectCustomerCommentList(customerComment);
		
		model.addAttribute("resultList", resultList);
		
		return "cooperation/coop_customerCommentL";
	}
    
    @RequestMapping("/cooperation/insertCustomerComment.do")
    public String insertCustomerComment(MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") CustomerComment customerComment, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(multiRequest);
    	
    	customerComment.setUserNo(user.getNo());
    	
    	List<FileVO> result = null;
	    String atchFileId = "";

	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "CST_", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result);
	    }
		
		customerComment.setAtchFileId(atchFileId);
		customerComment.setCommentCn(CommonUtil.unscript(customerComment.getCommentCn()));
		
		custService.insertCustomerComment(customerComment);
		
    	return "redirect:/cooperation/selectCustomer.do?custId=" + customerComment.getCustId();
    }
	
    @RequestMapping("/cooperation/updateCustomerCommentView.do")
    public String updateCustomerCommentView(@ModelAttribute("searchVO") CustomerComment customerComment, ModelMap model) throws Exception {

    	CustomerComment commentVO = custService.selectCustomerComment(customerComment);
    	customerComment.setNo(null);
		List<CustomerComment> resultList = custService.selectCustomerCommentList(customerComment);
		
		model.addAttribute("type", "body");
		model.addAttribute("resultList", resultList);
		model.addAttribute("commentVO", commentVO);
		
		return "cooperation/coop_customerCommentL";
    }
    
    @RequestMapping("/cooperation/updateCustomerComment.do")
    public String updateCustomerComment(MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") CustomerComment customerComment, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(multiRequest);
    	
    	customerComment.setUserNo(user.getNo());
    	
    	String atchFileId = customerComment.getAtchFileId();
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
			    List<FileVO> result = fileUtil.parseFileInf(files, "CST_", 0, atchFileId, "");
			    atchFileId = fileMngService.insertFileInfs(result);
			    customerComment.setAtchFileId(atchFileId);
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "CST_", cnt, atchFileId, "");
			    fileMngService.updateFileInfs(_result);
			}
	    }
	
		customerComment.setUseAt("Y");
		customerComment.setCommentCn(CommonUtil.unscript(customerComment.getCommentCn()));
	    
    	custService.updateCustomerComment(customerComment);
    	
    	return "redirect:/cooperation/selectCustomer.do?custId=" + customerComment.getCustId();
    }
    
    @RequestMapping("/cooperation/deleteCustomerComment.do")
    public String deleteCustomerComment(@ModelAttribute("searchVO") CustomerComment customerComment, ModelMap model) throws Exception {
    	
    	custService.deleteCustomerComment(customerComment);
		
		customerComment.setNo(null);
		List<CustomerComment> resultList = custService.selectCustomerCommentList(customerComment);
		
		model.addAttribute("resultList", resultList);
    	model.addAttribute("type", "body");
    	
		return "cooperation/coop_customerCommentL";
    }
    
}
