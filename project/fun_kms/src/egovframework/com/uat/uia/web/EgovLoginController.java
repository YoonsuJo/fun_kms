package egovframework.com.uat.uia.web;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.uat.uia.service.EgovLoginPolicyService;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uat.uia.service.LoginPolicyVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;

import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.com.cmm.service.Globals;

import java.net.*;

/*
import com.gpki.servlet.GPKIHttpServletRequest;
import com.gpki.servlet.GPKIHttpServletResponse;
import com.gpki.io.GPKIJspWriter;
import com.gpki.secureweb.GPKIKeyInfo;
import com.dsjdf.jdf.*;

import com.gpki.gpkiapi.GpkiApi;
import com.gpki.gpkiapi.cert.X509Certificate;
import com.gpki.gpkiapi.cms.SignedData;
import com.gpki.gpkiapi.crypto.PrivateKey;
import com.gpki.gpkiapi.crypto.Random;
import com.gpki.gpkiapi.storage.*;
import com.gpki.gpkiapi.util.*;
import com.gpki.gpkiapi.exception.GpkiApiException;
*/

/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
@Controller
public class EgovLoginController {

    /** EgovLoginService */
	@Resource(name = "loginService")
    private EgovLoginService loginService;
	
	/** EgovCmmUseService */
	@Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

    /** EgovMenuManageService */
	//@Resource(name = "meunManageService")
    //private EgovMenuManageService menuManageService;
	
	/** EgovLoginPolicyService */
	@Resource(name="egovLoginPolicyService")
	EgovLoginPolicyService egovLoginPolicyService;
	
	/** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
	/** log */
    protected static final Log LOG = LogFactory.getLog(EgovLoginController.class);
    
	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/egovLoginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {
    	/*
		GPKIHttpServletResponse gpkiresponse = null;
	    GPKIHttpServletRequest gpkirequest = null;
	    
	    try{
	    
	    	gpkiresponse=new GPKIHttpServletResponse(response); 
		    gpkirequest= new GPKIHttpServletRequest(request);
	        gpkiresponse.setRequest(gpkirequest);
	        model.addAttribute("challenge", gpkiresponse.getChallenge());
	        return "cmm/uat/uia/EgovLoginUsr";
	        
	    }catch(Exception e){
	        return "cmm/egovError";
	    }
	    */
    	return "cmm/uat/uia/EgovLoginUsr";
	}
    @RequestMapping(value="/test.do")
    public String test(@ModelAttribute("loginVO") LoginVO loginVO,
    		HttpServletRequest request,
    		HttpServletResponse response,
    		ModelMap model) 
    throws Exception {
    	
    	request.setAttribute("imgUrl", request.getRequestURI() + "\\images");
    	
    	return "test/index";
    }
	
    /**
	 * 일반 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionLogin.do")
    public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, 
    		                   HttpServletRequest request,
    		                   ModelMap model)
            throws Exception {
    	
    	// 접속IP
    	String userIp = EgovClntInfo.getClntIP(request);


    	// 1. 일반 로그인 처리
        LoginVO resultVO = loginService.actionLogin(loginVO);

        boolean loginPolicyYn = true;
        
        LoginPolicyVO loginPolicyVO = new LoginPolicyVO();        
		loginPolicyVO.setEmplyrId(resultVO.getId());
		loginPolicyVO = egovLoginPolicyService.selectLoginPolicy(loginPolicyVO);

		if (loginPolicyVO == null) {
		    loginPolicyYn = true;
		} else {
		    if (loginPolicyVO.getLmttAt().equals("Y")) {
			if (!userIp.equals(loginPolicyVO.getIpInfo())) {
			    loginPolicyYn = false;
			}
		    }
		}
		
        if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") && loginPolicyYn) {

            // 2. spring security 연동
            return "redirect:/j_spring_security_check?j_username=" + resultVO.getUserSe() + resultVO.getId() + "&j_password=" + resultVO.getUniqId();
    		
        } else {
        	
        	model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
        }
    }    
    
    /**
	 * 로그인 후 메인화면으로 들어간다
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionMain.do")
	public String actionMain(ModelMap model) 
			throws Exception {
    	
    	// 1. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/EgovLoginUsr";
    	}
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    		
    	/*
    	// 2. 메뉴조회
		MenuManageVO menuManageVO = new MenuManageVO();
    	menuManageVO.setTmp_Id(user.getId());
    	menuManageVO.setTmp_UserSe(user.getUserSe());
    	menuManageVO.setTmp_Name(user.getName());
    	menuManageVO.setTmp_Email(user.getEmail());
    	menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
    	menuManageVO.setTmp_UniqId(user.getUniqId());
    	List list_headmenu = menuManageService.selectMainMenuHead(menuManageVO);
		model.addAttribute("list_headmenu", list_headmenu);
    	*/
    	
		// 3. 메인 페이지 이동
		String main_page = Globals.MAIN_PAGE;
		//main_page = "EgovMainView";
		LOG.debug("Globals.MAIN_PAGE > " +  Globals.MAIN_PAGE);
		LOG.debug("main_page > " +  main_page);
		LOG.debug("main_page > " +  main_page);
		LOG.debug("main_page > " +  main_page);
		LOG.debug("main_page > " +  main_page);
		LOG.debug("main_page > " +  main_page);
		LOG.debug("main_page > " +  main_page);
		LOG.debug("main_page > " +  main_page);
		LOG.debug("main_page > " +  main_page);
		
		
		if (main_page.startsWith("/")) {
		    return "forward:" + main_page;
		} else {
		    return main_page;
		}
		
		/*
		if (main_page != null && !main_page.equals("")) {
			
			// 3-1. 설정된 메인화면이 있는 경우
			return main_page;
			
		} else {
			
			// 3-2. 설정된 메인화면이 없는 경우
			if (user.getUserSe().equals("USR")) {
	    		return "EgovMainView";
	    	} else {
	    		return "EgovMainViewG";
	    	}
		}
		*/
	}
    
    /**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) 
			throws Exception {
    	
    	String userIp = EgovClntInfo.getClntIP(request);
    	
    	// 1. Security 연동
    	return "redirect:/j_spring_security_logout";
    }
    
    /**
	 * 아이디/비밀번호 찾기 화면으로 들어간다
	 * @param 
	 * @return 아이디/비밀번호 찾기 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovIdPasswordSearch.do")
	public String idPasswordSearchView(ModelMap model) 
			throws Exception {
		
		// 1. 비밀번호 힌트 공통코드 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM022");
		List code = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("pwhtCdList", code);
		
		return "cmm/uat/uia/EgovIdPasswordSearch";
	}
	
    /**
	 * 아이디를 찾는다.
	 * @param vo - 이름, 이메일주소, 사용자구분이 담긴 LoginVO
	 * @return result - 아이디
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/searchId.do")
    public String searchId(@ModelAttribute("loginVO") LoginVO loginVO, 
    		ModelMap model)
            throws Exception {
    	
    	if (loginVO == null || loginVO.getName() == null || loginVO.getName().equals("")
    		&& loginVO.getEmail() == null || loginVO.getEmail().equals("")
    		&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")
    	) {
    		return "cmm/egovError";
    	}
    	
    	// 1. 아이디 찾기
        LoginVO resultVO = loginService.searchId(loginVO);
        
        if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
        	
        	model.addAttribute("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
        	return "cmm/uat/uia/EgovIdPasswordResult";
        } else {
        	model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.idsearch"));
        	return "cmm/uat/uia/EgovIdPasswordResult";
        }
    }
    
    /**
	 * 비밀번호를 찾는다.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */
    @RequestMapping(value="/uat/uia/searchPassword.do")
    public String searchPassword(@ModelAttribute("loginVO") LoginVO loginVO, 
    		ModelMap model)
            throws Exception {
    	
    	if (loginVO == null || loginVO.getId() == null || loginVO.getId().equals("")
    		&& loginVO.getName() == null || loginVO.getName().equals("")
    		&& loginVO.getEmail() == null || loginVO.getEmail().equals("")
    		&& loginVO.getPasswordHint() == null || loginVO.getPasswordHint().equals("")
    		&& loginVO.getPasswordCnsr() == null || loginVO.getPasswordCnsr().equals("")
    		&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")
    	) {
    		return "cmm/egovError";
    	}
    	
    	// 1. 비밀번호 찾기
        boolean result = loginService.searchPassword(loginVO);
        
        // 2. 결과 리턴
        if (result) {
        	model.addAttribute("resultInfo", "임시 비밀번호를 발송하였습니다.");
        	return "cmm/uat/uia/EgovIdPasswordResult";
        } else {
        	model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.pwsearch"));
        	return "cmm/uat/uia/EgovIdPasswordResult";
        }
    }
    
}