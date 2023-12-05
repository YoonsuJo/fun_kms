package kms.com.admin.status.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : TblScoreDAO.java
 * @Description : TblScore DAO Class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.15
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("KmsStatusDAO")
public class KmsStatusDAO extends EgovAbstractDAO {

	
	public List selectLoginStatus(Map<String, Object> param) {
		return list("WorkStateDAO.selectLoginStatus", param);
	}
	
	public List selectLoginStatusList(Map<String, Object> param) {
		return list("WorkStateDAO.selectLoginStatusList", param);
	}

	public List<EgovMap> selectLoginStatusExcel(Map<String, Object> param) {
		return list("WorkStateDAO.selectLoginStatusExcel", param);
	}
	
}
