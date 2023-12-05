package kms.com.support.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.community.service.BBSAttributeManageService;
import kms.com.community.service.BBSManageService;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BoardVO;
import kms.com.community.service.ScheduleService;
import kms.com.member.service.MemberVO;
import kms.com.support.service.Suggest;
import kms.com.support.service.SuggestVO;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class SuggestController {
	
	@Resource(name = "KmsBBSManageService")
    private BBSManageService bbsMngService;

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());

    @RequestMapping(value={"/support/selectSuggestSummary.do", "/expansion/selectSuggestSummary.do"}) 
    public String selectSuggestSummary(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
	
		EgovMap summary = bbsMngService.selectSuggestSummary(boardVO);
		
		model.addAttribute("summary", summary);
		
		if (boardVO.getBbsId().equals("BBSMSTR_000000000080"))
			return "expansion/exps_suggestS";
    	else
    		//return "support/sprt_suggestS";
			return "community/sprt_suggestS";
    }
    
    @RequestMapping("/support/selectKmsSuggestSummary.do") 
    public String selectKmsSuggestSummary(@ModelAttribute("searchVO") BoardVO boardVO, HttpServletRequest req, ModelMap model) throws Exception {
	
		EgovMap summary = bbsMngService.selectSuggestSummary(boardVO);
		
		model.addAttribute("summary", summary);
		
		//return "support/sprt_kmsSuggestS";
		return "community/sprt_kmsSuggestS";
    }    
    
    @RequestMapping(value={"/support/selectSuggestHistory.do", "/support/selectKmsSuggestHistory.do", "/expansion/selectSuggestHistory.do"})
    public String selectSuggestHistory(@ModelAttribute("searchVO") SuggestVO suggestVO, HttpServletRequest req, ModelMap model) throws Exception {
    	
    	List<SuggestVO> list = bbsMngService.selectSuggestHistory(suggestVO);
    	
    	model.addAttribute("hList", list);
    	
    	if (suggestVO.getBbsId().equals("BBSMSTR_000000000061"))
    		//return "support/sprt_kmsSuggestHistory";
    		return "community/sprt_kmsSuggestHistory";    	
    	else if (suggestVO.getBbsId().equals("BBSMSTR_000000000080"))
    		return "expansion/exps_suggestHistory";
    	else
    		//return "support/sprt_suggestHistory";
    		return "community/sprt_suggestHistory";
    }

    @RequestMapping(value={"/support/insertSuggestHistory.do", "/expansion/insertSuggestHistory.do"})
    public String insertSuggestHistory(@ModelAttribute("searchVO") SuggestVO suggestVO, Suggest suggest,
    		HttpServletRequest req, ModelMap model) throws Exception {
    	
    	MemberVO user = SessionUtil.getMember(req);
    	
    	suggest.setUserNo(user.getNo());
    	
    	bbsMngService.insertSuggestHistory(suggest);
    	
    	if (suggestVO.getBbsId().equals("BBSMSTR_000000000080"))
    		return "redirect:/expansion/selectBoardArticle.do?bbsId=" + suggestVO.getBbsId() + "&nttId=" + suggestVO.getNttId();
    	else
    		return "redirect:/support/selectBoardArticle.do?bbsId=" + suggestVO.getBbsId() + "&nttId=" + suggestVO.getNttId();
    }
}
