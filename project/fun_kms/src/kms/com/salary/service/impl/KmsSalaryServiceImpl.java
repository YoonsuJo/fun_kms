package kms.com.salary.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import kms.com.app.service.ApprovalHolVO;
import kms.com.app.service.ApprovalJobgVO;
import kms.com.app.service.ApprovalOfficialVO;
import kms.com.app.service.ApprovalReaderVO;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.ApprovalVacVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.app.service.impl.ApprovalDAO;
import kms.com.app.web.KmsApprovalController;
import kms.com.community.service.NoteVO;
import kms.com.member.service.MemberVO;
import kms.com.salary.service.KmsSalaryService;
import kms.com.salary.service.MemberEvaVO;
import kms.com.salary.service.SalaryVO;
import egovframework.com.utl.sim.service.EgovFileScrty;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.fcc.service.EgovNumberUtil;

import egovframework.com.cop.bbs.service.BoardVO;
import egovframework.com.ems.service.EgovSndngMailRegistService;
import egovframework.com.ems.service.SndngMailVO;

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
@Service("KmsSalaryService")
public class KmsSalaryServiceImpl extends AbstractServiceImpl implements
	KmsSalaryService {

	@Resource(name="salaryDAO")
		private SalaryDAO salaryDAO;
	 
		@Override
		public List selectRankSalaryList(SalaryVO salaryVO) {
			return salaryDAO.selectRankSalaryList(salaryVO);
			
		}

		@Override
		public void updateRankSalary(SalaryVO salaryVO) throws Exception {
			int size = salaryVO.getSalaryList().length;
			if(size<12)
				throw new Exception();
			salaryDAO.deleteRankSalary(salaryVO);
			for(int i = 0; i< size; i ++)
			{
				salaryVO.setSalary(salaryVO.getSalaryList()[i]);
				salaryVO.setMonth(Integer.toString(i+1));
				List voList =salaryDAO.selectRankSalaryList(salaryVO);
				salaryDAO.insertRankSalary(salaryVO);
			}
		}

		@Override
		public List selectUserSalaryList(SalaryVO salaryVO) {
			return salaryDAO.selectUserSalaryList(salaryVO);
		}
		
		@Override
		public void updateUserSalary(SalaryVO salaryVO) throws Exception {
			int size = salaryVO.getSalaryList().length;
			if(size<36)
				throw new Exception();
			salaryDAO.deleteUserSalary(salaryVO);
			for(int i = 0; i< size; i=i+3) {
				salaryVO.setSalary1(salaryVO.getSalaryList()[i]);
				salaryVO.setSalary2(salaryVO.getSalaryList()[i+1]);
				salaryVO.setSalary3(salaryVO.getSalaryList()[i+2]);
				salaryVO.setMonth(Integer.toString(i/3+1));
				List voList =salaryDAO.selectUserSalaryList(salaryVO);
				salaryDAO.insertUserSalary(salaryVO);
				
			}			
		}

		@Override
		public JSONObject selectUserSalaryYearWeight(JSONObject salaryVO) {
			List<EgovMap> list = salaryDAO.selectUserSalaryYearWeight(salaryVO);
			JSONObject js = new JSONObject();
			for(EgovMap egov : list) {
				String userId = (String)egov.get("userId");
				JSONObject elem = new JSONObject();
				elem.putAll(egov);
				js.put(userId, elem);
			}
			return js;			
		}		
		//인건비 끝
		
		//연봉 시작
		@Override
		public List selectRankSalaryRealList(SalaryVO salaryVO) {
			return salaryDAO.selectRankSalaryRealList(salaryVO);			
		}

		@Override
		public void updateRankSalaryReal(SalaryVO salaryVO) throws Exception {			
			//salaryDAO.updateRankSalaryReal(salaryVO);
			salaryDAO.deleteRankSalaryReal(salaryVO);
			salaryDAO.insertRankSalaryReal(salaryVO);			
		}

		@Override
		public List selectUserSalaryRealList(SalaryVO salaryVO) {
			return salaryDAO.selectUserSalaryRealList(salaryVO);
		}
		
		@Override
		public List selectUserSalaryRealListCEO(SalaryVO salaryVO) {
			return salaryDAO.selectUserSalaryRealListCEO(salaryVO);
		}
		
		@Override
		public List selectUserSalaryRealListCEOSum(SalaryVO salaryVO) {
			return salaryDAO.selectUserSalaryRealListCEOSum(salaryVO);
		}
		
		@Override
		public SalaryVO selectUserSalaryRealListCEOSum2(SalaryVO salaryVO) {
			return salaryDAO.selectUserSalaryRealListCEOSum2(salaryVO);
		}
				
		@Override
		public List selectUserSalaryRealListCEOStatusCnt(SalaryVO salaryVO) {
			return salaryDAO.selectUserSalaryRealListCEOStatusCnt(salaryVO);
		}
		
		@Override
		public List selectMemberSalaryNego(SalaryVO salaryVO) {
			return salaryDAO.selectMemberSalaryNego(salaryVO);
		}
		
		@Override
		public int selectUserSalaryRealListCEOTotCnt(SalaryVO salaryVO) throws Exception {
			return salaryDAO.selectUserSalaryRealListCEOTotCnt(salaryVO);
		}
		
		@Override
		public List selectUserSalaryEva(SalaryVO salaryVO) {
			return salaryDAO.selectUserSalaryEva(salaryVO);
		}
		
		@Override
		public MemberEvaVO selectUserSalaryMemberEva(MemberEvaVO memberEvaVO) throws Exception {
			return salaryDAO.selectUserSalaryMemberEva(memberEvaVO);
		}		
		
		@Override
		public SalaryVO selectUserSalaryRealMember(SalaryVO salaryVO) throws Exception {
			return salaryDAO.selectUserSalaryRealMember(salaryVO);
		}
		
		@Override
		public void updateUserSalaryReal(SalaryVO salaryVO) throws Exception {			
			salaryDAO.deleteUserSalaryReal(salaryVO);
			salaryDAO.insertUserSalaryReal(salaryVO);								
		}
		
		@Override
		public void updateUserSalaryReal2(SalaryVO salaryVO) throws Exception {			
			salaryDAO.updateUserSalaryReal(salaryVO);							
		}

		@Override
		public void updateUserSalaryMemberEva(MemberEvaVO memberEvaVO) throws Exception {			
			salaryDAO.deleteUserSalaryMemberEva(memberEvaVO);
			salaryDAO.insertUserSalaryMemberEva(memberEvaVO);											
		}
		
		@Override
		public void insertUserSalaryMemberEva(MemberEvaVO memberEvaVO) throws Exception {
			salaryDAO.insertUserSalaryMemberEva(memberEvaVO);											
		}

		@Override
	    public void insertMemberSalaryNextYear(SalaryVO salaryVO) throws Exception {
	    	//차년도 연봉데이터 자동입력
	    	SalaryVO salaryVO2 = new SalaryVO();
	    	salaryVO2.setUserNo(salaryVO.getUserNo());
			salaryVO2.setYear(salaryVO.getNextYear());
			salaryVO2.setSalaryReal(salaryVO.getSalarySuggest());
			salaryVO2.setCarCost(salaryVO.getCarCost());
			salaryVO2.setMealCost(salaryVO.getMealCost());
			//salaryVO2.setNote(salaryVO.getNote());
			salaryVO2.setStatus("1");
			updateUserSalaryReal(salaryVO2);
	    }

		@Override
		public void insertMemberEvaAuto(MemberVO memberVO, String year) throws Exception {
	    	//사원평가정보 같이 입력
	    	MemberEvaVO memberEvaVO = new MemberEvaVO();
	    	memberEvaVO.setYear(year);    	
	    	memberEvaVO.setUserNo(memberVO.getStringNo());
			memberEvaVO.setExpCompId(memberVO.getExpCompId());
			memberEvaVO.setCompnyId(memberVO.getCompnyId());
			memberEvaVO.setOrgnztId(memberVO.getOrgnztId());
			memberEvaVO.setRankId(memberVO.getRankId());
			memberEvaVO.setPosition(memberVO.getPosition());
			memberEvaVO.setWorkSt(memberVO.getWorkSt());
			memberEvaVO.setDegree(memberVO.getDegree());
			memberEvaVO.setPromotionYear(memberVO.getPromotionYear());
			memberEvaVO.setCareerLength(memberVO.getWorkMonth() + memberVO.getCareerMonthInt() );		
			
			//기존 status 데이터 검사
			SalaryVO salaryVO = new SalaryVO();
	    	salaryVO.setUserNo(Integer.toString(memberVO.getUserNo()) );
			salaryVO.setYear(year);
			salaryVO.setStatus("");		
	    	List resultList = selectUserSalaryEva(salaryVO);
	    	if(resultList.size() < 1){
	    		updateUserSalaryMemberEva(memberEvaVO);
	    	}
	    }
		
		@Override
		public JSONObject selectUserSalaryRealYearWeight(JSONObject salaryVO) {
			List<EgovMap> list = salaryDAO.selectUserSalaryRealYearWeight(salaryVO);
			JSONObject js = new JSONObject();
			for(EgovMap egov : list)
			{
				String userId = (String)egov.get("userId");
				JSONObject elem = new JSONObject();
				elem.putAll(egov);
				js.put(userId, elem);
			}
			return js;
			
		}


	

       
    
}
