package egovframework.com.ems.web;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.ems.service.EgovSndngMailRegistService;
import egovframework.com.ems.service.SndngMailVO;
import egovframework.com.ems.service.AtchmnFileVO;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.Globals;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartFile;
import egovframework.com.cmm.service.FileVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;

/**
 * 발송메일등록, 발송요청XML파일 생성하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.12
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.12  박지욱          최초 생성 
 *  
 *  </pre>
 */
@Controller
public class EgovSndngMailRegistController {

	/** EgovSndngMailRegistService */
	@Resource(name = "sndngMailRegistService")
    private EgovSndngMailRegistService sndngMailRegistService;
	
	/** EgovFileMngService */
	@Resource(name="EgovFileMngService")
	private EgovFileMngService fileMngService;	
	
	/** EgovFileMngUtil */
	@Resource(name="EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

    /** 파일구분자 */
    static final char FILE_SEPARATOR = File.separatorChar;
    
    /**
	 * 발송메일 등록화면으로 들어간다
	 * @param sndngMailVO SndngMailVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/ems/insertSndngMailView.do")
    public String insertSndngMailView(@ModelAttribute("sndngMailVO") SndngMailVO sndngMailVO,
			ModelMap model) throws Exception {
    	
    	model.addAttribute("resultInfo", sndngMailVO);
    	return "ems/EgovMailRegist";
    }
    
    /**
	 * 발송메일을 등록한다
	 * @param multiRequest MultipartHttpServletRequest
	 * @param sndngMailVO SndngMailVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/ems/insertSndngMail.action")
	public String insertSndngMail(final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("sndngMailVO") SndngMailVO sndngMailVO,
			ModelMap model) throws Exception {
    	
    	String link = "N";
    	if (sndngMailVO != null && sndngMailVO.getLink() != null && !sndngMailVO.getLink().equals("")) {
    		link = sndngMailVO.getLink();
    	}
    	
    	LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	
    	List<FileVO> _result = null;
    	String _atchFileId = "";
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();
    	if(!files.isEmpty()){
    	 _result = fileUtil.parseFileInf(files, "MSG_", 0, "", ""); 
    	 _atchFileId = fileMngService.insertFileInfs(_result);  //파일이 생성되고나면 생성된 첨부파일 ID를 리턴한다.
    	}
    	
    	sndngMailVO.setAtchFileId(_atchFileId);
    	sndngMailVO.setDsptchPerson(user.getId());
    	
    	// 발송메일을 등록한다.
    	boolean result = sndngMailRegistService.insertSndngMail(sndngMailVO);
    	if (result) {
    		if (link.equals("N")) {
    			return "redirect:/ems/selectSndngMailList.do";
    		} else {
    			model.addAttribute("closeYn", "Y");
    	    	return "ems/EgovMailRegist";
    		}
    	} else {
    		return "cmm/EgovError";
    	}
	}
    
    /**
	 * 발송메일 내용조회로 돌아간다.
	 * @param sndngMailVO SndngMailVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/ems/backSndngMailRegist.do")
	public String backSndngMailRegist(@ModelAttribute("sndngMailVO") SndngMailVO sndngMailVO,
			ModelMap model) throws Exception {

    	return "redirect:/ems/selectSndngMailList.do";
	}
}