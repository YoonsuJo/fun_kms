package kms.com.salary.service;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalHolVO;
import kms.com.community.service.NoteVO;
import kms.com.member.service.MemberVO;

import org.json.simple.JSONArray;
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
public interface KmsSalaryService {

	List selectRankSalaryList(SalaryVO salaryVO);

	void updateRankSalary(SalaryVO salaryVO)throws Exception;

	List selectUserSalaryList(SalaryVO salaryVO);
	
	void updateUserSalary(SalaryVO salaryVO)throws Exception;

	JSONObject selectUserSalaryYearWeight(JSONObject salaryVO);

	List selectRankSalaryRealList(SalaryVO salaryVO);

	void updateRankSalaryReal(SalaryVO salaryVO)throws Exception;

	List selectUserSalaryRealList(SalaryVO salaryVO);
	
	List selectUserSalaryRealListCEO(SalaryVO salaryVO);
	
	List selectUserSalaryRealListCEOSum(SalaryVO salaryVO);
	
	SalaryVO selectUserSalaryRealListCEOSum2(SalaryVO salaryVO);
	
	List selectUserSalaryRealListCEOStatusCnt(SalaryVO salaryVO);
	
	List selectMemberSalaryNego(SalaryVO salaryVO);	
	
	int selectUserSalaryRealListCEOTotCnt(SalaryVO salaryVO) throws Exception;	
	
	List selectUserSalaryEva(SalaryVO salaryVO);
	
	MemberEvaVO selectUserSalaryMemberEva(MemberEvaVO memberEvaVO) throws Exception;	
	
	SalaryVO selectUserSalaryRealMember(SalaryVO salaryVO) throws Exception;
		
	void updateUserSalaryReal(SalaryVO salaryVO)throws Exception;
	
	void updateUserSalaryReal2(SalaryVO salaryVO)throws Exception;
	
	void updateUserSalaryMemberEva(MemberEvaVO memberEvaVO)throws Exception;
	
	void insertUserSalaryMemberEva(MemberEvaVO memberEvaVO)throws Exception;
	
	void insertMemberSalaryNextYear(SalaryVO salaryVO)throws Exception;
	
	void insertMemberEvaAuto(MemberVO memberVO, String year)throws Exception;
	
	JSONObject selectUserSalaryRealYearWeight(JSONObject salaryVO);

	
	
    
	    
}
