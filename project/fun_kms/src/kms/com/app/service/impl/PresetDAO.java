package kms.com.app.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.app.service.AccountVO;
import kms.com.app.service.ApprovalJobgVO;
import kms.com.app.service.ApprovalOfficialVO;
import kms.com.app.service.ApprovalPresetVO;
import kms.com.app.service.ApprovalReaderVO;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.ApprovalVacVO;
import kms.com.member.service.WorkStateVO;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
 * 
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.10.20  양진환            최초작성
 * 
 * </pre>
 */
@Repository("presetDAO")
public class PresetDAO extends EgovAbstractDAO {

	/** log */
	protected static final Log LOG = LogFactory.getLog(PresetDAO.class);

	@SuppressWarnings("unchecked")
	public List selectPresetList(ApprovalPresetVO searchVO) throws Exception {
		return list("presetDAO.selectPresetList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public ApprovalPresetVO selectPresetView(ApprovalPresetVO searchVO) throws Exception {

		return (ApprovalPresetVO) selectByPk("presetDAO.selectPresetView",searchVO);
	}
	
	public void updatePreset(ApprovalPresetVO presetVO) {
		update("presetDAO.updatePreset",  presetVO);
		
	}
	
	public void insertPreset(ApprovalPresetVO presetVO) {
		insert("presetDAO.insertPreset",  presetVO);
	}
	
	public void deletePreset(ApprovalPresetVO presetVO) {
		delete("presetDAO.deletePreset",  presetVO);
	}

	public List selectSpeicalPresetPrjList(ApprovalPresetVO searchPresetVO) {
		return list("presetDAO.selectSpeicalPresetPrjList", searchPresetVO);
	}

	public int selectSpeicalPresetPrjCnt(ApprovalPresetVO searchPresetVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject(
				"presetDAO.selectSpeicalPresetPrjCnt", searchPresetVO);
	}

	public int selectAlreadyRegPrjCnt(ApprovalPresetVO presetVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject(
				"presetDAO.selectAlreadyRegPrjCnt", presetVO);
	}
}
