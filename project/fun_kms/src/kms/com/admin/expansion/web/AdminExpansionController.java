package kms.com.admin.expansion.web;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kms.com.common.service.*;
import kms.com.common.utils.CommonUtil;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

@Controller
public class AdminExpansionController {

	@Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsExpansionService")
    private ExpansionService expService;
    
    @Resource(name = "KmsFileMngUtil")
    private FileMngUtil fileUtil;

    @Resource(name = "KmsFileMngService")
    private FileMngService fileMngService;
    
    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());
    
    
    @RequestMapping("/admin/expansion/selectExpansionList.do")
    public String selectExpansionList(@ModelAttribute("searchVO") ExpansionVO expVO, ModelMap model) throws Exception {
    	
		expVO.setPageUnit(propertyService.getInt("pageUnit"));
		expVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(expVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(expVO.getPageUnit());
		paginationInfo.setPageSize(expVO.getPageSize());
	
		expVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		expVO.setLastIndex(paginationInfo.getLastRecordIndex());
		expVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<ExpansionVO> expList = expService.selectExpansionList(expVO);
		int totCnt = expService.selectExpansionListTotCnt(expVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", expList);
		model.addAttribute("paginationInfo", paginationInfo);

    	return "admin/expansion/expansionL";
    }
    
    @RequestMapping("/admin/expansion/insertExpansionView.do")
    public String insertBannerView(@ModelAttribute("searchVO") ExpansionVO expVO, ModelMap model) throws Exception {
    	
    	return "admin/expansion/expansionW";
    }
    
    @RequestMapping("/admin/expansion/insertExpansion.do")
    public String insertBanner(final MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") ExpansionVO expVO, Expansion exp, ModelMap model) throws Exception {
    	
    	//if ("L".equals(exp.getAccess())) {
    		exp.setAccessUserList(CommonUtil.makeValidIdList(exp.getAccessUser()));
    	//}
    	
    	String expFileId = "";
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
	    	List<FileVO> result = fileUtil.parseFileInf(files, "EXP_", 0, "", "");
	    	expFileId = fileMngService.insertFileInfs(result);
	    }
	    exp.setExpFileId(expFileId);
	    
	    exp.setExpCn(CommonUtil.unscript(exp.getExpCn()));
	    
    	expService.insertExpansion(exp);
    	
    	return "redirect:/admin/expansion/selectExpansionList.do";
    }

    @RequestMapping("/admin/expansion/updtExpansionView.do")
    public String updtExpansionView(@ModelAttribute("searchVO") ExpansionVO expVO, ModelMap model) throws Exception {
    	
    	ExpansionVO result = expService.selectExpansion(expVO);
    	
    	model.addAttribute("result", result);
    	
    	return "admin/expansion/expansionM";
    }
    @RequestMapping("/admin/expansion/updtExpansion.do")
    public String updtExpansion(final MultipartHttpServletRequest multiRequest,
    		@ModelAttribute("searchVO") ExpansionVO expVO, Expansion exp, ModelMap model) throws Exception {

    	//if ("L".equals(exp.getAccess())) {
    		exp.setAccessUserList(CommonUtil.makeValidIdList(exp.getAccessUser()));
    	//}
    	
    	String expFileId = exp.getExpFileId();
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
			if ("".equals(expFileId)) {
			    List<FileVO> result = fileUtil.parseFileInf(files, "EXP_", 0, expFileId, "");
			    expFileId = fileMngService.insertFileInfs(result);
			    exp.setExpFileId(expFileId);
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(expFileId);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "EXP_", cnt, expFileId, "");
			    fileMngService.updateFileInfs(_result);
			}
	    }
	    
	    exp.setExpCn(CommonUtil.unscript(exp.getExpCn()));
	    
	    expService.updateExpansion(exp);

    	return "redirect:/admin/expansion/selectExpansionList.do";
    }
    
    
    @RequestMapping("/admin/expansion/ajaxOrderUpdate.do")
    public void ajaxOrderUpdate(@ModelAttribute("searchVO") ExpansionVO expVO,
    		String orderResult,HttpServletResponse response, Model model) throws Exception {
        
        String orderResultDecode = URLDecoder.decode(orderResult, "UTF-8");
        JSONObject orderResultJ=  (JSONObject)JSONValue.parseWithException(orderResultDecode);
        
        int idx = 0;
        while(!orderResultJ.isEmpty())
        {
        	String expId = (String)orderResultJ.get(Integer.toString(idx));
        	if(expId == null)
        	{
        		
        	}
        	else
        	{
        		expVO.setExpId(expId);
        		expVO.setSort(idx);
        		orderResultJ.remove(Integer.toString(idx));
        		expService.updateExpansionSort(expVO);
        	}
        	idx ++;
        }
        /*response.
        response.flushBuffer();*/
    }
    
}
