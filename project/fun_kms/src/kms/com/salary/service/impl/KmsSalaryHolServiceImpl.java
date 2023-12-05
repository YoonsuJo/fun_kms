package kms.com.salary.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import kms.com.app.service.ApprovalHolVO;
import kms.com.app.service.ApprovalJobgVO;
import kms.com.app.service.ApprovalOfficialVO;
import kms.com.app.service.ApprovalReaderVO;
import kms.com.app.service.ApprovalVO;
import kms.com.app.service.ApprovalVacVO;
import kms.com.app.service.KmsApprovalService;
import kms.com.app.service.impl.ApprovalDAO;
import kms.com.app.web.KmsApprovalController;
import kms.com.salary.service.KmsSalaryHolService;
import kms.com.salary.service.KmsSalaryService;
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
@Service("KmsSalaryHolService")
public class KmsSalaryHolServiceImpl extends AbstractServiceImpl implements
	KmsSalaryHolService {

	
	 @Resource(name="salaryHolDAO")
	   private SalaryHolDAO salaryHolDAO;
	 
	 
	@Override
	public List selectRankSalaryList(SalaryVO salaryVO) {
		return salaryHolDAO.selectRankSalaryList(salaryVO);
	}

	@Override
	public List selectPosSalaryList(SalaryVO salaryVO) {
		return salaryHolDAO.selectPosSalaryList(salaryVO);
	}

	@Override
	public List selectUserSalaryList(SalaryVO salaryVO) {
		return salaryHolDAO.selectUserSalaryList(salaryVO);
	}

	@Override
	public void updateRankSalary(SalaryVO salaryVO) throws Exception {
		int size = salaryVO.getSalaryList().length;
		if(size<12)
			throw new Exception();
		salaryHolDAO.deleteRankSalary(salaryVO);
		for(int i = 0; i< size; i ++)
		{
			salaryVO.setSalary(salaryVO.getSalaryList()[i]);
			salaryVO.setMonth(Integer.toString(i+1));
			salaryHolDAO.insertRankSalary(salaryVO);
		}
	}
	@Override
	public void updatePosSalary(SalaryVO salaryVO) throws Exception {
		int size = salaryVO.getSalaryList().length;
		if(size<12)
			throw new Exception();
		salaryHolDAO.deletePosSalary(salaryVO);
		for(int i = 0; i< size; i ++)
		{
			salaryVO.setSalary(salaryVO.getSalaryList()[i]);
			salaryVO.setMonth(Integer.toString(i+1));
			salaryHolDAO.insertPosSalary(salaryVO);
		}
	}


	

	@Override
	public void updateUserSalary(SalaryVO salaryVO) throws Exception {
		int size = salaryVO.getSalaryList().length;
		if(size<12)
			throw new Exception();
		//해당 년도의 유저에 해당하는 모든 셀러리를 지움.
		salaryHolDAO.deleteUserSalary(salaryVO);
		for(int i = 0; i< size; i=i+1)
		{
			salaryVO.setSalary(salaryVO.getSalaryList()[i]);
			salaryVO.setMonth(Integer.toString(i+1));
			
			salaryHolDAO.insertUserSalary(salaryVO);
		}
	}

	@Override
	public JSONObject selectUserHolSalaryInfo(ApprovalHolVO searchVO) {
		return salaryHolDAO.selectUserHolSalaryInfo(searchVO);
	}
	

       
    
}
