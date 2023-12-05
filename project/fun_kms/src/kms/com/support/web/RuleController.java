package kms.com.support.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.app.service.ApprovalCommentVO;
import kms.com.app.service.ApprovalVO;
import kms.com.common.config.PathConfig;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.Task;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarReservationVO;
import kms.com.support.service.CarVO;
import kms.com.support.service.ResourceService;
import kms.com.support.service.RuleService;
import kms.com.support.service.TaxPublishService;
import kms.com.support.service.TaxPublishVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class RuleController {
    
	@Resource(name = "KmsRuleService")
	private RuleService ruleService;
	
	@Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
    
	@Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;
	
	@RequestMapping("/support/ruleS.do")
	public String searchRuleList(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{

		if (commandMap.get("searchTxt") == null || commandMap.get("searchTxt").equals(""))
			return "redirect:/support/ruleL.do";
		
		List resultList = ruleService.searchRuleList(commandMap);
		model.addAttribute("resultList", resultList);
		model.addAttribute("searchTxt", commandMap.get("searchTxt"));
		
		return "support/sprt_ruleS";
	}
	
	@RequestMapping("/support/ruleL.do")
	public String selectRuleList(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		List resultList = ruleService.selectRuleList(commandMap);
		model.addAttribute("resultList", resultList);
		
		if (commandMap.get("editTyp") != null && !commandMap.get("editTyp").toString().equals(""))
			model.addAttribute("editTyp", commandMap.get("editTyp"));
		
		return "support/sprt_ruleL";
	}

	@RequestMapping("/support/ruleW.do")
	public String ruleW(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		return "support/include/sprt_ruleW";
	}
	
	@RequestMapping("/support/ruleI.do")
	public String selectRuleI(MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 파일 첨부 Start */
		List<FileVO> fileResult = null;
	    String atchFileId = "";
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
	    	fileResult = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(fileResult);
	    }
	    commandMap.put("atchFileId", atchFileId);
	    /* 파일 첨부 End */
		
		return "redirect:/support/ruleL.do?contentNo=" + ruleService.insertRule(commandMap);
	}
	
	@RequestMapping("/support/ruleV.do")
	public String selectRuleV(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> result = ruleService.selectRule(commandMap);
		model.addAttribute("result", result);
		
		commandMap.put("titleNo", result.get("titleNo"));
		List resultList = ruleService.selectRuleHistoryList(commandMap);
		model.addAttribute("resultList", resultList);
		
		return "support/include/sprt_ruleV";
	}
	
	@RequestMapping("/support/ruleM.do")
	public String selectRuleM(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		Map<String, Object> result = ruleService.selectRule(commandMap);
		model.addAttribute("result", result);
		
		return "support/include/sprt_ruleM";
	}
	
	@RequestMapping("/support/ruleU.do")
	public String selectRuleU(MultipartHttpServletRequest multiRequest, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		/* 파일첨부 Start */
		String atchFileId = commandMap.get("atchFileId").toString();
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
				List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				commandMap.put("atchFileId", atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}
		/* 파일첨부 End */
		
		return "redirect:/support/ruleL.do?contentNo=" + ruleService.updateRule(commandMap);
	}
	
	@RequestMapping("/support/ruleListM.do")
	public String ruleListM(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		List resultList = ruleService.selectRuleList(commandMap);
		model.addAttribute("resultList", resultList);
		
		return "/support/include/sprt_ruleListM";
	}
	
	@RequestMapping("/support/ruleListU.do")
	public String ruleListU(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		ruleService.updateRuleList(commandMap);
		
		if (commandMap.get("contentNo") != null && commandMap.get("contentNo").toString().equals(""))
			return "redirect:/support/ruleL.do?contentNo=" + commandMap.get("contentNo").toString();
		else
			return "redirect:/support/ruleL.do";
	}
	
	@RequestMapping("/support/ruleO.do")
	public String selectRuleO(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		return "redirect:/support/ruleL.do?contentNo=" + ruleService.updateRuleOrder(commandMap);
	}
	
	@RequestMapping("/support/ruleD.do")
	public String selectRuleD(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		return "redirect:/support/ruleL.do?contentNo=" + ruleService.deleteRule(commandMap);
	}
	
	@RequestMapping("/support/ruleR.do")
	public String selectRuleR(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		return "redirect:/support/ruleL.do?contentNo=" + ruleService.recoverRule(commandMap);
	}
	
	@RequestMapping("/support/ruleHistoryL.do")
	public String ruleHistoryL(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		List resultList = ruleService.selectRuleHistoryList(commandMap);
		model.addAttribute("resultList", resultList);
		
		return "support/include/sprt_ruleHistoryL";
	}
	
}
