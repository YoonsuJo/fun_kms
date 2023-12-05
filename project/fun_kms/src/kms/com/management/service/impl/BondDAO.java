package kms.com.management.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalVO;
import kms.com.management.service.BondVO;
import kms.com.management.service.InnerSalesDetailVO;
import kms.com.management.service.InnerSalesVO;
import kms.com.management.service.PlanCostVO;
import kms.com.management.service.SalesVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsBondDAO")
public class BondDAO extends EgovAbstractDAO{

	public List<BondVO> selectBondOrgSumList(BondVO bondVO) {
		return list("KmsBondDAO.selectBondOrgSumList", bondVO);
	}
	
	public List<BondVO> selectBondPrjSumList(BondVO bondVO) {
		return list("KmsBondDAO.selectBondPrjSumList", bondVO);
	}

	public BondVO selectBondPrjSum(BondVO bondVO) {
		return (BondVO) selectByPk("KmsBondDAO.selectBondPrjSum", bondVO);
	}
	
	public BondVO selectBondCollectionSum(BondVO bondVO) {
		return (BondVO) selectByPk("KmsBondDAO.selectBondCollectionSum", bondVO);
	}

//	public List<BondVO> selectBondPrj(BondVO bondVO) {
//		return list("KmsBondDAO.selectBondPrj", bondVO);
//	}
	
	public List<BondVO> selectBondTaxPublish(BondVO bondVO) {
		return list("KmsBondDAO.selectBondList", bondVO);
	}
	
	public List<BondVO> selectNoPublish(BondVO bondVO) {
		return list("KmsBondDAO.selectNoPublish", bondVO);
	}
	
	public List<BondVO> selectCollectionList(BondVO bondVO) {
		return list("KmsBondDAO.selectCollectionList", bondVO);
	}
	
	void insertCollection(BondVO bondVO) {
		insert("KmsBondDAO.insertCollection", bondVO);
	}
	
	public BondVO selectCollection(BondVO bondVO) {
		return (BondVO) selectByPk("KmsBondDAO.selectCollection", bondVO);
	}
	
	void updateCollection(BondVO bondVO) {
		update("KmsBondDAO.updateCollection", bondVO);
	}
	
	void deleteCollection(BondVO bondVO) {
		update("KmsBondDAO.deleteCollection", bondVO);
	}
	
	public List selecCollectionFullList(Map<String, Object> param) {
		return list("KmsBondDAO.selecCollectionFullList", param);
	}
	
	public int selecCollectionFullListCnt(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsBondDAO.selecCollectionFullListCnt", param);
	}
	
	// 수금내역 총합계
	public long selecCollectionFullListSum(Map<String, Object> param) {
		return (Long) getSqlMapClientTemplate().queryForObject("KmsBondDAO.selecCollectionFullListSum", param);
	}
	
	void insertSalesBond(BondVO bondVO) {
		insert("KmsBondDAO.insertSalesBond", bondVO);
	}
	
	void deleteSalesBond(BondVO bondVO) {
		delete("KmsBondDAO.deleteSalesBond", bondVO);
	}
}
