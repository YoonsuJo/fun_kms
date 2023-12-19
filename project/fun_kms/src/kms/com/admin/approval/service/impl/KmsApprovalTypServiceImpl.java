package kms.com.admin.approval.service.impl;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import kms.com.admin.approval.service.KmsApprovalTyp;
import kms.com.admin.approval.service.KmsApprovalTypService;
import kms.com.admin.approval.service.KmsApprovalTypVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

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

@Service("kmsApprovalTypService")
public class KmsApprovalTypServiceImpl extends AbstractServiceImpl implements
        KmsApprovalTypService {

    @Resource(name="kmsEappDoctypDAO")
    private KmsApprovalTypDAO kmsEappDoctypDAO;
    
    /** ID Generation */
    //@Resource(name="{egovKmsEappDoctypIdGnrService}")    
    //private EgovIdGnrService egovIdGnrService;

	/**
	 * KMS_EAPP_DOCTYP을 등록한다.
	 * @param vo - 등록할 정보가 담긴 KmsEappDoctypVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public Integer insertKmsEappDoctyp(KmsApprovalTyp vo) throws Exception {
    	log.debug(vo.toString());
    	
    	/** ID Generation Service */
    	//TODO 해당 테이블 속성에 따라 ID 제너레이션 서비스 사용
    	//String id = egovIdGnrService.getNextStringId();
    	//vo.setId(id);
    	log.debug(vo.toString());

    	kmsEappDoctypDAO.insertKmsEappDoctyp(vo);
    	//TODO 해당 테이블 정보에 맞게 수정

		return kmsEappDoctypDAO.selectMaxTempltId();
    }

    /**
	 * KMS_EAPP_DOCTYP을 수정한다.
	 * @param vo - 수정할 정보가 담긴 KmsEappDoctypVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateKmsEappDoctyp(KmsApprovalTyp vo) throws Exception {
        kmsEappDoctypDAO.updateKmsEappDoctyp(vo);
    }

    /**
	 * KMS_EAPP_DOCTYP을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 KmsEappDoctypVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteKmsEappDoctyp(KmsApprovalTyp vo) throws Exception {
        kmsEappDoctypDAO.deleteKmsEappDoctyp(vo);
    }

    /**
	 * KMS_EAPP_DOCTYP을 조회한다.
	 * @param vo - 조회할 정보가 담긴 KmsEappDoctypVO
	 * @return 조회한 KMS_EAPP_DOCTYP
	 * @exception Exception
	 */
    public KmsApprovalTyp selectKmsEappDoctyp(KmsApprovalTyp vo) throws Exception {
        KmsApprovalTyp resultVO = kmsEappDoctypDAO.selectKmsEappDoctyp(vo);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    /**
	 * KMS_EAPP_DOCTYP 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_DOCTYP 목록
	 * @exception Exception
	 */
    public List<KmsApprovalTypVO> selectKmsEappDoctypList(KmsApprovalTypVO searchVO) throws Exception {
        return kmsEappDoctypDAO.selectKmsEappDoctypList(searchVO);
    }

    /**
	 * KMS_EAPP_DOCTYP 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_DOCTYP 총 갯수
	 * @exception
	 */
    public int selectKmsEappDoctypListTotCnt(KmsApprovalTypVO searchVO) {
		return kmsEappDoctypDAO.selectKmsEappDoctypListTotCnt(searchVO);
	}

	@Override
	public void updateKmsEappDoctypOrd(KmsApprovalTypVO searchVO) {
		 kmsEappDoctypDAO.updateKmsEappDoctypOrd(searchVO);
		
	}
	
	
	  /**
	 * 회사구분 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return KMS_EAPP_DOCTYP 목록
	 * @exception Exception
	 */
    public List<KmsApprovalTypVO> selectKmsCompanyList(KmsApprovalTypVO searchVO) throws Exception {
        return kmsEappDoctypDAO.selectKmsCompanyList(searchVO);
    }
    
    
}
