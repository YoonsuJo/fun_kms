package egovframework.com.uss.umt.web;

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

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo; 

import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.uss.umt.service.EgovSiteMapngService;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.uss.umt.service.SiteMapngVO;
import egovframework.com.uat.uia.service.LoginVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/** 
 * 사이트맵 조회 처리를 하는 비즈니스 구현 클래스
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
public class EgovSiteMapngController {

	protected Log log = LogFactory.getLog(this.getClass());

	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** EgovSiteMapngService */
	@Resource(name = "siteMapngService")
    private EgovSiteMapngService siteMapngService;

	/*사이트맵조회*/
    /**
     * 사이트맵 화면을 조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "uss/umt/EgovSiteMapng"
     * @exception Exception
     */
    @RequestMapping(value="/uss/umt/EgovSiteMapng.action")
    public String selectSiteMapng(
    		@ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception {
    	LoginVO user = 
			(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	searchVO.setSearchKeyword(user.getUniqId());
    	SiteMapngVO  resultVO = siteMapngService.selectSiteMapng(searchVO);
    	log.debug(resultVO.getBndeFileNm());
        model.addAttribute("resultVO", resultVO);

        return "/uss/umt/EgovSiteMapng";
    }
}