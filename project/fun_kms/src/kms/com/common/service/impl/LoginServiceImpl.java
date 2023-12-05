package kms.com.common.service.impl;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kms.com.common.service.LoginService;
import kms.com.common.service.impl.LoginDAO;
import kms.com.member.service.MemberVO;
import kms.com.member.service.MobileLogVO;
import kms.com.member.service.WorkState;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.com.uat.uia.service.EgovLoginService;
import egovframework.com.uat.uia.service.LoginVO;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.fcc.service.EgovNumberUtil;

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
@Service("KmsLoginService")
public class LoginServiceImpl extends AbstractServiceImpl implements
        LoginService {

    @Resource(name="KmsLoginDAO")
    private LoginDAO loginDAO;
    
	public MemberVO actionLogin(MemberVO vo) throws Exception {
		return loginDAO.actionLogin(vo);
		//return null;
	}
	
	public MemberVO actionLoginOverride(MemberVO vo) throws Exception {
		//이후 오버라이드 로그인 절차는 이 함수에서만 유일하게 접근
		return loginDAO.actionLoginOverride(vo);		
	}
	
	@Override
	public List<EgovMap> selectAttendCheck(Map<String,Object> param) throws Exception {
		return loginDAO.selectAttendCheck(param);
	}
	
	@Override
	public void insertLoginLog(Map<String,Object> param) throws Exception {
		loginDAO.insertLoginLog(param);
	}
	
	@Override
	public Map<String, Object> selectRecentLoginLog(Map<String,Object> param) throws Exception {
		return loginDAO.selectRecentLoginLog(param);
	}
	
	@Override
	public void insertMobileLoginLog(MobileLogVO mobileLog) throws Exception {
		loginDAO.insertMobileLoginLog(mobileLog);
	}
	
	@Override
	public void insertAttendCheck(Map<String,Object> param) throws Exception {
		loginDAO.insertAttendCheck(param);
	}

	@Override
	public void insertAttendChecks(Map<String,Object> param) throws Exception {
		loginDAO.insertAttendChecks(param);
	}

	@Override
	public void updateAttendCheck(Map<String,Object> param) throws Exception {
		loginDAO.updateAttendCheck(param);
		//List list = loginDAO.selectPastAttendData(param);
		//if (list.size() == 0)
		//	return;
		//param.put("attendCd", ((Map<String, Object>) list.get(0)).get("attendCd"));
		//loginDAO.updatePastAttendData(param);
	}
	
	@Override
	public void updateAttendCheckEx(Map<String,Object> param) throws Exception {
		loginDAO.updateAttendCheckEx(param);
	}
	
	@Override
	public void updateWorkStateNullCheck(Map<String,Object> param) throws Exception {
		loginDAO.updateWorkStateNullCheck(param);
	}

	@Override
	public boolean isHoliday(Map<String,Object> param) throws Exception {
		int i = loginDAO.isHoliday(param); // 1이면 휴일or주말
		return i == 1;
	}

	@Override
	public void updatePastAttendCheck(Map<String,Object> param) throws Exception {
		List list = loginDAO.selectPastAttendData(param);
		if (list.size() == 0)
			return;
		param.put("attendCd", ((Map<String, Object>) list.get(0)).get("attendCd"));
		loginDAO.updatePastAttendData(param);
	}

	@Override
	public MemberVO selectLoginPageMember() throws Exception {
		return loginDAO.selectLoginPageMember();
	}

	@Override
	public boolean authAppLogin(String code) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	String todayDate = sdf.format(new Date());
        	
    	StringBuffer hexString = new StringBuffer();
    	MessageDigest digest;
		try {
			digest = MessageDigest.getInstance("SHA-1");
			digest.update(todayDate.getBytes());
	        byte messageDigest[] = digest.digest();
	
	        // Create Hex String
	        for (int i = 0; i < messageDigest.length; i++){
	            hexString.append(Integer.toHexString(0xFF & messageDigest[i]));
	        }
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

    	if (code.equals(hexString.toString()))
    		return true;
    	else
    		return false;
	}
	
	// 외부 접속 로그 리스트
	@Override
	public List<EgovMap> selectOuterNetLoginLogList(MemberVO vo) throws Exception {
		return loginDAO.selectOuterNetLoginLogList(vo);
	}
}
