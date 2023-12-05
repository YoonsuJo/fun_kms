package kms.com.app.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kms.com.app.service.KmsEappCommentService;
import kms.com.app.service.ApprovalCommentVO;
import kms.com.app.service.ApprovalComment;
import kms.com.app.service.impl.KmsEappCommentDAO;

/**
 * @Class Name : KmsEappCommentServiceImpl.java
 * @Description : KmsEappComment Business Implement class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.01
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Service("kmsEappCommentService")
public class KmsEappCommentServiceImpl extends AbstractServiceImpl implements
        KmsEappCommentService {

    @Resource(name="kmsEappCommentDAO")
    private KmsEappCommentDAO kmsEappCommentDAO;
    
    /** ID Generation */
    //@Resource(name="{egovKmsEappCommentIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * KMS_EAPP_COMMENT을 등록한다.
	 * @param vo - 등록할 정보가 담긴 KmsEappCommentVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertKmsEappComment(ApprovalComment vo) throws Exception {
    	log.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	log.debug(vo.toString());
    	
    	kmsEappCommentDAO.insertKmsEappComment(vo);
    	//TODO 해당 테이블 정보에 맞게 수정    	
        return null;
    }

    /**
	 * KMS_EAPP_COMMENT을 수정한다.
	 * @param vo - 수정할 정보가 담긴 KmsEappCommentVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateKmsEappComment(ApprovalComment vo) throws Exception {
        kmsEappCommentDAO.updateKmsEappComment(vo);
    }

    /**
	 * KMS_EAPP_COMMENT을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 KmsEappCommentVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteKmsEappComment(ApprovalComment vo) throws Exception {
        kmsEappCommentDAO.deleteKmsEappComment(vo);
    }

    /**
	 * KMS_EAPP_COMMENT을 조회한다.
	 * @param vo - 조회할 정보가 담긴 KmsEappCommentVO
	 * @return 조회한 KMS_EAPP_COMMENT
	 * @exception Exception
	 */
    public ApprovalComment selectKmsEappComment(ApprovalComment vo) throws Exception {
        ApprovalComment resultVO = kmsEappCommentDAO.selectKmsEappComment(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * KMS_EAPP_COMMENT 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_COMMENT 목록
	 * @exception Exception
	 */
    public List selectKmsEappCommentList(ApprovalCommentVO searchVO) throws Exception {
        return kmsEappCommentDAO.selectKmsEappCommentList(searchVO);
    }

    /**
	 * KMS_EAPP_COMMENT 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_COMMENT 총 갯수
	 * @exception
	 */
    public int selectKmsEappCommentListTotCnt(ApprovalCommentVO searchVO) {
		return kmsEappCommentDAO.selectKmsEappCommentListTotCnt(searchVO);
	}
    
}
