package egovframework.com.sym.ccm.cde.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo; 

import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.com.sym.ccm.cde.service.CmmnDetailCodeVO;
import egovframework.com.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;

import egovframework.com.sym.ccm.cca.service.CmmnCode;
import egovframework.com.sym.ccm.cca.service.CmmnCodeVO;
import egovframework.com.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;

import egovframework.com.sym.ccm.ccc.service.CmmnClCodeVO;
import egovframework.com.sym.ccm.ccc.service.EgovCcmCmmnClCodeManageService;

import egovframework.com.uat.uia.service.LoginVO;

import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.validation.BindingResult;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 
 * 공통상세코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovCcmCmmnDetailCodeManageController {

	@Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;

	@Resource(name = "CmmnClCodeManageService")
    private EgovCcmCmmnClCodeManageService cmmnClCodeManageService;

	@Resource(name = "CmmnCodeManageService")
    private EgovCcmCmmnCodeManageService cmmnCodeManageService;
	
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Autowired
	private DefaultBeanValidator beanValidator;
    
	/**
	 * 공통상세코드를 삭제한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/cde/EgovCcmCmmnDetailCodeRemove.do")
	public String deleteCmmnDetailCode (@ModelAttribute("loginVO") LoginVO loginVO
			, CmmnDetailCode cmmnDetailCode
			, ModelMap model
			) throws Exception {
    	cmmnDetailCodeManageService.deleteCmmnDetailCode(cmmnDetailCode);
        return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do";
	}

	/**
	 * 공통상세코드를 등록한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeRegist"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/cde/EgovCcmCmmnDetailCodeRegist.do")
	public String insertCmmnDetailCode	(@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			)	throws Exception {

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
    	if   (cmmnDetailCode.getCodeId() == null
        		||cmmnDetailCode.getCodeId().equals("")
        		||cmmnDetailCode.getCode() == null
        		||cmmnDetailCode.getCode().equals("")
        		||sCmd.equals("")) {
        		
        		CmmnClCodeVO searchClCodeVO;
        		searchClCodeVO = new CmmnClCodeVO();
        		searchClCodeVO.setRecordCountPerPage(999999);
        		searchClCodeVO.setFirstIndex(0);
        		searchClCodeVO.setSearchCondition("CodeList");
                List CmmnClCodeList = (List)cmmnClCodeManageService.selectCmmnClCodeList(searchClCodeVO);
                model.addAttribute("cmmnClCodeList", CmmnClCodeList);
        		
                CmmnCodeVO searchCodeVO;
                searchCodeVO = new CmmnCodeVO();
                searchCodeVO.setRecordCountPerPage(999999);
                searchCodeVO.setFirstIndex(0);
                searchCodeVO.setSearchCondition("clCode");
                if (cmmnCode.getClCode().equals("")) {
                	EgovMap emp = (EgovMap)CmmnClCodeList.get(0);
                	cmmnCode.setClCode(emp.get("clCode").toString());
                }
                searchCodeVO.setSearchKeyword(cmmnCode.getClCode());
        		
                List CmmnCodeList = cmmnCodeManageService.selectCmmnCodeList(searchCodeVO);
                model.addAttribute("cmmnCodeList", CmmnCodeList);

                return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeRegist";
    	} else if (sCmd.equals("Regist")) {

	        beanValidator.validate(cmmnDetailCode, bindingResult);
			if (bindingResult.hasErrors()){
	    		CmmnClCodeVO searchClCodeVO;
	    		searchClCodeVO = new CmmnClCodeVO();
	    		searchClCodeVO.setRecordCountPerPage(999999);
	    		searchClCodeVO.setFirstIndex(0);
	            List CmmnClCodeList = (List)cmmnClCodeManageService.selectCmmnClCodeList(searchClCodeVO);
	            model.addAttribute("cmmnClCodeList", CmmnClCodeList);
	    		
	            CmmnCodeVO searchCodeVO;
	            searchCodeVO = new CmmnCodeVO();
	            searchCodeVO.setRecordCountPerPage(999999);
	            searchCodeVO.setFirstIndex(0);
	            searchCodeVO.setSearchCondition("clCode");
	            if (cmmnCode.getClCode().equals("")) {
	            	EgovMap emp = (EgovMap)CmmnClCodeList.get(0);
	            	cmmnCode.setClCode(emp.get("clCode").toString());
	            }
	            searchCodeVO.setSearchKeyword(cmmnCode.getClCode());
	    		
	            List CmmnCodeList = cmmnCodeManageService.selectCmmnCodeList(searchCodeVO);
	            model.addAttribute("cmmnCodeList", CmmnCodeList);
				
	            return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeRegist";
			}
	    	
	    	cmmnDetailCode.setFrstRegisterId(loginVO.getUniqId());
	    	cmmnDetailCodeManageService.insertCmmnDetailCode(cmmnDetailCode);
	        return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do";
    	}  else {
    		return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do";
    	}
    }

	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "cmm/sym/ccm/EgovCcmCmmnDetailCodeDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/sym/ccm/cde/EgovCcmCmmnDetailCodeDetail.do")
 	public String selectCmmnDetailCodeDetail (@ModelAttribute("loginVO") LoginVO loginVO
 			, CmmnDetailCode cmmnDetailCode
 			,	ModelMap model
 			)	throws Exception {
    	CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
		model.addAttribute("result", vo);
		
		return "cmm/sym/ccm/EgovCcmCmmnDetailCodeDetail";
	}

    /**
	 * 공통상세코드 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeList"
     * @throws Exception
     */
    @RequestMapping(value="/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do")
	public String selectCmmnDetailCodeList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") CmmnDetailCodeVO searchVO
			, ModelMap model
			) throws Exception {
    	/** EgovPropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List CmmnCodeList = cmmnDetailCodeManageService.selectCmmnDetailCodeList(searchVO);
        model.addAttribute("resultList", CmmnCodeList);
        
        int totCnt = cmmnDetailCodeManageService.selectCmmnDetailCodeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeList";
	}

	/**
	 * 공통상세코드를 수정한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/sym/ccm/cde/EgovCcmCmmnDetailCodeModify.do")
	public String updateCmmnDetailCode (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
    	if (sCmd.equals("")) {
    		CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
    		model.addAttribute("cmmnDetailCode", vo);

    		return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeModify";
    	} else if (sCmd.equals("Modify")) {
            beanValidator.validate(cmmnDetailCode, bindingResult);
    		if (bindingResult.hasErrors()){
        		CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
        		model.addAttribute("cmmnDetailCode", vo);

        		return "/cmm/sym/ccm/EgovCcmCmmnDetailCodeModify";
    		}

    		cmmnDetailCode.setLastUpdusrId(loginVO.getUniqId());
	    	cmmnDetailCodeManageService.updateCmmnDetailCode(cmmnDetailCode);
	        return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do";
    	} else {
    		return "forward:/sym/ccm/cde/EgovCcmCmmnDetailCodeList.do";
    	}
    }

}