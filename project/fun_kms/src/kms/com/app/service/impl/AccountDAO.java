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
 *  2009.03.06  박지욱          최초 생성
 * 
 * </pre>
 */
@Repository("accountDAO")
public class AccountDAO extends EgovAbstractDAO {

	/** log */
	protected static final Log LOG = LogFactory.getLog(AccountDAO.class);

	@SuppressWarnings("unchecked")
	public List selectAccountList(AccountVO searchVO) throws Exception {
		return list("accountDAO.selectAccountList", searchVO);
	}

	public void insertAccount(AccountVO accountVO) {
		insert("accountDAO.insertAccount",  accountVO);		
	}

	public AccountVO selectAccountView(AccountVO searchVO) {
		return (AccountVO) selectByPk("accountDAO.selectAccountView", searchVO);
	}

	public void updateAccount(AccountVO accountVO) {
		update("accountDAO.updateAccount",  accountVO);		
	}

	public void updateAccountOrder(AccountVO vo) {
		update("accountDAO.updateAccountOrder", vo);		
	}

	public List selectAccountListTree(AccountVO vo) {
		return list("accountDAO.selectAccountListTree",vo);
	}
	
	public int selectChildAccountCnt(AccountVO vo) {
		return (Integer) getSqlMapClientTemplate().queryForObject("accountDAO.selectChildAccountCnt",vo);
	}

	public void updateBatchChildAccTyp(AccountVO accountVO) {
		update("accountDAO.updateBatchChildAccTyp",accountVO);		
	}

	public int selectPresetChildAccCnt(AccountVO accountVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject("accountDAO.selectPresetChildAccCnt",accountVO);		
	}

	public int selectPresetAccCnt(AccountVO accountVO) {
		return (Integer) getSqlMapClientTemplate().queryForObject("accountDAO.selectPresetAccCnt",accountVO);
	}


}
