package egovframework.com.sym.mpm.web;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/* Pagination */
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo; 
/* Validator */
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.mpm.service.EgovProgrmManageService;
import egovframework.com.sym.mpm.service.MenuCreatVO;
import egovframework.com.sym.mpm.service.MenuSiteMapVO;
import egovframework.com.sym.mpm.service.MenuManageVO;
import egovframework.com.sym.mpm.service.EgovMenuManageService;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/** 
 * 메뉴목록 관리및 메뉴생성, 사이트맵 생성을 처리하는 비즈니스 구현 클래스
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovMenuManageController {

	protected Log log = LogFactory.getLog(this.getClass());
	/* Validator */
	@Autowired
	private DefaultBeanValidator beanValidator;
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

    /** EgovMenuManageService */
	@Resource(name = "progrmManageService")	
	private EgovProgrmManageService progrmManageService;
	
    /** EgovFileMngService */
//	@Resource(name="EgovFileMngService")
//	private EgovFileMngService fileMngService;	
	
    /** EgovFileMngUtil */
//	@Resource(name="EgovFileMngUtil")
//	private EgovFileMngUtil fileUtil;
	
//	@Resource(name = "excelZipService")
//    private EgovExcelService excelZipService;

	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;	

   
    /**
     * 메뉴정보목록을 상세화면 호출 및 상세조회한다. 
     * @param req_menuNo  String
     * @return 출력페이지정보 "sym/mpm/EgovMenuDetailSelectUpdt"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuManageListDetailSelect.do")
    public String selectMenuManage(
    		@RequestParam("req_menuNo") String req_menuNo ,
    		@ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	searchVO.setSearchKeyword(req_menuNo);
    	
    	MenuManageVO resultVO = menuManageService.selectMenuManage(searchVO);
        model.addAttribute("menuManageVO", resultVO);

        return "sym/mpm/EgovMenuDetailSelectUpdt";
    }
	
    /**
     * 메뉴목록 리스트조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mpm/EgovMenuManage"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuManageSelect.do")
    public String selectMenuManageList(
    		@ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception { 
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	// 내역 조회
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
		
		List list_menumanage = menuManageService.selectMenuManageList(searchVO);
		model.addAttribute("list_menumanage", list_menumanage);
        
        int totCnt = menuManageService.selectMenuManageListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
    	
      	return "sym/mpm/EgovMenuManage";
    }

    /**
     * 메뉴목록 멀티 삭제한다. 
     * @param checkedMenuNoForDel  String
     * @return 출력페이지정보 "forward:/sym/mpm/EgovMenuManageSelect.do"
     * @exception Exception
     */
    @RequestMapping("/sym/mpm/EgovMenuManageListDelete.do")
    public String deleteMenuManageList(
            @RequestParam("checkedMenuNoForDel") String checkedMenuNoForDel ,
            @ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
            ModelMap model)
            throws Exception {
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
		String sLocationUrl = null;
    	String resultMsg    = "";
    	
		String [] delMenuNo = checkedMenuNoForDel.split(",");
		
		if (delMenuNo == null || (delMenuNo.length ==0)){ 
    		resultMsg = egovMessageSource.getMessage("fail.common.delete");
    		sLocationUrl = "forward:/sym/mpm/EgovMenuManageSelect.do";
		}else{
			menuManageService.deleteMenuManageList(checkedMenuNoForDel);
			resultMsg = egovMessageSource.getMessage("success.common.delete");
			sLocationUrl ="forward:/sym/mpm/EgovMenuManageSelect.do";
		}
		model.addAttribute("resultMsg", resultMsg);
        return sLocationUrl;
    }
    
    /**
     * 메뉴정보를 등록화면으로 이동 및 등록 한다. 
     * @param menuManageVO    MenuManageVO
     * @param commandMap      Map
     * @return 출력페이지정보 등록화면 호출시 "sym/mpm/EgovMenuRegist",
     *         출력페이지정보 등록처리시 "forward:/sym/mpm/EgovMenuManageSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuRegistInsert.do")
    public String insertMenuManage(
    		Map commandMap, 
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
		String sLocationUrl = null;
    	String resultMsg    = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
        String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");	
		if(sCmd.equals("insert")){
            beanValidator.validate(menuManageVO, bindingResult);
    		if (bindingResult.hasErrors()){
    			sLocationUrl = "sym/mpm/EgovMenuRegist";
    			return sLocationUrl;
    		}
    		if(menuManageService.selectMenuNoByPk(menuManageVO) == 0){
    			ComDefaultVO searchVO = new ComDefaultVO();
    			searchVO.setSearchKeyword(menuManageVO.getProgrmFileNm());
    			if(progrmManageService.selectProgrmNMTotCnt(searchVO)==0){
    	    		resultMsg = egovMessageSource.getMessage("fail.common.insert");
    		        sLocationUrl = "sym/mpm/EgovMenuRegist";
    			}else{
    	        	menuManageService.insertMenuManage(menuManageVO);
            		resultMsg = egovMessageSource.getMessage("success.common.insert");
    		        sLocationUrl = "forward:/sym/mpm/EgovMenuManageSelect.do";
    			}
    		}else{
        		resultMsg = egovMessageSource.getMessage("common.isExist.msg");
        		sLocationUrl = "sym/mpm/EgovMenuRegist";
    		}
    		model.addAttribute("resultMsg", resultMsg);
		}else{
            sLocationUrl = "sym/mpm/EgovMenuRegist";
        }
		return sLocationUrl; 
    } 

    /**
     * 메뉴정보를 수정 한다. 
     * @param menuManageVO  MenuManageVO
     * @return 출력페이지정보 "forward:/sym/mpm/EgovMenuManageSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuDetailSelectUpdt.do")
    public String updateMenuManage(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
        beanValidator.validate(menuManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/sym/mpm/EgovMenuManageListDetailSelect.do";
			return sLocationUrl;
		}
		ComDefaultVO searchVO = new ComDefaultVO();
		searchVO.setSearchKeyword(menuManageVO.getProgrmFileNm());
		if(progrmManageService.selectProgrmNMTotCnt(searchVO)==0){
    		resultMsg = egovMessageSource.getMessage("fail.common.update");
	        sLocationUrl = "forward:/sym/mpm/EgovMenuManageListDetailSelect.do";
		}else{
			menuManageService.updateMenuManage(menuManageVO);
	    	resultMsg = egovMessageSource.getMessage("success.common.update");
	       	sLocationUrl = "forward:/sym/mpm/EgovMenuManageSelect.do";
		}
    	model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
    }    

    /**
     * 메뉴정보를 삭제 한다. 
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "forward:/sym/mpm/EgovMenuManageSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuManageDelete.do")
    public String deleteMenuManage(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
    		ModelMap model)
            throws Exception {
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	menuManageService.deleteMenuManage(menuManageVO);
    	resultMsg = egovMessageSource.getMessage("success.common.delete");
    	String _MenuNm = "%";
    	menuManageVO.setMenuNm(_MenuNm);
    	model.addAttribute("resultMsg", resultMsg);
      	return "forward:/sym/mpm/EgovMenuManageSelect.do";
    } 

    /**
     * 메뉴리스트를 조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mpm/EgovMenuList" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuListSelect.do")
    public String selectMenuList(
    		@ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception { 
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	List list_menulist = menuManageService.selectMenuList();
    	resultMsg = egovMessageSource.getMessage("success.common.select");
        model.addAttribute("list_menulist", list_menulist);
        model.addAttribute("resultMsg", resultMsg);
      	return  "sym/mpm/EgovMenuList"; 
    }
    
    /**
     * 메뉴리스트의 메뉴정보를 등록한다. 
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "sym/mpm/EgovMenuList" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuListInsert.do")
    public String insertMenuList(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}

        beanValidator.validate(menuManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "sym/mpm/EgovMenuList";
			return sLocationUrl;
		}

		if(menuManageService.selectMenuNoByPk(menuManageVO) == 0){
			ComDefaultVO searchVO = new ComDefaultVO();
			searchVO.setSearchKeyword(menuManageVO.getProgrmFileNm());
			if(progrmManageService.selectProgrmNMTotCnt(searchVO)==0){
	    		resultMsg = egovMessageSource.getMessage("fail.common.insert");
		        sLocationUrl = "forward:/sym/mpm/EgovMenuListSelect.do";
			}else{
	        	menuManageService.insertMenuManage(menuManageVO);
	    		resultMsg = egovMessageSource.getMessage("success.common.insert");
		        sLocationUrl = "forward:/sym/mpm/EgovMenuListSelect.do";
			}
		}else{
    		resultMsg = egovMessageSource.getMessage("common.isExist.msg");
    		sLocationUrl = "forward:/sym/mpm/EgovMenuListSelect.do";
		}
		model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;
    } 

    /**
     * 메뉴리스트의 메뉴정보를 수정한다. 
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "sym/mpm/EgovMenuList" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuListUpdt.do")
    public String updateMenuList(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}

        beanValidator.validate(menuManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/sym/mpm/EgovMenuListSelect.do";
			return sLocationUrl;
		}
		ComDefaultVO searchVO = new ComDefaultVO();
		searchVO.setSearchKeyword(menuManageVO.getProgrmFileNm());
		if(progrmManageService.selectProgrmNMTotCnt(searchVO)==0){
    		resultMsg = egovMessageSource.getMessage("fail.common.update");
	        sLocationUrl = "forward:/sym/mpm/EgovMenuListSelect.do";
		}else{
			menuManageService.updateMenuManage(menuManageVO);
			resultMsg = egovMessageSource.getMessage("success.common.update");
	        sLocationUrl = "forward:/sym/mpm/EgovMenuListSelect.do";
		}
		model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;
    }    

    /**
     * 메뉴리스트의 메뉴정보를 삭제한다. 
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "sym/mpm/EgovMenuList" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuListDelete.do")
    public String deleteMenuList(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}

        beanValidator.validate(menuManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "sym/mpm/EgovMenuList";
			return sLocationUrl;
		}
		menuManageService.deleteMenuManage(menuManageVO);
		resultMsg = egovMessageSource.getMessage("success.common.delete");
        sLocationUrl = "forward:/sym/mpm/EgovMenuListSelect.do";
		model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;    	
    }
    
    /**
     * 메뉴리스트의 메뉴정보를 이동 메뉴목록을 조회한다. 
     * @param searchVO  ComDefaultVO 
     * @return 출력페이지정보 "sym/mpm/EgovMenuMvmn" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuListSelectMvmn.do")
    public String selectMenuListMvmn(
    		@ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception { 
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	
    	List list_menulist = menuManageService.selectMenuList();
        model.addAttribute("list_menulist", list_menulist);
      	return  "sym/mpm/EgovMenuMvmn"; 
    }
    
	/*********** 메뉴 생성 관리 ***************/

    /**
     * *메뉴생성목록을 조회한다. 
     * @param searchVO  ComDefaultVO
     * @return 출력페이지정보 "sym/mpm/EgovMenuCreatManage" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuCreatManageSelect.do")
    public String selectMenuCreatManagList(
    		@ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception { 
    	String resultMsg ="";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	// 내역 조회
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
		if(searchVO.getSearchKeyword() != null && !searchVO.getSearchKeyword().equals("")){
			int IDcnt = menuManageService.selectUsrByPk(searchVO);
			if (IDcnt == 0){
				resultMsg = egovMessageSource.getMessage("info.nodata.msg");
			}else{
				/* AuthorCode 검색 */
				MenuCreatVO vo = new MenuCreatVO();
		    	vo =  menuManageService.selectAuthorByUsr(searchVO);
	    		searchVO.setSearchKeyword(vo.getAuthorCode());
			}
		}
		List list_menumanage = menuManageService.selectMenuCreatManagList(searchVO);
		model.addAttribute("list_menumanage", list_menumanage);
        
        int totCnt = menuManageService.selectMenuCreatManagTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("resultMsg", resultMsg);
      	return "sym/mpm/EgovMenuCreatManage";
    }
    
    /*메뉴생성 세부조회*/
    /**
     * 메뉴생성 세부화면을 조회한다. 
     * @param menuCreatVO MenuCreatVO
     * @return 출력페이지정보 "sym/mpm/EgovMenuCreat" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuCreatSelect.do")
    public String selectMenuCreatList(
    		@ModelAttribute("menuCreatVO") MenuCreatVO menuCreatVO,
    		ModelMap model)
            throws Exception { 
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	List list_menulist = menuManageService.selectMenuCreatList(menuCreatVO);
        model.addAttribute("list_menulist", list_menulist);
        model.addAttribute("resultVO", menuCreatVO);
        
      	return "sym/mpm/EgovMenuCreat";  
    }

    /**
     * 메뉴생성처리 및 메뉴생성내역을 등록한다. 
     * @param checkedAuthorForInsert  String
     * @param checkedMenuNoForInsert  String
     * @return 출력페이지정보 등록처리시 "forward:/sym/mpm/EgovMenuCreatSelect.do" 
     * @exception Exception
     */
    @RequestMapping("/sym/mpm/EgovMenuCreatInsert.do")
    public String insertMenuCreatList(
            @RequestParam("checkedAuthorForInsert")  String checkedAuthorForInsert ,
            @RequestParam("checkedMenuNoForInsert") String checkedMenuNoForInsert ,
            @ModelAttribute("menuCreatVO") MenuCreatVO menuCreatVO, 
            ModelMap model)
            throws Exception {
    	String resultMsg = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
		String [] insertMenuNo = checkedMenuNoForInsert.split(",");
		if (insertMenuNo == null || (insertMenuNo.length ==0)){ 
			resultMsg = egovMessageSource.getMessage("fail.common.insert");
		}else{
	    	menuManageService.insertMenuCreatList(checkedAuthorForInsert, checkedMenuNoForInsert);
	    	resultMsg = egovMessageSource.getMessage("success.common.insert");
		}
		model.addAttribute("resultMsg", resultMsg);
        return "forward:/sym/mpm/EgovMenuCreatSelect.do";
    }

    /*메뉴사이트맵 생성조회*/
    /**
     * 메뉴사이트맵을 생성할 내용을 조회한다. 
     * @param menuSiteMapVO MenuSiteMapVO
     * @return 출력페이지정보 등록처리시 "sym/mpm/EgovMenuCreatSiteMap" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuCreatSiteMapSelect.do")
    public String selectMenuCreatSiteMap(
    		@ModelAttribute("menuSiteMapVO") MenuSiteMapVO menuSiteMapVO,
    		ModelMap model)
            throws Exception { 
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	List list_menulist = menuManageService.selectMenuCreatSiteMapList(menuSiteMapVO);
        model.addAttribute("list_menulist", list_menulist);
    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	menuSiteMapVO.setCreatPersonId(user.getId());
        model.addAttribute("resultVO", menuSiteMapVO);
      	return "sym/mpm/EgovMenuCreatSiteMap";  
    }

    
    /*메뉴사이트맵 생성조회*/
    /**
     * 메뉴사이트맵을 생성할 내용을 조회한다. 
     * @param menuSiteMapVO MenuSiteMapVO
     * @return 출력페이지정보 등록처리시 "sym/mpm/EgovMenuCreatSiteMap" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovSiteMap.do")
    public String selectSiteMap (
    		@ModelAttribute("menuCreatVO") MenuSiteMapVO menuSiteMapVO,
    		ModelMap model)
            throws Exception { 
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}

    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	menuSiteMapVO.setCreatPersonId(user.getId());
        
    	List list_menulist = menuManageService.selectSiteMapByUser(menuSiteMapVO);
        model.addAttribute("list_menulist", list_menulist);

    	model.addAttribute("resultVO", menuSiteMapVO);
      	return "sym/mpm/EgovSiteMap";  
    }

    
    
    /**
     * 메뉴사이트맵 생성처리 및 사이트맵을 등록한다. 
     * @param menuSiteMapVO MenuSiteMapVO
     * @param valueHtml      String
     * @return 출력페이지정보 "sym/mpm/EgovMenuCreatSiteMap" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuCreatSiteMapInsert.action")
    public String selectMenuCreatSiteMapInsert(
    		@ModelAttribute("menuSiteMapVO") MenuSiteMapVO menuSiteMapVO,
    		@RequestParam("valueHtml") String valueHtml,
    		ModelMap model)
            throws Exception { 
    	boolean chkCreat = false;
    	String  resultMsg = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
/*    	사이트맵 파일 생성 위치 지정
        if ("WINDOWS".equals(Globals.OS_TYPE)) {
    		menuSiteMapVO.setTmp_rootPath("D:/egovframework/workspace/egovcmm/src/main/webapp");
    	}else{
    		menuSiteMapVO.setTmp_rootPath("/product/jeus/webhome/was_com/egovframework-com-1_0/egovframework-com-1_0_war___");
    	}
*/    	
    	chkCreat = menuManageService.creatSiteMap(menuSiteMapVO, valueHtml);
    	if(!chkCreat){
    		resultMsg = egovMessageSource.getMessage("fail.common.insert");
    	}else{
    		resultMsg = egovMessageSource.getMessage("success.common.insert");
    	}
    	List list_menulist = menuManageService.selectMenuCreatSiteMapList(menuSiteMapVO);
        model.addAttribute("list_menulist", list_menulist);
        model.addAttribute("resultVO", menuSiteMapVO);
    	model.addAttribute("resultMsg", resultMsg);
    	return "sym/mpm/EgovMenuCreatSiteMap";  
    }

    /*### 일괄처리 프로세스 ###*/

    /**
     * 메뉴생성 일괄삭제프로세스  
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "sym/mpm/EgovMenuBndeRegist" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuBndeAllDelete.do")
    public String menuBndeAllDelete(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception { 
    	String resultMsg = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	menuManageService.menuBndeAllDelete();
    	resultMsg = egovMessageSource.getMessage("success.common.delete");
    	model.addAttribute("resultMsg", resultMsg);
        return "sym/mpm/EgovMenuBndeRegist";  
    }

    /**
     * 메뉴일괄등록화면 호출 및  메뉴일괄등록처리 프로세스  
     * @param commandMap    Map
     * @param menuManageVO  MenuManageVO
     * @param request       HttpServletRequest
     * @return 출력페이지정보 "sym/mpm/EgovMenuBndeRegist" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovMenuBndeRegist.do")
    public String menuBndeRegist(
    		Map commandMap, 
    		final HttpServletRequest request,
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
        String resultMsg = "";
        String sMessage  = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
        String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");	
        if(sCmd.equals("bndeInsert")){
	    	final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				if (!"".equals(file.getOriginalFilename())) {
					if(menuManageService.menuBndeAllDelete()){
						sMessage = menuManageService.menuBndeRegist(menuManageVO, file.getInputStream());
			    	    resultMsg = sMessage;
					}else{
						resultMsg = egovMessageSource.getMessage("fail.common.msg");
						menuManageVO.setTmp_Cmd("EgovMenuBndeRegist Error!!");
				        model.addAttribute("resultVO", menuManageVO);
					}
				}else{
					resultMsg = egovMessageSource.getMessage("fail.common.msg");
				}
			}
			sLocationUrl = "sym/mpm/EgovMenuBndeRegist";
	    	model.addAttribute("resultMsg", resultMsg);
        }else{
            sLocationUrl = "sym/mpm/EgovMenuBndeRegist";
        }
    	return sLocationUrl; 
    }
}
