package kms.com.admin.banner.web;

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
public class AdminBannerController {

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsBannerService")
    private BannerService bannerService;
    
    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;
    
    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());
    
    
    @RequestMapping("/admin/banner/selectBannerList.do")
    public String selectBannerList(@ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model) throws Exception {
    	
		bannerVO.setPageUnit(propertyService.getInt("pageUnit"));
		bannerVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(bannerVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(bannerVO.getPageUnit());
		paginationInfo.setPageSize(bannerVO.getPageSize());
	
		bannerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bannerVO.setLastIndex(paginationInfo.getLastRecordIndex());
		bannerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<BannerVO> bannerList = bannerService.selectAllBannerList(bannerVO);
		int totCnt = bannerService.selectAllBannerListTotCnt(bannerVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", bannerList);
		model.addAttribute("paginationInfo", paginationInfo);

    	return "admin/banner/bannerL";
    }
    @RequestMapping("/admin/banner/insertBannerView.do")
    public String insertBannerView(@ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model) throws Exception {
    	
    	return "admin/banner/pop_bannerW";
    }
    @RequestMapping("/admin/banner/insertBanner.do")
    public String insertBanner(final MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") BannerVO bannerVO, Banner banner, ModelMap model) throws Exception {
    	
    	String bnrFileId = "";
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
	    	List<FileVO> result = fileUtil.parseFileInf(files, "BNR_", 0, "", "");
	    	bnrFileId = fileMngService.insertFileInfs(result);
	    }
	    banner.setBnrFileId(bnrFileId);
	    
	    banner.setBnrCn(CommonUtil.unscript(banner.getBnrCn()));
	    
    	bannerService.insertBanner(banner);
    	
    	return "admin/banner/closePage";
    }

    @RequestMapping("/admin/banner/updtBannerView.do")
    public String updtBannerView(@ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model) throws Exception {
    	
    	BannerVO result = bannerService.selectBanner(bannerVO);
    	
    	model.addAttribute("result", result);
    	
    	return "admin/banner/pop_bannerM";
    }
    @RequestMapping("/admin/banner/updtBanner.do")
    public String updtBanner(final MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") BannerVO bannerVO, Banner banner, ModelMap model) throws Exception {

    	String bnrFileId = banner.getBnrFileId();
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			if ("".equals(bnrFileId)) {
			    List<FileVO> result = fileUtil.parseFileInf(files, "BNR_", 0, bnrFileId, "");
			    bnrFileId = fileMngService.insertFileInfs(result);
			    banner.setBnrFileId(bnrFileId);
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(bnrFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "BNR_", cnt, bnrFileId, "");
			    fileMngService.updateFileInfs(_result);
			}
	    }
	    
	    banner.setBnrCn(CommonUtil.unscript(banner.getBnrCn()));
	    
	    bannerService.updateBanner(banner);
	    
    	return "admin/banner/closePage";
    }
    @RequestMapping("/admin/banner/changeBannerOrder.do")
    public String changeBannerOrder(@ModelAttribute("searchVO") BannerVO bannerVO, ModelMap model) throws Exception {

    	if (bannerVO.getOrdNo() != null && !bannerVO.getOrdNo().equals("")) {
    		int ordNo = Integer.parseInt(bannerVO.getOrdNo());
    		if (bannerVO.getChangeType().equals("increase"))
    			ordNo++;
    		else if (bannerVO.getChangeType().equals("decrease"))
    			ordNo--;
    		bannerVO.setOrdNo("" + ordNo);
    		bannerService.changeBannerOrder(bannerVO);
    	}
	    
    	return "redirect:/admin/banner/selectBannerList.do";
    }
    
    
    
    
    
    
    
    
    
    
}
