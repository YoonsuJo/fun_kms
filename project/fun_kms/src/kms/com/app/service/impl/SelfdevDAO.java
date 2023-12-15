package kms.com.app.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.app.service.SelfdevVO;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

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
@Repository("selfdevDAO")
public class SelfdevDAO extends EgovAbstractDAO {

	/** log */
	protected static final Log LOG = LogFactory.getLog(SelfdevDAO.class);

	@SuppressWarnings("unchecked")
	public List selectSelfdevCmmList(SelfdevVO searchVO) throws Exception {
		return list("selfdevDAO.selectSelfdevCmmList", searchVO);
	}

	public List selectSelfdevUsrList(SelfdevVO searchVO) throws Exception {
		return list("selfdevDAO.selectSelfdevUsrList", searchVO);
	}
		
	@SuppressWarnings("unchecked")
	public SelfdevVO selectSelfdevUsrInfo(SelfdevVO searchVO) throws Exception {
		return (SelfdevVO) selectByPk("selfdevDAO.selectSelfdevUsrInfo",searchVO);
	}
	
	public void updateSelfdev(SelfdevVO selfdevVO) {
		update("selfdevDAO.updateSelfdev",  selfdevVO);
		
	}
	
	public void insertSelfdev(SelfdevVO selfdevVO) {
		insert("selfdevDAO.insertSelfdev",  selfdevVO);
	}
	
	public void deleteSelfdev(SelfdevVO selfdevVO) {
		delete("selfdevDAO.deleteSelfdev",  selfdevVO);
	}

	
    public int selectSelfdevCmmCnt(SelfdevVO vo) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("selfdevDAO.selectSelfdevCmmCnt", vo);
    }
    
	
	public void insertSelfdevCmm(SelfdevVO vo) {
		update("selfdevDAO.insertSelfdevCmm",  vo);
		
	}
	
	public void updateSelfdevCmm(SelfdevVO vo) {
		update("selfdevDAO.updateSelfdevCmm", vo);
		
	}

	public SelfdevVO selectSelfdevUsrView(SelfdevVO searchVO) {
		return (SelfdevVO) selectByPk("selfdevDAO.selectSelfdevUsrView",searchVO);
	}

	public void insertSelfdevUsr(SelfdevVO selfdevVO) {
		insert("selfdevDAO.insertSelfdevUsr",  selfdevVO);
		
	}

	public void updateSelfdevUsr(SelfdevVO selfdevVO) {
		update("selfdevDAO.updateSelfdevUsr", selfdevVO);
		
	}

	public void deleteSelfdevUsr(SelfdevVO searchVO) {
		delete("selfdevDAO.deleteSelfdevUsr",  searchVO);
		
	}

}
