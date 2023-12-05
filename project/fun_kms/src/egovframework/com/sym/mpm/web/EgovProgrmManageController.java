package egovframework.com.sym.mpm.web;

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
/* Pagination */
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo; 
/* Validator */
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.validation.BindingResult;

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.mpm.service.EgovProgrmManageService;
import egovframework.com.sym.mpm.service.ProgrmManageVO;
import egovframework.com.sym.mpm.service.ProgrmManageDtlVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.ems.service.EgovSndngMailRegistService;
import egovframework.com.ems.service.SndngMailVO;
/* Log */
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/*Mail*/

/** 
 * 프로그램목록 관리및 변경을 처리하는 비즈니스 구현 클래스
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
public class EgovProgrmManageController {

	protected Log log = LogFactory.getLog(this.getClass());

	/** Validator */
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    /** EgovProgrmManageService */
	@Resource(name = "progrmManageService")
    private EgovProgrmManageService progrmManageService;

	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
    /** EgovSndngMailRegistService */
	@Resource(name = "sndngMailRegistService")
    private EgovSndngMailRegistService sndngMailRegistService;
	
    /**
     * 프로그램목록을 상세화면 호출 및 상세조회한다. 
     * @param tmp_progrmNm  String
     * @return 출력페이지정보 "sym/mpm/EgovProgramListDetailSelectUpdt"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramListDetailSelect.do")
    public String selectProgrm(
    		@RequestParam("tmp_progrmNm") String tmp_progrmNm ,
   		    @ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	searchVO.setSearchKeyword(tmp_progrmNm);
    	ProgrmManageVO progrmManageVO = progrmManageService.selectProgrm(searchVO);
        model.addAttribute("progrmManageVO", progrmManageVO);
        return "sym/mpm/EgovProgramListDetailSelectUpdt";
    }
	
    /**
     * 프로그램목록 리스트조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mpm/EgovProgramListManage"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramListManageSelect.do")
    public String selectProgrmList(
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
		
        List list_progrmmanage = progrmManageService.selectProgrmList(searchVO);
        model.addAttribute("list_progrmmanage", list_progrmmanage);

        int totCnt = progrmManageService.selectProgrmListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
      	return "sym/mpm/EgovProgramListManage";

    }

    /**
     * 프로그램목록 멀티 삭제한다. 
     * @param checkedProgrmFileNmForDel String
     * @return 출력페이지정보 "forward:/sym/mpm/EgovProgramListManageSelect.do"
     * @exception Exception
     */
    @RequestMapping("/sym/mpm/EgovProgrmManageListDelete.do")
    public String deleteProgrmManageList(
            @RequestParam("checkedProgrmFileNmForDel") String checkedProgrmFileNmForDel ,
            @ModelAttribute("progrmManageVO") ProgrmManageVO progrmManageVO, 
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
    	String [] delProgrmFileNm = checkedProgrmFileNmForDel.split(",");
		if (delProgrmFileNm == null || (delProgrmFileNm.length ==0)){ 
    		resultMsg = egovMessageSource.getMessage("fail.common.delete");
    		sLocationUrl = "forward:/sym/mpm/EgovProgramListManageSelect.do";
		}else{
    	   progrmManageService.deleteProgrmManageList(checkedProgrmFileNmForDel);
    	   resultMsg = egovMessageSource.getMessage("success.common.delete");
    	   sLocationUrl ="forward:/sym/mpm/EgovProgramListManageSelect.do";
		}
		model.addAttribute("resultMsg", resultMsg);
        //status.setComplete();
        return sLocationUrl ;
    } 
    
    /**
     * 프로그램목록을 등록화면으로 이동 및 등록 한다. 
     * @param progrmManageVO ProgrmManageVO 
     * @param commandMap     Map     
     * @return 출력페이지정보 등록화면 호출시 "sym/mpm/EgovProgramListRegist",
     *         출력페이지정보 등록처리시 "forward:/sym/mpm/EgovProgramListManageSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramListRegist.do")
    public String insertProgrmList(
    		Map commandMap, 
    		@ModelAttribute("progrmManageVO") ProgrmManageVO progrmManageVO,
			BindingResult bindingResult,
			ModelMap model)
            throws Exception { 
        String resultMsg = "";
        String sLocationUrl = null;
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}

        String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");	
        if(sCmd.equals("insert")){
	        beanValidator.validate(progrmManageVO, bindingResult);
			if (bindingResult.hasErrors()){
				sLocationUrl = "sym/mpm/EgovProgramListRegist";
				return sLocationUrl;
			}
			if(progrmManageVO.getProgrmDc()==null || progrmManageVO.getProgrmDc().equals("")){progrmManageVO.setProgrmDc(" ");} 
	    	progrmManageService.insertProgrm(progrmManageVO);
			resultMsg = egovMessageSource.getMessage("success.common.insert");
	        sLocationUrl = "forward:/sym/mpm/EgovProgramListManageSelect.do";
        }else{    		
            sLocationUrl = "sym/mpm/EgovProgramListRegist";
        }
    	model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
    }    
    
    /**
     * 프로그램목록을 수정 한다. 
     * @param progrmManageVO ProgrmManageVO
     * @return 출력페이지정보 "forward:/sym/mpm/EgovProgramListManageSelect.do" 
     * @exception Exception
     */
    /*프로그램목록수정*/
    @RequestMapping(value="/sym/mpm/EgovProgramListDetailSelectUpdt.do")
    public String updateProgrmList(
    		@ModelAttribute("progrmManageVO") ProgrmManageVO progrmManageVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
		String resultMsg = "";
        String sLocationUrl = null;
    	// 0. Spring Security 사용자권한 처리
   	    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}

        beanValidator.validate(progrmManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/sym/mpm/EgovProgramListDetailSelect.do";
			return sLocationUrl;
		}
		if(progrmManageVO.getProgrmDc()==null || progrmManageVO.getProgrmDc().equals("")){progrmManageVO.setProgrmDc(" ");}
		progrmManageService.updateProgrm(progrmManageVO);
		resultMsg = egovMessageSource.getMessage("success.common.update");
        sLocationUrl = "forward:/sym/mpm/EgovProgramListManageSelect.do";
    	model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
    }    
    
    /**
     * 프로그램목록을 삭제 한다. 
     * @param progrmManageVO ProgrmManageVO
     * @return 출력페이지정보 "forward:/sym/mpm/EgovProgramListManageSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramListManageDelete.do")
    public String deleteProgrmList(
    		@ModelAttribute("progrmManageVO") 
    		ProgrmManageVO progrmManageVO,
    		ModelMap model)
            throws Exception {
    	String resultMsg = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
        progrmManageService.deleteProgrm(progrmManageVO);
        resultMsg = egovMessageSource.getMessage("success.common.delete");
    	model.addAttribute("resultMsg", resultMsg);
        return "forward:/sym/mpm/EgovProgramListManageSelect.do";
    } 

    /**
     * 프로그램변경요청목록 조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mpm/EgovProgramChangeRequst" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChangeRequstSelect.do")
    public String selectProgrmChangeRequstList(
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
    	
        List list_changerequst = progrmManageService.selectProgrmChangeRequstList(searchVO);
        model.addAttribute("list_changerequst", list_changerequst);

        int totCnt = progrmManageService.selectProgrmChangeRequstListTotCnt(searchVO);
 		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
         
         return "sym/mpm/EgovProgramChangeRequst";
    }

    /**
     * 프로그램변경요청목록을 상세조회한다. 
     * @param progrmManageDtlVO ProgrmManageDtlVO
     * @return 출력페이지정보 "sym/mpm/EgovProgramChangRequstDetailSelectUpdt" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChangRequstDetailSelect.do")
    public String selectProgrmChangeRequst(
    		@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO,
    		ModelMap model)
            throws Exception {
         // 0. Spring Security 사용자권한 처리
    	 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	 if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	 }
         if(progrmManageDtlVO.getProgrmFileNm()== null||progrmManageDtlVO.getProgrmFileNm().equals("")){
	    	 String _FileNm = progrmManageDtlVO.getTmp_progrmNm();    	
	         progrmManageDtlVO.setProgrmFileNm(_FileNm);
	         int _tmp_no = progrmManageDtlVO.getTmp_rqesterNo();    	
	         progrmManageDtlVO.setRqesterNo(_tmp_no);
         }
         ProgrmManageDtlVO resultVO = progrmManageService.selectProgrmChangeRequst(progrmManageDtlVO);
         model.addAttribute("progrmManageDtlVO", resultVO);
         return "sym/mpm/EgovProgramChangRequstDetailSelectUpdt";
    }
    
    /**
     * 프로그램변경요청 화면을 호출및 프로그램변경요청을 등록한다. 
     * @param progrmManageDtlVO ProgrmManageDtlVO
     * @param commandMap        Map
     * @return 출력페이지정보 등록화면 호출시 "sym/mpm/EgovProgramChangRequstStre",
     *         출력페이지정보 등록처리시 "forward:/sym/mpm/EgovProgramChangeRequstSelect.do" 
     * @exception Exception
     */
    /*프로그램변경요청등록*/
    @RequestMapping(value="/sym/mpm/EgovProgramChangRequstStre.do")
    public String insertProgrmChangeRequst(
        	Map commandMap, 
    		@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
    	String resultMsg = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
       	    return "cmm/uat/uia/EgovLoginUsr";
    	}
		//로그인 객체 선언
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        String sLocationUrl = null;
        String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");	
        if(sCmd.equals("insert")){
    		//beanValidator 처리
	        beanValidator.validate(progrmManageDtlVO, bindingResult);
			if (bindingResult.hasErrors()){
				sLocationUrl = "sym/mpm/EgovProgramChangRequstStre";
				return sLocationUrl;
			}
			if(progrmManageDtlVO.getChangerqesterCn()==null || progrmManageDtlVO.getChangerqesterCn().equals("")){progrmManageDtlVO.setChangerqesterCn("");}
			if(progrmManageDtlVO.getRqesterProcessCn()==null || progrmManageDtlVO.getRqesterProcessCn().equals("")){progrmManageDtlVO.setRqesterProcessCn("");}
			progrmManageService.insertProgrmChangeRequst(progrmManageDtlVO);
	    	resultMsg = egovMessageSource.getMessage("success.common.insert");
	        sLocationUrl = "forward:/sym/mpm/EgovProgramChangeRequstSelect.do";
        }else{    	
	        /* MAX요청번호 조회 */
	    	ProgrmManageDtlVO tmp_vo = progrmManageService.selectProgrmChangeRequstNo(progrmManageDtlVO);			
			int _tmp_no = tmp_vo.getRqesterNo();
			progrmManageDtlVO.setRqesterNo(_tmp_no);
			progrmManageDtlVO.setRqesterPersonId(user.getId());
            sLocationUrl = "sym/mpm/EgovProgramChangRequstStre";
        }
    	model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
    }

    /**
     * 프로그램변경 요청을 수정 한다. 
     * @param progrmManageDtlVO  ProgrmManageDtlVO
     * @return 출력페이지정보 "forward:/sym/mpm/EgovProgramChangeRequstSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChangRequstDetailSelectUpdt.do")
    public String updateProgrmChangeRequst(
    		@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
    	String resultMsg = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
		//로그인 객체 선언
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		//beanValidator 처리
        beanValidator.validate(progrmManageDtlVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/sym/mpm/EgovProgramChangRequstDetailSelect.do";
			return sLocationUrl;
		}

    	if(progrmManageDtlVO.getRqesterPersonId().equals(loginVO.getId())){
			if(progrmManageDtlVO.getChangerqesterCn()==null || progrmManageDtlVO.getChangerqesterCn().equals("")){progrmManageDtlVO.setChangerqesterCn(" ");}
			if(progrmManageDtlVO.getRqesterProcessCn()==null || progrmManageDtlVO.getRqesterProcessCn().equals("")){progrmManageDtlVO.setRqesterProcessCn(" ");}
	        progrmManageService.updateProgrmChangeRequst(progrmManageDtlVO);
    		resultMsg = egovMessageSource.getMessage("success.common.update");
	        sLocationUrl = "forward:/sym/mpm/EgovProgramChangeRequstSelect.do";
    	}else{
    		resultMsg = "수정이 실패하였습니다. 변경요청 수정은 변경요청자만 수정가능합니다.";
            progrmManageDtlVO.setTmp_progrmNm(progrmManageDtlVO.getProgrmFileNm());    	
            progrmManageDtlVO.setTmp_rqesterNo(progrmManageDtlVO.getRqesterNo());    	
			sLocationUrl = "forward:/sym/mpm/EgovProgramChangRequstDetailSelect.do";
    	}
    	model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
    }    

    /**
     * 프로그램변경 요청을 삭제 한다. 
     * @param progrmManageDtlVO  ProgrmManageDtlVO
     * @return 출력페이지정보 "forward:/sym/mpm/EgovProgramChangeRequstSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChangRequstDelete.do")
    public String deleteProgrmChangeRequst(
    		@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
    		ModelMap model)
            throws Exception {
        String sLocationUrl = null;
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
		//로그인 객체 선언
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	if(progrmManageDtlVO.getRqesterPersonId().equals(loginVO.getId())){
    	//progrmManageDtlVO.setRqesterPersonId(user.getId());
    		model.addAttribute("resultMsg", egovMessageSource.getMessage("success.common.delete"));
	        progrmManageService.deleteProgrmChangeRequst(progrmManageDtlVO);
	        sLocationUrl = "forward:/sym/mpm/EgovProgramChangeRequstSelect.do";
    	}else{
    		model.addAttribute("resultMsg", "삭제에 실패하였습니다. 변경요청자만 삭제가능합니다.");
			sLocationUrl = "forward:/sym/mpm/EgovProgramChangRequstDetailSelect.do";
    	}
        return sLocationUrl; 
    } 

    /**
     * 프로그램변경 요청에 대한 처리 사항을 조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mpm/EgovProgramChangeRequstProcess" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChangeRequstProcessListSelect.do")
    public String selectProgrmChangeRequstProcessList(
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
     	
         List list_changerequst = progrmManageService.selectChangeRequstProcessList(searchVO);
         model.addAttribute("list_changerequst", list_changerequst);

         int totCnt = progrmManageService.selectChangeRequstProcessListTotCnt(searchVO);
  		 paginationInfo.setTotalRecordCount(totCnt);
         model.addAttribute("paginationInfo", paginationInfo);
         
         return "sym/mpm/EgovProgramChangeRequstProcess";
    }
    
    /**
     * 프로그램변경 요청에 대한 처리 사항을 상세조회한다. 
     * @param progrmManageDtlVO ProgrmManageDtlVO
     * @return 출력페이지정보 "sym/mpm/EgovProgramChangRequstProcessDetailSelectUpdt" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChangRequstProcessDetailSelect.do")
    public String selectProgrmChangRequstProcess(
    		@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO,
    		ModelMap model)
            throws Exception {
         // 0. Spring Security 사용자권한 처리
    	 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	 if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	 }
         if(progrmManageDtlVO.getProgrmFileNm()==null){
	    	 String _FileNm = progrmManageDtlVO.getTmp_progrmNm();    	
	         progrmManageDtlVO.setProgrmFileNm(_FileNm);
	         int _Tmp_no = progrmManageDtlVO.getTmp_rqesterNo();    	
	         progrmManageDtlVO.setRqesterNo(_Tmp_no);
         }
         ProgrmManageDtlVO resultVO = progrmManageService.selectProgrmChangeRequst(progrmManageDtlVO);
         if(resultVO.getOpetrId()== null){
	     	 LoginVO user = 
				(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	         resultVO.setOpetrId(user.getId());
         }
         model.addAttribute("progrmManageDtlVO", resultVO);
         return "sym/mpm/EgovProgramChangRequstProcessDetailSelectUpdt";
    }    

    /**
     * 프로그램변경요청처리 내용을 수정 한다. 
     * @param progrmManageDtlVO ProgrmManageDtlVO 
     * @return 출력페이지정보 "forward:/sym/mpm/EgovProgramChangeRequstProcessListSelect.do" 
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChangRequstProcessDetailSelectUpdt.do")
    public String updateProgrmChangRequstProcess(
    		@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
    	boolean result = true;
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
		
        beanValidator.validate(progrmManageDtlVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/sym/mpm/EgovProgramChangRequstProcessDetailSelect.do";
			return sLocationUrl;
		}

    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	if(progrmManageDtlVO.getOpetrId().equals(user.getId())){
			if(progrmManageDtlVO.getChangerqesterCn()==null || progrmManageDtlVO.getChangerqesterCn().equals("")){progrmManageDtlVO.setChangerqesterCn(" ");}
			if(progrmManageDtlVO.getRqesterProcessCn()==null || progrmManageDtlVO.getRqesterProcessCn().equals("")){progrmManageDtlVO.setRqesterProcessCn(" ");}
	        progrmManageService.updateProgrmChangeRequstProcess(progrmManageDtlVO);
	        model.addAttribute("resultMsg", egovMessageSource.getMessage("success.common.update"));
	        
	        ProgrmManageDtlVO vo = new ProgrmManageDtlVO();
	        vo = progrmManageService.selectRqesterEmail(progrmManageDtlVO);
	        String sTemp = null;
	        if(progrmManageDtlVO.getProcessSttus().equals("A")){
	        	sTemp = "신청중";
	        }else if(progrmManageDtlVO.getProcessSttus().equals("P")){
	        	sTemp = "진행중";	
	        }else if(progrmManageDtlVO.getProcessSttus().equals("R")){
	        	sTemp = "반려";
	        }else if(progrmManageDtlVO.getProcessSttus().equals("C")){
	        	sTemp = "처리완료";
	        }
	    	// 프로그램 변경요청 사항을 이메일로  발송한다.(메일연동솔루션 활용)
	    	SndngMailVO sndngMailVO = new SndngMailVO();
	    	sndngMailVO.setDsptchPerson(user.getId());
	    	sndngMailVO.setRecptnPerson(vo.getTmp_Email());
	    	sndngMailVO.setSj("프로그램변경요청  처리.");
	    	sndngMailVO.setEmailCn("프로그램 변경요청 사항이  "+sTemp+"(으)로 처리 되었습니다.");
	    	sndngMailVO.setAtchFileId(""); 
	    	result = sndngMailRegistService.insertSndngMail(sndngMailVO); 
	        sLocationUrl = "forward:/sym/mpm/EgovProgramChangeRequstProcessListSelect.do";
    	}else{
    		model.addAttribute("resultMsg", "수정이 실패하였습니다. 변경요청처리 수정은 변경처리해당 담당자만 처리가능합니다.");
            progrmManageDtlVO.setTmp_progrmNm(progrmManageDtlVO.getProgrmFileNm());    	
            progrmManageDtlVO.setTmp_rqesterNo(progrmManageDtlVO.getRqesterNo());   
			sLocationUrl = "forward:/sym/mpm/EgovProgramChangRequstProcessDetailSelect.do";
    	}
		return sLocationUrl; 
    }     

    /**
     * 프로그램변경요청처리를 삭제 한다. 
     * @param progrmManageDtlVO  ProgrmManageDtlVO
     * @return 출력페이지정보 "forward:/sym/mpm/EgovProgramChangeRequstProcessListSelect.do" 
     * @exception Exception
     */
    /*프로그램변경요청처리 삭제*/
    @RequestMapping(value="/sym/mpm/EgovProgramChangRequstProcessDelete.do")
    public String deleteProgrmChangRequstProcess(
    		@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
    		ModelMap model)
            throws Exception {
         // 0. Spring Security 사용자권한 처리
    	 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	 if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	 }
         progrmManageService.deleteProgrmChangeRequst(progrmManageDtlVO);

         return "forward:/sym/mpm/EgovProgramChangeRequstProcessListSelect.do";
    }
    
    /**
     * 프로그램변경이력리스트를 조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mpm/EgovProgramChgHst"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChgHstListSelect.do")
    public String selectProgrmChgHstList(
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
     	
         List list_changerequst = progrmManageService.selectProgrmChangeRequstList(searchVO);
         model.addAttribute("list_changerequst", list_changerequst);

         int totCnt = progrmManageService.selectProgrmChangeRequstListTotCnt(searchVO);
  		 paginationInfo.setTotalRecordCount(totCnt);
         model.addAttribute("paginationInfo", paginationInfo);
         
         return "sym/mpm/EgovProgramChgHst";
    } 

    /*프로그램변경이력상세조회*/ 
    /**
     * 프로그램변경이력을 상세조회한다. 
     * @param progrmManageDtlVO ProgrmManageDtlVO
     * @return 출력페이지정보 "sym/mpm/EgovProgramChgHstDetail"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramChgHstListDetailSelect.do")
    public String selectProgramChgHstListDetail(
    		@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO,
    		ModelMap model)
            throws Exception {
         // 0. Spring Security 사용자권한 처리
    	 Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	 if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	 }
         String _FileNm = progrmManageDtlVO.getTmp_progrmNm();    	
         progrmManageDtlVO.setProgrmFileNm(_FileNm);
         int _tmp_no = progrmManageDtlVO.getTmp_rqesterNo();    	
         progrmManageDtlVO.setRqesterNo(_tmp_no);

         ProgrmManageDtlVO resultVO = progrmManageService.selectProgrmChangeRequst(progrmManageDtlVO);
         model.addAttribute("resultVO", resultVO);
         return "sym/mpm/EgovProgramChgHstDetail";
    }

    /**
     * 프로그램파일명을 조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "sym/mpm/EgovFileNmSearch"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mpm/EgovProgramListSearch.do")
    public String selectProgrmListSearch(
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
		
        List list_progrmmanage = progrmManageService.selectProgrmList(searchVO);
        model.addAttribute("list_progrmmanage", list_progrmmanage);

        int totCnt = progrmManageService.selectProgrmListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
      	return "sym/mpm/EgovFileNmSearch";

    }
    
}