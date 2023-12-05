package kms.com.admin.authority.service.impl;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import kms.com.admin.authority.service.AuthVO;
import kms.com.admin.authority.service.KmsAdminAuthService;
import kms.com.common.exception.IdMixInputException;
import kms.com.common.utils.CommonUtil;
import kms.com.member.service.HolidayWorkStatisticDetail;

/**
 * @Class Name : KmsEappDoctypServiceImpl.java
 * @Description : KmsEappDoctyp Business Implement class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.08.31
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("kmsAdminAuthService")
public class KmsAdminAuthServiceImpl extends AbstractServiceImpl implements
        KmsAdminAuthService {

	@Resource(name="kmsAdminAuthDAO")
    private KmsAdminAuthDAO adminAuthDAO;
	
	@Override
	public List selectAuthList(AuthVO searchVO) {		
		return adminAuthDAO.selectAuthList(searchVO);
	}

	@Override
	public List<String> selectUserAuthList(Map<String, Object> param) {
		List<String> resultList = adminAuthDAO.selectUserAuthList(param);
		return resultList;
	}

	@Override
	public void updateAuthList(AuthVO searchVO) throws IdMixInputException {
		String[] users = CommonUtil.parseIdFromMixs(searchVO
				.getUserComplexs());
		adminAuthDAO.deleteAuthList(searchVO);
		for(String userId : users) {
			searchVO.setUserId(userId);
			adminAuthDAO.insertAuthUser(searchVO);		
		}		
	}
	
	@Override
	public List selectAuthUserList(Map<String, Object> param) {		
		return adminAuthDAO.selectAuthUserList(param);
	}
    
}
