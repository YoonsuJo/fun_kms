package kms.com.salary.service.impl;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.app.service.ApprovalHolVO;
import kms.com.community.service.NoteVO;
import kms.com.salary.service.MemberEvaVO;
import kms.com.salary.service.Salary;
import kms.com.salary.service.SalaryVO;

/**
 * @Class Name : TblRankSalaryDAO.java
 * @Description : TblRankSalary DAO Class
 * @Modification Information
 *
 * @author 양진환
 * @since 2011.09.20
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Repository("salaryDAO")
public class SalaryDAO extends EgovAbstractDAO {

	/**
	 * TBL_RANK_SALARY을 등록한다.
	 * @param vo - 등록할 정보가 담긴 TblRankSalaryVO
	 * @return 등록 결과
	 * @exception Exception
	 */
    public String insertTblRankSalary(Salary vo) throws Exception {
        return (String)insert("tblRankSalaryDAO.insertTblRankSalary_S", vo);
    }

    /**
	 * TBL_RANK_SALARY을 수정한다.
	 * @param vo - 수정할 정보가 담긴 TblRankSalaryVO
	 * @return void형
	 * @exception Exception
	 */
    public void updateTblRankSalary(Salary vo) throws Exception {
        update("tblRankSalaryDAO.updateTblRankSalary_S", vo);
    }

    /**
	 * TBL_RANK_SALARY을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 TblRankSalaryVO
	 * @return void형 
	 * @exception Exception
	 */
    public void deleteTblRankSalary(Salary vo) throws Exception {
        delete("tblRankSalaryDAO.deleteTblRankSalary_S", vo);
    }

    /**
	 * TBL_RANK_SALARY을 조회한다.
	 * @param vo - 조회할 정보가 담긴 TblRankSalaryVO
	 * @return 조회한 TBL_RANK_SALARY
	 * @exception Exception
	 */
    public Salary selectTblRankSalary(Salary vo) throws Exception {
        return (Salary) selectByPk("tblRankSalaryDAO.selectTblRankSalary_S", vo);
    }

    /**
	 * TBL_RANK_SALARY 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return TBL_RANK_SALARY 목록
	 * @exception Exception
	 */
    public List selectTblRankSalaryList(SalaryVO searchVO) throws Exception {
        return list("tblRankSalaryDAO.selectTblRankSalaryList_D", searchVO);
    }

    /**
	 * TBL_RANK_SALARY 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return TBL_RANK_SALARY 총 갯수
	 * @exception
	 */
    public int selectTblRankSalaryListTotCnt(SalaryVO searchVO) {
        return (Integer)getSqlMapClientTemplate().queryForObject("tblRankSalaryDAO.selectTblRankSalaryListTotCnt_S", searchVO);
    }

	public List selectRankSalaryList(SalaryVO searchVO) {
		return list("salaryDAO.selectRankSalaryList", searchVO);		
	}

	public void updateRankSalary(SalaryVO salaryVO) {
		update("salaryDAO.updateRankSalary",salaryVO);		
	}

	public List selectUserSalaryList(SalaryVO salaryVO) {
		return list("salaryDAO.selectUserSalaryList", salaryVO);
	}
	
	public void updateUserSalary(SalaryVO salaryVO) {
		update("salaryDAO.updateUserSalary",salaryVO);		
	}

	public void insertUserSalary(SalaryVO salaryVO) {
		insert("salaryDAO.insertUserSalary",salaryVO);		
	}

	public List selectUserSalaryYearWeight(JSONObject salaryVO) {
		return list("salaryDAO.selectUserSalaryYearWeight", salaryVO);		
	}

	public void insertRankSalary(SalaryVO salaryVO) {
		insert("salaryDAO.insertRankSalary",salaryVO);		
	}

	public void deleteRankSalary(SalaryVO salaryVO) {
		delete("salaryDAO.deleteRankSalary",salaryVO);		
	}

	public void deleteUserSalary(SalaryVO salaryVO) {
		delete("salaryDAO.deleteUserSalary",salaryVO);		
	}
	//인건비 끝
	
	//연봉시작
	public List selectRankSalaryRealList(SalaryVO searchVO) {
		return list("salaryDAO.selectRankSalaryRealList", searchVO);		
	}

	public void updateRankSalaryReal(SalaryVO salaryVO) {
		update("salaryDAO.updateRankSalaryReal",salaryVO);		
	}

	public List selectUserSalaryRealList(SalaryVO salaryVO) {
		return list("salaryDAO.selectUserSalaryRealList", salaryVO);
	}
	
	public List selectUserSalaryRealListCEO(SalaryVO salaryVO) {
		return list("salaryDAO.selectUserSalaryRealListCEO", salaryVO);
	}
	
	public List selectUserSalaryRealListCEOSum(SalaryVO salaryVO) {
		return list("salaryDAO.selectUserSalaryRealListCEOSum", salaryVO);
	}
	
	public SalaryVO selectUserSalaryRealListCEOSum2(SalaryVO salaryVO) {
		return (SalaryVO)selectByPk("salaryDAO.selectUserSalaryRealListCEOSum2", salaryVO);
	}
	
	public List selectUserSalaryRealListCEOStatusCnt(SalaryVO salaryVO) {
		return list("salaryDAO.selectUserSalaryRealListCEOStatusCnt", salaryVO);
	}
	
	public List selectMemberSalaryNego(SalaryVO salaryVO) {
		return list("salaryDAO.selectMemberSalaryNego", salaryVO);
	}
	
	 public int selectUserSalaryRealListCEOTotCnt(SalaryVO salaryVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("salaryDAO.selectUserSalaryRealListCEOTotCnt", salaryVO);
    }
	 
	public List selectUserSalaryEva(SalaryVO salaryVO) {
		return list("salaryDAO.selectUserSalaryEva", salaryVO);
	}
	
	public MemberEvaVO selectUserSalaryMemberEva(MemberEvaVO memberEvaVO) throws Exception{
		return (MemberEvaVO)selectByPk("salaryDAO.selectUserSalaryMemberEva", memberEvaVO);
	}
	
	public SalaryVO selectUserSalaryRealMember(SalaryVO salaryVO) throws Exception {
		return (SalaryVO)selectByPk("salaryDAO.selectUserSalaryRealMember", salaryVO);
	}
	
	public void updateUserSalaryReal(SalaryVO salaryVO) {
		update("salaryDAO.updateUserSalaryReal", salaryVO);		
	}

	public void insertUserSalaryReal(SalaryVO salaryVO) {
		insert("salaryDAO.insertUserSalaryReal", salaryVO);		
	}
	
	public void insertUserSalaryMemberEva(MemberEvaVO memberEvaVO) {
		insert("salaryDAO.insertUserSalaryMemberEva", memberEvaVO);		
	}
	
	public List selectUserSalaryRealYearWeight(JSONObject salaryVO) {
		return list("salaryDAO.selectUserSalaryRealYearWeight", salaryVO);		
	}

	public void insertRankSalaryReal(SalaryVO salaryVO) {
		insert("salaryDAO.insertRankSalaryReal", salaryVO);		
	}

	public void deleteRankSalaryReal(SalaryVO salaryVO) {
		delete("salaryDAO.deleteRankSalaryReal", salaryVO);		
	}

	public void deleteUserSalaryReal(SalaryVO salaryVO) {
		delete("salaryDAO.deleteUserSalaryReal", salaryVO);		
	}
	
	public void deleteUserSalaryMemberEva(MemberEvaVO memberEvaVO) {
		delete("salaryDAO.deleteUserSalaryMemberEva", memberEvaVO);		
	}
	
}
