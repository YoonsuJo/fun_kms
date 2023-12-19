package kms.com.admin.approval.web;

import egovframework.rte.fdl.property.EgovPropertyService;
import kms.com.admin.approval.service.KmsApprovalTyp;
import kms.com.admin.approval.service.KmsApprovalTypService;
import kms.com.admin.approval.service.KmsApprovalTypVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @Class Name : KmsApprovalTypController.java
 * @Description : KmsApprovalTypController class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class AdminApprovalTypController {

    @Resource(name = "kmsApprovalTypService")
    private KmsApprovalTypService kmsApprovalTypService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
    
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	
    /**
	 * KMS_EAPP_DOCTYP 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 KmsEappDoctypDefaultVO
	 * @return "/kmsEappDoctyp/KmsEappDoctypList"
	 * @exception Exception
	 */
    @RequestMapping(value="/admin/approval/approvalL.do")
    public String selectKmsEappDoctypList(@ModelAttribute("searchVO") KmsApprovalTypVO searchVO, 
    		ModelMap model)
            throws Exception {
    	
		
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(1000);
		searchVO.setUseYn(0);//0으로 설정시 전체 검색.
        List kmsEappDoctypList = kmsApprovalTypService.selectKmsEappDoctypList(searchVO);
        model.addAttribute("resultList", kmsEappDoctypList);
        
        int totCnt = kmsApprovalTypService.selectKmsEappDoctypListTotCnt(searchVO);
        
        return "admin/approval/approvalL";
    } 
    
    
    @RequestMapping("/admin/approval/approvalW.do")
    public String addKmsEappDoctypView(
            @ModelAttribute("searchVO") KmsApprovalTypVO searchVO, Model model)
            throws Exception {
        model.addAttribute("result", new KmsApprovalTyp());
        model.addAttribute("code", "W");

        return "admin/approval/approvalW";
    }
    
    @RequestMapping("/admin/approval/approvalM.do")
    public String modifyKmsEappDoctypView(
            @ModelAttribute("searchVO") KmsApprovalTypVO searchVO
            , Model model)
            throws Exception {
        
        // 변수명은 CoC 에 따라 kmsEappDoctypVO
        model.addAttribute("result", kmsApprovalTypService.selectKmsEappDoctyp(searchVO));
        model.addAttribute("code", "M");
        return "admin/approval/approvalW";
    }
        
    @RequestMapping("/admin/approval/approvalI.do")    
    public String addKmsEappDoctyp
    (final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("KmsApprovalTyp") KmsApprovalTyp kmsEappDoctypVO ,
			HttpServletRequest request,
			HttpServletResponse response, ModelMap model
			)
            throws Exception {
    	List<FileVO> result = null;
		String atchFileId = "";
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "APPT_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		kmsEappDoctypVO.setDocIcon(atchFileId);
		if(kmsEappDoctypVO.getDeciderRule4()==null || kmsEappDoctypVO.getDeciderRule4().equals(""))
				kmsEappDoctypVO.setDeciderRule4("0");
        Integer templtId = kmsApprovalTypService.insertKmsEappDoctyp(kmsEappDoctypVO);
        return "redirect:/admin/approval/approvalV.do?templtId=" + templtId;
    }

    @RequestMapping("/admin/approval/approvalU.do")
    public String updateKmsEappDoctyp(MultipartHttpServletRequest multiRequest,
            @ModelAttribute("searchVO") KmsApprovalTypVO searchVO, SessionStatus status)
            throws Exception {

    	String docIcon = searchVO.getDocIcon();
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
	    	if ("".equals(docIcon)) {
			    List<FileVO> result = fileUtil.parseFileInf(files, "APPT_", 0, docIcon, "");
			    docIcon = fileMngService.insertFileInfs(result);
			    searchVO.setDocIcon(docIcon);
			} else {
			    FileVO fvo = new FileVO();
			    fvo.setAtchFileId(docIcon);
			    int cnt = fileMngService.getMaxFileSN(fvo);
			    List<FileVO> _result = fileUtil.parseFileInf(files, "APPT_", cnt, docIcon, "");
			    fileMngService.updateFileInfs(_result);
			}
	    }

        kmsApprovalTypService.updateKmsEappDoctyp(searchVO);
        return "redirect:/admin/approval/approvalV.do?templtId=" + searchVO.getTempltId() ;
    }

    @RequestMapping("/admin/approval/approvalV.do")
    public String updateKmsEappDoctypView(
            @ModelAttribute("searchVO") KmsApprovalTypVO searchVO
            , Model model)
            throws Exception {

        // 변수명은 CoC 에 따라 kmsEappDoctypVO
        model.addAttribute("result", kmsApprovalTypService.selectKmsEappDoctyp(searchVO));

        return "admin/approval/approvalV";
    }

    @RequestMapping("/kmsEappDoctyp/deleteKmsEappDoctyp.do")
    public String deleteKmsEappDoctyp(
            KmsApprovalTyp kmsEappDoctypVO,
            @ModelAttribute("searchVO") KmsApprovalTypVO searchVO, SessionStatus status)
            throws Exception {
        kmsApprovalTypService.deleteKmsEappDoctyp(kmsEappDoctypVO);
        status.setComplete();
        return "forward:/kmsEappDoctyp/KmsEappDoctypList.do";
    }

    @RequestMapping("/admin/approval/ajaxOrderUpdate.do")
    public void ajaxOrderUpdate(
            @ModelAttribute("searchVO") KmsApprovalTypVO searchVO,
            String orderResult,
            HttpServletResponse response,
             Model model)
            throws Exception {


        String orderResultDecode = URLDecoder.decode(orderResult, "UTF-8");
        JSONObject orderResultJ=  (JSONObject)JSONValue.parseWithException(orderResultDecode);
        Set set = orderResultJ.keySet();
        Iterator it = set.iterator();
        while(it.hasNext())
        {
            Integer templtId = (Integer) it.next();
        	int ord = Integer.parseInt((String) orderResultJ.get(templtId));
    		searchVO.setTempltId(templtId);
    		searchVO.setDocOrd(ord);
    		kmsApprovalTypService.updateKmsEappDoctypOrd(searchVO);
        }
    }
        
    
}
