package kms.com.app.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.app.service.ApprovalComment;
import kms.com.app.service.ApprovalCommentVO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Class Name : KmsEappCommentDAO.java
 * @Description : KmsEappComment DAO Class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("kmsEappCommentDAO")
public class KmsEappCommentDAO extends EgovAbstractDAO {

	/**
	 * KMS_EAPP_COMMENT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 KmsEappCommentVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertKmsEappComment(ApprovalComment vo) throws Exception {
        return (String)insert("kmsEappCommentDAO.insertKmsEappComment_S", vo);
    }

    /**
	 * KMS_EAPP_COMMENT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 KmsEappCommentVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateKmsEappComment(ApprovalComment vo) throws Exception {
        update("kmsEappCommentDAO.updateKmsEappComment_S", vo);
    }

    /**
	 * KMS_EAPP_COMMENT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 KmsEappCommentVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteKmsEappComment(ApprovalComment vo) throws Exception {
        delete("kmsEappCommentDAO.deleteKmsEappComment_S", vo);
    }

    /**
	 * KMS_EAPP_COMMENT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 KmsEappCommentVO
	 * @return 조회한 KMS_EAPP_COMMENT
	 * @exception Exception
	 */
    public ApprovalComment selectKmsEappComment(ApprovalComment vo) throws Exception {
        return (ApprovalComment) selectByPk("kmsEappCommentDAO.selectKmsEappComment_S", vo);
    }

    /**
	 * KMS_EAPP_COMMENT 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return KMS_EAPP_COMMENT 목록
	 * @exception Exception
	 */
    public List selectKmsEappCommentList(ApprovalCommentVO searchVO) throws Exception {
        return list("kmsEappCommentDAO.selectKmsEappCommentList_D", searchVO);
    }

    /**
	 * KMS_EAPP_COMMENT 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return KMS_EAPP_COMMENT 총 갯수
	 * @exception
	 */
    public int selectKmsEappCommentListTotCnt(ApprovalCommentVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("kmsEappCommentDAO.selectKmsEappCommentListTotCnt_S", searchVO);
    }

}
