package kms.com.admin.dining.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import kms.com.common.service.Banner;
import kms.com.common.service.BannerService;
import kms.com.common.service.BannerVO;
import kms.com.common.service.Dining;
import kms.com.common.service.DiningService;
import kms.com.common.service.DiningVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CommonUtil;
import kms.com.member.service.MemberVO;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdminDiningController {

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsDiningService")
    private DiningService diningService;
    
    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;
    
    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());
    
    
    @RequestMapping("/admin/dining/selectDiningList.do")
    public String selectDiningList(@ModelAttribute("searchVO") DiningVO diningVO, ModelMap model) throws Exception {
    	
		diningVO.setPageUnit(propertyService.getInt("pageUnit"));
		diningVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(diningVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(diningVO.getPageUnit());
		paginationInfo.setPageSize(diningVO.getPageSize());
	
		diningVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		diningVO.setLastIndex(paginationInfo.getLastRecordIndex());
		diningVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<DiningVO> diningList = diningService.selectAllDiningList(diningVO);
		int totCnt = diningService.selectAllDiningListTotCnt(diningVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", diningList);
		model.addAttribute("paginationInfo", paginationInfo);
    	 
    	return "admin/dining/diningL";
    }
    
    @RequestMapping("/admin/dining/insertDiningView.do")
    public String insertDiningView(@ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model) throws Exception {
    	
    	return "admin/dining/pop_diningW";
    }
    
    @RequestMapping("/admin/dining/updtDiningView.do")
    public String updtBannerView(@ModelAttribute("searchVO") DiningVO diningVO, ModelMap model) throws Exception {
    	
    	DiningVO result = diningService.selectDining(diningVO);
    	
    	model.addAttribute("result", result);
    	
    	return "admin/dining/pop_diningM";
    }
    
    @RequestMapping("/admin/dining/updtDining.do")
    public String updtBanner(final MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") DiningVO diningVO, Dining dining, ModelMap model) throws Exception {

    	diningService.updateDining(dining);
	    
    	return "admin/dining/closePage";
    }
    
    @RequestMapping("/admin/dining/insertDining.do")
    public String insertDining(final MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") DiningVO diningVO, Dining dining, ModelMap model) throws Exception {
    	
    	//banner.setBnrCn(CommonUtil.unscript(banner.getBnrCn()));
	    
    	diningService.insertDining(dining);
    	
    	return "admin/dining/closePage";
    }
    
}
