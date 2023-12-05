package kms.com.app.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

import kms.com.common.exception.IdMixInputException;
import kms.com.member.service.WorkStateVO;

import egovframework.rte.psl.dataaccess.util.EgovMap;

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
public interface KmsSelfdevService {
	
	List selectSelfdevCmmList (SelfdevVO searchVO) throws Exception;
	
	List selectSelfdevUsrList (SelfdevVO searchVO) throws Exception;

	void insertSelfdev(SelfdevVO selfDevVO);

	SelfdevVO selectSelfdevUsrInfo(SelfdevVO SelfdevVO) throws Exception;

	void updateSelfdev(SelfdevVO selfDevVO);
	
	void deleteSelfdev(SelfdevVO selfDevVO);

	void updateSelfdevCmm(SelfdevVO selfdevCmmVO) throws Exception;

	SelfdevVO selectSelfdevUsrView(SelfdevVO searchVO);

	void insertSelfdevUsr(SelfdevVO selfdevVO) throws IdMixInputException;

	void updateSelfdevUsr(SelfdevVO selfdevVO);

	void deleteSelfdevUsr(SelfdevVO searchVO);

	
}
