package kms.com.admin.salary.web;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.member.service.MemberService;
import kms.com.salary.service.KmsSalaryHolService;
import kms.com.salary.service.SalaryVO;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.List;

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
public class AdminSalaryHolController {
    
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "KmsMemberService")
    private MemberService memberService;

    @Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
    
    @Resource(name = "KmsSalaryHolService")
	private KmsSalaryHolService salaryHolService;
    
    @Autowired
    private DefaultBeanValidator beanValidator;

    Logger log = Logger.getLogger(this.getClass());

    
    @RequestMapping("/admin/salary/salaryHolMain.do")
    public String selectMemberList(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {

    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	if(salaryVO.getMonth()==null)
    		salaryVO.setMonth(Integer.toString(cal.get(Calendar.MONTH)+ 1));
    	model.addAttribute("resultList1",salaryHolService.selectRankSalaryList(salaryVO));
    	model.addAttribute("resultList2",salaryHolService.selectPosSalaryList(salaryVO));
    	model.addAttribute("resultList3",salaryHolService.selectUserSalaryList(salaryVO));
    	
    	
    	model.addAttribute("year", salaryVO.getYear());
    	model.addAttribute("month", salaryVO.getMonth());
    	return "admin/salary/salaryHolMain";
    }
    
    @RequestMapping("/ajax/admin/salary/rankSalaryHolP.do")
    public String rankSalaryModify(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	salaryVO.setMonth(null);
    	List voList = salaryHolService.selectRankSalaryList(salaryVO);
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
    	return "admin/salary/include/rankSalaryHolPop";
    }
        
    @RequestMapping("/ajax/admin/salary/rankSalaryHolU.do")
    public String rankSalaryUpdate(@ModelAttribute("searchVO") 
    		SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	salaryHolService.updateRankSalary(salaryVO);
    	return "success";
    }
    
    
    @RequestMapping("/ajax/admin/salary/rankSalaryHolAjax.do")
    public String rankSalaryAjax(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {

    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	if(salaryVO.getMonth()==null)
    		salaryVO.setMonth(Integer.toString(cal.get(Calendar.MONTH)));
    	List resultList = salaryHolService.selectRankSalaryList(salaryVO);
    	if(resultList.isEmpty())
    		return "fail";
    	else
    	{
    		model.addAttribute("resultList1",resultList);
    		return "admin/salary/include/rankSalaryHol";
    	}
    	
    }
    @RequestMapping("/ajax/admin/salary/posSalaryHolP.do")
    public String posSalaryModify(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	salaryVO.setMonth(null);
    	List voList =salaryHolService.selectPosSalaryList(salaryVO);
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
    	return "admin/salary/include/positionSalaryHolPop";
    }
    
    @RequestMapping("/ajax/admin/salary/posSalaryHolU.do")
    public String posSalaryUpdate(@ModelAttribute("searchVO") 
    		SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	salaryHolService.updatePosSalary(salaryVO);
    	return "success";
    }
    
    
    @RequestMapping("/ajax/admin/salary/posSalaryHolAjax.do")
    public String posSalaryAjax(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	if(salaryVO.getMonth()==null)
    		salaryVO.setMonth(Integer.toString(cal.get(Calendar.MONTH)));
    	List resultList = salaryHolService.selectPosSalaryList(salaryVO);
    	if(resultList.isEmpty())
    		return "fail";
    	else
    	{
    		model.addAttribute("resultList2",resultList);
    		return "admin/salary/include/positionSalaryHol";
    	}
    	
    }
    	
    
    @RequestMapping("/ajax/admin/salary/userSalaryHolP.do")
    public String userSalaryModify(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	salaryVO.setMonth(null);
    	List voList =salaryHolService.selectUserSalaryList(salaryVO);
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
    	return "admin/salary/include/userSalaryHolPop";
    }
    	
    
    
    @RequestMapping("/ajax/admin/salary/userSalaryHolU.do")
    public String userSalaryUpdate(@ModelAttribute("searchVO") 
    		SalaryVO salaryVO, ModelMap model) throws Exception {
    	
    	
    	Calendar cal = Calendar.getInstance();
    	
    	salaryHolService.updateUserSalary(salaryVO);
    	return "success";
    }
    
    

    @RequestMapping("/ajax/admin/salary/userSalaryHolAjax.do")
    public String userSalaryAjax(@ModelAttribute("searchVO") SalaryVO salaryVO, ModelMap model) throws Exception {

    	
    	Calendar cal = Calendar.getInstance();
    	
    	if(salaryVO.getYear()==null)
    		salaryVO.setYear(Integer.toString(cal.get(Calendar.YEAR)));
    	if(salaryVO.getMonth()==null)
    		salaryVO.setMonth(Integer.toString(cal.get(Calendar.MONTH))+1);
    	List resultList = salaryHolService.selectUserSalaryList(salaryVO);
    	if(resultList.isEmpty())
    		return "fail";
    	else
    	{
    		model.addAttribute("resultList3",resultList);
    		return "admin/salary/include/userSalaryHol";
    	}
    	
    }
    
}
