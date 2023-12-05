package kms.com.admin.authority.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.admin.approval.service.KmsApprovalTyp;
import kms.com.admin.approval.service.KmsApprovalTypVO;
import kms.com.admin.authority.service.AuthVO;

/**
 * @Class Name : KmsEappDoctypDAO.java
 * @Description : KmsEappDoctyp DAO Class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("kmsAdminAuthDAO")
public class KmsAdminAuthDAO extends EgovAbstractDAO {

	public List selectAuthList(AuthVO searchVO) {
		// TODO Auto-generated method stub
		return list("authDAO.selectAuthList", searchVO);
	}

	public List<String> selectUserAuthList(Map<String, Object> param) {
		return list("authDAO.selectUserAuthList", param);
	}

	public void deleteAuthList(AuthVO searchVO) {
		delete("authDAO.deleteAuthList", searchVO);
		
	}

	public void insertAuthUser(AuthVO searchVO) {
		insert("authDAO.insertAuthUser",searchVO);
		
	}

	public List selectAuthUserList(Map<String, Object> param) {
		return list("authDAO.selectAuthUserList", param);
		
	}
	
}
