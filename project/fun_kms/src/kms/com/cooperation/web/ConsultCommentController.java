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
import kms.com.cooperation.service.BusinessContactComment;
import kms.com.cooperation.service.ConsultCommentVO;
import kms.com.cooperation.service.ConsultService;
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
public class ConsultCommentController {

	@Resource(name = "KmsConsultService")
	private ConsultService conService;
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;

    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;

    
    //상담관리 페이지에 임포트 할때 덧글 조회
    @RequestMapping("/cooperation/selectConsultCommentList.do")
	public String selectCustomeselectConsultCommentListrCommentList(@ModelAttribute("searchVO") ConsultCommentVO consultCommentVO,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		model.addAttribute("type", consultCommentVO.getType());
		
		if (consultCommentVO.getType().equals("head")) {
		    return "expansion/exps_consultCommentL";
		}
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			return "forward:/cooperation/updateConsultCommentView.do";
		}
		
		// 고객사 팝업창으로 띄운 경우
		if (commandMap.get("type").equals("pop")) {
			consultCommentVO.setConsult_no((String)commandMap.get("consultNo"));
			consultCommentVO.setNo(null);
			List<ConsultCommentVO> resultList = conService.selectConsultCommentList(consultCommentVO);
			
			model.addAttribute("resultList", resultList);
			return "expansion/exps_consultCommentL";
		}
		
		consultCommentVO.setNo(null);
		List<ConsultCommentVO> resultList = conService.selectConsultCommentList(consultCommentVO);
		
		model.addAttribute("resultList", resultList);
		
		return "expansion/exps_consultCommentL";
	}
    
  //상담관리 페이지에 임포트 할때 덧글 조회
    @RequestMapping("/cooperation/withoutLogin/selectConsultCommentList.do")
	public String selectCustomeselectConsultCommentListrWithoutLogin(@ModelAttribute("searchVO") ConsultCommentVO consultCommentVO,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		
		model.addAttribute("type", consultCommentVO.getType());
		
		if (consultCommentVO.getType().equals("head")) {
		    return "expansion/exps_consultCommentL";
		}
		
		consultCommentVO.setNo(null);
		List<ConsultCommentVO> resultList = conService.selectConsultCommentList(consultCommentVO);
		
		model.addAttribute("resultList", resultList);
		
		return "expansion/exps_consultCommentL_megameet";
	}
    
    
    //덧글 인서트
    @RequestMapping("/cooperation/insertConsultComment.do")
    public String insertConsultComment(MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") ConsultCommentVO consultCommentVO, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(multiRequest);
    	
    	consultCommentVO.setUserNo(user.getNo());
    	
    	List<FileVO> result = null;
	    String atchFileId = "";

	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "CST_", 0, "", "");
	    	atchFileId = fileMngService.insertFileInfs(result);
	    }
		
		consultCommentVO.setAtchFileId(atchFileId);
		consultCommentVO.setCn(CommonUtil.unscript(consultCommentVO.getCn()));
		
		conService.insertConsultComment(consultCommentVO);
		
		//return "redirect:/cooperation/selectConsultManage.do?no=" + consultCommentVO.getNo();
		
    	return "redirect:/cooperation/selectConsultManage.do?consult_no=" + consultCommentVO.getConsult_no();
    }
	
    //덧글 수정
    @RequestMapping("/cooperation/updateConsultCommentView.do")
    public String updateConsultCommentView(@ModelAttribute("searchVO") ConsultCommentVO consultCommentVO, ModelMap model) throws Exception {

    	ConsultCommentVO commentVO = conService.selectConsultComment(consultCommentVO);
    	consultCommentVO.setNo(null);
		List<ConsultCommentVO> resultList = conService.selectConsultCommentList(consultCommentVO);
		
		model.addAttribute("type", "body");
		model.addAttribute("resultList", resultList);
		model.addAttribute("commentVO", commentVO);
		
		return "expansion/exps_consultCommentL";
    }
    
    //덧글 수정  & 첨부파일
    @RequestMapping("/cooperation/updateConsultComment.do")
    public String updateConsultComment(MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") ConsultCommentVO consultCommentVO, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(multiRequest);
    	
    	consultCommentVO.setUserNo(user.getNo());
    	
    	String atchFileId = consultCommentVO.getAtchFileId();
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			if (atchFileId == null || "".equals(atchFileId) ) {
			    List<FileVO> result = fileUtil.parseFileInf(files, "CST_", 0, atchFileId, "");
			    atchFileId = fileMngService.insertFileInfs(result);
			    consultCommentVO.setAtchFileId(atchFileId);
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "CST_", cnt, atchFileId, "");
			    fileMngService.updateFileInfs(_result);
			}
	    }
	
		consultCommentVO.setUseAt("Y");
		consultCommentVO.setCn(CommonUtil.unscript(consultCommentVO.getCn()));
	    
		conService.updateConsultComment(consultCommentVO);
    	
		return "redirect:/cooperation/selectConsultManage.do?consult_no=" + consultCommentVO.getConsult_no();
		//return "redirect:/cooperation/selectConsult.do?custId=" + consultCommentVO.getCustId();
    }
    
    //덧글 삭제
    @RequestMapping("/cooperation/deleteConsultComment.do")
    public String deleteConsultComment(@ModelAttribute("searchVO") ConsultCommentVO consultCommentVO, ModelMap model) throws Exception {
    	
    	conService.deleteConsultComment(consultCommentVO);
		
    	consultCommentVO.setNo(null);
    	List<ConsultCommentVO> resultList = conService.selectConsultCommentList(consultCommentVO);
		
		model.addAttribute("resultList", resultList);
    	model.addAttribute("type", "body");
    	
		return "expansion/exps_consultCommentL";
    }
   
}
