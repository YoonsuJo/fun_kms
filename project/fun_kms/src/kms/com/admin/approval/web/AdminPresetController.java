package kms.com.admin.approval.web;

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

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import kms.com.admin.approval.service.KmsApprovalTyp;
import kms.com.admin.approval.service.KmsApprovalTypService;
import kms.com.admin.approval.service.KmsApprovalTypVO;
import kms.com.app.service.AccountVO;
import kms.com.app.service.ApprovalPresetVO;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.ApprovalVacVO;
import kms.com.app.service.KmsAccountService;
import kms.com.app.service.KmsPresetService;
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
public class AdminPresetController {

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
	@Resource(name = "kmsPresetIdGnrService")
	private EgovIdGnrService idGnrService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "presetService")
	private KmsPresetService presetService;
    
    /**
     * @param searchVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/admin/approval/selectPresetList.do")
    public String selectPresetList(@ModelAttribute("searchVO") ApprovalPresetVO searchVO, 
    		ModelMap model)
            throws Exception {
         searchVO.setPresetTyp("G");
    	 List resultList = presetService.selectPresetList(searchVO);
    	 searchVO.setPresetTyp("S");
    	 List resultList2 = presetService.selectPresetList(searchVO);
    	 searchVO.setPresetTyp("D");
    	 List resultList3 = presetService.selectPresetList(searchVO);
    	/* searchVO.setPresetTyp("C");
    	 List resultList4 = presetService.selectPresetList(searchVO);*/
         model.addAttribute("generalList", resultList);
         model.addAttribute("selfdevList", resultList2);
         model.addAttribute("diningList", resultList3);
         /*model.addAttribute("costList", resultList4);*/
         
         
        return "admin/approval/presetL";
    }
    
    
    @RequestMapping(value="/admin/approval/modifyPreset.do")
    public String modifyPreset(@ModelAttribute("searchVO") ApprovalPresetVO searchVO, 
    		ModelMap model)
    throws Exception {

    	ApprovalPresetVO presetVO = presetService.selectPresetView(searchVO);
    	model.addAttribute("mode","M");
    	model.addAttribute("presetVO",presetVO);
    	model.addAttribute("presetTyp",presetVO.getPresetTyp());
    	
    	if("G".equals(searchVO.getPresetTyp()))
    		return "admin/approval/presetGeneralW";
    	else
    		return "admin/approval/presetSpecialW";
    }
        
    
    @RequestMapping(value="/admin/approval/writePreset.do")
    public String writePreset(@ModelAttribute("searchVO") ApprovalPresetVO searchVO, 
    		ModelMap model)
    throws Exception {
    	if(searchVO.getPresetTyp()==null || "".equals(searchVO.getPresetTyp()))
    	{
    		model.addAttribute("message", "잘못된 접근입니다.");
    		return "error/messageError";
    	}
    	ApprovalPresetVO presetVO = new ApprovalPresetVO();
    	presetVO.setPresetTyp(searchVO.getPresetTyp());
    	model.addAttribute("presetVO",presetVO);
    	model.addAttribute("mode","W");
    	if("G".equals(searchVO.getPresetTyp()))
    		return "admin/approval/presetGeneralW";
    	else
    		return "admin/approval/presetSpecialW";
    }	
    
    @RequestMapping(value="/admin/approval/insertPreset.do")
    public String insertPreset(@ModelAttribute("searchVO") ApprovalPresetVO searchVO, 
    		@ModelAttribute("presetVO") ApprovalPresetVO presetVO,
    		HttpServletRequest request, HttpServletResponse response,
    		ModelMap model)
    throws Exception {
    	//speical preset write의 경우 프로젝트 중복 확인
    	if(!"G".equals(presetVO.getPresetTyp()))
    	{
    		if(presetService.selectAlreadyRegPrjCnt(presetVO)>=1)
    		{
    			model.addAttribute("message","해당 프리셋이 이미 등록된 프로젝트입니다.");
    			return "error/messageError";
    		}
    	}
    	MemberVO user = (MemberVO) SessionUtil.getMember(request);
    	String presetId = idGnrService.getNextStringId();
    	presetVO.setPresetId(presetId);
    	presetVO.setWriterNo(user.getNo());
    	presetService.insertPreset(presetVO);
    	return "redirect:/admin/approval/selectPresetList.do";
    }
    
    @RequestMapping(value="/admin/approval/updatePreset.do")
    public String updatePreset(@ModelAttribute("searchVO") ApprovalPresetVO searchVO, 
    		@ModelAttribute("presetVO") ApprovalPresetVO presetVO,
    		ModelMap model)
    throws Exception {
    	
    	presetService.updatePreset(searchVO);
    	return "redirect:/admin/approval/selectPresetList.do";
    }
    
    @RequestMapping(value="/admin/approval/deletePreset.do")
    public String deletePreset(@ModelAttribute("searchVO") ApprovalPresetVO searchVO, 
    		@ModelAttribute("presetVO") ApprovalPresetVO presetVO,
    		ModelMap model)
    throws Exception {
    	
    	presetService.deletePreset(searchVO);
    	return "redirect:/admin/approval/selectPresetList.do";
    }
}
