package kms.com.common.web;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileVO;
import kms.com.common.utils.SessionUtil;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.25  이삼섭          최초 생성
 *
 * </pre>
 */
@Controller
public class FileMngController {

    @Resource(name = "KmsFileMngService")
    private FileMngService fileService;

    Logger log = Logger.getLogger(this.getClass());

    /**
     * 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectFileInfs.do") 
    public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		String atchFileId = (String)commandMap.get("param_atchFileId");
		String isComment = (String)commandMap.get("param_isComment");
	
		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);
	
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		model.addAttribute("isComment", isComment);
		
		return "common/FileList";
    }

    /**
     * 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectFileInfsForMobile.do") 
    public String selectFileInfsForMobile(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
		String atchFileId = (String)commandMap.get("param_atchFileId");
		String isComment = (String)commandMap.get("param_isComment");
	
		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectFileInfs(fileVO);
	
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		model.addAttribute("isComment", isComment);
		
		return "common/FileListMobile";
    }
    
    /**
     * 첨부파일 변경을 위한 수정페이지로 이동한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectFileInfsForUpdate.do")
    public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

		String atchFileId = (String)commandMap.get("param_atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
	
		List<FileVO> result = fileService.selectFileInfs(fileVO);
		
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		
		return "common/FileList";
    }
    
    /**
     * 첨부파일 변경을 위한 수정페이지로 이동한다. 2개의 파일첨부폼일 경우
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectFileInfsForUpdate2.do")
    public String selectFileInfsForUpdate2(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

		String atchFileId = (String)commandMap.get("param_atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
	
		List<FileVO> result = fileService.selectFileInfs(fileVO);
		
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		
		return "common/FileList3";
    }
    
    /**
     * 첨부파일 변경을 위한 수정페이지로 이동한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectFileInfsForUpdateRequest.do")
    public String selectFileInfsForUpdateRequest(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

		String atchFileId = (String)commandMap.get("param_atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
	
		List<FileVO> result = fileService.selectFileInfs(fileVO);
		
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		
		return "common/FileListRequest";
    }    
    
    
    
    /**
     * 첨부파일을 포함한 문서 재기안관련 첨부파일 수정 페이지로 이동한다
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectFileInfsForReWrite.do")
    public String selectFileInfsForReWrite(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

		String atchFileId = (String)commandMap.get("param_atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
	
		List<FileVO> result = fileService.selectFileInfs(fileVO);
		
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		
		return "common/FileList2";
    }
    
    

    /**
     * 첨부파일에 대한 삭제를 처리한다.
     * 
     * @param fileVO
     * @param returnUrl
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/deleteFileInfs.do")
    public String deleteFileInf(HttpServletRequest req, ModelMap model, @ModelAttribute("searchVO") FileVO fileVO, 
    		HttpServletRequest request) throws Exception {
    	
    //public String deleteFileInf(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam("returnUrl") String returnUrl,
	    //HttpServletRequest request, ModelMap model) throws Exception {

    	System.out.println("deleteFileInfs.do  " + fileVO.getAtchFileId() + ",  " + fileVO.getFileSn());
		Boolean isAuthenticated = SessionUtil.isLogin(request);
		if (isAuthenticated) {			
		    fileService.deleteFileInf(fileVO);
		}	
		
		// 업무연락 댓글 파일 삭제용
		if (request.getParameter("commentNo") != null && request.getParameter("commentNo").equals("") == false) {
			model.addAttribute("commentNo", request.getParameter("commentNo"));
		}
		
		return "success";
		
		// [20140924, 김동우] ajax 방식으로 변경하여 아래부분 삭제.
		//--------------------------------------------
		// contextRoot가 있는 경우 제외 시켜야 함
		//--------------------------------------------
		//return "forward:/selectFileInfs.do";
		//return "forward:" + returnUrl;
		/*
		if ("".equals(request.getContextPath()) || "/".equals(request.getContextPath())) {
		    return "forward:" + returnUrl;			
		}
		
		if (returnUrl.startsWith(request.getContextPath())) {
		    return "forward:" + returnUrl.substring(returnUrl.indexOf("/", 1));
		} else {
		    return "forward:" + returnUrl;
		}
		*/
		////------------------------------------------
    }

    /**
     * 이미지 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/selectImageFileInfs.do")
    public String selectImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
	    ModelMap model) throws Exception {

		String atchFileId = (String)commandMap.get("param_atchFileId");
		String width = (String)commandMap.get("param_width");
		String height = (String)commandMap.get("param_height");
	
		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectImageFileList(fileVO);
		
		model.addAttribute("fileList", result);
		model.addAttribute("width", width);
		model.addAttribute("height", height);
	
		return "common/ImgFileList";
    }
}
