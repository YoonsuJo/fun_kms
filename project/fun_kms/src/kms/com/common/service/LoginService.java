package kms.com.common.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kms.com.member.service.MemberVO;
import kms.com.member.service.MobileLogVO;
import kms.com.member.service.WorkState;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
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
public interface LoginService {
	
	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	MemberVO actionLogin(MemberVO vo) throws Exception;
	
	MemberVO actionLoginOverride(MemberVO vo) throws Exception;

	List<EgovMap> selectAttendCheck(Map<String,Object> param) throws Exception;

	void insertLoginLog(Map<String,Object> param) throws Exception;
	
	public Map<String, Object> selectRecentLoginLog(Map<String,Object> param) throws Exception;
	
	void insertMobileLoginLog(MobileLogVO mobileLog) throws Exception;
	
	void insertAttendCheck(Map<String,Object> param) throws Exception;

	void insertAttendChecks(Map<String,Object> param) throws Exception;

	void updateAttendCheck(Map<String,Object> param) throws Exception;
	
	void updateAttendCheckEx(Map<String,Object> param) throws Exception;
	
	void updateWorkStateNullCheck(Map<String,Object> param) throws Exception;

	boolean isHoliday(Map<String,Object> param) throws Exception;

	void updatePastAttendCheck(Map<String,Object> param) throws Exception;

	MemberVO selectLoginPageMember() throws Exception;
    
	boolean authAppLogin(String code) throws Exception;
	
	// 외부 접속 로그 리스트
	List<EgovMap> selectOuterNetLoginLogList(MemberVO vo) throws Exception;
}
