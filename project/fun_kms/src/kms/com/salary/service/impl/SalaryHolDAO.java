package kms.com.salary.service.impl;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kms.com.app.service.ApprovalHolVO;
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

@Repository("salaryHolDAO")
public class SalaryHolDAO extends EgovAbstractDAO {

	

	public List selectRankSalaryList(SalaryVO searchVO) {
		return list("salaryHolDAO.selectRankSalaryList", searchVO);
		
	}
	
	public List selectUserSalaryList(SalaryVO salaryVO) {
		return list("salaryHolDAO.selectUserSalaryList", salaryVO);
	}
	
	public List selectPosSalaryList(SalaryVO salaryVO) {
		return list("salaryHolDAO.selectPosSalaryList", salaryVO);
	}
	
	public void insertUserSalary(SalaryVO salaryVO) {
		insert("salaryHolDAO.insertUserSalary",salaryVO);
		
	}

	public void deleteRankSalary(SalaryVO salaryVO) {
		delete("salaryHolDAO.deleteRankSalary",salaryVO);
	}
	public void deletePosSalary(SalaryVO salaryVO) {
		delete("salaryHolDAO.deletePosSalary",salaryVO);
	}
	public void deleteUserSalary(SalaryVO salaryVO) {
		delete("salaryHolDAO.deleteUserSalary",salaryVO);
	}

	public void insertRankSalary(SalaryVO salaryVO) {
		insert("salaryHolDAO.insertRankSalary",salaryVO);
	}
	
	public void insertPosSalary(SalaryVO salaryVO) {
		insert("salaryHolDAO.insertPosSalary",salaryVO);
	}

	public JSONObject selectUserHolSalaryInfo(ApprovalHolVO searchVO) {
		return (JSONObject) selectByPk("salaryHolDAO.selectUserHolSalaryInfo", searchVO);
	}	

}
