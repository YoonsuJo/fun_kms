package kms.com.common.service.impl;

import java.util.List;

import kms.com.common.service.Expansion;
import kms.com.common.service.ExpansionVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("KmsExpansionDAO")
public class ExpansionDAO extends EgovAbstractDAO {

	public List<ExpansionVO> selectExpansionList(ExpansionVO expVO) {
		return list("ExpansionDAO.selectExpansionList", expVO);
	}

	public int selectExpanstionListTotCnt(ExpansionVO expVO) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ExpansionDAO.selectExpansionListTotCnt", expVO);
	}

	public void insertExpansion(Expansion exp) {
		insert("ExpansionDAO.insertExpansion", exp);
	}

	public void updateExpansionSort(ExpansionVO expVO) {
		update("ExpansionDAO.updateExpansionSort", expVO);
	}

	public List<Integer> getUserNo(Expansion exp) {
		return list("ExpansionDAO.getUserNo", exp);
	}

	public ExpansionVO selectExpansion(ExpansionVO expVO) {
		return (ExpansionVO)selectByPk("ExpansionDAO.selectExpansion", expVO);
	}
	
	public List<EgovMap> selectExpansionAccessUserList(ExpansionVO expVO) {
		return list("ExpansionDAO.selectExpansionAccessUserList", expVO);
	}

	public void updateExpansion(Expansion exp) {
		update("ExpansionDAO.updateExpansion", exp);
	}


}
