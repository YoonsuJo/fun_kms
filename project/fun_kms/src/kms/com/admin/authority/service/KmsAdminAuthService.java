package kms.com.admin.authority.service;

import java.util.List;
import java.util.Map;

import kms.com.common.exception.IdMixInputException;
import kms.com.member.service.HolidayWorkStatisticDetail;


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
