package kms.com.admin.dbManage.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kms.com.admin.dbManage.service.AdminDbManageService;
import kms.com.common.utils.CalendarUtil;
import kms.com.member.service.HolidayWorkStatisticDetailVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.sym.ccm.cde.service.CmmnDetailCode;
import egovframework.rte.psl.dataaccess.util.EgovMap;



@Controller
public class AdminDbManageController {

	@Resource(name="KmsAdminDbManageService")
	private AdminDbManageService adminDbManageService;
   
	@RequestMapping(value="/admin/dbManage/schemaChangeL.do")
    public String selectSchemaChangeList(ModelMap model) throws Exception {

		List<EgovMap> resultList = adminDbManageService.selectSchemaChangeList(null);
		model.addAttribute("resultList", resultList);
    	return "admin/dbManage/db_schemaChangeL";
    } 
    
	@RequestMapping(value="/admin/dbManage/confirmSchemaChange.do")
    public String confirmSchemaChange(ModelMap model) throws Exception {

		adminDbManageService.confirmSchemaChange(null);
		
		return "redirect:/admin/dbManage/schemaChangeL.do";
    } 
}
