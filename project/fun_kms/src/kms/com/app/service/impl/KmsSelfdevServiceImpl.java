package kms.com.app.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.app.service.AccountVO;
import kms.com.app.service.ApprovalJobgVO;
import kms.com.app.service.ApprovalOfficialVO;
import kms.com.app.service.SelfdevVO;
import kms.com.app.service.ApprovalReaderVO;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.ApprovalVacVO;
import kms.com.app.service.KmsAccountService;
import kms.com.app.service.KmsApprovalService;
import kms.com.app.service.KmsSelfdevService;
import kms.com.app.web.KmsApprovalController;
import kms.com.common.exception.IdMixInputException;
import kms.com.common.utils.CommonUtil;
import kms.com.member.service.WorkStateVO;
import egovframework.com.utl.sim.service.EgovFileScrty;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.fcc.service.EgovNumberUtil;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.ems.service.EgovSndngMailRegistService;
import egovframework.com.ems.service.SndngMailVO;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  
 *  </pre>
 */
/**
 * @author blind
 *
 */
/**
 * @author blind
 *
 */
@Service("KmsSelfdevService")
public class KmsSelfdevServiceImpl extends AbstractServiceImpl implements
	KmsSelfdevService {

    @Resource(name="selfdevDAO")
    private SelfdevDAO selfdevDAO;

	@Override
	public void deleteSelfdev(SelfdevVO selfDevVO) {
		selfdevDAO.deleteSelfdev(selfDevVO);
	}

	@Override
	public void insertSelfdev(SelfdevVO selfDevVO) {
		selfdevDAO.insertSelfdev(selfDevVO);
		
	}

	@Override
	public List selectSelfdevCmmList(SelfdevVO searchVO) throws Exception {
		return selfdevDAO.selectSelfdevCmmList(searchVO);
	}


	@Override
	public List selectSelfdevUsrList(SelfdevVO searchVO) throws Exception {
		return selfdevDAO.selectSelfdevUsrList(searchVO);
	}
 
	@Override
	public SelfdevVO selectSelfdevUsrInfo(SelfdevVO searchVO) throws Exception {
		return selfdevDAO.selectSelfdevUsrInfo(searchVO);
	}

	@Override
	public void updateSelfdev(SelfdevVO selfDevVO) {
		selfdevDAO.updateSelfdev(selfDevVO);
	}

	
	@Override
	public void updateSelfdevCmm(SelfdevVO selfdevCmmVO) throws Exception {
		for(int i=0; i< selfdevCmmVO.getSelfdevFullList().length;i++)
		{
			 SelfdevVO vo =new SelfdevVO();
			 vo.setYear(selfdevCmmVO.getYear());
			 vo.setMonth(i+1);
			 vo.setFull(selfdevCmmVO.getSelfdevFullList()[i]);
			 vo.setHalf(selfdevCmmVO.getSelfdevHalfList()[i]);
			 
			 int Cnt = selfdevDAO.selectSelfdevCmmCnt(vo);
			 if(Cnt > 0){
				 selfdevDAO.updateSelfdevCmm(vo);
			 }else{
				 selfdevDAO.insertSelfdevCmm(vo);
			 }		
		}
		
	}

	@Override
	public SelfdevVO selectSelfdevUsrView(SelfdevVO searchVO) {
		return selfdevDAO.selectSelfdevUsrView(searchVO);
	}

	@Override
	public void insertSelfdevUsr(SelfdevVO selfdevVO) throws IdMixInputException {
		selfdevVO.setUserId(CommonUtil.parseIdFromMixs(selfdevVO.getUserMix())[0]);
		selfdevDAO.insertSelfdevUsr(selfdevVO);
		
	}

	@Override
	public void updateSelfdevUsr(SelfdevVO selfdevVO) {
		selfdevDAO.updateSelfdevUsr(selfdevVO);
		
	}

	@Override
	public void deleteSelfdevUsr(SelfdevVO searchVO) {
		selfdevDAO.deleteSelfdevUsr(searchVO);
	}



        
}
