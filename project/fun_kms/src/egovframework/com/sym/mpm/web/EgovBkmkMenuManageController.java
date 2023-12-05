package egovframework.com.sym.mpm.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.com.sym.mpm.service.BkmkMenuManage;
import egovframework.com.sym.mpm.service.BkmkMenuManageVO;
import egovframework.com.sym.mpm.service.EgovBkmkMenuManageservice;
import egovframework.com.sym.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mpm.service.MenuManage;
import egovframework.com.sym.mpm.service.MenuManageVO;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 바로가기메뉴관리 정보를 관리하기 위한 컨트롤러 클래스
 * @author 공통컴포넌트팀 윤성록
 * @since 2009.09.25
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.9.25  윤성록          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovBkmkMenuManageController {
          
    @Resource(name = "bkmkMenuManageservice")
    private EgovBkmkMenuManageservice bkmkMenuManageService;    

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());          
      
    /**
     * 바로가기메뉴관리 정보에 대한 목록을 조회한다.
     *      
     * @param BkmkMenuManageVO
     * @param status
     * @param model
     * @return
     * @throws Exception
     */    
    @RequestMapping("/sym/mpm/selectBkmkMenuManageList.do")
    public String selectBkmkMenuManageList(@ModelAttribute("searchVO") BkmkMenuManageVO bkmkMenuManageVO, SessionStatus status, ModelMap model) throws Exception {
           
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        
        @SuppressWarnings("unused")
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        if(!isAuthenticated) {
            return "cmm/uat/uia/EgovLoginUsr";
        } 

        bkmkMenuManageVO.setPageUnit(propertyService.getInt("pageUnit"));
        bkmkMenuManageVO.setPageSize(propertyService.getInt("pageSize"));
        bkmkMenuManageVO.setUserId(user.getId());

        PaginationInfo paginationInfo = new PaginationInfo();
            
        paginationInfo.setCurrentPageNo(bkmkMenuManageVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(bkmkMenuManageVO.getPageUnit());
        paginationInfo.setPageSize(bkmkMenuManageVO.getPageSize());        
          
        bkmkMenuManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        bkmkMenuManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
        bkmkMenuManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        bkmkMenuManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        bkmkMenuManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
        bkmkMenuManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
         
        Map<String, Object> map = bkmkMenuManageService.selectBkmkMenuManageList(bkmkMenuManageVO);
            
        int totCnt = Integer.parseInt((String)map.get("resultCnt"));
            
        paginationInfo.setTotalRecordCount(totCnt);
            
        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("resultCnt", map.get("resultCnt"));
        model.addAttribute("uniqId", user.getUniqId());
        model.addAttribute("paginationInfo", paginationInfo);
       
        return "sym/mpm/EgovBkmkMenuManageList";
        
    }
    
    /**
     * 바로가기메뉴관리 정보를 삭제한다.
     *      
     * @param checkMenuIds
     * @param bkmkMenuManageVO
     * @param model
     * @return
     * @throws Exception
     */    
    @RequestMapping("/sym/mpm/EgovBkmkMenuManageDelete.do")
    public String deleteMenuManageList(
            @RequestParam("checkMenuIds") String checkMenuIds ,
            @ModelAttribute("bkmkMenuManageVO") BkmkMenuManageVO bkmkMenuManageVO, 
            ModelMap model)
            throws Exception {        
        
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        
        @SuppressWarnings("unused")
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        if(!isAuthenticated) {
            //    model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
            return "cmm/uat/uia/EgovLoginUsr";
        }
               
        String [] temp = checkMenuIds.split(",");
        
        for(int i =0; i < temp.length; i++){
            BkmkMenuManage bkmk = new BkmkMenuManage();
            bkmk.setMenuId(temp[i]);
            bkmk.setUserId(user.getId());
            bkmkMenuManageService.deleteBkmkMenuManage(bkmk);
        }
                
        return "forward:/sym/mpm/selectBkmkMenuManageList.do";          
    }
    
    /**
     * 바로가기메뉴관리 등록화면으로 이동한다.
     *      
     * @param BkmkMenuManage
     * @param status
     * @param model
     * @return
     * @throws Exception
     */    
    @RequestMapping("/sym/mpm/addBkmkInf.do")
    public String addBkmkMenuManage( @ModelAttribute("bkmkMenuManage") BkmkMenuManage bkmkMenuManage, SessionStatus status, ModelMap model) throws Exception {
               
        if(!bkmkMenuManage.getMenuId().equals("")){          
           
            bkmkMenuManage.setProgrmStrePath(bkmkMenuManageService.selectUrl(bkmkMenuManage));
        }
        
        return "sym/mpm/EgovBkmkMenuManageRegist";
    }   
    
    /**
     * 메뉴정보 목록팝업 화면으로 이동한다.
     *      
     * @param commandMap
     * @param model
     * @return
     * @throws Exception
     */ 
    @RequestMapping("/sym/mpm/openPopup.do")
    public String openPopupWindow(Map<String, Object> commandMap, ModelMap model) throws Exception {
          
        String requestUrl = (String)commandMap.get("requestUrl");
        String width = (String)commandMap.get("width");
        String height = (String)commandMap.get("height");
        model.addAttribute("requestUrl", requestUrl + "?" + "&PopFlag=Y");        
        model.addAttribute("width", width);
        model.addAttribute("height", height);           
       
        return "/sym/mpm/EgovModalPopupFrame";
    }   
    
    /**
     * 메뉴정보 목록을 조회한다.
     *      
     * @param BkmkMenuManageVO
     * @param commandMap
     * @param model
     * @return
     * @throws Exception
     */ 
    @RequestMapping("/sym/mpm/selectMenuList.do") 
    public String selectMenuList(@ModelAttribute("bkmkMenuManageVO") BkmkMenuManageVO bkmkMenuManageVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
        String popFlag = (String)commandMap.get("PopFlag");
             
        
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        
        bkmkMenuManageVO.setPageUnit(propertyService.getInt("pageUnit"));
        bkmkMenuManageVO.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();
      
        paginationInfo.setCurrentPageNo(bkmkMenuManageVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(bkmkMenuManageVO.getPageUnit());
        paginationInfo.setPageSize(bkmkMenuManageVO.getPageSize());

        
        bkmkMenuManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        bkmkMenuManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
        bkmkMenuManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        bkmkMenuManageVO.setUserId(user.getId());
  
        Map<String, Object> map = bkmkMenuManageService.selectMenuList(bkmkMenuManageVO); 
        
        int totCnt = Integer.parseInt((String)map.get("resultCnt"));      
        paginationInfo.setTotalRecordCount(totCnt);

        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("resultCnt", map.get("resultCnt"));
        model.addAttribute("paginationInfo", paginationInfo);
                
        return "/sym/mpm/EgovBkmkMenuPopup";
    }
  
    /**
     * 바로가기메뉴관리 정보를 등록한다.
     *      
     * @param BkmkMenuManage
     * @param bindingResult
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/sym/mpm/registBkmkInf.do") 
    public String registBkmkInf(@ModelAttribute("bkmkMenuManage") BkmkMenuManage bkmkMenuManage, 
            BindingResult bindingResult, SessionStatus status, ModelMap model) throws Exception {
        
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();   
        
        if(!isAuthenticated) {
            return "cmm/uat/uia/EgovLoginUsr";
        } 
        
        beanValidator.validate(bkmkMenuManage, bindingResult);
        if (bindingResult.hasErrors()) {
            return "sym/mpm/EgovBkmkMenuManageRegist";
        }            
     
        bkmkMenuManage.setUserId(user.getId());                    
        if (isAuthenticated) {
            bkmkMenuManageService.insertBkmkMenuManage(bkmkMenuManage);
        }

        return "forward:/sym/mpm/selectBkmkMenuManageList.do";
    }
    
    /**
     * 바로가기메뉴관리 미리보기 화면으로 이동한다.
     *      
     * @param BkmkMenuManageVO
     * @param model
     * @return
     * @throws Exception
     */    
    @RequestMapping(value="/sym/mpm/previewBkmkInf.do")
    public String previewBkmkInf(@ModelAttribute("searchVO") BkmkMenuManageVO bkmkMenuManageVO,ModelMap model)
            throws Exception { 
        String resultMsg    = "";
        // 0. Spring Security 사용자권한 처리
        LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
       
        if(!isAuthenticated) {
               return "cmm/uat/uia/EgovLoginUsr";
        }        
    
        bkmkMenuManageVO.setFirstIndex(0);
        bkmkMenuManageVO.setLastIndex(10);
        bkmkMenuManageVO.setRecordCountPerPage(10);
        
        bkmkMenuManageVO.setUserId(user.getId());

        Map<String, Object> map = bkmkMenuManageService.selectBkmkMenuManageList(bkmkMenuManageVO);
               
        model.addAttribute("list_menulist",  map.get("resultList"));
        model.addAttribute("resultMsg", resultMsg);
        
        return  "sym/mpm/EgovBookMarkMenuPopup"; 
    }
}
