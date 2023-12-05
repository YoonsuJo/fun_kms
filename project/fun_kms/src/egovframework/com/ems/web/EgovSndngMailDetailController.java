package egovframework.com.ems.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.ems.service.EgovSndngMailDetailService;
import egovframework.com.ems.service.SndngMailVO;
import egovframework.com.ems.service.AtchmnFileVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.com.cmm.service.Globals;

/**
 * 발송메일을 상세 조회하는 컨트롤러 클래스
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
public class EgovSndngMailDetailController {
	
	/** EgovSndngMailDetailService */
	@Resource(name = "sndngMailDetailService")
    private EgovSndngMailDetailService sndngMailDetailService;
	
    /**
	 * 발송메일을 상세 조회한다.
	 * @param sndngMailVO SndngMailVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/ems/selectSndngMailDetail.action")
	public String selectSndngMail(@ModelAttribute("sndngMailVO") SndngMailVO sndngMailVO,
			ModelMap model) throws Exception {

    	if (sndngMailVO == null || sndngMailVO.getMssageId() == null || sndngMailVO.getMssageId().equals("")) {
    		return "cmm/egovError";
    	}
    	
    	// 1. 발송메일을 상세 조회한다.
    	SndngMailVO resultMailVO = sndngMailDetailService.selectSndngMail(sndngMailVO);
    	
        // 2. 결과 리턴
        model.addAttribute("resultInfo", resultMailVO);
        if (!resultMailVO.getMssageId().equals("")) {
        	// 발송메일 상세조회 화면 이동
        	return "ems/EgovMailDetail";
        } else {
        	// 오류 페이지 이동
        	return "cmm/egovError";
        }
	}
    
    /**
	 * 발송메일을 삭제한다.
	 * @param sndngMailVO SndngMailVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/ems/deleteSndngMail.do")
	public String deleteSndngMail(@ModelAttribute("sndngMailVO") SndngMailVO sndngMailVO,
			ModelMap model) throws Exception {
    	
    	if (sndngMailVO == null || sndngMailVO.getMssageId() == null || sndngMailVO.getMssageId().equals("")) {
    		return "cmm/egovError";
    	}
    	
    	// 1. 발송메일을 삭제한다.
    	sndngMailDetailService.deleteSndngMail(sndngMailVO);
    	
    	// 2. 첨부파일을 삭제한다.
    	sndngMailDetailService.deleteAtchmnFile(sndngMailVO);
    	
        // 3. 발송메일 목록 페이지 이동
    	return "redirect:/ems/selectSndngMailList.do";
	}
    
    /**
	 * 발송메일 내용조회로 돌아간다.
	 * @param sndngMailVO SndngMailVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/ems/backSndngMailDetail.do")
	public String backSndngMailDtls(@ModelAttribute("sndngMailVO") SndngMailVO sndngMailVO, ModelMap model) throws Exception {

    	return "redirect:/ems/selectSndngMailList.do";
	}
    
    /**
	 * XML형태의 발송요청메일을 조회한다.
	 * @param sndngMailVO SndngMailVO
	 * @exception Exception
	 */
    @RequestMapping(value="/ems/selectSndngMailXml.do")
	public void selectSndngMailXml(@ModelAttribute("sndngMailVO") SndngMailVO sndngMailVO,
			HttpServletResponse response,
			ModelMap model) throws Exception {
    	String xmlFile = Globals.MAIL_REQUEST_PATH + sndngMailVO.getMssageId() + ".xml";
    	File uFile = new File(xmlFile);
    	int fSize = (int) uFile.length();

		if (fSize > 0) {
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));

			String mimetype = "application/x-msdownload;charset=UTF-8";

			response.setBufferSize(fSize);
			response.setContentType(mimetype);
			response.setHeader("Content-Disposition", "attachment; filename=\""
					+ xmlFile + "\"");
			response.setContentLength(fSize);

			FileCopyUtils.copy(in, response.getOutputStream());
			in.close();
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} else {
			response.setContentType("application/x-msdownload");
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>"
					+ xmlFile + "</h2>");
			printwriter
					.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}
	}
}