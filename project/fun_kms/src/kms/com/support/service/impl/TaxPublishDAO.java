package kms.com.support.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalVO;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarVO;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.CardVO;
import kms.com.support.service.TaxPublishVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsTaxPublishDAO")
public class TaxPublishDAO extends EgovAbstractDAO{

	public List<TaxPublishVO> selectTaxPublishListAll(Map<String, Object> param) {
		return (List<TaxPublishVO>) list("KmsTaxPublishDAO.selectTaxPublishListAll", param);
	}
	
	public List<TaxPublishVO> selectTaxPublishList(Map<String, Object> param) {
		return (List<TaxPublishVO>) list("KmsTaxPublishDAO.selectTaxPublishList", param);
	}

	public int selectTaxPublishListTotCnt(Map<String, Object> param) {
		return (Integer) getSqlMapClientTemplate().queryForObject("KmsTaxPublishDAO.selectTaxPublishListTotCnt", param);
	}
	
	public String selectMaxBondId() {
		return (String) getSqlMapClientTemplate().queryForObject("KmsTaxPublishDAO.selectMaxBondId");
	}

	void insertTaxPublish(TaxPublishVO taxPublishVO) {
		insert("KmsTaxPublishDAO.insertTaxPublish", taxPublishVO);
	}
	
	void insertBondExpense(JSONObject ob) {
		insert("KmsTaxPublishDAO.insertBondExpense", ob);
	}
	
	void insertBondProject(JSONObject ob) {
		insert("KmsTaxPublishDAO.insertBondProject", ob);
	}
	
	public TaxPublishVO selectTaxPublish(Map<String, Object> param) {
		return (TaxPublishVO) selectByPk("KmsTaxPublishDAO.selectTaxPublish", param);
	}
	
	public List<TaxPublishVO> selectBondExpenseList(Map<String, Object> param) {
		return (List<TaxPublishVO>) list("KmsTaxPublishDAO.selectBondExpenseList", param);
	}
	
	public List<TaxPublishVO> selectBondProjectList(Map<String, Object> param) {
		return (List<TaxPublishVO>) list("KmsTaxPublishDAO.selectBondProjectList", param);
	}
	
	void updateTaxPublish(TaxPublishVO taxPublishVO) {
		update("KmsTaxPublishDAO.updateTaxPublish", taxPublishVO);
	}
	
	void updateBondExpense(JSONObject ob) {
		update("KmsTaxPublishDAO.updateBondExpense", ob);
	}
	
	void updateBondProject(JSONObject ob) {
		update("KmsTaxPublishDAO.updateBondProject", ob);
	}
	
	void deleteTaxPublish(TaxPublishVO taxPublishVO) {
		update("KmsTaxPublishDAO.deleteTaxPublish", taxPublishVO);
	}
	
	void updateTaxPublishState(TaxPublishVO taxPublishVO) {
		update("KmsTaxPublishDAO.updateTaxPublishState", taxPublishVO);
	}
	
	public TaxPublishVO selectTaxProject(Map<String, Object> param) {
		return (TaxPublishVO) selectByPk("KmsTaxPublishDAO.selectTaxProject", param);
	}
	
	public List selectBondPrjNo(Map<String, Object> param) {
		return list("KmsTaxPublishDAO.selectBondPrjNo", param);
	}
}
