package kms.com.admin.dbManage.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.util.List;
import java.util.Map;


public interface AdminDbManageService {
	List<EgovMap> selectSchemaChangeList(Map<String, Object> param) throws Exception;
	void confirmSchemaChange(Map<String, Object> param) throws Exception;
}
