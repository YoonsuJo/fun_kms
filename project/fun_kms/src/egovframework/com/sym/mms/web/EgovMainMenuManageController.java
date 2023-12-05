package egovframework.com.sym.mms.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo; 

import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.mpm.service.EgovProgrmManageService;
import egovframework.com.sym.mpm.service.MenuManageVO;
import egovframework.com.sym.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mpm.service.ProgrmManageVO;
import egovframework.com.cmm.ComDefaultVO;

import egovframework.com.uat.uia.service.LoginVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/** 
 * 메인메뉴 해당링크 처리를 하는 비즈니스 구현 클래스
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
public class EgovMainMenuManageController {

	protected Log log = LogFactory.getLog(this.getClass());

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

    /** EgovFileMngService */
	//@Resource(name="EgovFileMngService")
	//private EgovFileMngService fileMngService;	
	
    /** EgovFileMngUtil */
	//@Resource(name="EgovFileMngUtil")
	//private EgovFileMngUtil fileUtil;
	
    /*### 메인작업 ###*/
    /*Main Index 조회*/
    /**
     * Main메뉴의 Index를 조회한다. 
     * @param menuNo  String
     * @param chkURL  String
     * @return 출력페이지정보 "menu_index"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenuIndex.do")
    public String selectMainMenuIndex(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		@RequestParam("menuNo") String menuNo,
    		@RequestParam("chkURL") String chkURL,
    		ModelMap model)
            throws Exception { 

    	int iMenuNo = Integer.parseInt(menuNo);
    	menuManageVO.setMenuNo(iMenuNo);
    	//menuManageVO.setTempValue(chkURL);
        model.addAttribute("resultVO", menuManageVO);
        
        return "menu_index";  
    }
    
    /**
     * Head메뉴를 조회한다. 
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "main_headG", "main_head"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenu.do")
    public String selectMainMenu(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception { 
    	
    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
    	menuManageVO.setTmp_Id(user.getId());
    	menuManageVO.setTmp_Password(user.getPassword());
    	menuManageVO.setTmp_UserSe(user.getUserSe());
    	menuManageVO.setTmp_Name(user.getName());
    	menuManageVO.setTmp_Email(user.getEmail());
    	menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
    	menuManageVO.setTmp_UniqId(user.getUniqId());

    	List list_headmenu = menuManageService.selectMainMenuHead(menuManageVO);
        model.addAttribute("list_headmenu", list_headmenu);
		if (!user.getId().equals("")) {
        	// 메인 페이지 이동
			// G일반 / E기업 / U업무
			if (user.getUserSe().equals("USR")) {
	    		return "EgovMainView";
	    	} else {
	    		return "EgovMainViewG";
        	}
        } else {
        	// 오류 페이지 이동
        	return "cmm/egovError";
        }
    }

    /**
     * Head메뉴를 조회한다. 
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "main_headG", "main_head"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenuHead.do")
    public String selectMainMenuHead(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception { 
    	
    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
    	menuManageVO.setTmp_Id(user.getId());
    	menuManageVO.setTmp_Password(user.getPassword());
    	menuManageVO.setTmp_UserSe(user.getUserSe());
    	menuManageVO.setTmp_Name(user.getName());
    	menuManageVO.setTmp_Email(user.getEmail());
    	menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
    	menuManageVO.setTmp_UniqId(user.getUniqId());

    	List list_headmenu = menuManageService.selectMainMenuHead(menuManageVO);
        model.addAttribute("list_headmenu", list_headmenu);
		if (!user.getId().equals("")) {
        	// 메인 페이지 이동
			// G일반 / E기업 / U업무
			if (user.getUserSe().equals("USR")) {
        		return "main_head"; //"EgovMainViewG"; 일반사용자
        	} else {
        		return "main_headG"; 
        	}
        } else {
        	// 오류 페이지 이동
        	return "cmm/egovError";
        }
    }
    
    
    /**
     * 좌측메뉴를 조회한다. 
     * @param menuManageVO MenuManageVO
     * @param vStartP      String
     * @return 출력페이지정보 "main_left"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenuLeft.do")
    public String selectMainMenuLeft(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		@RequestParam("vStartP") String vStartP,
    		ModelMap model)
            throws Exception { 
    	int iMenuNo = Integer.parseInt(vStartP);
    	menuManageVO.setTempInt(iMenuNo);
        model.addAttribute("resultVO", menuManageVO);

    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
    	menuManageVO.setTmp_Id(user.getId());
    	menuManageVO.setTmp_Password(user.getPassword());
    	menuManageVO.setTmp_UserSe(user.getUserSe());
    	menuManageVO.setTmp_Name(user.getName());
    	menuManageVO.setTmp_Email(user.getEmail());
    	menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
    	menuManageVO.setTmp_UniqId(user.getUniqId());
    	
    	List list_menulist = menuManageService.selectMainMenuLeft(menuManageVO);
        model.addAttribute("list_menulist", list_menulist);
      	return "/main_left"; 
    }

    /**
     * 우측화면을 조회한다. 
     * @param menuManageVO MenuManageVO
     * @param vStartP      String
     * @return 출력페이지정보 해당URL
     * @exception Exception
     */
    /*Right Menu 조회*/
    @RequestMapping(value="/sym/mms/EgovMainMenuRight.do")
    public String selectMainMenuRight(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		@RequestParam("vStartP") String vStartP,
    		ModelMap model)
            throws Exception { 
    	int iMenuNo = Integer.parseInt(vStartP);
    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

    	String forwardURL = null;
    	forwardURL = menuManageService.selectLastMenuURL(iMenuNo, user.getUniqId());
      	return "forward:"+forwardURL; 
    }

    /**
     * HOME 메인화면 조회한다. 
     * @param menuManageVO  MenuManageVO
     * @return 출력페이지정보 "EgovMainView","EgovMainViewG"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenuHome.do")
    public String selectMainMenuHome(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception { 

    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
    	menuManageVO.setTmp_Id(user.getId());
    	menuManageVO.setTmp_Password(user.getPassword());
    	menuManageVO.setTmp_UserSe(user.getUserSe());
    	menuManageVO.setTmp_Name(user.getName());
    	menuManageVO.setTmp_Email(user.getEmail());
    	menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
    	menuManageVO.setTmp_UniqId(user.getUniqId());
    	
		List list_headmenu = menuManageService.selectMainMenuHead(menuManageVO);
		model.addAttribute("list_headmenu", list_headmenu);
		
		log.debug("## selectMainMenuHome ## getSUserSe 1: "+user.getUserSe());
		log.debug("## selectMainMenuHome ## getSUserId 2: "+user.getId());
		log.debug("## selectMainMenuHome ## getUniqId  2: "+user.getUniqId());
		
		if (!user.getId().equals("")) {
        	// 메인 페이지 이동
			// G일반 / E기업 / U업무
        	if (user.getUserSe().equals("G")) {
        		return "EgovMainViewG"; //"EgovMainViewG"; 일반사용자
        		
        	}else if(user.getUserSe().equals("U")){
        		//return "EgovIndvdlpgeDetail";
        		return "EgovMainView";
        	}
        	else {
        		//return "EgovMainView";//1차 사업 메인화면 
        		return "EgovMainView2";//2차 사업 메인화면
        	}
        } else {
        	// 오류 페이지 이동
        	return "cmm/egovError";
        }
    }
}