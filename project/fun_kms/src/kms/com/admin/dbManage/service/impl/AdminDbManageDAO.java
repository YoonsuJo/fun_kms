package kms.com.admin.dbManage.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("KmsAdminDbManageDAO")
public class AdminDbManageDAO extends EgovAbstractDAO {

	public List<EgovMap> selectSchemaChangeList(Map<String, Object> param) {
		return list("AdminDbManageDAO.selectSchemaChangeList", param);
	}

	public void confirmSchemaChange(Map<String, Object> param) {
		delete("AdminDbManageDAO.clearOldDbSchema", param);
		insert("AdminDbManageDAO.makeNewDbSchema", param);
	}
}
