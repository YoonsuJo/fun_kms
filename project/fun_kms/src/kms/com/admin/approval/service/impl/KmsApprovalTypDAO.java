package kms.com.admin.approval.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.admin.approval.service.KmsApprovalTyp;
import kms.com.admin.approval.service.KmsApprovalTypVO;
import org.springframework.stereotype.Repository;

import java.util.List;

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

@Repository("kmsEappDoctypDAO")
public class KmsApprovalTypDAO extends EgovAbstractDAO {

	/**
	 * KMS_EAPP_DOCTYP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 KmsEappDoctypVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public void  insertKmsEappDoctyp(KmsApprovalTyp vo) throws Exception {
    	insert("kmsEappDoctypDAO.insertKmsEappDoctyp_S", vo);
    }
	public Integer selectMaxTempltId() throws Exception {
		return (Integer) getSqlMapClientTemplate().queryForObject("kmsEappDoctypDAO.selectMaxTempltId");
	}

    /**
	 * KMS_EAPP_DOCTYP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 KmsEappDoctypVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateKmsEappDoctyp(KmsApprovalTyp vo) throws Exception {
        update("kmsEappDoctypDAO.updateKmsEappDoctyp_S", vo);
    }

    /**
	 * KMS_EAPP_DOCTYP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 KmsEappDoctypVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteKmsEappDoctyp(KmsApprovalTyp vo) throws Exception {
        delete("kmsEappDoctypDAO.deleteKmsEappDoctyp_S", vo);
    }

    /**
	 * KMS_EAPP_DOCTYP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 KmsEappDoctypVO
	 * @return 조회한 KMS_EAPP_DOCTYP
	 * @exception Exception
	 */
    public KmsApprovalTyp selectKmsEappDoctyp(KmsApprovalTyp vo) throws Exception {
        return (KmsApprovalTyp) selectByPk("kmsEappDoctypDAO.selectKmsEappDoctyp_S", vo);
    }

    /**
	 * KMS_EAPP_DOCTYP 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return KMS_EAPP_DOCTYP 목록
	 * @exception Exception
	 */
    public List<KmsApprovalTypVO> selectKmsEappDoctypList(KmsApprovalTypVO searchVO) throws Exception {
        return (List<KmsApprovalTypVO>) list("kmsEappDoctypDAO.selectKmsEappDoctypList_D", searchVO);
    }

    /**
	 * KMS_EAPP_DOCTYP 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return KMS_EAPP_DOCTYP 총 갯수
	 * @exception
	 */
    public int selectKmsEappDoctypListTotCnt(KmsApprovalTypVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("kmsEappDoctypDAO.selectKmsEappDoctypListTotCnt_S", searchVO);
    }

	public void updateKmsEappDoctypOrd(KmsApprovalTypVO searchVO) {
		update("kmsEappDoctypDAO.updateKmsEappDoctypOrd", searchVO);
		
	}

	
	/**
	 * 회사구분 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return KMS_EAPP_DOCTYP 목록
	 * @exception Exception
	 */
    public List<KmsApprovalTypVO> selectKmsCompanyList(KmsApprovalTypVO searchVO) {
		// TODO Auto-generated method stub
		return (List<KmsApprovalTypVO>) list("kmsEappDoctypDAO.selectKmsCompanyList", searchVO);
	}
    
}
