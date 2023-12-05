package kms.com.message.web;

import java.net.URLEncoder;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.cooperation.service.CustomerVO;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;

import kms.com.message.service.MessageService;
import kms.com.message.service.MessageVO;


@Controller
public class MessageController {

	Logger logT = Logger.getLogger("TENY");

//	@Resource(name = "KmsResourceService")
//	private ResourceService resourceService;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Resource(name="egovMessageSource")
	protected EgovMessageSource egovMessageSource;
	
	@Resource(name = "EgovCmmUseService")
	 private EgovCmmUseService cmmUseService;

	@Resource(name = "KmsFileMngUtil")
	private FileMngUtil fileUtil;
	
	@Resource(name = "KmsFileMngService")
	private FileMngService fileMngService;
	
	@Resource(name = "KmsMessageService")
	private MessageService messageService;

	@Resource(name="KmsMemberService")
	MemberService memberService;


	/* TENY_170206 한개의 세금계산서 내용을 조회하는 화면을 만드는 Controll 메소드 */
	@RequestMapping("/message/MessageTest.do")
	public String messageTest(@ModelAttribute("messageVO")  MessageVO  messageVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model, Map<String, Object> commandMap) throws Exception{
		
		logT.debug("START");

		return "message/msg_MessageTest";
	}
}
