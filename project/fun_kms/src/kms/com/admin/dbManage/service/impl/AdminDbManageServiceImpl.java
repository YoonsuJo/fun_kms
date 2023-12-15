package kms.com.admin.dbManage.service.impl;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.admin.dbManage.service.AdminDbManageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service("KmsAdminDbManageService")
public class AdminDbManageServiceImpl implements AdminDbManageService {

	@Resource(name = "KmsAdminDbManageDAO")
	private AdminDbManageDAO adminDbManageDAO;

	@Override
	public List<EgovMap> selectSchemaChangeList(Map<String, Object> param) throws Exception {
		List<EgovMap> resultList = adminDbManageDAO.selectSchemaChangeList(param);
		return resultList;
	}

	@Override
	public void confirmSchemaChange(Map<String, Object> param) throws Exception {
		adminDbManageDAO.confirmSchemaChange(param);
	}
}
