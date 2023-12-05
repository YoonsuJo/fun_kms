package kms.com.admin.approval.service;

import java.util.List;


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
public interface KmsApprovalTypService {
	
	/**
	 * KMS_EAPP_DOCTYP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 KmsEappDoctypVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    String insertKmsEappDoctyp(KmsApprovalTyp vo) throws Exception;
    
    /**
	 * KMS_EAPP_DOCTYP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 KmsEappDoctypVO
	 * @return void형
	 * @exception Exception
	 */
    void updateKmsEappDoctyp(KmsApprovalTyp vo) throws Exception;
    
    /**
	 * KMS_EAPP_DOCTYP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 KmsEappDoctypVO
	 * @return void형 
	 * @exception Exception
	 */
    void deleteKmsEappDoctyp(KmsApprovalTyp vo) throws Exception;
    
    /**
	 * KMS_EAPP_DOCTYP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 KmsEappDoctypVO
	 * @return 조회한 KMS_EAPP_DOCTYP
	 * @exception Exception
	 */
    KmsApprovalTyp selectKmsEappDoctyp(KmsApprovalTyp vo) throws Exception;
    
    /**
	 * KMS_EAPP_DOCTYP 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_DOCTYP 목록
	 * @exception Exception
	 */
    List<KmsApprovalTypVO> selectKmsEappDoctypList(KmsApprovalTypVO searchVO) throws Exception;
    
    
    
    
    /**
	 * 회사구분 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_DOCTYP 목록
	 * @exception Exception
	 */
    List<KmsApprovalTypVO> selectKmsCompanyList(KmsApprovalTypVO searchVO) throws Exception;
    
    /**
	 * KMS_EAPP_DOCTYP 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_DOCTYP 총 갯수
	 * @exception
	 */
    int selectKmsEappDoctypListTotCnt(KmsApprovalTypVO searchVO);

	/**
	 * @param searchVO
	 * docOrd변경
	 */
	void updateKmsEappDoctypOrd(KmsApprovalTypVO searchVO);
    
}
