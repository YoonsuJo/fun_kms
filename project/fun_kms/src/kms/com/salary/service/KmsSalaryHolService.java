package kms.com.salary.service;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalHolVO;

import org.json.simple.JSONObject;


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
public interface KmsSalaryHolService {

	List selectRankSalaryList(SalaryVO salaryVO);

	void updateRankSalary(SalaryVO salaryVO)throws Exception;

	List selectUserSalaryList(SalaryVO salaryVO);

	void updateUserSalary(SalaryVO salaryVO)throws Exception;

	List selectPosSalaryList(SalaryVO salaryVO);

	void updatePosSalary(SalaryVO salaryVO) throws Exception;
	
	JSONObject selectUserHolSalaryInfo(ApprovalHolVO searchVO);
	    
}
