package kms.com.admin.score.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

// Servoce 객체에 대한 import 구문
// import (service package).scoreService;
import kms.com.admin.score.service.Score;
import kms.com.admin.score.service.ScoreService;
import kms.com.admin.score.service.ScoreVO;

/**
 * @Class Name : TblScoreController.java
 * @Description : TblScore Controller class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=Score.class)
public class ScoreController {

	@Resource(name = "ScoreService")
    private ScoreService scoreService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @RequestMapping(value="/admin/score/scorePolicyMain.do")
    public String selectScorePolicyMain(@ModelAttribute("searchVO") ScoreVO searchVO, 
    		ModelMap model)
            throws Exception {
        List policyList = scoreService.selectScorePolicyList();
        model.addAttribute("policyList", policyList);
        
        return "/admin/score/scorePolicyM";
    }
    
    @RequestMapping(value="/admin/score/scorePolicyU.do")
    public String updateScorePolicy(@ModelAttribute("searchVO") ScoreVO searchVO,
    		Map<String, Object> commandMap,
    		ModelMap model, SessionStatus status)
            throws Exception {
    	
        scoreService.updateScorePolicy(commandMap);
        return "forward:/admin/score/scorePolicyMain.do";
    } 
    
  
}
