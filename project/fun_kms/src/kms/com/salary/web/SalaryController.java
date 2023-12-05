package kms.com.salary.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.salary.service.KmsSalaryHolService;
import kms.com.salary.service.KmsSalaryService;
import kms.com.app.service.ApprovalHolVO;
import kms.com.common.config.PathConfig;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.CalendarUtil;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.member.service.PositionHistoryVO;
import kms.com.salary.service.SalaryVO;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 인건비 관리를 위한 웹 서비스
 * @author 공통서비스개발팀 이삼섭
 * @since 2011.09.20
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2011.09.20  양진환           생성
 *
 * </pre>
 */
@Controller
public class SalaryController {
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsMemberService")
    private MemberService memberService;

    @Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    @Resource(name = "KmsSalaryService")
	private KmsSalaryService salaryService;
    
    @Resource(name = "KmsSalaryHolService")
	private KmsSalaryHolService salaryHolService;
    
    
    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());

    
    @RequestMapping("/ajax/salary/selectUserSalaryYearWeight.do")
    public void selectUserSalaryYearWeight(
    		HttpServletResponse res
    		, String userInfo
    		, ModelMap model) throws Exception {

    	
    	JSONObject userInfoJ=  (JSONObject)JSONValue.parseWithException( CommonUtil.unescape(userInfo));
    	JSONObject js = salaryService.selectUserSalaryYearWeight(userInfoJ);
    	res.setContentType("charset=UTF-8");
   		ServletOutputStream out=res.getOutputStream();
		out.write(js.toString().getBytes("utf-8"));
		out.flush();
		out.close();
    }
    
    @RequestMapping("/ajax/salary/selectUserHolSalaryInfo.do")
    public void selectUserHolSalaryInfo(
    		ApprovalHolVO searchVO,
    		HttpServletRequest request, HttpServletResponse response
    		, ModelMap model) throws Exception {
    	
    	if(searchVO.getStDt()==null||"".equals(searchVO.getStDt()))
    	{
    		searchVO.setStDt(CalendarUtil.getToday());
    	}
    	JSONObject js = salaryHolService.selectUserHolSalaryInfo(searchVO);
    	response.setContentType("charset=UTF-8");
    	ServletOutputStream out=response.getOutputStream();
    	out.write(js.toString().getBytes("utf-8"));
    	out.flush();
    	out.close();
    }
       
}
