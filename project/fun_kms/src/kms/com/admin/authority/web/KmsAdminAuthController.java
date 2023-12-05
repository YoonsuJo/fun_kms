package kms.com.admin.authority.web;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import kms.com.admin.approval.service.KmsApprovalTyp;
import kms.com.admin.approval.service.KmsApprovalTypService;
import kms.com.admin.approval.service.KmsApprovalTypVO;
import kms.com.admin.authority.service.AuthVO;
import kms.com.admin.authority.service.KmsAdminAuthService;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.ApprovalVacVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.SessionUtil;
import kms.com.member.service.MemberVO;

/**
 * @Class Name : KmsApprovalTypController.java
 * @Description : KmsApprovalTypController class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class KmsAdminAuthController {

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	
    @Resource(name = "kmsAdminAuthService")
    protected KmsAdminAuthService adminAuthService;
    
    /**
	 * KMS_EAPP_DOCTYP 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 KmsEappDoctypDefaultVO
	 * @return "/kmsEappDoctyp/KmsEappDoctypList"
	 * @exception Exception
	 */
    @RequestMapping(value="/admin/authority/authMain.do")
    public String authMain(@ModelAttribute("searchVO") AuthVO searchVO, 
    		HttpServletRequest req, ModelMap model)
            throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	boolean auth = false;     
        if (user.isAuthadmin()) {
    		auth = true;
        }        
		if(auth == false){
	     	model.addAttribute("message", "관리자기능 권한관리 : 접근권한이 없습니다.");
			return "error/messageError";
	    }
    	model.addAttribute("resultList", adminAuthService.selectAuthList(searchVO)); 
    	return "/admin/authority/authorityL";
		
    } 
    
    @RequestMapping(value="/admin/authority/authU.do")
    public String authU(@ModelAttribute("searchVO") AuthVO searchVO, 
    		ModelMap model)
    throws Exception {
    	
    	adminAuthService.updateAuthList(searchVO); 
    	return "success";
    	
    } 
    
    

    
    
    
}
