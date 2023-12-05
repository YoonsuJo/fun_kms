package kms.com.admin.status.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


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
public interface KmsStatusService {
	
	
    /**
	 * KMS_EAPP_DOCTYP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 KmsEappDoctypVO
	 * @return 조회한 KMS_EAPP_DOCTYP
	 * @exception Exception
	 */
	List selectLoginStatus(Map<String, Object> param) throws Exception;
    
    /**
	 * KMS_EAPP_DOCTYP 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_DOCTYP 목록
	 * @exception Exception
	 */
    List selectLoginStatusList(Map<String, Object> param) throws Exception;

    /**
	 * KMS_EAPP_DOCTYP 엑셀파일생성을 위한 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_DOCTYP 목록
	 * @exception Exception
	 */
    List<EgovMap> selectLoginStatusExcel(Map<String, Object> param) throws Exception;
    
}
