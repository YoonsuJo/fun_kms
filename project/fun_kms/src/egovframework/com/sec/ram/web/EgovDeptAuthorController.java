package egovframework.com.sec.ram.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.sec.ram.service.AuthorManageVO;
import egovframework.com.sec.ram.service.DeptAuthorVO;
import egovframework.com.sec.ram.service.EgovAuthorManageService;
import egovframework.com.sec.ram.service.EgovDeptAuthorService;
import egovframework.com.sec.ram.service.DeptAuthor;
import egovframework.com.uat.uia.service.SessionVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 부서권한에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *
 * </pre>
 */

@Controller
@SessionAttributes(types=SessionVO.class)
public class EgovDeptAuthorController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "egovDeptAuthorService")
    private EgovDeptAuthorService egovDeptAuthorService;
    
    @Resource(name = "egovAuthorManageService")
    private EgovAuthorManageService egovAuthorManageService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /**
	 * 권한 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/cmm/sec/ram/EgovDeptAuthorListView.do")
    public String selectDeptAuthorListView() throws Exception {
        return "/cmm/sec/ram/EgovDeptAuthorManage";
    }    

	/**
	 * 부서별 할당된 권한목록 조회
	 * 
	 * @param deptAuthorVO DeptAuthorVO
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/cmm/sec/ram/EgovDeptAuthorList.do")
	public String selectDeptAuthorList(@ModelAttribute("deptAuthorVO") DeptAuthorVO deptAuthorVO,
			                            @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
			                             ModelMap model) throws Exception {

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(deptAuthorVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(deptAuthorVO.getPageUnit());
		paginationInfo.setPageSize(deptAuthorVO.getPageSize());
		
		deptAuthorVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		deptAuthorVO.setLastIndex(paginationInfo.getLastRecordIndex());
		deptAuthorVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		deptAuthorVO.setDeptAuthorList(egovDeptAuthorService.selectDeptAuthorList(deptAuthorVO));
        model.addAttribute("deptAuthorList", deptAuthorVO.getDeptAuthorList());
        
        int totCnt = egovDeptAuthorService.selectDeptAuthorListTotCnt(deptAuthorVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

    	authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
        
        return "/cmm/sec/ram/EgovDeptAuthorManage";
	}
	
	/**
	 * 부서에 권한정보를 할당하여 데이터베이스에 등록
	 * 
	 * @param userIds String
	 * @param authorCodes String
	 * @param regYns String
	 * @param deptAuthor DeptAuthor
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/cmm/sec/ram/EgovDeptAuthorInsert.do")
	public String insertDeptAuthor(@RequestParam("userIds") String userIds,
			                       @RequestParam("authorCodes") String authorCodes,
			                       @RequestParam("regYns") String regYns,
			                       @ModelAttribute("deptAuthor") DeptAuthor deptAuthor,
			                         SessionStatus status,
			                         ModelMap model) throws Exception {
		
    	String [] strUserIds = userIds.split(";");
    	String [] strAuthorCodes = authorCodes.split(";");
    	String [] strRegYns = regYns.split(";");
    	
    	for(int i=0; i<strUserIds.length;i++) {
    		deptAuthor.setUniqId(strUserIds[i]);
    		deptAuthor.setAuthorCode(strAuthorCodes[i]);
    		if(strRegYns[i].equals("N"))
    			egovDeptAuthorService.insertDeptAuthor(deptAuthor);
    		else 
    			egovDeptAuthorService.updateDeptAuthor(deptAuthor);
    	}

        status.setComplete();
        model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));		
		return "forward:/cmm/sec/ram/EgovDeptAuthorList.do";
	}

	/**
	 * 부서별 할당된 시스템 메뉴 접근권한을 삭제
	 * @param userIds String
	 * @param deptAuthor DeptAuthor
	 * @return String
	 * @exception Exception
	 */ 
	@RequestMapping(value="/cmm/sec/ram/EgovDeptAuthorDelete.do")
	public String deleteDeptAuthor (@RequestParam("userIds") String userIds,
			                        @ModelAttribute("deptAuthor") DeptAuthor deptAuthor,
                                     SessionStatus status,
                                     ModelMap model) throws Exception {
		
    	String [] strUserIds = userIds.split(";");
    	for(int i=0; i<strUserIds.length;i++) {
    		deptAuthor.setUniqId(strUserIds[i]);
    		egovDeptAuthorService.deleteDeptAuthor(deptAuthor);
    	}
    	
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/cmm/sec/ram/EgovDeptAuthorList.do";
	}
	
    /**
	 * 부서조회 팝업 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/cmm/sec/ram/EgovDeptSearchView.do")
    public String selectDeptListView() throws Exception {
        return "/cmm/sec/ram/EgovDeptSearch";
    }    	
	
	/**
	 * 부서별 할당된 권한목록 조회
	 * @param deptAuthorVO DeptAuthorVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/cmm/sec/ram/EgovDeptSearchList.do")
	public String selectDeptList(@ModelAttribute("deptAuthorVO") DeptAuthorVO deptAuthorVO,
			                             ModelMap model) throws Exception {

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(deptAuthorVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(deptAuthorVO.getPageUnit());
		paginationInfo.setPageSize(deptAuthorVO.getPageSize());
		
		deptAuthorVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		deptAuthorVO.setLastIndex(paginationInfo.getLastRecordIndex());
		deptAuthorVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		deptAuthorVO.setDeptList(egovDeptAuthorService.selectDeptList(deptAuthorVO));
        model.addAttribute("deptList", deptAuthorVO.getDeptList());
        
        int totCnt = egovDeptAuthorService.selectDeptListTotCnt(deptAuthorVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
        
        return "/cmm/sec/ram/EgovDeptSearch";
	}
}