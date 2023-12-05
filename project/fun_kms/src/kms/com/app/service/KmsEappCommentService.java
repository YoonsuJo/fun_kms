package kms.com.app.service;

import java.util.List;
import kms.com.app.service.ApprovalCommentVO;
import kms.com.app.service.ApprovalComment;

/**
 * @Class Name : KmsEappCommentService.java
 * @Description : KmsEappComment Business class
 * @Modification Information
 * 
 * @author 양진환
 * @since 2011.09.01
 * @version 1.0
 * @see Copyright (C) All right reserved.
 */
public interface KmsEappCommentService {

	/**
	 * KMS_EAPP_COMMENT을 등록한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 KmsEappCommentVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	String insertKmsEappComment(ApprovalComment vo) throws Exception;

	/**
	 * KMS_EAPP_COMMENT을 수정한다.
	 * 
	 * @param vo
	 *            - 수정할 정보가 담긴 KmsEappCommentVO
	 * @return void형
	 * @exception Exception
	 */
	void updateKmsEappComment(ApprovalComment vo) throws Exception;

	/**
	 * KMS_EAPP_COMMENT을 삭제한다.
	 * 
	 * @param vo
	 *            - 삭제할 정보가 담긴 KmsEappCommentVO
	 * @return void형
	 * @exception Exception
	 */
	void deleteKmsEappComment(ApprovalComment vo) throws Exception;

	/**
	 * KMS_EAPP_COMMENT을 조회한다.
	 * 
	 * @param vo
	 *            - 조회할 정보가 담긴 KmsEappCommentVO
	 * @return 조회한 KMS_EAPP_COMMENT
	 * @exception Exception
	 */
	ApprovalComment selectKmsEappComment(ApprovalComment vo) throws Exception;

	/**
	 * KMS_EAPP_COMMENT 목록을 조회한다.
	 * 
	 * @param searchVO
	 *            - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_COMMENT 목록
	 * @exception Exception
	 */
	List<ApprovalCommentVO> selectKmsEappCommentList(ApprovalCommentVO searchVO)
			throws Exception;

	/**
	 * KMS_EAPP_COMMENT 총 갯수를 조회한다.
	 * 
	 * @param searchVO
	 *            - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_COMMENT 총 갯수
	 * @exception
	 */
	int selectKmsEappCommentListTotCnt(ApprovalCommentVO searchVO);

}
