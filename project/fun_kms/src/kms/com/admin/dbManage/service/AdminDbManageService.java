package kms.com.admin.dbManage.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface AdminDbManageService {
	List<EgovMap> selectSchemaChangeList(Map<String, Object> param) throws Exception;
	void confirmSchemaChange(Map<String, Object> param) throws Exception;
}
