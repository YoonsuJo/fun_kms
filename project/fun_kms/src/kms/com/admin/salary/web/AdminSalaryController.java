package kms.com.admin.salary.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.salary.service.KmsSalaryService;
import kms.com.common.config.PathConfig;
import kms.com.common.service.FileMngService;
import kms.com.common.service.FileMngUtil;
import kms.com.common.service.FileVO;
import kms.com.common.utils.SessionUtil;
import kms.com.common.utils.CommonUtil;
import kms.com.member.service.MemberService;
import kms.com.member.service.MemberVO;
import kms.com.member.service.Msn;
import kms.com.member.service.PositionHistoryVO;
import kms.com.salary.service.SalaryVO;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
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
public class AdminSalaryController {
    
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
    
    @Autowired
    private DefaultBeanValidator beanValidator;

    @RequestMapping("/admin/salary/salaryMain.do")
    public String selectMemberList(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {

    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	if(salaryVO.getMonth()==null)
    		salaryVO.setMonth(Integer.toString(cal.get(Calendar.MONTH)+ 1));
    	model.addAttribute("resultList1",salaryService.selectRankSalaryList(salaryVO));
    	model.addAttribute("resultList2",salaryService.selectUserSalaryList(salaryVO));
    	
    	
    	model.addAttribute("year", salaryVO.getYear());
    	model.addAttribute("month", salaryVO.getMonth());
    	return "admin/salary/salaryMain";
    }
    
    @RequestMapping("/ajax/admin/salary/rankSalaryP.do")
    public String rankSalaryModify(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	salaryVO.setMonth(null);
    	List voList = salaryService.selectRankSalaryList(salaryVO);
    	if(voList.size()==1)
    	{
    		for(int i =0 ;i<11 ; i++)
    		{
    			EgovMap egov = new EgovMap();
    			egov.put("SALARY", 0);
    			voList.add(egov);
    		}
    	}
    	model.addAttribute("resultList",voList);
    	model.addAttribute("year", salaryVO.getYear());
    	model.addAttribute("month", salaryVO.getMonth());
    	return "admin/salary/salaryP1";
    }
        
    @RequestMapping("/ajax/admin/salary/rankSalaryU.do")
    public String rankSalaryUpdate(@ModelAttribute("searchVO") 
    		SalaryVO salaryVO, ModelMap model) throws Exception {    	    	
    	Calendar cal = Calendar.getInstance();    	
    	salaryService.updateRankSalary(salaryVO);
    	return "success";
    }
    
    
    @RequestMapping("/ajax/admin/salary/rankSalaryAjax.do")
    public String rankSalaryAjax(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {

    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	if(salaryVO.getMonth()==null)
    		salaryVO.setMonth(Integer.toString(cal.get(Calendar.MONTH)));
    	List resultList = salaryService.selectRankSalaryList(salaryVO);
    	if(resultList.isEmpty())
    		return "fail";
    	else
    	{
    		model.addAttribute("resultList1",resultList);
    		return "admin/salary/include/rankSalary";
    	}
    	
    }
    	
    
    @RequestMapping("/ajax/admin/salary/userSalaryP.do")
    public String userSalaryModify(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	salaryVO.setMonth(null);	
    	List voList = salaryService.selectUserSalaryList(salaryVO);
    	if(voList.size()==1)
    	{
    		for(int i =0 ;i<11 ; i++)
    		{
    			EgovMap egov = new EgovMap();
    			egov.put("SALARY1", 0);
    			egov.put("SALARY2", 0);
    			egov.put("SALARY3", 0);
    			voList.add(egov);
    		}
    	}
    	model.addAttribute("resultList",voList);
    	model.addAttribute("year", salaryVO.getYear());
    	model.addAttribute("month", salaryVO.getMonth());
    	return "admin/salary/salaryP2";
    }
    	
    
    
    @RequestMapping("/ajax/admin/salary/userSalaryU.do")
    public String userSalaryUpdate(@ModelAttribute("searchVO") 
    		SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    //	Calendar cal = Calendar.getInstance();
    	
    	salaryService.updateUserSalary(salaryVO);
    	return "success";
    }
    
    

    @RequestMapping("/ajax/admin/salary/userSalaryAjax.do")
    public String userSalaryAjax(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {

    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	if(salaryVO.getMonth()==null)
    		salaryVO.setMonth(Integer.toString(cal.get(Calendar.MONTH))+1);
    	List resultList = salaryService.selectUserSalaryList(salaryVO);
    	if(resultList.isEmpty())
    		return "fail";
    	else
    	{
    		model.addAttribute("resultList2",resultList);
    		return "admin/salary/include/userSalary";
    	}
    	
    }
    
}
