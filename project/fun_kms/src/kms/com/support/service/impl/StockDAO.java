package kms.com.support.service.impl;

import java.util.List;
import java.util.Map;

import kms.com.app.service.ApprovalVO;
import kms.com.support.service.CarFixVO;
import kms.com.support.service.CarReservation;
import kms.com.support.service.CarVO;
import kms.com.support.service.CardSpendVO;
import kms.com.support.service.CardVO;
import kms.com.support.service.StockVO;
import kms.com.support.service.TaxPublishVO;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("KmsStockDAO")
public class StockDAO extends EgovAbstractDAO{

	Map<String, Object> selectStock(Map<String, Object> param) {
		return (Map<String, Object>) selectByPk("KmsStockDAO.selectStock", param);
	}
	
	List selectStockList(Map<String, Object> param) {
		return list("KmsStockDAO.selectStock", param);
	}
	
	void insertStock(Map<String, Object> param) {
		insert("KmsStockDAO.insertStock", param);
	}
	
	public void updateStock(Map<String, Object> param) {
		update("KmsStockDAO.updateStock", param);
	}
	
	void deleteSavedStock(Map<String, Object> param) {
		update("KmsStockDAO.deleteSavedStock", param);
	}
	
	void insertStockHistory(Map<String, Object> param) {
		insert("KmsStockDAO.insertStockHistory", param);
	}
	
	void updateStockHistory(Map<String, Object> param) {
		update("KmsStockDAO.updateStockHistory", param);
	}
	
	List selectStockCategory(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockCategory", param);
	}
	
	void insertStockCategory(Map<String, Object> param) {
		insert("KmsStockDAO.insertStockCategory", param);
	}
	
	void updateStockCategory(Map<String, Object> param) {
		update("KmsStockDAO.updateStockCategory", param);
	}
	
	void deleteStockCategory(Map<String, Object> param) {
		update("KmsStockDAO.deleteStockCategory", param);
	}
	
	List selectStockItem(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockItem", param);
	}
	
	void insertStockItem(Map<String, Object> param) {
		insert("KmsStockDAO.insertStockItem", param);
	}
	
	void updateStockItem(Map<String, Object> param) {
		update("KmsStockDAO.updateStockItem", param);
	}
	
	void updateStockItemPrice(Map<String, Object> param) {
		update("KmsStockDAO.updateStockItemPrice", param);
	}
	
	void deleteStockItem(Map<String, Object> param) {
		update("KmsStockDAO.deleteStockItem", param);
	}
	
	List selectStockState(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockState", param);
	}
	
	List selectOldStockStateTotal(Map<String, Object> param) {
		return list("KmsStockDAO.selectOldStockStateTotal", param);
	}
	
	List selectStockListAjax(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockAjax", param);
	}
	
	List selectStockStatistic(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockStatisticMonthly", param);
	}
	
	List selectStockStatsStock(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockStatsStock", param);
	}
	
	List selectStockStatsBuy(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockStatsBuy", param);
	}
	
	List selectStockStatsSell(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockStatsSell", param);
	}
	
	List selectStockStatusList(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockStatusList", param);
	}
	
	List selectStockSalesList(Map<String, Object> param) {
		return list("KmsStockDAO.selectStockSalesList", param);
	}
	
	List selectStockDetailList(StockVO stockVO) {
		return list("KmsStockDAO.selectStockDetailList", stockVO);
	}
	
	Map<String, Object> selectStockDetailListCount(StockVO stockVO) {
		return (Map<String, Object>) selectByPk("KmsStockDAO.selectStockDetailListCount", stockVO);
	}
	
	List selectOldStockDetailList(StockVO stockVO) {
		return list("KmsStockDAO.selectOldStockDetailList", stockVO);
	}
	
	Map<String, Object> selectOldStockDetailListCount(StockVO stockVO) {
		return (Map<String, Object>) selectByPk("KmsStockDAO.selectOldStockDetailListCount", stockVO);
	}
	
	Map<String, Object> selectItemInfo(StockVO stockVO) {
		return (Map<String, Object>) selectByPk("KmsStockDAO.selectItemInfo", stockVO);
	}

	Map<String, Object> selectStockInfo(StockVO stockVO) {
		return (Map<String, Object>) selectByPk("KmsStockDAO.selectStockInfo", stockVO);
	}
	
	List selectHistoryList(StockVO stockVO) {
		return list("KmsStockDAO.selectHistoryList", stockVO);
	}
	
	int checkStockSerialNo(Map<String, Object> param) {
		return (Integer)getSqlMapClientTemplate().queryForObject("KmsStockDAO.checkStockSerialNo", param);
	}
	
	void insertStockInstall(Map<String, Object> param) {
		insert("KmsStockDAO.insertStockInstall", param);
	}
	
	void deleteStockInstall(Map<String, Object> param) {
		update("KmsStockDAO.deleteStockInstall", param);
	}

	List selectStockInstallL(StockVO stockVO) {
		return list("KmsStockDAO.selectStockInstallL", stockVO);
	}
}