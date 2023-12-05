package kms.com.common.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import kms.com.common.service.FileMngService;
import kms.com.common.service.FileVO;
import kms.com.common.utils.SessionUtil;
import egovframework.com.sec.ram.security.userdetails.util.EgovUserDetailsHelper;


/**
 * 파일 다운로드를 위한 컨트롤러 클래스
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
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class FileDownloadController {
    
    @Resource(name = "KmsFileMngService")
    private FileMngService fileService;
    
    Logger log = Logger.getLogger(this.getClass());
    
    /**
     * 브라우저 구분 얻기.
     * 
     * @param request
     * @return
     */
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {  //IE 11에서는 MSIE로 판단할수 없음
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
    
    /**
     * Disposition 지정하기.
     * 
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	
		String browser = getBrowser(request);
		
		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;
		
		if (browser.equals("MSIE")) {
		    encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
		    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
		    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
		    StringBuffer sb = new StringBuffer();
		    for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
				    sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
				    sb.append(c);
				}
		    }
		    encodedFilename = sb.toString();
		} else {
		    //throw new RuntimeException("Not supported browser");
		    throw new IOException("Not supported browser");
		}
		
		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
		
		if ("Opera".equals(browser)){
		    response.setContentType("application/octet-stream;charset=UTF-8");
		}
		
		String userAgent = request.getHeader("user-agent");
		String[] mobileos = {"iPhone", "iPod"};
		boolean isMobile = false;
    	int j = -1;
    	for(int i=0; i<mobileos.length; i++){
    	   j = userAgent.indexOf(mobileos[i]);
    	   if(j > -1){
    		   //System.out.println("os - : " + userAgent);
    		   isMobile = true; 
    		   break;
    	   }
    	}
		// 2013-03-05 iOS6 오류로 exe 를 붙이는 문제 해결 
    	String ext = filename.substring(filename.lastIndexOf(".") + 1, filename.length());
		if(isMobile && userAgent.indexOf("OS 6") > 0 ){
			/*
			if(ext.equalsIgnoreCase("pdf"))
				response.setContentType("application/pdf");
			else if(ext.equalsIgnoreCase("XLS") || ext.equalsIgnoreCase("XLS3") || ext.equalsIgnoreCase("XLS4") 
				 || ext.equalsIgnoreCase("XLW") || ext.equalsIgnoreCase("XLS5") || ext.equalsIgnoreCase("XLSX"))  //"XLS", "XLS3", "XLS4", "XLS5", "XLW","XLSX"
				response.setContentType("application/vnd.ms-excel;euc-kr");
			else if(ext.equalsIgnoreCase("DOC") || ext.equalsIgnoreCase("DOCX")) //"DOC","DOCX"
				response.setContentType("application/msword;euc-kr");
			else if(ext.equalsIgnoreCase("PPT") || ext.equalsIgnoreCase("PPS") || ext.equalsIgnoreCase("PPTX")) //"PPT","PPS","PPTX"
				response.setContentType("application/vnd.ms-powerpoint;euc-kr");
			else if(ext.equalsIgnoreCase("ZIP"))
				response.setContentType("application/x-zip-compressed");
			else if(ext.equalsIgnoreCase("GZ"))
				response.setContentType("application/x-gzip");
			else if(ext.equalsIgnoreCase("RAR"))
				response.setContentType("application/x-rar-compressed");
			else
			*/ 
				response.setContentType("application/octet-stream");     
		}
    }

    /**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/FileDown.do")    
    public void cvplFileDownload(Map<String, Object> commandMap, 
    		HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
		
		boolean isAuthenticated = SessionUtil.isLogin(request);		
      	if (isAuthenticated) {	//사용자 권한 인증
		    FileVO fileVO = new FileVO();
		    fileVO.setAtchFileId(atchFileId);
		    fileVO.setFileSn(fileSn);
		    FileVO fvo = fileService.selectFileInf(fileVO);
		    
		    File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
	      	int fSize = (int)uFile.length();	      	
			setDisposition(fvo.getOrignlFileNm(), request, response); //이건 여기 누가 왜 추가한건지 모름
		    
			if (fSize > 0) { //파일있음
				String mimetype = "application/x-msdownload";
		
				//response.setBufferSize(fSize);	// OutOfMemeory 발생
				response.setContentType(mimetype);
				//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				
				setDisposition(fvo.getOrignlFileNm(), request, response);
	
				response.setContentLength(fSize);
		
				/*
				 * FileCopyUtils.copy(in, response.getOutputStream());
				 * in.close(); 
				 * response.getOutputStream().flush();
				 * response.getOutputStream().close();
				 */
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
		
				try {
				    in = new BufferedInputStream(new FileInputStream(uFile));
				    out = new BufferedOutputStream(response.getOutputStream());
		
				    FileCopyUtils.copy(in, out);
				    out.flush();
				} catch (Exception ex) {
				    //ex.printStackTrace();
				    // 다음 Exception 무시 처리
				    // Connection reset by peer: socket write error
				    log.debug("IGNORED: " + ex.getMessage());
				} finally {
				    if (in != null) {
						try {
						    in.close();
						} catch (Exception ignore) {
						    // no-op
						    log.debug("IGNORED: " + ignore.getMessage());
						}
				    }
				    if (out != null) {
						try {
						    out.close();
						} catch (Exception ignore) {
						    // no-op
						    log.debug("IGNORED: " + ignore.getMessage());
						}
				    }
				}	
		    } else { //파일없음
				response.setContentType("application/x-msdownload");
		
				PrintWriter printwriter = response.getWriter();
				printwriter.println("<html>");
				printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fvo.getOrignlFileNm() + "</h2>");
				printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
				printwriter.println("<br><br><br>&copy; webAccess");
				printwriter.println("</html>");
				printwriter.flush();
				printwriter.close();
		    }
		}
    }
    
    /**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/mobile/FileDown.do")    
    public void cvplFileDownloadForMobile(Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
		
		//boolean isAuthenticated = SessionUtil.isLogin(request);
		
      	//if (isAuthenticated) {
	
		    FileVO fileVO = new FileVO();
		    fileVO.setAtchFileId(atchFileId);
		    fileVO.setFileSn(fileSn);
		    FileVO fvo = fileService.selectFileInf(fileVO);
		    
		    File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
	      	int fSize = (int)uFile.length();
	      	
			setDisposition(fvo.getOrignlFileNm(), request, response); //이거 왜 여기 달아놨지? 작업중
		    
		    if (fSize > 0) {
				String mimetype = "application/x-msdownload";
		
				//response.setBufferSize(fSize);	// OutOfMemeory 발생
				response.setContentType(mimetype);
				response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				//dos.writeBytes("Content-Disposition:form-data;name=\"data\";filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				
				setDisposition(fvo.getOrignlFileNm(), request, response);
				
				//response.addProperty("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
	
				response.setContentLength(fSize);
		
				/*
				 * FileCopyUtils.copy(in, response.getOutputStream());
				 * in.close(); 
				 * response.getOutputStream().flush();
				 * response.getOutputStream().close();
				 */
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
		
				try {
				    in = new BufferedInputStream(new FileInputStream(uFile));
				    out = new BufferedOutputStream(response.getOutputStream());
		
				    FileCopyUtils.copy(in, out);
				    out.flush();
				} catch (Exception ex) {
				    //ex.printStackTrace();
				    // 다음 Exception 무시 처리
				    // Connection reset by peer: socket write error
				    log.debug("IGNORED: " + ex.getMessage());
				} finally {
				    if (in != null) {
						try {
						    in.close();
						} catch (Exception ignore) {
						    // no-op
						    log.debug("IGNORED: " + ignore.getMessage());
						}
				    }
				    if (out != null) {
						try {
						    out.close();
						} catch (Exception ignore) {
						    // no-op
						    log.debug("IGNORED: " + ignore.getMessage());
						}
				    }
				}	
		    } else {
				response.setContentType("application/x-msdownload");
		
				PrintWriter printwriter = response.getWriter();
				printwriter.println("<html>");
				printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fvo.getOrignlFileNm() + "</h2>");
				printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
				printwriter.println("<br><br><br>&copy; webAccess");
				printwriter.println("</html>");
				printwriter.flush();
				printwriter.close();
		    }
		//}
    }    
}
