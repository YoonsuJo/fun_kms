package kms.com.admin.authority.service;

import kms.com.common.exception.IdMixInputException;

import java.util.List;
import java.util.Map;


/**
 * @Class Name : KmsEappDoctypService.java
 * @Description : KmsEappDoctyp Business class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31	
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public interface KmsAdminAuthService {

	List selectAuthList(AuthVO searchVO);

	List<String> selectUserAuthList(Map<String, Object> param);
	
	void updateAuthList(AuthVO searchVO)throws IdMixInputException;
	
	List selectAuthUserList(Map<String, Object> param);
}
