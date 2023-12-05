package kms.com.common.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.member.service.MemberVO;
import kms.com.member.service.MobileLogVO;
import kms.com.member.service.WorkState;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.com.uat.uia.service.LoginVO;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
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
@Repository("KmsLoginDAO")
public class LoginDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log LOG = LogFactory.getLog(LoginDAO.class);
    
	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public MemberVO actionLogin(MemberVO vo) throws Exception {
    	return (MemberVO)selectByPk("KmsLoginDAO.actionLogin", vo);
    }
    
    public MemberVO actionLoginOverride(MemberVO vo) throws Exception {
    	return (MemberVO)selectByPk("KmsLoginDAO.actionLoginOverride", vo);
    }
    
    public String selectUserMixByEmplyrId (String emplyrId) throws Exception {
    	return (String)selectByPk("KmsLoginDAO.selectUserMixByEmplyrId", emplyrId);
    }

	public List<EgovMap> selectAttendCheck(Map<String,Object> param) {
		return list("KmsLoginDAO.selectAttendCheck", param);
	}	
	
	public void insertLoginLog(Map<String,Object> param) {
		insert("KmsLoginDAO.insertLoginLog", param);		
	}	
	
	public Map<String, Object> selectRecentLoginLog(Map<String,Object> param) {
		return (Map<String, Object>) selectByPk("KmsLoginDAO.selectRecentLoginLog", param);
	}	

	public void insertMobileLoginLog(MobileLogVO mobileLog) {
		insert("KmsLoginDAO.insertMobileLoginLog", mobileLog);		
	}	

	public void insertAttendCheck(Map<String,Object> param) {
		insert("KmsLoginDAO.insertAttendCheck", param);		
	}

	public void insertAttendChecks(Map<String,Object> param) {
		insert("KmsLoginDAO.insertAttendChecks", param);
	}
	
	public void updateAttendCheck(Map<String,Object> param) {
		update("KmsLoginDAO.updateAttendCheck", param);
	}
	
	public void updateAttendCheckEx(Map<String,Object> param) {
		update("KmsLoginDAO.updateAttendCheckEx", param);
	}
	
	public void updateWorkStateNullCheck(Map<String,Object> param) {
		update("KmsLoginDAO.updateWorkStateNullCheck", param);		
	}

	public int isHoliday(Map<String,Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsLoginDAO.isHoliday", param);
	}

	public void updatePastAttendCheck(Map<String,Object> param) {
		update("KmsLoginDAO.updatePastAttendCheck", param);
	}
	
	public List selectPastAttendData(Map<String,Object> param) {
		return list("KmsLoginDAO.selectPastAttendData", param);
	}
	
	public void updatePastAttendData(Map<String,Object> param) {
		update("KmsLoginDAO.updatePastAttendData", param);
	}

	public MemberVO selectLoginPageMember() {
		return (MemberVO)getSqlMapClientTemplate().queryForObject("KmsLoginDAO.selectLoginPageMember");
	}
	
	// 외부 접속 로그 리스트
	public List<EgovMap> selectOuterNetLoginLogList(MemberVO vo) {
		return list("KmsLoginDAO.selectOuterNetLoginLogList", vo);
	}

}
