package kms.com.cooperation.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.cooperation.service.BusinessContactComment;
import kms.com.cooperation.service.ConsultCommentVO;
import kms.com.cooperation.service.ConsultService;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;

public class ConsultManageCommentController {
	
	@Resource(name = "KmsConsultService")
    private ConsultService consultService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;

    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;
    
    
    @RequestMapping("/cooperation/selectConsultCommentList.do")
	public String selectBusinessContactCommentList(@ModelAttribute("searchVO") ConsultCommentVO consultCommentVO,
			Map<String, Object> commandMap, HttpServletRequest req, ModelMap model) throws Exception {
		// 사용 안 함
		model.addAttribute("type", consultCommentVO.getType());
		
		if (consultCommentVO.getType().equals("head")) {
		    return "cooperation/coop_busiContactCommentL";
		}
		
		if (commandMap.get("commentNo") != null && commandMap.get("commentNo").equals("") == false) {
			return "forward:/cooperation/updateBusinessContactCommentView.do";
		}
		
		consultCommentVO.setNo(null);
		List<ConsultCommentVO> resultList = consultService.selectConsultCommentList(consultCommentVO);
		
		model.addAttribute("resultList", resultList);
		
		return "cooperation/coop_busiContactCommentL";
	}
    
    
}
