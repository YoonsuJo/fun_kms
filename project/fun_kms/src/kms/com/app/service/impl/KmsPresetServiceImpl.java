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
import kms.com.app.service.ApprovalPresetVO;
import kms.com.app.service.ApprovalReaderVO;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.ApprovalVacVO;
import kms.com.app.service.KmsAccountService;
import kms.com.app.service.KmsApprovalService;
import kms.com.app.service.KmsPresetService;
import kms.com.app.web.KmsApprovalController;
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
@Service("presetService")
public class KmsPresetServiceImpl extends AbstractServiceImpl implements
	KmsPresetService {

    @Resource(name="presetDAO")
    private PresetDAO presetDAO;

	@Override
	public void deletePreset(ApprovalPresetVO presetVO) {
		presetDAO.deletePreset(presetVO);
		
	}

	@Override
	public void insertPreset(ApprovalPresetVO presetVO) {
		presetDAO.insertPreset(presetVO);
		
	}

	@Override
	public List selectPresetList(ApprovalPresetVO searchVO) throws Exception {
		return presetDAO.selectPresetList(searchVO);
	}

	@Override
	public ApprovalPresetVO selectPresetView(ApprovalPresetVO searchVO) throws Exception {
		return presetDAO.selectPresetView(searchVO);
	}

	@Override
	public void updatePreset(ApprovalPresetVO presetVO) {
		presetDAO.updatePreset(presetVO);
	}

	@Override
	public List selectSpeicalPresetPrjList(ApprovalPresetVO searchPresetVO) {
		return presetDAO.selectSpeicalPresetPrjList(searchPresetVO);
	}

	@Override
	public int selectSpeicalPresetPrjCnt(ApprovalPresetVO searchPresetVO) {
		return presetDAO.selectSpeicalPresetPrjCnt(searchPresetVO);
	}

	@Override
	public int selectAlreadyRegPrjCnt(ApprovalPresetVO presetVO) {
		return presetDAO.selectAlreadyRegPrjCnt(presetVO);
	}
 
        
}
