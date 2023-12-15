package kms.com.app.service.impl;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import kms.com.app.service.ApprovalPresetVO;
import kms.com.app.service.KmsPresetService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

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
