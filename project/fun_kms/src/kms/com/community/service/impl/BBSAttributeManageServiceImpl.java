package kms.com.community.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.community.service.BoardMaster;
import kms.com.community.service.BoardMasterVO;
import kms.com.community.service.BBSAttributeManageService;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cop.bbs.service.impl.BBSAddedOptionsDAO;
import egovframework.com.cop.com.service.BoardUseInf;
import egovframework.com.cop.com.service.EgovUserInfManageService;
import egovframework.com.cop.com.service.UserInfVO;
import egovframework.com.cop.com.service.impl.BBSUseInfoManageDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 게시판 속성관리를 위한 서비스 구현 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.24  이삼섭          최초 생성
 *   2009.06.26	한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@Service("KmsBBSAttributeManageService")
public class BBSAttributeManageServiceImpl extends AbstractServiceImpl implements BBSAttributeManageService {

    @Resource(name = "KmsBBSAttributeManageDAO")
    private BBSAttributeManageDAO attrbMngDAO;


    /**
     * 게시판 속성정보 한 건을 상세조회한다.
     * 
     * @see egovframework.com.cop.bbs.BBSAttributeManageService.service.EgovBBSAttributeManageService#selectBBSMasterInf(egovframework.com.cop.bbs.brd.service.BoardMasterVO)
     */
    public BoardMasterVO selectBBSMasterInf(BoardMaster searchVO) throws Exception {
		BoardMasterVO result = attrbMngDAO.selectBBSMasterInf(searchVO);
	
		return result;
		
    }


	@Override
	public List<BoardMasterVO> selectBoardMasterList(BoardMasterVO searchVO)
			throws Exception {
		return attrbMngDAO.selectBoardMasterList(searchVO);
	}
}
