package egovframework.com.cop.bbs.web;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cop.bbs.service.EgovBBSSatisfactionService;
import egovframework.com.cop.bbs.service.Satisfaction;
import egovframework.com.cop.bbs.service.SatisfactionVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 만족도 서비스 컨트롤러 클래스
 * @author 공통컴포넌트개발팀 한성곤
 * @since 2009.06.29
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.06.29  한성곤          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class EgovBBSSatisfactionController {
    @Resource(name="EgovBBSSatisfactionService")
    protected EgovBBSSatisfactionService bbsSatisfactionService;
    
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Autowired
    private DefaultBeanValidator beanValidator;
    
    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * 만족도조사 목록 조회를 제공한다.
     * 
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/selectSatisfactionList.do")
    public String selectSatisfactionList(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, ModelMap model) throws Exception {

	// 수정 처리된 후 만족도조사 등록 화면으로 처리되기 위한 구현
	if (satisfactionVO.isModified()) {
	    satisfactionVO.setStsfdgNo("");
	    satisfactionVO.setStsfdgCn("");
	    satisfactionVO.setStsfdg(0);
	}
	
	// 수정을 위한 처리
	if (!satisfactionVO.getStsfdgNo().equals("")) {
	    return "forward:/cop/bbs/selectSingleSatisfaction.do";
	}
	
	//------------------------------------------
	// JSP의 <head> 부분 처리 (javascript 생성)
	//------------------------------------------
	model.addAttribute("type", satisfactionVO.getType());	// head or body
	
	if (satisfactionVO.getType().equals("head")) {
	    return "cop/bbs/EgovSatisfactionList";
	}
	////----------------------------------------
	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
	model.addAttribute("sessionUniqId", user.getUniqId());
	
	satisfactionVO.setWrterNm(user.getName());
	
	satisfactionVO.setSubPageUnit(propertyService.getInt("pageUnit"));
	satisfactionVO.setSubPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(satisfactionVO.getSubPageIndex());
	paginationInfo.setRecordCountPerPage(satisfactionVO.getSubPageUnit());
	paginationInfo.setPageSize(satisfactionVO.getSubPageSize());

	satisfactionVO.setSubFirstIndex(paginationInfo.getFirstRecordIndex());
	satisfactionVO.setSubLastIndex(paginationInfo.getLastRecordIndex());
	satisfactionVO.setSubRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsSatisfactionService.selectSatisfactionList(satisfactionVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("summary", map.get("summary"));
	model.addAttribute("paginationInfo", paginationInfo);
	
	satisfactionVO.setStsfdgCn("");	// 등록 후 만족도 내용 처리
	satisfactionVO.setStsfdg(0);	// 등록 후 만족도 처리

	return "cop/bbs/EgovSatisfactionList";
    }
    
    /**
     * 익명용 만족도조사 목록 조회를 제공한다.
     * 
     * @param boardVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/anonymous/selectSatisfactionList.do")
    public String selectAnonymousSatisfactionList(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, ModelMap model) throws Exception {

	// 수정 처리된 후 만족도조사 등록 화면으로 처리되기 위한 구현
	if (satisfactionVO.isModified()) {
	    satisfactionVO.setStsfdgNo("");
	    satisfactionVO.setStsfdgCn("");
	    satisfactionVO.setStsfdg(0);
	    satisfactionVO.setWrterNm("");
	}
	
	// 수정을 위한 처리
	if (!satisfactionVO.getStsfdgNo().equals("")) {
	    return "forward:/cop/bbs/anonymous/selectSingleSatisfaction.do";
	}
	
	//------------------------------------------
	// JSP의 <head> 부분 처리 (javascript 생성)
	//------------------------------------------
	model.addAttribute("type", satisfactionVO.getType());	// head or body
	
	if (satisfactionVO.getType().equals("head")) {
	    return "cop/bbs/EgovSatisfactionList";
	}
	////----------------------------------------
	
	model.addAttribute("anonymous", "true");
	
	satisfactionVO.setSubPageUnit(propertyService.getInt("pageUnit"));
	satisfactionVO.setSubPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(satisfactionVO.getSubPageIndex());
	paginationInfo.setRecordCountPerPage(satisfactionVO.getSubPageUnit());
	paginationInfo.setPageSize(satisfactionVO.getSubPageSize());

	satisfactionVO.setSubFirstIndex(paginationInfo.getFirstRecordIndex());
	satisfactionVO.setSubLastIndex(paginationInfo.getLastRecordIndex());
	satisfactionVO.setSubRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsSatisfactionService.selectSatisfactionList(satisfactionVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("summary", map.get("summary"));
	model.addAttribute("paginationInfo", paginationInfo);
	
	satisfactionVO.setWrterNm("");
	satisfactionVO.setStsfdgCn("");	// 등록 후 만족도 내용 처리
	satisfactionVO.setStsfdg(0);	// 등록 후 만족도 처리

	return "cop/bbs/EgovSatisfactionList";
    }
    
    /**
     * 만족도조사를 등록한다.
     * 
     * @param satisfactionVO
     * @param satisfaction
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/insertSatisfaction.do")
    public String insertSatisfaction(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, @ModelAttribute("satisfaction") Satisfaction satisfaction, 
	    BindingResult bindingResult, ModelMap model) throws Exception {

	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(satisfaction, bindingResult);
	if (bindingResult.hasErrors()) {
	    model.addAttribute("msg", "작성자 및 만족도는 필수 입력값입니다.");
	    
	    return "forward:/cop/bbs/selectBoardArticle.do";
	}

	if (isAuthenticated) {
	    satisfaction.setFrstRegisterId(user.getUniqId());
	    satisfaction.setWrterId(user.getUniqId());
	    
	    satisfaction.setStsfdgPassword("");	// dummy
	    
	    bbsSatisfactionService.insertSatisfaction(satisfaction);
	    
	    satisfactionVO.setStsfdgCn("");
	    satisfactionVO.setStsfdgNo("");
	    satisfactionVO.setStsfdg(0);
	}

	return "forward:/cop/bbs/selectBoardArticle.do";
    }
    
    /**
     * 익명 만족도조사를 등록한다.
     * 
     * @param satisfactionVO
     * @param satisfaction
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/anonymous/insertSatisfaction.do")
    public String insertAnonymousSatisfaction(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, @ModelAttribute("satisfaction") Satisfaction satisfaction, 
	    BindingResult bindingResult, ModelMap model) throws Exception {

	beanValidator.validate(satisfaction, bindingResult);
	if (bindingResult.hasErrors()) {
	    model.addAttribute("msg", "작성자 및 만족도는 필수 입력값입니다.");
	    
	    return "forward:/cop/bbs/anonymous/selectBoardArticle.do";
	}

	satisfaction.setFrstRegisterId("ANONYMOUS");
	satisfaction.setWrterId("");
	satisfaction.setStsfdgPassword(EgovFileScrty.encryptPassword(satisfaction.getStsfdgPassword()));

	bbsSatisfactionService.insertSatisfaction(satisfaction);

	satisfactionVO.setStsfdgNo("");
	satisfactionVO.setStsfdgCn("");
	satisfactionVO.setStsfdg(0);
	satisfactionVO.setWrterNm("");

	return "forward:/cop/bbs/anonymous/selectBoardArticle.do";
    }
    
    /**
     * 만족도조사를 삭제한다.
     * 
     * @param satisfactionVO
     * @param satisfaction
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/deleteSatisfaction.do")
    public String deleteSatisfaction(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, @ModelAttribute("satisfaction") Satisfaction satisfaction, ModelMap model) throws Exception {
	@SuppressWarnings("unused")
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
	if (isAuthenticated) {
	    bbsSatisfactionService.deleteSatisfaction(satisfactionVO);
	}
	
	satisfactionVO.setStsfdgCn("");
	satisfactionVO.setStsfdgNo("");
	satisfactionVO.setStsfdg(0);
	
	return "forward:/cop/bbs/selectBoardArticle.do";
    }
    
    /**
     * 익명 만족도조사를 삭제한다.
     * 
     * @param satisfactionVO
     * @param satisfaction
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/anonymous/deleteSatisfaction.do")
    public String deleteAnonymousSatisfaction(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, @ModelAttribute("satisfaction") Satisfaction satisfaction, ModelMap model) throws Exception {
	
	//-------------------------------
	// 패스워드 비교
	//-------------------------------
	String dbpassword = bbsSatisfactionService.getSatisfactionPassword(satisfactionVO);
	String enpassword = EgovFileScrty.encryptPassword(satisfactionVO.getConfirmPassword());
	
	if (!dbpassword.equals(enpassword)) {
	    
	    model.addAttribute("subMsg", egovMessageSource.getMessage("cop.password.not.same.msg"));
	    
	    return "forward:/cop/bbs/anonymous/selectBoardArticle.do";
	}
	////-----------------------------
	
	bbsSatisfactionService.deleteSatisfaction(satisfactionVO);
	
	satisfactionVO.setStsfdgNo("");
	satisfactionVO.setStsfdgCn("");
	satisfactionVO.setStsfdg(0);
	satisfactionVO.setWrterNm("");
	
	return "forward:/cop/bbs/anonymous/selectBoardArticle.do";
    }
    
    /**
     * 만족도조사 수정 페이지로 이동한다.
     * 
     * @param satisfactionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/selectSingleSatisfaction.do")
    public String selectSingleSatisfaction(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, ModelMap model) throws Exception {

	//------------------------------------------
	// JSP의 <head> 부분 처리 (javascript 생성)
	//------------------------------------------
	model.addAttribute("type", satisfactionVO.getType());	// head or body
	
	if (satisfactionVO.getType().equals("head")) {
	    return "cop/bbs/EgovSatisfactionList";
	}
	////----------------------------------------
	
	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
	satisfactionVO.setWrterNm(user.getName());

	satisfactionVO.setSubPageUnit(propertyService.getInt("pageUnit"));
	satisfactionVO.setSubPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(satisfactionVO.getSubPageIndex());
	paginationInfo.setRecordCountPerPage(satisfactionVO.getSubPageUnit());
	paginationInfo.setPageSize(satisfactionVO.getSubPageSize());

	satisfactionVO.setSubFirstIndex(paginationInfo.getFirstRecordIndex());
	satisfactionVO.setSubLastIndex(paginationInfo.getLastRecordIndex());
	satisfactionVO.setSubRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsSatisfactionService.selectSatisfactionList(satisfactionVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("summary", map.get("summary"));
	model.addAttribute("paginationInfo", paginationInfo);
	
	Satisfaction data = bbsSatisfactionService.selectSatisfaction(satisfactionVO);
	
	satisfactionVO.setStsfdgNo(data.getStsfdgNo());
	satisfactionVO.setNttId(data.getNttId());
	satisfactionVO.setBbsId(data.getBbsId());
	satisfactionVO.setWrterId(data.getWrterId());
	satisfactionVO.setWrterNm(data.getWrterNm());
	satisfactionVO.setStsfdgPassword(data.getStsfdgPassword());
	satisfactionVO.setStsfdgCn(data.getStsfdgCn());
	satisfactionVO.setStsfdg(data.getStsfdg());
	satisfactionVO.setUseAt(data.getUseAt());
	satisfactionVO.setFrstRegisterPnttm(data.getFrstRegisterPnttm());
	satisfactionVO.setFrstRegisterNm(data.getFrstRegisterNm());
	
	return "cop/bbs/EgovSatisfactionList";
    }
    
    /**
     * 익명 만족도조사 수정 페이지로 이동한다.
     * 
     * @param satisfactionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/anonymous/selectSingleSatisfaction.do")
    public String selectAnonymousSingleSatisfaction(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, ModelMap model) throws Exception {

	//------------------------------------------
	// JSP의 <head> 부분 처리 (javascript 생성)
	//------------------------------------------
	model.addAttribute("type", satisfactionVO.getType());	// head or body
	
	if (satisfactionVO.getType().equals("head")) {
	    return "cop/bbs/EgovSatisfactionList";
	}
	////----------------------------------------
	
	model.addAttribute("anonymous", "true");

	satisfactionVO.setSubPageUnit(propertyService.getInt("pageUnit"));
	satisfactionVO.setSubPageSize(propertyService.getInt("pageSize"));

	PaginationInfo paginationInfo = new PaginationInfo();
	paginationInfo.setCurrentPageNo(satisfactionVO.getSubPageIndex());
	paginationInfo.setRecordCountPerPage(satisfactionVO.getSubPageUnit());
	paginationInfo.setPageSize(satisfactionVO.getSubPageSize());

	satisfactionVO.setSubFirstIndex(paginationInfo.getFirstRecordIndex());
	satisfactionVO.setSubLastIndex(paginationInfo.getLastRecordIndex());
	satisfactionVO.setSubRecordCountPerPage(paginationInfo.getRecordCountPerPage());

	Map<String, Object> map = bbsSatisfactionService.selectSatisfactionList(satisfactionVO);
	int totCnt = Integer.parseInt((String)map.get("resultCnt"));
	
	paginationInfo.setTotalRecordCount(totCnt);

	model.addAttribute("resultList", map.get("resultList"));
	model.addAttribute("resultCnt", map.get("resultCnt"));
	model.addAttribute("summary", map.get("summary"));
	model.addAttribute("paginationInfo", paginationInfo);
	
	//-------------------------------
	// 패스워드 비교
	//-------------------------------
	String dbpassword = bbsSatisfactionService.getSatisfactionPassword(satisfactionVO);
	String enpassword = EgovFileScrty.encryptPassword(satisfactionVO.getConfirmPassword());

	if (!dbpassword.equals(enpassword)) {

	    model.addAttribute("subMsg", egovMessageSource.getMessage("cop.password.not.same.msg"));
	    
	    satisfactionVO.setStsfdgNo("");
	    satisfactionVO.setStsfdgCn("");
	    satisfactionVO.setStsfdg(0);
	    satisfactionVO.setWrterNm("");
	    
	} else {
	
	    Satisfaction data = bbsSatisfactionService.selectSatisfaction(satisfactionVO);

	    satisfactionVO.setStsfdgNo(data.getStsfdgNo());
	    satisfactionVO.setNttId(data.getNttId());
	    satisfactionVO.setBbsId(data.getBbsId());
	    satisfactionVO.setWrterId(data.getWrterId());
	    satisfactionVO.setWrterNm(data.getWrterNm());
	    satisfactionVO.setStsfdgPassword(data.getStsfdgPassword());
	    satisfactionVO.setStsfdgCn(data.getStsfdgCn());
	    satisfactionVO.setStsfdg(data.getStsfdg());
	    satisfactionVO.setUseAt(data.getUseAt());
	    satisfactionVO.setFrstRegisterPnttm(data.getFrstRegisterPnttm());
	    satisfactionVO.setFrstRegisterNm(data.getFrstRegisterNm());
	}
	////-----------------------------
	
	return "cop/bbs/EgovSatisfactionList";
    }
    
    /**
     * 만족도조사를 수정한다.
     * 
     * @param satisfactionVO
     * @param satisfaction
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/updateSatisfaction.do")
    public String updateSatisfaction(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, @ModelAttribute("satisfaction") Satisfaction satisfaction, 
	    BindingResult bindingResult, ModelMap model) throws Exception {

	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

	beanValidator.validate(satisfaction, bindingResult);
	if (bindingResult.hasErrors()) {
	    model.addAttribute("msg", "작성자 및 만족도는 필수 입력값입니다.");
	    
	    return "forward:/cop/bbs/selectBoardArticle.do";
	}

	if (isAuthenticated) {
	    satisfaction.setLastUpdusrId(user.getUniqId());
	    
	    satisfaction.setStsfdgPassword("");	// dummy
	    
	    bbsSatisfactionService.updateSatisfaction(satisfaction);
	    
	    satisfactionVO.setStsfdgCn("");
	    satisfactionVO.setStsfdgNo("");
	    satisfactionVO.setStsfdg(0);
	}

	return "forward:/cop/bbs/selectBoardArticle.do";
    }
    
    /**
     * 익명 만족도조사를 수정한다.
     * 
     * @param satisfactionVO
     * @param satisfaction
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/cop/bbs/anonymous/updateSatisfaction.do")
    public String updateAnonymousSatisfaction(@ModelAttribute("searchVO") SatisfactionVO satisfactionVO, @ModelAttribute("satisfaction") Satisfaction satisfaction, 
	    BindingResult bindingResult, ModelMap model) throws Exception {

	beanValidator.validate(satisfaction, bindingResult);
	if (bindingResult.hasErrors()) {
	    model.addAttribute("msg", "작성자 및 만족도는 필수 입력값입니다.");
	    
	    return "forward:/cop/bbs/anonymous/selectBoardArticle.do";
	}

	satisfaction.setLastUpdusrId("ANONYMOUS");
	satisfaction.setStsfdgPassword(EgovFileScrty.encryptPassword(satisfaction.getStsfdgPassword()));
	    
	bbsSatisfactionService.updateSatisfaction(satisfaction);

	satisfactionVO.setStsfdgNo("");
	satisfactionVO.setStsfdgCn("");
	satisfactionVO.setStsfdg(0);
	satisfactionVO.setWrterNm("");

	return "forward:/cop/bbs/anonymous/selectBoardArticle.do";
    }
}
