package kms.com.admin.dbManage.web;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.admin.dbManage.service.AdminDbManageService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;



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
